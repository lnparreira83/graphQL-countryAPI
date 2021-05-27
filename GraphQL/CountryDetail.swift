//
//  CountryDetail.swift
//  GraphQL
//
//  Created by Lucas Parreira on 22/05/21.
//

import SwiftUI

struct CountryDetail: View {
    
    let countries: GetAllCountriesQuery.Data.Country
    @State var countryInfo: GetCountryInfoQuery.Data.Country?
    
    var body: some View {
        VStack{
                Text(countryInfo?.emoji ?? "").font(.system(size: 275)).bold()
                Text(countryInfo?.name ?? "")
                    .font(.system(size: 34))
                    .bold()
                Text(countryInfo?.capital ?? "").bold()
                List(countryInfo?.states ?? [], id: \.name){state in
                    Text(state.name)
                }
            }
        .padding(.top, -60)
            .onAppear(perform: {
                Network.shared.apollo.fetch(query: GetCountryInfoQuery(code: countries.code)){ result in
                    switch result {
                    case .success(let graphQLResult):
                        DispatchQueue.main.async {
                            self.countryInfo = graphQLResult.data?.country
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
       }
    }

struct CountryDetail_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetail(countries: GetAllCountriesQuery.Data.Country(code: "US", name: "United States", capital: "", emoji: ""))
    }
}
