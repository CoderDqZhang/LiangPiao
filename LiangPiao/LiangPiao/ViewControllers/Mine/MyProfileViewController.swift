//
//  MyProfileViewController.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class MyProfileViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:MyProfileViewModel = MyProfileViewModel()
    
    var sexPickerView:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "完善资料"
        self.setUpView()
        self.setupForDismissKeyboard()
        self.setNavigationItem()
        self.talKingDataPageName = "个人信息"
        // Do any additional setup after loading the view.
    }
    
    func setNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(MyProfileViewController.saveItemPress(_:)))
    }
    
    func saveItemPress(sender:UIBarButtonItem) {
        Notification(LoginStatuesChange, value: nil);
        viewModel.changeUserInfoData(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
        if KWINDOWDS?.viewWithTag(1) != nil {
            sexPickerView.remove()
        }
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func showSexPickerView(){
        if sexPickerView == nil {
            sexPickerView = ZHPickView(pickviewWithArray: ["男","女"], isHaveNavControler: false)
            sexPickerView.setPickViewColer(UIColor.whiteColor())
            sexPickerView.setPickViewColer(UIColor.whiteColor())
            sexPickerView.setTintColor(UIColor.whiteColor())
            sexPickerView.tag = 1
            sexPickerView.setToolbarTintColor(UIColor.whiteColor())
            sexPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            sexPickerView.delegate = self
        }
        
        sexPickerView.show()
    }
    
    func presentImagePickerView(){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancel = UIAlertAction(title: "取消", style: .Cancel) { (cancelAction) in
            
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let cameraAction = UIAlertAction(title: "拍照", style: .Default) { (cancelAction) in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true) {
                    
                }
            }
            controller.addAction(cameraAction)
        }

        
        let album = UIAlertAction(title: "相册", style: .Default) { (cancelAction) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true) {
                
            }
        }
        controller.addAction(cancel)
        controller.addAction(album)
        self.presentViewController(controller, animated: true) { 
            
        }
        
    }

}

extension MyProfileViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        if indexPath.section == 0 {
            self.presentImagePickerView()
        }else{
            switch indexPath.row {
            case 1:
                self.showSexPickerView()
            default:
                break;
            }
        }
    }
}

extension MyProfileViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileImageTableViewCell", forIndexPath: indexPath) as! ProfileImageTableViewCell
            let image = SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage") == nil ? UIImage.init(named: "Icon_Camera") : SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage")
            if SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage") == nil && UserInfoModel.shareInstance().avatar != "" {
                SDWebImageManager.sharedManager().loadImageWithURL(NSURL.init(string: UserInfoModel.shareInstance().avatar), options: .RetryFailed, progress: { (star, end, url) in
                    
                }) { (image, data, error, cache, finish, url) in
                    if error == nil {
                        SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
                    }
                }
            }
            cell.photoImageView.setImage(image, forState: .Normal)
            cell.selectionStyle = .None
            return cell
        default:
            switch indexPath.row {
            case 0,2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndFieldCell", forIndexPath: indexPath) as! GloabTitleAndFieldCell
                viewModel.tableViewGloabTitleAndFieldCellData(cell, indexPath: indexPath)
                cell.textField.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
                cell.textField.returnKeyType = .Done
                cell.textField.textAlignment = .Right
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                cell.selectionStyle = .None
                if indexPath.row == 4 {
                    cell.hideLineLabel()
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCellData(cell, indexPath: indexPath)
                cell.selectionStyle = .None
                return cell
            }
            
        }
    }
}

extension MyProfileViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        if resultString != nil {
            viewModel.updateCellString(tableView, string: resultString, tag: pickView.tag)
        }
        if pickView.tag == 3 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 4, inSection: 1)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else{
            self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: pickView.tag + 1, inSection: 1))
        }
    }
}

extension MyProfileViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image, path: "headerImage")
        viewModel.uploadImage(image)
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
        self.tableView.reloadData()
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MyProfileViewController : UINavigationControllerDelegate {
    
}

extension MyProfileViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.tag == 0 {
            self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: 1, inSection: 1))
        }else{
            self.view.endEditing(true)
        }
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
