//
//  CipherChaCha20Tests.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 27/12/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//
import XCTest
@testable import CryptoSwift

final class ChaCha20Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testChaCha20() {
        let keys:[[UInt8]] = [
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01],
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F]
        ]
        
        let ivs:[[UInt8]] = [
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01],
            [0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
            [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07]
        ]
        
        let expectedHexes = [
            "76B8E0ADA0F13D90405D6AE55386BD28BDD219B8A08DED1AA836EFCC8B770DC7DA41597C5157488D7724E03FB8D84A376A43B8F41518A11CC387B669B2EE6586",
            "4540F05A9F1FB296D7736E7B208E3C96EB4FE1834688D2604F450952ED432D41BBE2A0B6EA7566D2A5D1E7E20D42AF2C53D792B1C43FEA817E9AD275AE546963",
            "DE9CBA7BF3D69EF5E786DC63973F653A0B49E015ADBFF7134FCB7DF137821031E85A050278A7084527214F73EFC7FA5B5277062EB7A0433E445F41E3",
            "EF3FDFD6C61578FBF5CF35BD3DD33B8009631634D21E42AC33960BD138E50D32111E4CAF237EE53CA8AD6426194A88545DDC497A0B466E7D6BBDB0041B2F586B",
            "F798A189F195E66982105FFB640BB7757F579DA31602FC93EC01AC56F85AC3C134A4547B733B46413042C9440049176905D3BE59EA1C53F15916155C2BE8241A38008B9A26BC35941E2444177C8ADE6689DE95264986D95889FB60E84629C9BD9A5ACB1CC118BE563EB9B3A4A472F82E09A7E778492B562EF7130E88DFE031C79DB9D4F7C7A899151B9A475032B63FC385245FE054E3DD5A97A5F576FE064025D3CE042C566AB2C507B138DB853E3D6959660996546CC9C4A6EAFDC777C040D70EAF46F76DAD3979E5C5360C3317166A1C894C94A371876A94DF7628FE4EAAF2CCB27D5AAAE0AD7AD0F9D4B6AD3B54098746D4524D38407A6DEB3AB78FAB78C9"
        ]

        for idx in 0..<keys.count {            
            let expectedHex = expectedHexes[idx]
            let message = [UInt8](count: (expectedHex.characters.count / 2), repeating: 0)
            
            do {
                let encrypted = try ChaCha20(key: keys[idx], iv: ivs[idx])!.encrypt(message)
                let decrypted = try ChaCha20(key: keys[idx], iv: ivs[idx])!.decrypt(encrypted)
                XCTAssertEqual(message, decrypted, "ChaCha20 decryption failed");
                
                // check extension
                let messageData = NSData(bytes: message, length: message.count);
                let encrypted2 = try! messageData.encrypt(ChaCha20(key: keys[idx], iv: ivs[idx])!)
                XCTAssertNotNil(encrypted2, "")
                XCTAssertEqual(NSData.with(bytes: encrypted), encrypted2, "ChaCha20 extension failed")
            } catch CipherError.Encrypt {
                XCTAssert(false, "Encryption failed")
            } catch CipherError.Decrypt {
                XCTAssert(false, "Decryption failed")
            } catch {
                XCTAssert(false, "Failed")
            }
        }
    }

    func testVector1Py() {
        let key:[UInt8] = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
        let iv:[UInt8]  = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
        let expected:[UInt8] = [0x76,0xB8,0xE0,0xAD,0xA0,0xF1,0x3D,0x90,0x40,0x5D,0x6A,0xE5,0x53,0x86,0xBD,0x28,0xBD,0xD2,0x19,0xB8,0xA0,0x8D,0xED,0x1A,0xA8,0x36,0xEF,0xCC,0x8B,0x77,0x0D,0xC7,0xDA,0x41,0x59,0x7C,0x51,0x57,0x48,0x8D,0x77,0x24,0xE0,0x3F,0xB8,0xD8,0x4A,0x37,0x6A,0x43,0xB8,0xF4,0x15,0x18,0xA1,0x1C,0xC3,0x87,0xB6,0x69,0xB2,0xEE,0x65,0x86]
        let message = [UInt8](count: expected.count, repeating: 0)

        print(message.count)

        let encrypted = try! ChaCha20(key: key, iv: iv)!.encrypt(message)
        XCTAssertEqual(encrypted, expected, "Ciphertext failed")
    }

    func testChaCha20Performance() {
        let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let message = [UInt8](count: (1024 * 1024) * 1, repeating: 7)
        measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: true, forBlock: { () -> Void in
            let encrypted = try! ChaCha20(key: key, iv: iv)?.encrypt(message)
            self.stopMeasuring()
            XCTAssert(encrypted != nil, "not encrypted")
        })
    }
}
