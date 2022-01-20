//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Foundation

public enum GXBaseAPIErros: Error, LocalizedError {
    case notValidURL
    case notValidBody
    case noContent
    
    public var errorDescription: String? {
        switch self {
        case .notValidURL:
            return "Некорректный URL"
        case .notValidBody:
            return  "Некорректное тело запроса"
        case .noContent:
            return "Нет контента"
        }
    }
    
}


public struct ErrorHandler {
    static func checkDecodingErrors<Output: Codable>(decoder: JSONDecoder, model: Output.Type, with data: Data) throws -> Output {
        do {
            return try decoder.decode(model.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            debugPrint("\(Output.self) could not find key \(key) in JSON: \(context.debugDescription)")
            throw DecodingError.keyNotFound(key, context)
        } catch DecodingError.valueNotFound(let type, let context) {
            debugPrint("\(Output.self) could not find type \(type) in JSON: \(context.debugDescription)")
            throw DecodingError.valueNotFound(type, context)
        } catch DecodingError.typeMismatch(let type, let context) {
            debugPrint("\(Output.self)  type mismatch for type \(type) in JSON: \(context.debugDescription)")
            throw DecodingError.typeMismatch(type, context)
        } catch DecodingError.dataCorrupted(let context) {
            debugPrint("\(Output.self) data found to be corrupted in JSON: \(context.debugDescription)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
