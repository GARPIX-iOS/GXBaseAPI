//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Foundation

public protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

public extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw GXBaseAPIErros.notValidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = nil
        NetworkLogger.log(request: request)
        return request
    }
    
    func urlRequest<BodyData: Codable>(baseURL: String, bodyData: BodyData) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw GXBaseAPIErros.notValidURL
        }
        
        guard let body = try? JSONEncoder().encode(bodyData) else {
            debugPrint("Error: Trying to convert model to JSON data")
            throw GXBaseAPIErros.notValidBody
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        NetworkLogger.log(request: request)
        return request
    }
    
    
    func uploadRequest(baseURL: String, boundary: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw GXBaseAPIErros.notValidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        return request
    }    
}
