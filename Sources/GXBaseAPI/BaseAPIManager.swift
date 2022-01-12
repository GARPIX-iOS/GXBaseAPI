//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Combine
import Foundation

public protocol BaseAPIManagerProtocol {
    var baseURL: String { get }
}

public extension BaseAPIManagerProtocol {
    func fetch<Output: Codable>(endpoint: APICall, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Output, Error> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Output in
                    try decoder.decode(Output.self, from: result.data)
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
                    try decoder.decode(Output.self, from: result.data)
                }
                .eraseToAnyPublisher()
        } catch {
            return AnyPublisher(
                Fail<Output, Error>(error: GXBaseAPIErros.notValidURL)
            )
        }
    }
}
