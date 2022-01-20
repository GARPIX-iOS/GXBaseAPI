//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Foundation

public enum GXBaseAPIErros: Error {
    case notValidURL
    case notValidBody
}


public struct ErrorHandler {
    static func checkDecodingErrors<Output: Codable>(decoder: JSONDecoder, model: Output.Type, with data: Data) throws -> Output {
        do {
            return try decoder.decode(model.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            debugPrint("could not find key \(key) in JSON: \(context.debugDescription)")
            throw DecodingError.keyNotFound(key, context)
        } catch DecodingError.valueNotFound(let type, let context) {
            debugPrint("could not find type \(type) in JSON: \(context.debugDescription)")
            throw DecodingError.valueNotFound(type, context)
        } catch DecodingError.typeMismatch(let type, let context) {
            debugPrint("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            throw DecodingError.typeMismatch(type, context)
        } catch DecodingError.dataCorrupted(let context) {
            debugPrint("data found to be corrupted in JSON: \(context.debugDescription)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
