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

public extension String {
    public static var page = "page"
    public static var pageSize = "page_size"
}

public extension HTTPQuery {
    public static func createDefaultPaging(_ pageNumber: Int, _ pageSize: Int) -> HTTPQuery {
        let pageNumberValue = String(pageNumber)
        let pageSizeValue = String(pageSize)
        return [.page: pageNumberValue, .pageSize : pageSizeValue]
    }
}

public extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

public struct NoContentResponse: Codable {}
