//
//  DataExtension.swift
//  CryptoSwift
//
//  Created by Alsey Coleman Miller on 9/19/15.
//  Copyright © 2015 Marcin Krzyzanowski. All rights reserved.
//

extension Array where Generator.Element: UInt8 {
    
    public func checksum() -> UInt16 {
        
        var s:UInt32 = 0;
        
        var bytesArray = self
        
        for (var i = 0; i < bytesArray.count; i++) {
            _ = bytesArray[i]
            s = s + UInt32(bytesArray[i])
        }
        s = s % 65536;
        
        return UInt16(s);
    }
    
    public func md5() -> [UInt8]? {
        return Hash.md5(self).calculate()
    }
    
    public func sha1() -> [UInt8]? {
        return Hash.sha1(self).calculate()
    }
    
    public func sha224() -> [UInt8]? {
        return Hash.sha224(self).calculate()
    }
    
    public func sha256() -> [UInt8]? {
        return Hash.sha256(self).calculate()
    }
    
    public func sha384() -> [UInt8]? {
        return Hash.sha384(self).calculate()
    }
    
    public func sha512() -> [UInt8]? {
        return Hash.sha512(self).calculate()
    }
    
    public func crc32() -> [UInt8]? {
        return Hash.crc32(self).calculate()
    }
    
    public func encrypt(cipher: Cipher) throws -> [UInt8]? {
        let encrypted = try cipher.encrypt(self.arrayOfBytes())
        return NSData.withBytes(encrypted)
    }
    
    public func decrypt(cipher: Cipher) throws -> [UInt8]? {
        let decrypted = try cipher.decrypt(self.arrayOfBytes())
        return NSData.withBytes(decrypted)
    }
    
    public func authenticate(authenticator: Authenticator) -> [UInt8]? {
        
        return authenticator.authenticate(self)
    }
}
