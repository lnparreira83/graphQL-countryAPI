//
//  Apollo.swift
//  GraphQL
//
//  Created by Lucas Parreira on 22/05/21.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}
