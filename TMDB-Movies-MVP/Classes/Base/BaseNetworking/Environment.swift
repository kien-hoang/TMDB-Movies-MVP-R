//
//  Environment.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 29/12/2022.
//

import Foundation

enum EnvironmentType: String {
    case development = "Development"
    case production = "Production"
}

final class Environment {
    
    static let shared = Environment()
    
    // MARK: - Public Variable
    
    var environment: EnvironmentType {
        EnvironmentType(rawValue: currentConfiguration)!
    }
    
    var baseUrl: String {
        switch environment {
        case .development:
            return NetworkingConstant.baseUrl
        case .production:
            return NetworkingConstant.baseUrl
        }
    }
    
    // MARK: - Private Variable
    
    private var currentConfiguration = "Development"
    
    // MARK: - Lifecycle
    
    private init() {
        currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
    }
}
