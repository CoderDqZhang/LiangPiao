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
    func getUrlWithString(url:String, parameters:AnyObject?) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Get, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        subscriber.sendNext(["fail":responseError])
                    }else{
                        subscriber.sendError(responseError as! NSError)
                    }
            })
            return nil
        })
    }
    /// postRequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func postUrlWithString(url:String, parameters:AnyObject?) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Post, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        subscriber.sendNext(["fail":responseError])
                    }else{
                        subscriber.sendError(responseError as! NSError)
                    }
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
    func putUrlWithString(url:String, parameters:AnyObject?) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Put, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        subscriber.sendNext(["fail":responseError])
                    }else{
                        subscriber.sendError(responseError as! NSError)
                    }
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
    func deleteUrlWithString(url:String, parameters:AnyObject?) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.httpRequest(.Delete, url: url, parameters: parameters, success: { (responseObject) in
                subscriber.sendNext(responseObject)
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        subscriber.sendNext(["fail":responseError])
                    }else{
                        subscriber.sendError(responseError as! NSError)
                    }
            })
            return nil
        })
    }
    
    
    func uploadDataFile(url:String, filePath:String,name:String) ->RACSignal{
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            Alamofire.upload(.POST, url, headers: [
                "content-type": "multipart/form-data",
                "cache-control": "no-cache"
                ], multipartFormData: { (multipartFormData) in
                multipartFormData.appendBodyPart(fileURL: NSURL.init(fileURLWithPath: filePath), name: "avatar")
                }, encodingCompletion: { (encodingResult) in
                    switch encodingResult {
                    case .Success(let upload, _, _):
                        upload.responseJSON { response in
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                subscriber.sendNext(response.result.value!)
                            }else{
                                subscriber.sendNext(["fail":response.result.value!])
                            }
//                            debugPrint(response)
                            subscriber.sendCompleted()
                        }
                    case .Failure(let encodingError):
                        subscriber.sendNext(["fail":"服务器请求失败"])
                        print(encodingError)
                        subscriber.sendCompleted()
                    }
            })
            return nil
        })
    }
    
    ///
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func httpRequest(type:HttpRequestType,url:String, parameters:AnyObject?, success:SuccessClouse, failure:FailureClouse) {
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
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    success(responseObject: response.result.value!)
                }else{
                    failure(responseError: response.result.value!)
                }
            }
        }
    }
}
