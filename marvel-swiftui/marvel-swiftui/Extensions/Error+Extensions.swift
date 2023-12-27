//
//  Error+Extensions.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

extension Error {
    func printCatchError() {
        switch self {
        case let decodingError as DecodingError:
            switch decodingError {
            case .dataCorrupted(let context):
                logger.error(context)
            case .keyNotFound(let key, let context):
                logger.error("Key '\(key)' not found: \(context.debugDescription)")
                logger.error("codingPath: \(context.codingPath)")
            case .valueNotFound(let type, let context):
                logger.error("Value '\(type)' not found: \(context.debugDescription)")
                logger.error("codingPath: \(context.codingPath)")
            case .typeMismatch(let type, let context):
                logger.error("Type '\(type)' mismatch: \(context.debugDescription)")
                logger.error("codingPath: \(context.codingPath)")
            @unknown default:
                logger.error("DecodingError unknown")
            }
        default:
            logger.error(self.localizedDescription)
        }
    }
}
