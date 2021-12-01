//
//  Services.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import Apollo

// I prefer using a Networking class instead of directly the apollo client to be more flexible
protocol ApiServiceType {
    func getLaunches(offset: Int?, completion: @escaping (Result<GraphQLResult<LaunchListQuery.Data>, Error>) -> Void)
}

class ApiService: ApiServiceType {
    private lazy var apollo = ApolloClient(url: URL(string: "https://api.spacex.land/graphql")!)
    
    func getLaunches(offset: Int?, completion: @escaping (Result<GraphQLResult<LaunchListQuery.Data>, Error>) -> Void) {
        
        apollo.fetch(query: LaunchListQuery(limit: 20, offset: offset ?? 0)) { result in
            completion(result)
        }
    }
}
