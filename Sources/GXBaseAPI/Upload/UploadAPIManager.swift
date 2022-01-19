//
//  File.swift
//  
//
//  Created by Danil on 16.01.2022.
//

import Foundation
import Combine

public protocol UploadAPIManager {
    func upload<Output: Codable>(endpoint: APICall, with boundary: String, and httpBody: Data, decoder: JSONDecoder) -> AnyPublisher<Output, Error>
}
