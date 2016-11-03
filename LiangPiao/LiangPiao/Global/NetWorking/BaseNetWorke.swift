//
//  BaseNetWorke.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveCocoa

typealias SuccessClouse = (responseObject:AnyObject) -> Void
typealias FailureClouse = (responseError:AnyObject) -> Void

enum HttpRequestType {
    case Post
    case Get
    case Delete
    case Put
}

class BaseNetWorke {
    private init() {
    }
    
    static let sharedInstance = BaseNetWorke()
    /// getRequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func getUrlWithString(url:String, parameters:AnyObject) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Get, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    subscriber.sendError(responseError as! NSError)
                    subscriber.sendCompleted()
            })
            return nil
        })
    }
    /// postRequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func postUrlWithString(url:String, parameters:AnyObject) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Post, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                subscriber.sendError(responseError as! NSError)
                subscriber.sendCompleted()
            })
            return nil
        })
        
    }
    
    /// Putrequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func putUrlWithString(url:String, parameters:AnyObject) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Put, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    subscriber.sendError(responseError as! NSError)
                    subscriber.sendCompleted()
            })
            return nil
        })
    }
    
    /// 删除request
    ///
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func deleteUrlWithString(url:String, parameters:AnyObject) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Delete, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    subscriber.sendError(responseError as! NSError)
                    subscriber.sendCompleted()
            })
            return nil
        })
    }
    
    ///
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func httpRequest(type:HttpRequestType,url:String, parameters:AnyObject, success:SuccessClouse, failure:FailureClouse) {
        var method:Alamofire.Method
        switch type {
            case .Post:
                method = .POST
            case .Get:
                method = .GET
            case .Delete:
                method = .DELETE
            default:
                method = .PUT
        }
        Alamofire.request(method, url, parameters: parameters as? [String : AnyObject], encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error != nil{
                failure(responseError: response.result.error!)
            }else{
                success(responseObject: response.result.value!)
            }
        }
    }
}
