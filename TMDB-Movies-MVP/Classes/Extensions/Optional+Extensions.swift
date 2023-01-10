//
//  Optional+Extensions.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 29/12/2022.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
