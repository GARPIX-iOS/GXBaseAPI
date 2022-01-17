//
//  File.swift
//  
//
//  Created by Danil on 16.01.2022.
//

import Foundation
import Combine

enum UploadResponse {
    case progress(percentage: Double)
    case response(data: Data?)
}

public protocol UploadManager: NSObject {

}

public extension UploadManager {
    
    func upload(
        request: URLRequest,
        fileURL: URL
    ) -> AnyPublisher<UploadResponse, Error> {
        let progress: PassthroughSubject<(id: Int, progress: Double), Never> = .init()

        let subject: PassthroughSubject<UploadResponse, Error> = .init()
        let task: URLSessionUploadTask = URLSession.shared.uploadTask(
            with: request,
            fromFile: fileURL
        ) { data, response, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                subject.send(.response(data: data))
                return
            }
            subject.send(.response(data: nil))
        }
        task.resume()
        return progress
            .filter{ $0.id == task.taskIdentifier }
            .setFailureType(to: Error.self)
            .map { .progress(percentage: $0.progress) }
            .merge(with: subject)
            .eraseToAnyPublisher()
    }
}


