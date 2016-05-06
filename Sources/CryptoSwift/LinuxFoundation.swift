//
//  LinuxFoundation.swift
//  CryptoSwift
//
//  Created by Alsey Coleman Miller on 4/18/16.
//  Copyright © 2016 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

#if !os(Linux)
    
extension String {
    
    // Workaround:
    // https://github.com/krzyzanowskim/CryptoSwift/issues/177
    @inline(__always)
    func bridge() -> NSString {
        return self as NSString
    }
}

#endif
