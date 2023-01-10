//
//  TMDBConfigAPI.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

final class TMDBConfigAPI: BaseNetworking<TMDBNetworkingConfiguration> {
    static let shared = TMDBConfigAPI()
    
    private override init() {}
    
    func getAPIConfiguration(completion: @escaping (Result<TMDBConfigurationModel, ServiceError>) -> Void) {
        fetchData(configuration: .getAPIConfiguration,
                  responseType: TMDBConfigurationModel.self) { result in
            switch result {
            case .success(let configuration):
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
