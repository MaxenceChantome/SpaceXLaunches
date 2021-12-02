//
//  Services.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import Apollo

protocol ApiServiceType {
    func getLaunches(offset: Int?, completion: @escaping (Result<GraphQLResult<LaunchListQuery.Data>, Error>) -> Void)
    
    func getLaunchDetails(id: String, completion: @escaping (Result<GraphQLResult<LaunchQuery.Data>, Error>) -> Void)
}

class ApiService: ApiServiceType {
    private lazy var apollo = ApolloClient(url: URL(string: "https://api.spacex.land/graphql")!)
    
    func getLaunches(offset: Int?, completion: @escaping (Result<GraphQLResult<LaunchListQuery.Data>, Error>) -> Void) {
        
        apollo.fetch(query: LaunchListQuery(limit: 20, offset: offset ?? 0)) { result in
            completion(result)
        }
    }
    
    func getLaunchDetails(id: String, completion: @escaping (Result<GraphQLResult<LaunchQuery.Data>, Error>) -> Void) {
        
        apollo.fetch(query: LaunchQuery(id:id)) { result in
            completion(result)
        }
    }
}
