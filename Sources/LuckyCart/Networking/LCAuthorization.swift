//
//  LCAuthorization.swift
//
//  LuckyCart Framework - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 13/01/2022.
//

import Foundation
import CryptoKit


/// LCSignature
///
/// The signature object returned by authorization

struct LCSignature {
    var key: String
    var timestamp: String
    var hex: String
}


/// LCAuthorization
///
/// The use/secret key to use in network or server configuration

public struct LCAuthorization {
    let key: String
    let secret: String
    
    let version = "2.0"
    
    func computeSignature() -> LCSignature {
        // TODO: Finish Encryption and move in private part
        
        let date = Date()
        let timestamp = "\(floor(date.timeIntervalSinceNow) / 1000)"
        
        let secretString = "p#91J#i&00!QkdSPjgGNJq"
        let key = SymmetricKey(data: secretString.data(using: .utf8)!)
        
        let signature = HMAC<SHA256>.authenticationCode(for: timestamp.data(using: .utf8)!, using: key)
        let signatureHex = Data(signature).map { String(format: "%02hhx", $0) }.joined()
        
        return LCSignature(key: self.key, timestamp: timestamp, hex: signatureHex)
    }
}