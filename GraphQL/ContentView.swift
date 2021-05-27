//
//  ContentView.swift
//  GraphQL
//
//  Created by Lucas Parreira on 22/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var countries: [GetAllCountriesQuery.Data.Country] = []
    
    var body: some View {
        NavigationView{
            VStack{
                List(countries, id: \.code){ country in
                    NavigationLink(destination:CountryDetail(countries: country)){
                        Text(country.emoji)
                        Text(country.name)
                    }
                    
                    
                }.listStyle(PlainListStyle())
            }
            .navigationTitle("Countries")
            .onAppear(perform:{
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()){ result in
                    switch result {
                    case .success(let graphQLResult):
                        if let countries = graphQLResult.data?.countries {
                            DispatchQueue.main.async {
                                self.countries = countries
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
