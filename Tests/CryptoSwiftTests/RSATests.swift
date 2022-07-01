//
//  CryptoSwift
//
//  Copyright (C) 2014-2021 Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//

import Foundation
import XCTest
@testable import CryptoSwift

final class RSATests: XCTestCase {
  
  func testSmallRSA() {
    /*
     * Example taken from the book "Understanding Cryptography"
     *
     * p = 3; q = 11; n = pq = 33; e = 3; d = 7
     */
    
    let n: Array<UInt8> = [33]
    let e: Array<UInt8> = [3]
    let d: Array<UInt8> = [7]
    let message: Array<UInt8> = [4]
    let expected: Array<UInt8> = [31]
    
    let rsa = RSA(n: n, e: e, d: d)
    XCTAssertEqual(rsa.keySize, 6, "key size is not correct")
    
    let encrypted = try! rsa.encrypt(message)
    XCTAssertEqual(encrypted, expected, "small encrypt failed")
    
    let decrypted = try! rsa.decrypt(encrypted)
    XCTAssertEqual(decrypted, message, "small decrypt failed")
  }

  func testRSA1() {
    /*
     * Taken from http://cryptomanager.com/tv.html
     *
     * 1. 1024-bit RSA bare exponentiation
     */
    
    let n: Array<UInt8> = [
      0xF0, 0xC4, 0x2D, 0xB8, 0x48, 0x6F, 0xEB, 0x95, 0x95, 0xD8, 0xC7, 0x8F, 0x90, 0x8D, 0x04, 0xA9,
      0xB6, 0xC8, 0xC7, 0x7A, 0x36, 0x10, 0x5B, 0x1B, 0xF2, 0x75, 0x53, 0x77, 0xA6, 0x89, 0x3D, 0xC4,
      0x38, 0x3C, 0x54, 0xEC, 0x6B, 0x52, 0x62, 0xE5, 0x68, 0x8E, 0x5F, 0x9D, 0x9D, 0xD1, 0x64, 0x97,
      0xD0, 0xE3, 0xEA, 0x83, 0x3D, 0xEE, 0x2C, 0x8E, 0xBC, 0xD1, 0x43, 0x83, 0x89, 0xFC, 0xCA, 0x8F,
      0xED, 0xE7, 0xA8, 0x8A, 0x81, 0x25, 0x7E, 0x8B, 0x27, 0x09, 0xC4, 0x94, 0xD4, 0x2F, 0x72, 0x3D,
      0xEC, 0x2E, 0x0B, 0x5C, 0x09, 0x73, 0x1C, 0x55, 0x0D, 0xCC, 0x9D, 0x7E, 0x75, 0x25, 0x89, 0x89,
      0x1C, 0xBB, 0xC3, 0x02, 0x13, 0x07, 0xDD, 0x91, 0x8E, 0x10, 0x0B, 0x34, 0xC0, 0x14, 0xA5, 0x59,
      0xE0, 0xE1, 0x82, 0xAF, 0xB2, 0x1A, 0x72, 0xB3, 0x07, 0xCC, 0x39, 0x5D, 0xEC, 0x99, 0x57, 0x47
    ]
    let e: Array<UInt8> = [
      0x01, 0x00, 0x01
    ]
    let d: Array<UInt8> = [
      0x24, 0x89, 0x10, 0x8B, 0x0B, 0x6A, 0xF8, 0x6B, 0xED, 0x9E, 0x44, 0xC2, 0x33, 0x64, 0x42, 0xD5,
      0xE2, 0x27, 0xDB, 0xA5, 0x5E, 0xF8, 0xE2, 0x6A, 0x7E, 0x43, 0x71, 0x94, 0x11, 0x90, 0x77, 0xF0,
      0x03, 0xBC, 0x9C, 0x02, 0x78, 0x52, 0xBB, 0x31, 0x26, 0xC9, 0x9C, 0x16, 0xD5, 0xF1, 0x05, 0x7B,
      0xC8, 0x36, 0x1D, 0xCB, 0x26, 0xA5, 0xB2, 0xDB, 0x42, 0x29, 0xDB, 0x3D, 0xE5, 0xBD, 0x97, 0x9B,
      0x2E, 0x59, 0x7D, 0x19, 0x16, 0xD7, 0xBB, 0xC9, 0x27, 0x46, 0xFC, 0x07, 0x59, 0x5C, 0x76, 0xB4,
      0x4B, 0x39, 0xA4, 0x76, 0xA6, 0x5C, 0x86, 0xF0, 0x86, 0xDC, 0x92, 0x83, 0xCA, 0x6D, 0x1E, 0xEF,
      0xC1, 0x49, 0x15, 0x98, 0x2F, 0x9C, 0x4C, 0xED, 0x5F, 0x62, 0xA9, 0xFF, 0x3B, 0xE2, 0x42, 0x18,
      0xA9, 0x93, 0x57, 0xB5, 0xB6, 0x5C, 0x3B, 0x10, 0xAE, 0xB3, 0x67, 0xE9, 0x11, 0xEB, 0x9E, 0x21
    ]
    let message: Array<UInt8> = [
      0x11, 0x22, 0x33, 0x44
    ]
    let expected: Array<UInt8> = [
      0x50, 0x5B, 0x09, 0xBD, 0x5D, 0x0E, 0x66, 0xD7, 0xC8, 0x82, 0x9F, 0x5B, 0x47, 0x3E, 0xD3, 0x4D,
      0xB5, 0xCF, 0xDB, 0xB5, 0xD5, 0x8C, 0xE7, 0x83, 0x29, 0xC8, 0xBF, 0x85, 0x20, 0xE4, 0x86, 0xD3,
      0xC4, 0xCF, 0x9B, 0x70, 0xC6, 0x34, 0x65, 0x94, 0x35, 0x80, 0x80, 0xF4, 0x3F, 0x47, 0xEE, 0x86,
      0x3C, 0xFA, 0xF2, 0xA2, 0xE5, 0xF0, 0x3D, 0x1E, 0x13, 0xD6, 0xFE, 0xC5, 0x7D, 0xFB, 0x1D, 0x55,
      0x22, 0x24, 0xC4, 0x61, 0xDA, 0x41, 0x1C, 0xFE, 0x5D, 0x0B, 0x05, 0xBA, 0x87, 0x7E, 0x3A, 0x42,
      0xF6, 0xDE, 0x4D, 0xA4, 0x6A, 0x96, 0x5C, 0x9B, 0x69, 0x5E, 0xE2, 0xD5, 0x0E, 0x40, 0x08, 0x94,
      0x06, 0x1C, 0xB0, 0xA2, 0x1C, 0xA3, 0xA5, 0x24, 0xB4, 0x07, 0xE9, 0xFF, 0xBA, 0x87, 0xFC, 0x96,
      0x6B, 0x3B, 0xA9, 0x45, 0x90, 0x84, 0x9A, 0xEB, 0x90, 0x8A, 0xAF, 0xF4, 0xC7, 0x19, 0xC2, 0xE4
    ]
    
    let rsa = RSA(n: n, e: e, d: d)
    XCTAssertEqual(rsa.keySize, 1024, "key size is not correct")
    
    let encrypted = try! rsa.encrypt(message)
    XCTAssertEqual(encrypted, expected, "encrypt failed")
    
    let decrypted = try! rsa.decrypt(encrypted)
    XCTAssertEqual(decrypted, message, "decrypt failed")
  }
  
