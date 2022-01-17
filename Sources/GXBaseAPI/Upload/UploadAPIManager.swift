//
//  File.swift
//  
//
//  Created by Danil on 16.01.2022.
//

import Foundation
import Combine

public protocol UploadAPIManager {
    
}

public extension UploadAPIManager {
    func upload<Output: Codable>(with multipartFormData: MultipartFormDataRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Output, Error> {
        let request = multipartFormData.asURLRequest()
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Output in
                let httpResponse = result.response as? HTTPURLResponse
                NetworkLogger.log(response: httpResponse, data: result.data)
                return try decoder.decode(Output.self, from: result.data)
            }
            .eraseToAnyPublisher()
    }
}
