//
//  File.swift
//
//
//  Created by Danil on 16.12.2021.
//

import Foundation

// in progress

public protocol FileDownloader {}

//public extension FileDownloader {
//    func downloadFile(by url: URL, headers: HTTPHeaders, completion: @escaping (Result<URL, Error>) -> Void) {
//        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//        guard !FileManager().fileExists(atPath: destinationUrl.path) else {
//            completion(.success(destinationUrl))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.GET.rawValue
//        request.allHTTPHeaderFields = headers
//        URLSession.shared.downloadTask(with: request) { localURL, _, error in
//            if let localURL = localURL {
//                completion(.success(localURL))
//            } else {
//                completion(.failure(error ?? URLError(.badServerResponse)))
//            }
//        }
//    }
//}
