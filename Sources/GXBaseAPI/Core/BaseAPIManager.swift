//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Combine
import Foundation

public protocol BaseAPIManagerProtocol: UploadAPIManager {
    var baseURL: String { get }
}

public extension BaseAPIManagerProtocol {
    func fetch<Output: Codable>(endpoint: APICall, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Output, Error> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Output in
                    let httpResponse = result.response as? HTTPURLResponse
                    NetworkLogger.log(response: httpResponse, data: result.data)
                    return try decoder.decode(Output.self, from: result.data)
                }
                .eraseToAnyPublisher()
        } catch {
            return AnyPublisher(
                Fail<Output, Error>(error: GXBaseAPIErros.notValidURL)
            )
        }
    }

    func fetch<Input: Codable, Output: Codable>(endpoint: APICall, params: Input? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Output, Error> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL, bodyData: params)
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Output in
                    let httpResponse = result.response as? HTTPURLResponse
                    NetworkLogger.log(response: httpResponse, data: result.data)
                    return try decoder.decode(Output.self, from: result.data)
                }
                .eraseToAnyPublisher()
        } catch {
            return AnyPublisher(
                Fail<Output, Error>(error: GXBaseAPIErros.notValidURL)
            )
        }
    }
}

public extension BaseAPIManagerProtocol {
    func upload<Output: Codable>(endpoint: APICall, with multipartFormData: MultipartFormDataRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Output, Error> {
        do {
            var request = try endpoint.uploadRequest(baseURL: baseURL, boundary: multipartFormData.boundary)
            request.httpBody = multipartFormData.httpBody as Data
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Output in
                    let httpResponse = result.response as? HTTPURLResponse
                    NetworkLogger.log(response: httpResponse, data: result.data)
                    return try decoder.decode(Output.self, from: result.data)
                }
                .eraseToAnyPublisher()
        } catch {
            return AnyPublisher(
                Fail<Output, Error>(error: GXBaseAPIErros.notValidURL)
            )
        }
    }
}
