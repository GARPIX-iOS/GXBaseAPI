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
    func upload(with multipartFormData: MultipartFormDataRequest) -> AnyPublisher<Data, Error> {
        let request = multipartFormData.asURLRequest()
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                let httpResponse = result.response as? HTTPURLResponse
                NetworkLogger.log(response: httpResponse, data: result.data)
                return result.data
            }
            .eraseToAnyPublisher()
    }
}
