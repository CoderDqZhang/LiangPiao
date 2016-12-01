//
//  LoginViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 15/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MJExtension
import SDWebImage

class LoginForm: NSObject {
    var phone:String = ""
    var code:String = ""
}

class LoginViewModel: NSObject {

    override init() {
        
    }
    
    func requestLoginCode(number:String, controller:LoginViewController){
        let dic = ["mobile_num":number]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginCode, parameters: dic).subscribeNext { (resultDic) in
            if (resultDic as! NSDictionary).objectForKey("fail") != nil {
                print("请求失败")
            }else{
                let aMinutes:NSTimeInterval = 60
                controller.startWithStartDate(NSDate(), finishDate: NSDate.init(timeIntervalSinceNow: aMinutes))
            }
        }
    }
    
    func requestLogin(form:LoginForm,controller:LoginViewController) {
        let dic = ["mobile_num":form.phone, "code":form.code]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginUrl, parameters: dic).subscribeNext { (resultDic) in
            let model = UserInfoModel.mj_objectWithKeyValues(resultDic)
            model.phone = form.phone
            UserInfoModel.shareInstance().avatar = model.avatar
            UserInfoModel.shareInstance().username = model.username
            UserInfoModel.shareInstance().id = model.id
            UserInfoModel.shareInstance().gender = model.gender
            UserInfoModel.shareInstance().phone = model.phone
            
            model.saveOrUpdate()
            self.savePhotoImage()
            Notification(LoginStatuesChange, value: nil)
            controller.navigationController?.popViewControllerAnimated(true)
            
        }
    }
    
    func savePhotoImage(){
        if UserInfoModel.shareInstance().avatar != "" {
            SDWebImageManager.sharedManager().loadImageWithURL(NSURL.init(string: UserInfoModel.shareInstance().avatar), options: .RetryFailed, progress: { (star, end, url) in
                
            }) { (image, data, error, cache, finish, url) in
                if error == nil {
                    SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
                }
            }
        }
    }
    
    func requestAddress(){
        BaseNetWorke.sharedInstance.getUrlWithString(AddAddress, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            var addressModels:[AddressModel] = []
            for model in resultModels {
                addressModels.append(AddressModel.init(fromDictionary: model as! NSDictionary))
            }
            AddressModel.archiveRootObject(addressModels)
        }
    }
}
