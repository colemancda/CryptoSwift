//
//  StringExtension.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 15/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

/** String extension */
public extension String {
    
    public func UTF8Data() -> [UInt8] {
        
        let data = self.utf8.map { (codeUnit: UTF8.CodeUnit) -> UInt8 in return codeUnit }
        
        return data
    }
    
    /** Calculate MD5 hash */
    public func md5() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.md5()?.toHexString()
    }
    
    public func sha1() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.sha1()?.toHexString()
    }

    public func sha224() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.sha224()?.toHexString()
    }

    public func sha256() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.sha256()?.toHexString()
    }

    public func sha384() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.sha384()?.toHexString()
    }

    public func sha512() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.sha512()?.toHexString()
    }

    public func crc32() -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.crc32()?.toHexString()
    }

    public func encrypt(cipher: Cipher) throws -> String? {
        return try self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.encrypt(cipher)?.toHexString()
    }

    public func decrypt(cipher: Cipher) throws -> String? {
        return try self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.decrypt(cipher)?.toHexString()
    }
    
    public func authenticate(authenticator: Authenticator) -> String? {
        return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.authenticate(authenticator)?.toHexString()
    }

}