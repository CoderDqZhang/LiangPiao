//
//  MyProfileViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyProfileViewModel: NSObject {
   
    let titleLabel = ["昵称","性别","手机号"]
    override init() {
        
    }
    
    
    func uploadPhototImage(_ image:UIImage){
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
    
    func cellTitle(_ indexPath:IndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func cellDetail(_ indexPath:IndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func updateCellString(_ tableView:UITableView ,string:String, tag:NSInteger) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: tag, section: 1)) as! GloabTitleAndDetailImageCell
        switch tag {
        case 1:
            let gender = string == "男" ? 1 : 2
            UserInfoModel.shareInstance().gender = gender
        default:
            break
        }
        cell.detailLabel.text = string            
    }
    
    func tableViewGloabTitleAndFieldCellData(_ cell:GloabTitleAndFieldCell, indexPath:IndexPath) {
        if indexPath.row == 0 {
            cell.setData(self.cellTitle(indexPath), detail: UserInfoModel.shareInstance().username)
            cell.setTextFieldText(UserInfoModel.shareInstance().username)
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                UserInfoModel.shareInstance().username = str!
            })
        }else{
            cell.setData(self.cellTitle(indexPath), detail: UserInfoModel.shareInstance().phone)
            cell.textField.isEnabled = false
        }
    }
    
    func tableViewGloabTitleAndDetailImageCellData(_ cell:GloabTitleAndDetailImageCell, indexPath:IndexPath) {
        switch indexPath.row {
        case 1:
            let str = UserInfoModel.shareInstance().gender == 1 ? "男" : "女"
            cell.setData(self.cellTitle(indexPath), detail: str)
        default:
            break
        }
    }
    
    func uploadImage(_ image:UIImage) {
        let fileUrl = SaveImageTools.sharedInstance.getCachesDirectory("photoImage.png", path: "headerImage")
        BaseNetWorke.sharedInstance.uploadDataFile(UserAvatar, filePath: fileUrl,name: "avatar")
            .observe { (resultDic) in
                if !resultDic.isCompleted {
                    if (resultDic.value as! NSDictionary).object(forKey: "fail") != nil {
                        print("请求失败")
                    }else{
                        UserInfoModel.shareInstance().avatar = (resultDic.value as! NSDictionary).object(forKey: "avatar") as! String
                        UserInfoModel.shareInstance().update()
                        Notification(LoginStatuesChange, value: nil)
                    }
                }
        }
    }
    
    func changeUserInfoData(_ controller:MyProfileViewController){
        let parameters = ["username":UserInfoModel.shareInstance().username,"gender":UserInfoModel.shareInstance().gender] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(UserInfoChange, parameters: parameters as AnyObject).observe { (resultDic) in
            UserInfoModel.shareInstance().update()
            controller.navigationController?.popViewController(animated: true)
        }
    }
}
