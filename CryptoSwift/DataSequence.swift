//
//  DataSequence.swift
//  CryptoSwift
//
//  Created by Alsey Coleman Miller on 9/19/15.
//  Copyright © 2015 Marcin Krzyzanowski. All rights reserved.
//

struct DataSequence: SequenceType {
    
    let chunkSize: Int
    let data: [UInt8]
    
    func generate() -> AnyGenerator<[UInt8]> {
        
        var offset:Int = 0
        
        return anyGenerator {
            let result = self.data.subdataWithRange(NSRange(location: offset, length: min(self.chunkSize, self.data.length - offset)))
            offset += result.length
            return result.length > 0 ? result : nil
        }
    }
}