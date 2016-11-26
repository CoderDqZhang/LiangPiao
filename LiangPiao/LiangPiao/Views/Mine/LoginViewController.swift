//
//  LoginViewController.swift
//  LiangPiao
//
//  Created by Zhang on 09/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var phoneLabel:UILabel!
    var phontTextField:UITextField!
    var confimCodeLabel:UILabel!
    var confimCodeField:UITextField!
    
    var lineLabel:GloabLineView!
    var lineLabel1:GloabLineView!
    
    var loginButton:UIButton!
    var senderCode:UIButton!
    var serviceLabel:UILabel!
    
    var phoneStr:String = ""
    var smsCodeStr:String = ""
    
    var comfigLabel:UILabel!
    var proBtn:UIButton!
    
    let loginForm = LoginForm()
    
    var timeDownLabel:CountDown!
    
    var viewModel:LoginViewModel = LoginViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setUpView()
        self.setupForDismissKeyboard()
        self.setUpNavigationItem()
        self.talKingDataPageName = "登录"
        // Do any additional setup after loading the view.
    }
    
    deinit {
        timeDownLabel.destoryTimer()
    }
    
    func setUpView() {
        timeDownLabel = CountDown()
        
        phoneLabel = self.createLabel(CGRectZero, text: "手机号")
        self.view.addSubview(phoneLabel)
        
        lineLabel = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.view.addSubview(lineLabel)
        
        confimCodeLabel = self.createLabel(CGRectZero, text: "验证码")
        self.view.addSubview(confimCodeLabel)
        
        lineLabel1 = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.view.addSubview(lineLabel1)
        
        confimCodeField = self.createTextFiled(CGRectZero)
        confimCodeField.delegate = self
        confimCodeField.text = "1234"
        confimCodeField.textColor = UIColor.init(hexString: App_Theme_Text_Color)
        confimCodeField.font = Login_TextField_Font
        confimCodeField.rac_textSignal().subscribeNext { (action) in
            self.loginForm.code = action as! String
        }
        confimCodeField.keyboardType = .PhonePad
        self.view.addSubview(confimCodeField)
        
        phontTextField = self.createTextFiled(CGRectZero)
        phontTextField.delegate = self
        phontTextField.tag = 1
        phontTextField.text = "18363899723"
        phontTextField.textColor = UIColor.init(hexString: App_Theme_Text_Color)
        phontTextField.keyboardType = .PhonePad
        phontTextField.font = Login_TextField_Font
        phontTextField.rac_textSignal().subscribeNext { (action) in
            self.loginForm.phone = action as! String
            if self.senderCode != nil {
                if action.length == 11 {
                    self.senderCode.enabled = true
                    self.senderCode.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
                }else{
                    self.senderCode.enabled = false
                    self.senderCode.backgroundColor = UIColor.init(hexString: LoginView_CodeSenderButton_bColor)
                }
            }
        }
        self.view.addSubview(phontTextField)
        
        senderCode = UIButton(type: .Custom)
        senderCode.backgroundColor = UIColor.init(hexString: LoginView_CodeSenderButton_bColor)
        senderCode.setTitle("发验证码", forState: .Normal)
        senderCode.titleLabel?.font = LoginView_CodeSenderButton_Font
        senderCode.enabled = false
        
        senderCode.layer.cornerRadius = 2.0
        senderCode.layer.masksToBounds = true
        senderCode.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.viewModel.requestLoginCode(self.loginForm.phone, controller: self)
        }
        self.view.addSubview(senderCode)
        
        loginButton = UIButton(type: .Custom)
        loginButton.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        loginButton.setTitle("立即登录", forState: .Normal)
        loginButton.titleLabel?.font = LoginView_LoginButton_Font
        loginButton.enabled = true
        loginButton.layer.cornerRadius = 2.0
        loginButton.layer.masksToBounds = true
        loginButton.setTitleColor(UIColor.init(hexString: NavigationBar_Title_Color), forState: .Normal)
        loginButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.viewModel.requestLogin(self.loginForm, controller: self)
        }
        self.view.addSubview(loginButton)
        
        
        comfigLabel = UILabel()
        comfigLabel.text = "登录即代表您同意"
        comfigLabel.textColor = UIColor.init(hexString: LoginView_Label_Color)
        comfigLabel.font = LoginView_Service_Font
        self.view.addSubview(comfigLabel)
        
        proBtn = UIButton(type: .Custom)
        proBtn.setTitle("《良票用户协议》", forState: .Normal)
        proBtn.setTitleColor(UIColor.init(hexString: App_Theme_BackGround_Color),forState: .Normal)
        proBtn.titleLabel?.font = LoginView_Service_Font
        proBtn.layer.cornerRadius = 2.0
        proBtn.layer.masksToBounds = true
        proBtn.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            
        }
        self.view.addSubview(proBtn)
        
        self.makeConstraints()

    }
    
    func startWithStartDate(date:NSDate, finishDate:NSDate){
        timeDownLabel.countDownWithStratDate(date, finishDate: finishDate) { (day, hours, minutes, seconds) in
            let totoalSecod = day*24*60*60+hours*60*60+minutes*60+seconds
            if totoalSecod == 0 {
                self.senderCode.enabled = true
                self.senderCode.setTitle("发验证码", forState: .Normal)
            }else{
                self.senderCode.enabled = false
                self.senderCode.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
                self.senderCode.setTitle("\(totoalSecod)s", forState: .Normal)
            }
        }
    }
    
    func setUpNavigationItem() {
        self.navigationItem.title = "登录"
        self.setNavigationItemBack()
    }

    func createLabel(frame:CGRect, text:String) ->UILabel {
        let label = UILabel(frame: frame)
        label.textColor = UIColor.init(hexString: LoginView_Label_Color)
        label.font = LoginView_Label_Font
        label.text = text
        return label
    }
    
    func createTextFiled(frame:CGRect) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.font = LoginView_Label_Font
        textField.tintColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        return textField
    }
    
    func makeConstraints(){
        phoneLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(50)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.width.equalTo(49)
        }
        
        phontTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(49)
            make.left.equalTo(self.phoneLabel.snp_right).offset(28)
            make.right.equalTo(self.senderCode.snp_left).offset(-10)
            make.height.equalTo(20)
        }
        
        senderCode.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(45)
            make.right.equalTo(self.view.snp_right).offset(-15)
            make.size.equalTo(CGSizeMake(70, 29))
        }
        
        lineLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.phontTextField.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.right.equalTo(self.view.snp_right).offset(-15)
        }
        
        confimCodeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.lineLabel.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.width.equalTo(49)
        }
        
        confimCodeField.snp_makeConstraints { (make) in
            make.top.equalTo(self.lineLabel.snp_bottom).offset(17)
            make.left.equalTo(self.confimCodeLabel.snp_right).offset(28)
            make.right.equalTo(self.view.snp_right).offset(-15)
            make.height.equalTo(20)
        }
        
        lineLabel1.snp_makeConstraints { (make) in
            make.top.equalTo(self.confimCodeLabel.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.right.equalTo(self.view.snp_right).offset(-15)
        }
        
        loginButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.lineLabel1.snp_bottom).offset(28)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.right.equalTo(self.view.snp_right).offset(-15)
            make.height.equalTo(49)
        }
        
        comfigLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.loginButton.snp_bottom).offset(24)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.height.equalTo(17)
        }
        
        proBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.loginButton.snp_bottom).offset(24)
            make.left.equalTo(self.comfigLabel.snp_right).offset(2)
            make.height.equalTo(17)
        }
        
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

}

extension LoginViewController : UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            if textField.tag == 1 {
                phoneStr = ((textField.text)! + string)
            }else if textField.tag == 2 {
                smsCodeStr = ((textField.text)! + string)
            }
        }else{
            if textField.tag == 1 {
                if textField.text?.length == 0 || (range.location == 0 && string == ""){
                    phoneStr = textField.text!
                }else{
                    phoneStr = ""
                }
            }else if textField.tag == 2 {
                if textField.text?.length == 0 || (range.location == 0 && string == "") {
                    smsCodeStr = textField.text!
                }else{
                    smsCodeStr = ""
                }
            }
        }
        
        
        return true
    }
}
