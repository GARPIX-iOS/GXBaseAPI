//
//  File.swift
//  
//
//  Created by Danil on 16.01.2022.
//

import Foundation
import Combine

public protocol UploadAPIManager {
    func upload<Output: Codable>(endpoint: APICall, with multipartFormData: MultipartFormDataRequest, decoder: JSONDecoder) -> AnyPublisher<Output, Error>
}
