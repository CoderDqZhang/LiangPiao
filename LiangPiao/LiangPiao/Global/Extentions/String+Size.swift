//
//  String+Size.swift
//  Meet
//
//  Created by Zhang on 6/16/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import Foundation
import UIKit


//enum CryptoAlgorithm {
//    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
//    
//    var HMACAlgorithm: CCHmacAlgorithm {
//        var result: Int = 0
//        switch self {
//        case .MD5:      result = kCCHmacAlgMD5
//        case .SHA1:     result = kCCHmacAlgSHA1
//        case .SHA224:   result = kCCHmacAlgSHA224
//        case .SHA256:   result = kCCHmacAlgSHA256
//        case .SHA384:   result = kCCHmacAlgSHA384
//        case .SHA512:   result = kCCHmacAlgSHA512
//        }
//        return CCHmacAlgorithm(result)
//    }
//    
//    var digestLength: Int {
//        var result: Int32 = 0
//        switch self {
//        case .MD5:      result = CC_MD5_DIGEST_LENGTH
//        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
//        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
//        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
//        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
//        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
//        }
//        return Int(result)
//    }
//}

extension String{
    
    //MARK:获得string内容高度
     var length: Int { return self.characters.count }
    
    func heightWithConstrainedWidth(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let normalText: NSString = textStr
        let size = CGSizeMake(width,1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName)
        let stringSize = normalText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.height
    }
    
    func widthWithConstrainedHeight(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        let normalText: NSString = textStr
        let size = CGSizeMake(1000, height)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName)
        let stringSize = normalText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.width
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    func addEncoding(st : String ) ->String? {
        if #available(iOS 8.0, OSX 10.9, *) {
            return st.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        }
        else {
            return  st.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        }
    }
    
    func phoneType(st: String) -> String {
        let temp = NSMutableString.init(string: st)
        if temp.length == 11 {
            temp.insertString("-", atIndex: 3)
            temp.insertString("-", atIndex: 8)
        }else{
            temp.insertString("-", atIndex: 3)
            temp.insertString("-", atIndex: 7)
        }
        return temp as String
    }
    
    func muchType(str:String) -> String {
        let doubleStr = Double(str)
        var str = ""
        if doubleStr! % 10 == 0 {
            str = "\(doubleStr! / 100)0"
        }else{
            str = "\(doubleStr! / 100)"
        }
        return str
    }
    
    func md5() ->String!{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return String(format: hash as String)
    }
    
    func toBase64() -> String? {
        guard let data = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        
        return data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
    
    func dataTojsonString(object:AnyObject) -> String{
        var str = ""
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
             str = String.init(data: jsonData, encoding: NSUTF8StringEncoding)!
        } catch {
            
        }
        return str
    }
    
//    var sha1: String! {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_SHA1(str!, strLen, result)
//        return stringFromBytes(result, length: digestLen)
//    }
//    
//    var sha256String: String! {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_SHA256(str!, strLen, result)
//        return stringFromBytes(result, length: digestLen)
//    }
//    
//    var sha512String: String! {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_SHA512(str!, strLen, result)
//        return stringFromBytes(result, length: digestLen)
//    }
//    
//    func stringFromBytes(bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String{
//        let hash = NSMutableString()
//        for i in 0..<length {
//            hash.appendFormat("%02x", bytes[i])
//        }
//        bytes.dealloc(length)
//        return String(format: hash as String)
//    }
//    
//    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = Int(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = algorithm.digestLength
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        let keyStr = key.cStringUsingEncoding(NSUTF8StringEncoding)
//        let keyLen = Int(key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        
//        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
//        
//        let digest = stringFromResult(result, length: digestLen)
//        
//        result.dealloc(digestLen)
//        
//        return digest
//    }
//    
//    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
//        let hash = NSMutableString()
//        for i in 0..<length {
//            hash.appendFormat("%02x", result[i])
//        }
//        return String(hash)
//    }
    
}//extension end

