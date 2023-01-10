//
//  MovieAPI.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 08/01/2023.
//

import Foundation

final class MovieAPI: BaseNetworking<MovieNetworkingConfiguration> {
    static let shared = MovieAPI()
    
    private override init() {}
    
    func getListUpcomingMovies(page: Int,
                               completion: @escaping (Result<[MovieModel], ServiceError>) -> Void) {
        fetchData(configuration: .getUpcomingMovies(page: page),
                  responseType: DefaultResponse<[MovieModel]>.self) { result in
            switch result {
            case .success(let defaultResponse):
                completion(.success(defaultResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
