//
//  CryptoHash.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 07/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

public enum Hash {
    case md5([UInt8])
    case sha1([UInt8])
    case sha224([UInt8]), sha256([UInt8]), sha384([UInt8]), sha512([UInt8])
    case crc32([UInt8])
    
    public func calculate() -> [UInt8]? {
        switch self {
        case md5(let data):
            return MD5(data).calculate()
        case sha1(let data):
            return SHA1(data).calculate()
        case sha224(let data):
            return SHA2(data, variant: .sha224).calculate32()
        case sha256(let data):
            return SHA2(data, variant: .sha256).calculate32()
        case sha384(let data):
            return SHA2(data, variant: .sha384).calculate64()
        case sha512(let data):
            return SHA2(data, variant: .sha512).calculate64()
        case crc32(let data):
            return CRC().crc32(data);
        }
    }
}