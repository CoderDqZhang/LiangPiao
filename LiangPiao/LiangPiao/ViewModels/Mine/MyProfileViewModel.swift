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
    
    
    func uploadPhototImage(image:UIImage){
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
    
    func cellTitle(indexPath:NSIndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func cellDetail(indexPath:NSIndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func updateCellString(tableView:UITableView ,string:String, tag:NSInteger) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: tag, inSection: 1)) as! GloabTitleAndDetailImageCell
        switch tag {
        case 1:
            let gender = string == "男" ? 0 : 1
            UserInfoModel.shareInstance().gender = gender
        default:
            break
        }
        cell.detailLabel.text = string            
    }
    
    func tableViewGloabTitleAndFieldCellData(cell:GloabTitleAndFieldCell, indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            cell.setData(self.cellTitle(indexPath), detail: UserInfoModel.shareInstance().username)
            cell.textField.rac_textSignal().subscribeNext({ (str) in
                UserInfoModel.shareInstance().username = str as! String
            })
        }else{
            cell.setData(self.cellTitle(indexPath), detail: UserInfoModel.shareInstance().phone)
            cell.textField.enabled = false
        }
    }
    
    func tableViewGloabTitleAndDetailImageCellData(cell:GloabTitleAndDetailImageCell, indexPath:NSIndexPath) {
        switch indexPath.row {
        case 1:
            let str = UserInfoModel.shareInstance().gender == 0 ? "男" : "女"
            cell.setData(self.cellTitle(indexPath), detail: str)
        default:
            break
        }
    }
    
    func uploadImage(image:UIImage) {
        let fileUrl = SaveImageTools.sharedInstance.getCachesDirectory("photoImage.png", path: "headerImage")
        BaseNetWorke.sharedInstance.uploadDataFile(UserAvatar, filePath: fileUrl,name: "avatar")
            .subscribeNext { (resultDic) in
                if (resultDic as! NSDictionary).objectForKey("fail") != nil {
                    print("请求失败")
                }else{
                    UserInfoModel.shareInstance().avatar = (resultDic as! NSDictionary).objectForKey("avatar") as! String
                    UserInfoModel.shareInstance().update()
                    Notification(LoginStatuesChange, value: nil)
                }
        }
    }
}