  func testRSA2() {
    /*
     * Taken from http://cryptomanager.com/tv.html
     *
     * 2. 2048-bit PKCS V. 1.5 enciphering.
     */
    
    let n: Array<UInt8> = [
      0xF7, 0x48, 0xD8, 0xD9, 0x8E, 0xD0, 0x57, 0xCF, 0x39, 0x8C, 0x43, 0x7F, 0xEF, 0xC6, 0x15, 0xD7,
      0x57, 0xD3, 0xF8, 0xEC, 0xE6, 0xF2, 0xC5, 0x80, 0xAE, 0x07, 0x80, 0x76, 0x8F, 0x9E, 0xC8, 0x3A,
      0xAA, 0x08, 0x1F, 0xF0, 0x9E, 0x53, 0x17, 0xED, 0x60, 0x99, 0xC6, 0x3F, 0xD1, 0x5C, 0xFE, 0x11,
      0x17, 0x2F, 0x78, 0x90, 0x8C, 0xD5, 0x8C, 0x03, 0xAE, 0xC9, 0x3A, 0x48, 0x1F, 0xF5, 0x0E, 0x17,
      0x22, 0x04, 0xAF, 0xED, 0xFC, 0x1F, 0x16, 0xAF, 0xDB, 0x99, 0x0A, 0xAB, 0x45, 0xBE, 0x19, 0x0B,
      0xC1, 0x92, 0x59, 0xBD, 0x4A, 0x1B, 0xFC, 0xDF, 0xBE, 0x2A, 0x29, 0x8B, 0x3C, 0x0E, 0x31, 0x8F,
      0x78, 0xA3, 0x39, 0x19, 0x88, 0x23, 0x28, 0xDA, 0xCA, 0xC8, 0x5C, 0xB3, 0x5A, 0x0D, 0xE5, 0x37,
      0xB1, 0x63, 0x76, 0x97, 0x52, 0x17, 0xE5, 0xA5, 0xEA, 0xAF, 0x98, 0x26, 0x6B, 0x58, 0x8C, 0x2D,
      0xBA, 0xFD, 0x0B, 0xE3, 0x71, 0xC3, 0x49, 0x89, 0xCB, 0x36, 0xE6, 0x23, 0xD7, 0x5E, 0xFF, 0xED,
      0xBE, 0x4A, 0x95, 0x1A, 0x68, 0x40, 0x98, 0x2B, 0xC2, 0x79, 0xB3, 0x0F, 0xCD, 0x41, 0xDA, 0xC8,
      0x7C, 0x00, 0x74, 0xD4, 0x62, 0xF1, 0x01, 0x29, 0x00, 0xB8, 0x97, 0x3B, 0x46, 0xAD, 0xC7, 0xEA,
      0xC0, 0x17, 0x70, 0xDF, 0xC6, 0x32, 0xEA, 0x96, 0x7F, 0x94, 0x71, 0xE9, 0x78, 0x98, 0x31, 0xF3,
      0xA4, 0x10, 0x73, 0x0F, 0xF9, 0x14, 0x34, 0x8B, 0xE1, 0x11, 0x86, 0x3C, 0x13, 0x37, 0x63, 0x01,
      0x07, 0x97, 0x56, 0xA1, 0x47, 0xD8, 0x01, 0x03, 0xCE, 0x9F, 0xA6, 0x88, 0xA3, 0x38, 0xE2, 0x2B,
      0x2D, 0x91, 0x6C, 0xAD, 0x42, 0xD6, 0x73, 0xC9, 0xD0, 0x0F, 0x08, 0x21, 0x4D, 0xE5, 0x44, 0xF5,
      0xDE, 0x81, 0x2A, 0x9A, 0x94, 0x91, 0x89, 0x07, 0x8B, 0x2B, 0xDA, 0x14, 0xB2, 0x8C, 0xA6, 0x2F
    ]
    let e: Array<UInt8> = [
      0x01, 0x00, 0x01
    ]
    let d: Array<UInt8> = [
      0x1C, 0xBC, 0x9A, 0x76, 0xAD, 0xE2, 0x08, 0x52, 0x4C, 0x9D, 0xC0, 0x3A, 0x5D, 0xE2, 0xE7, 0x26,
      0xDF, 0x4E, 0x02, 0xDF, 0x84, 0xF7, 0x31, 0x7C, 0x82, 0xBC, 0xDC, 0x70, 0xEA, 0xBF, 0xC9, 0x05,
      0x08, 0x3D, 0x69, 0x78, 0xCC, 0xED, 0x5B, 0x1A, 0x7A, 0xDF, 0x63, 0xEA, 0x86, 0xAA, 0x07, 0xDC,
      0x74, 0x95, 0x4F, 0xAD, 0x7C, 0xB0, 0x54, 0x55, 0x19, 0x3A, 0xC9, 0x4B, 0x18, 0x6B, 0xA1, 0xF7,
      0x8E, 0x3C, 0x7D, 0x35, 0x6A, 0xD7, 0x32, 0x0B, 0xBD, 0xB9, 0x4B, 0x44, 0x1C, 0x16, 0xBB, 0x52,
      0x62, 0x6C, 0x5F, 0x81, 0x5F, 0xDB, 0x60, 0xC7, 0x9F, 0x91, 0xC6, 0xC2, 0x27, 0x78, 0x7E, 0xC9,
      0xED, 0x7B, 0x0A, 0x67, 0xAD, 0x2A, 0x68, 0xD5, 0x04, 0x3B, 0xC4, 0x8A, 0x13, 0x2D, 0x0A, 0x36,
      0x2E, 0xA7, 0x20, 0x60, 0xF5, 0x69, 0x51, 0x86, 0xB6, 0x7F, 0x31, 0x6F, 0x45, 0x8A, 0x44, 0xBF,
      0xD1, 0x40, 0x3D, 0x93, 0xA9, 0xB9, 0x12, 0xCB, 0xB5, 0x98, 0x15, 0x91, 0x6A, 0x14, 0xA2, 0xBA,
      0xD4, 0xF9, 0xA1, 0xED, 0x57, 0x8E, 0xBD, 0x2B, 0x5D, 0x47, 0x2F, 0x62, 0x3B, 0x4B, 0xB5, 0xF9,
      0xB8, 0x0B, 0x93, 0x57, 0x2B, 0xEA, 0x61, 0xBD, 0x10, 0x68, 0x09, 0x4E, 0x41, 0xE8, 0x39, 0x0E,
      0x2E, 0x28, 0xA3, 0x51, 0x43, 0x3E, 0xDD, 0x1A, 0x09, 0x9A, 0x8C, 0x6E, 0x68, 0x92, 0x60, 0x4A,
      0xEF, 0x16, 0x3A, 0x43, 0x9B, 0x1C, 0xAE, 0x6A, 0x09, 0x5E, 0x68, 0x94, 0x3C, 0xA6, 0x7B, 0x18,
      0xC8, 0xDC, 0x7F, 0x98, 0xCC, 0x5F, 0x8E, 0xFA, 0x22, 0xBB, 0xC8, 0x7D, 0x2E, 0x73, 0x57, 0x83,
      0xD2, 0xBA, 0xA3, 0x8F, 0x4C, 0x17, 0xD5, 0xED, 0x0C, 0x58, 0x36, 0x6D, 0xCE, 0xF5, 0xE8, 0x52,
      0xDD, 0x3D, 0x6E, 0x0F, 0x63, 0x72, 0x95, 0x43, 0xE2, 0x63, 0x8B, 0x29, 0x14, 0xD7, 0x2A, 0x01
    ]
    let message: Array<UInt8> = [
      0x11, 0x22, 0x33, 0x44
    ]
    let expected: Array<UInt8> = [
      0xEE, 0x69, 0x09, 0x9A, 0xFD, 0x9F, 0x99, 0xD6, 0x06, 0x5D, 0x65, 0xE1, 0x5F, 0x90, 0xB9, 0x23,
      0x7C, 0x16, 0x98, 0x7D, 0x48, 0x72, 0xE2, 0xB9, 0x94, 0xED, 0x2B, 0x9E, 0x56, 0x85, 0xF9, 0xBA,
      0x48, 0x9A, 0xB9, 0x36, 0xCC, 0x1E, 0x3D, 0xFD, 0x15, 0xB3, 0x5F, 0xEE, 0x21, 0x53, 0x6F, 0x8C,
      0x22, 0x20, 0xAE, 0x43, 0x21, 0x7D, 0x91, 0xD8, 0x1C, 0x9E, 0xD0, 0x1D, 0xE5, 0xBA, 0xEE, 0xF4,
      0xEF, 0xC7, 0x21, 0xD7, 0x0D, 0x67, 0xB5, 0x16, 0x6E, 0x43, 0xD8, 0x27, 0x24, 0xF3, 0x9B, 0xF0,
      0xBD, 0x19, 0x7C, 0x31, 0xE7, 0x48, 0x51, 0x8D, 0xEE, 0x63, 0xEC, 0x10, 0x98, 0x7A, 0x08, 0x39,
      0x0B, 0x15, 0xCC, 0x41, 0x57, 0x67, 0x7C, 0x54, 0x22, 0x6A, 0x8B, 0x04, 0xB4, 0x76, 0x84, 0xAE,
      0xDD, 0x02, 0xB4, 0x8C, 0x8E, 0xD4, 0x8A, 0x44, 0xBD, 0x13, 0x53, 0x97, 0xAC, 0x28, 0x69, 0x76,
      0x9B, 0x68, 0xC7, 0xD3, 0xBF, 0xAC, 0xDB, 0x72, 0xAF, 0xCD, 0x74, 0x42, 0xC2, 0x25, 0x17, 0xE0,
      0x44, 0x99, 0x6C, 0xB6, 0x8E, 0x0A, 0x31, 0x1D, 0xF5, 0xD6, 0xD2, 0xD2, 0x86, 0x37, 0x25, 0x56,
      0xF0, 0x19, 0x31, 0x66, 0xCC, 0x36, 0x4E, 0x65, 0x4E, 0xF4, 0x05, 0xDD, 0x22, 0xFB, 0xE5, 0x84,
      0xDB, 0xF6, 0x0F, 0x05, 0x52, 0x96, 0x06, 0x68, 0xFB, 0x69, 0x52, 0x2C, 0x1B, 0x52, 0x64, 0xF1,
      0x94, 0xFA, 0xC9, 0xF3, 0x56, 0x22, 0xE9, 0x82, 0x27, 0x63, 0x8F, 0xF2, 0x8B, 0x91, 0x0D, 0x8C,
      0xC9, 0x0E, 0x50, 0x11, 0x02, 0x12, 0x12, 0xC9, 0x6C, 0x64, 0xC8, 0x58, 0x20, 0x87, 0x7A, 0x7D,
      0x15, 0x59, 0x23, 0x5E, 0x99, 0xC3, 0x2A, 0xBE, 0xF3, 0x3D, 0x95, 0xE2, 0x8E, 0x18, 0xCC, 0xA3,
      0x44, 0x2E, 0x6E, 0x3A, 0x43, 0x2F, 0xFF, 0xEA, 0x10, 0x10, 0x4A, 0x8E, 0xEE, 0x94, 0xC3, 0x62
    ]
    
    let rsa = RSA(n: n, e: e, d: d)
    XCTAssertEqual(rsa.keySize, 2048, "key size is not correct")
    
    let encrypted = try! rsa.encrypt(message)
    XCTAssertEqual(encrypted, expected, "encrypt failed")
    
    let decrypted = try! rsa.decrypt(encrypted)
    XCTAssertEqual(decrypted, message, "decrypt failed")
  }
  
  func testGenerateKeyPair() {
    /*
     * To test key generation and its validity
     */
    let message: Array<UInt8> = [
      0x11, 0x22, 0x33, 0x44
    ]
    
    do {
      let rsa = try RSA(keySize: 2048)
      // Sometimes the modulus size is 2047 bits, but it's okay (with two 1024 bits primes)
      //XCTAssertEqual(rsa.keySize, 2048, "key size is not correct")
    
      let decrypted = try rsa.decrypt(rsa.encrypt(message))
      XCTAssertEqual(decrypted, message, "encrypt+decrypt failed")
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

}

extension RSATests {
  static func allTests() -> [(String, (RSATests) -> () -> Void)] {
    let tests = [
      ("testSmallRSA", testSmallRSA),
      ("testRSA1", testRSA1),
      ("testRSA2", testRSA2),
      ("testGenerateKeyPair", testGenerateKeyPair)
    ]

    return tests
  }
}
