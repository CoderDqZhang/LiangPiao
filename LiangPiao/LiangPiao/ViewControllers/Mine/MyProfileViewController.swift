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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(MyProfileViewController.saveItemPress(_:)))
    }
    
    func saveItemPress(_ sender:UIBarButtonItem) {
        Notification(LoginStatuesChange, value: nil);
        viewModel.changeUserInfoData(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
        if sexPickerView != nil {
            sexPickerView.remove()
        }
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        tableView.register(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
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
            sexPickerView = ZHPickView(pickviewWith: ["男","女"], isHaveNavControler: false)
            sexPickerView.setPickViewColer(UIColor.white)
            sexPickerView.setPickViewColer(UIColor.white)
            sexPickerView.setTintColor(UIColor.white)
            sexPickerView.tag = 1
            sexPickerView.setToolbarTintColor(UIColor.white)
            sexPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            sexPickerView.delegate = self
        }
        
        sexPickerView.show()
    }
    
    func presentImagePickerView(){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (cancelAction) in
            
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let cameraAction = UIAlertAction(title: "拍照", style: .default) { (cancelAction) in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true) {
                    
                }
            }
            controller.addAction(cameraAction)
        }

        
        let album = UIAlertAction(title: "相册", style: .default) { (cancelAction) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true) {
                
            }
        }
        controller.addAction(cancel)
        controller.addAction(album)
        self.present(controller, animated: true) { 
            
        }
        
    }

}

extension MyProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell", for: indexPath) as! ProfileImageTableViewCell
            let image = SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage") == nil ? UIImage.init(named: "Icon_Camera") : SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage")
            if SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage") == nil && UserInfoModel.shareInstance().avatar != "" {
                SDWebImageManager.shared().loadImage(with: URL.init(string: UserInfoModel.shareInstance().avatar), options: .retryFailed, progress: { (star, end, url) in
                    
                }) { (image, data, error, cache, finish, url) in
                    if error == nil {
                        _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
                    }
                }
            }
            cell.photoImageView.setImage(image, for: UIControlState())
            cell.selectionStyle = .none
            return cell
        default:
            switch indexPath.row {
            case 0,2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndFieldCell", for: indexPath) as! GloabTitleAndFieldCell
                viewModel.tableViewGloabTitleAndFieldCellData(cell, indexPath: indexPath)
                cell.textField.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
                cell.textField.returnKeyType = .done
                cell.textField.textAlignment = .right
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                cell.selectionStyle = .none
                if indexPath.row == 4 {
                    cell.hideLineLabel()
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCellData(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            }
            
        }
    }
}

extension MyProfileViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        if resultString != nil {
            viewModel.updateCellString(tableView, string: resultString, tag: pickView.tag)
        }
        if pickView.tag == 3 {
            let cell = tableView.cellForRow(at: IndexPath.init(row: 4, section: 1)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else{
            self.tableView(self.tableView, didSelectRowAt: IndexPath.init(row: pickView.tag + 1, section: 1))
        }
    }
}

extension MyProfileViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { 
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image, path: "headerImage")
        viewModel.uploadImage(image)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MyProfileViewController : UINavigationControllerDelegate {
    
}

extension MyProfileViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.tag == 0 {
            self.tableView(tableView, didSelectRowAt: IndexPath.init(row: 1, section: 1))
        }else{
            self.view.endEditing(true)
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
