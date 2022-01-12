//
//  File.swift
//
//
//  Created by Danil on 16.12.2021.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}

public typealias HTTPHeaders = [String: String]
public typealias HTTPQuery = [String: String]

public extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
