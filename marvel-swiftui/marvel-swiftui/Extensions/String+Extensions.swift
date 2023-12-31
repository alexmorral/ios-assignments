//
//  String+Extensions.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation
import CryptoKit

extension String {
    // Copied from https://stackoverflow.com/a/56578995/1927285
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
