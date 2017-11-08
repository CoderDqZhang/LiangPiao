//
//  GloabView.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift

typealias SearchNavigationBarCancelClouse = () ->Void
typealias SearchTextFieldBecomFirstRespoder = () ->Void

class HomeSearchNavigationBar: UIView {
    
    var searchField:HomeBandSearchField!
    var cancelButton:UIButton!
    var searchNavigationBarCancelClouse:SearchNavigationBarCancelClouse!
    var searchTextFieldBecomFirstRespoder:SearchTextFieldBecomFirstRespoder!
    init(frame: CGRect, font:UIFont?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.setUpView(font)
    }
    
    func setUpView(_ font:UIFont?) {
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRect(x: 15, y: 15, width: (searchImage?.size.width)!, height: (searchImage?.size.height)!)
        
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: SCREENWIDTH - 64, y: IPHONEX ? 47 : 27,width: 64, height: 30)
        cancelButton.setTitle("取消", for: UIControlState())
        cancelButton.titleLabel?.font = App_Theme_PinFan_L_17_Font
        cancelButton.isHidden = true
//        cancelButton.
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            if self.searchNavigationBarCancelClouse != nil{
                self.searchNavigationBarCancelClouse()
            }
        }
        self.addSubview(cancelButton)
        
        searchField = HomeBandSearchField(frame:CGRect(x: 20, y: IPHONEX ? 47 : 27,width: SCREENWIDTH - 40, height: 30))
        
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholder(in: CGRect(x: 20, y: -60, width: searchField.frame.size.width, height: searchField.frame.size.height))
        if font == nil {
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        }else{
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        }
        searchField.delegate = self
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        searchField.leftView = leftImage
        searchField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        searchField.backgroundColor = UIColor.white
        searchField.leftViewMode = .always
        searchField.returnKeyType = .search
        searchField.font = App_Theme_PinFan_R_14_Font
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        searchField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        searchField.clearButtonMode = .always
        self.addSubview(searchField)
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

typealias GloableSearchBarClouse = () -> Void
class GloableSearchNavigationBarView : UIView {
    var searchButton:UIButton!
    var titleLabel:UILabel!
    init(frame:CGRect, title:String, searchClouse:  @escaping GloableSearchBarClouse) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        
        titleLabel = UILabel(frame: CGRect.init(x: 50, y: IPHONEX ? 47 : 27, width: frame.size.width - 100, height: 40))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_L_17_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(titleLabel)
        
        searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage.init(named: "Icon_Search_W")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        searchButton.frame = CGRect.init(x: frame.size.width - 50, y: IPHONEX ? 47 : 27, width: 40, height: 40)
        searchButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            _ = searchClouse()
        }
        self.addSubview(searchButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSearchNavigationBar : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.searchTextFieldBecomFirstRespoder != nil {
            self.searchTextFieldBecomFirstRespoder()
        }
        textField.frame = CGRect(x: 20, y: IPHONEX ? 47 : 27,width: SCREENWIDTH - 84, height: 30)
        cancelButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

class GloabView: UIView {

}

class GloabLineView: UIView {
    
    let lineLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        lineLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.addSubview(lineLabel)
    }
    
    func setLineColor(_ color:UIColor){
        lineLabel.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias GlobalNavigationClouse = () ->Void
class GlobalNavigationBarView : UIView {
    
    
    var globalNavigationClouse:GlobalNavigationClouse!
    
    init(frame:CGRect, title:String, detail:String) {
        super.init(frame:frame)
        let titleLabel:UILabel! = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 5, width: frame.size.width, height: 18)
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        let detailLabel:UILabel! = UILabel()
        detailLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 1, width: frame.size.width, height: 13)
        detailLabel.text = detail
        detailLabel.font = App_Theme_PinFan_R_11_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        detailLabel.textAlignment = .center
        self.addSubview(detailLabel)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GlobalNavigationBarView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer) {
        if self.globalNavigationClouse != nil {
            self.globalNavigationClouse()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GlobalNavigationBarWithLabelView : UIView {
    
    
    var globalNavigationClouse:GlobalNavigationClouse!
    
    init(frame:CGRect, title:String) {
        super.init(frame:frame)
        let titleLabel:UILabel! = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        titleLabel.font = App_Theme_PinFan_L_17_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GlobalNavigationBarView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer) {
        if self.globalNavigationClouse != nil {
            self.globalNavigationClouse()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum GlobalTicketStatusTypeBgColor {
    
}

class GlobalTicketStatus : UIView {
    
    var globalNavigationClouse:GlobalNavigationClouse!
    var viewWidth:CGFloat = 0
    init(frame:CGRect, titles:[String], types:NSArray?) {
        super.init(frame:frame)
        self.setUpView(titles, types: types)
        self.backgroundColor = UIColor.clear
    }
    
    func setUpView(_ titles:[String], types:NSArray?){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        var originX:CGFloat = 0
        var i = 1
        for str in titles {
            let stringWidth = str.widthWithConstrainedHeight(str, font: App_Theme_PinFan_R_10_Font!, height: 16)
            let statusLabel = UILabel(frame: CGRect(x: originX, y: 0, width: CGFloat(Int(stringWidth)) + 6, height: 16))
            statusLabel.text = str
            statusLabel.tag = i
            i = i + 1
            statusLabel.font = App_Theme_PinFan_R_10_Font
            statusLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            statusLabel.textAlignment = .center
            statusLabel.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            statusLabel.layer.cornerRadius = 1.5
            statusLabel.clipsToBounds = true
            statusLabel.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            statusLabel.layer.masksToBounds = true
            originX = statusLabel.frame.maxX + 4
            self.addSubview(statusLabel)
            
        }
        viewWidth = (self.viewWithTag(titles.count)?.frame)!.maxX
        if types != nil {
            for i in types! {
                let label = self.viewWithTag(NSInteger(i as! NSNumber))
                label?.backgroundColor = UIColor.init(hexString: App_Theme_FF7A5E_Color)
            }
        }
    }
    
    func updateStatuesBgColor(_ types:NSArray?, bgColors:NSArray?){
        for i in types! {
            let label = self.viewWithTag(NSInteger(i as! NSNumber))
            let bgStr = ((bgColors! as NSArray).object(at: Int(i as! NSNumber))  as! String)
            label?.backgroundColor = UIColor.init(hexString: bgStr)
        }
    }
    
    func getMaxWidth() ->CGFloat {
        return viewWidth
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddAddressView: UIView {
    
    var addButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpButton()
    }
    
    func setUpButton() {
        addButton = UIButton(type: .custom)
        addButton.setTitle("新增收货地址", for: UIControlState())
        addButton.titleLabel?.font = App_Theme_PinFan_R_15_Font
        addButton.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: UIControlState())
        addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        addButton.setImage(UIImage.init(named: "Icon_Add"), for: UIControlState())
        addButton.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size:CGSize.init(width: SCREENWIDTH, height: 49))
        self.addSubview(addButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(-1)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


typealias GloableBottomButtonViewClouse = (_ tag:NSInteger?) -> Void

class GloableBottomButtonView: UIView {
   
    var button:UIButton!
    init(frame:CGRect?, title:String, tag:NSInteger?, action:GloableBottomButtonViewClouse?) {
        if frame == nil {
            super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENWIDTH, height: 49))
        }else{
            super.init(frame: frame!)
        }
        self.isUserInteractionEnabled = true
        self.setUpButton(title)
        button.reactive.controlEvents(.touchUpInside).observe { (button) in
            if action != nil {
                action!(self.button.tag)
                //self.button.enabled = false
            }
        }

        button.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func setUpButton(_ title:String) {
        button = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState())
        button.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
        button.titleLabel?.font = App_Theme_PinFan_R_15_Font
        button.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: UIControlState())
        button.titleLabel?.textAlignment = .center
        button.tag = 1
        self.addSubview(button)
        self.updateConstraintsIfNeeded()
    }
    
    func updateButtonTitle(_ title:String) {
        button.setTitle(title, for: UIControlState())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//let NumberTickButtonWidth:CGFloat = 44
let NumberTickButtonHeight:CGFloat = 34

enum NumberTickViewType {
    case sell
    case confirm
}

enum NumberTicketViewUseType {
    case disable
    case use
}

class NumberTickView: UIView {
    var downButton:UIButton!
    var upButton:UIButton!
    var numberTextField:UITextField!
    var number:NSInteger = 1
    var remainCount:Int = 0
    
    init(frame:CGRect, buttonWidth:CGFloat, type:NumberTickViewType, remainCount:Int?) {
        super.init(frame: frame)
        if type == .confirm {
            self.layer.cornerRadius = 2.0
            self.layer.masksToBounds = true
            downButton = UIButton(type: .custom)
            downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), for: UIControlState())
            downButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: frame.size.height)
            downButton.reactive.controlEvents(.touchUpInside).observe { (object) in
                if self.number > 1 {
                    self.number = self.number - 1
                    self.numberTextField.text = "\(self.number)"
                }
                self.setNumberUpColor()
                self.setNumberDownColor()
            }
            downButton.backgroundColor = UIColor.init(hexString: App_Theme_F6F7FA_Color)
            self.addSubview(downButton)
            
            upButton = UIButton(type: .custom)
            upButton.setImage(UIImage.init(named: "Icon_Add_Normal"), for: UIControlState())
            upButton.reactive.controlEvents(.touchUpInside).observe { (object) in
                if self.number < self.remainCount {
                    self.number = self.number + 1
                    self.numberTextField.text = "\(self.number)"
                }
                self.setNumberUpColor()
                self.setNumberDownColor()
            }
            upButton.frame = CGRect(x: self.frame.size.width - buttonWidth, y: 0, width: buttonWidth, height: frame.size.height)
            upButton.backgroundColor = UIColor.init(hexString: App_Theme_F6F7FA_Color)
            self.addSubview(upButton)
            
            numberTextField = UITextField()
            numberTextField.text = "\(self.number)"
            numberTextField.keyboardType = .numberPad
            numberTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            numberTextField.textColor = UIColor.init(hexString: App_Theme_556169_Color)
            
            let borderLeft = CALayer.init()
            borderLeft.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color).cgColor
            borderLeft.frame = CGRect.init(x: 0, y: 0, width: 2, height: frame.size.height)
            numberTextField.layer.addSublayer(borderLeft)
            
            let borderRight = CALayer.init()
            borderRight.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color).cgColor
            borderRight.frame = CGRect.init(x: self.frame.size.width - 2 * buttonWidth, y: 0, width: 2, height: frame.size.height)
            numberTextField.layer.addSublayer(borderRight)

            numberTextField.backgroundColor = UIColor.init(hexString: App_Theme_F6F7FA_Color)
            numberTextField.font = App_Theme_PinFan_M_15_Font
            numberTextField.frame = CGRect(x: buttonWidth, y: 0, width: self.frame.size.width - 2 * buttonWidth, height: frame.size.height)
            numberTextField.reactive.continuousTextValues.observeValues({ (str) in
                if str! == ""{
                    self.number = 1
                    self.numberTextField.text = "1"
                }else{
                    self.number = NSInteger(str!)!
                    self.numberTextField.text = str!
                }
                
            })
            numberTextField.textAlignment = .center
            self.addSubview(numberTextField)
        }else{
            self.layer.cornerRadius = 3.0
            self.layer.borderColor = UIColor.init(hexString: App_Theme_384249_Color).cgColor
            self.layer.borderWidth = 0.5
            downButton = UIButton(type: .custom)
            downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), for: UIControlState())
            downButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: frame.size.height)
            downButton.reactive.controlEvents(.touchUpInside).observe { (object) in
                if self.number > 1 {
                    self.number = self.number - 1
                    self.numberTextField.text = "\(self.number)"
                }
                self.setNumberDownColor()
            }
            self.addSubview(downButton)
            
            upButton = UIButton(type: .custom)
            upButton.setImage(UIImage.init(named: "Icon_Add_Normal"), for: UIControlState())
            upButton.reactive.controlEvents(.touchUpInside).observe { (object) in
                self.number = self.number + 1
                self.numberTextField.text = "\(self.number)"
                self.setNumberDownColor()
            }
            upButton.frame = CGRect(x: self.frame.size.width - buttonWidth, y: 0, width: buttonWidth, height: frame.size.height)
            self.addSubview(upButton)
            numberTextField = UITextField()
            numberTextField.text = "\(self.number)"
            numberTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            numberTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
            numberTextField.layer.borderColor = UIColor.init(hexString: App_Theme_384249_Color).cgColor
            numberTextField.layer.borderWidth = 0.5
            numberTextField.font = App_Theme_PinFan_M_15_Font
            numberTextField.frame = CGRect(x: buttonWidth, y: 0, width: self.frame.size.width - 2 * buttonWidth, height: frame.size.height)
            numberTextField.textAlignment = .center
            self.addSubview(numberTextField)
        }
    }
    
    func setNumberDownColor(){
        if self.number == 1 {
            self.downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), for: UIControlState())
        }else{
            self.downButton.setImage(UIImage.init(named: "Icon_Reduce_Normal"), for: UIControlState())
        }
        
    }
    
    func setNumberUpColor(){
        if self.number == self.remainCount {
            self.upButton.setImage(UIImage.init(named: "Icon_Add_disable"), for: UIControlState())
        }else{
            self.upButton.setImage(UIImage.init(named: "Icon_Add_Normal"), for: UIControlState())
        }
    }
    
    func setNumberUseType(isDisable:Bool){
        if isDisable {
            downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), for: UIControlState())
            downButton.isEnabled = false
            upButton.setImage(UIImage.init(named: "Icon_Add_Disable"), for: UIControlState.normal)
            upButton.isEnabled = false
            numberTextField.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            numberTextField.isEnabled = false
            self.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).cgColor
            numberTextField.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GloableServiceView: UIView, UIGestureRecognizerDelegate {
    
    var detailView:UIView!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var cancelButton:UIButton!
    var height:CGFloat = 0
    
    init(title:String?, message:String?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.backgroundColor = UIColor.init(hexString: App_Theme_384249_Color, andAlpha: 0.5)
        detailView = UIView()
        detailView.backgroundColor = UIColor.white
        self.setUpTitleView(title!)
        let height = self.setUpDetailView(message!)
        
        detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: height + 160)

        self.setUpCancelButton()
        self.addSubview(detailView)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GloableServiceView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT - height - 160, width: SCREENWIDTH, height: height + 160)
            }, completion: { completion in
                
        })
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer){
        self.removwSelf()
    }
    
    func removwSelf(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: self.height + 160)
            }, completion: { completion in
                self.removeFromSuperview()
        })
    }
    
    func setUpDetailView(_ message:String) -> CGFloat {
        let height = message.heightWithConstrainedWidth(message, font: App_Theme_PinFan_R_17_Font!, width: SCREENWIDTH - 30)
        detailLabel = UILabel()
        detailLabel.text = message
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        detailLabel.font = App_Theme_PinFan_R_13_Font
        UILabel.changeLineSpace(for: detailLabel, withSpace: TitleLineSpace)
        detailLabel.textAlignment = .center
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: 15, y: 96, width: SCREENWIDTH - 30, height: height)
        detailView.addSubview(detailLabel)
        self.height = height
        return height
    }
    
    func setUpCancelButton(){
        cancelButton =  UIButton(type: .custom)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.removwSelf()
        }
        cancelButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 10, width: 40, height: 40)
        cancelButton.setImage(UIImage.init(named: "Btn_Close"), for: UIControlState())
        detailView.addSubview(cancelButton)
    }
    
    func setUpTitleView(_ title:String){
        let recommentTitle = UILabel()
        let width = title.widthWithConstrainedHeight(title, font: App_Theme_PinFan_M_14_Font!, height: 20)
        if IPHONE_VERSION >= 9 {
            recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 48, width: width, height: 20)
        }else{
            recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 48, width: width, height: 20)
        }
        
        recommentTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        recommentTitle.font = App_Theme_PinFan_M_14_Font
        recommentTitle.text = title
        recommentTitle.textAlignment = .center
        detailView.addSubview(recommentTitle)
        
        let lineLabel = GloabLineView(frame: CGRect(x: recommentTitle.frame.minX - 50, y: 58, width: 30, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
        detailView.addSubview(lineLabel)
        let lineLabel1 = GloabLineView(frame: CGRect(x: recommentTitle.frame.maxX + 20, y: 58, width: 30, height: 0.5))
        lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
        detailView.addSubview(lineLabel1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        let touchPoint = touch.location(in: self)
        return touchPoint.y < SCREENHEIGHT - (self.height + 160) ? true : false
    }
}


typealias GloableBottomOrderClouse = (_ tag:NSInteger) -> Void

class GloableBottomOrder: UIView {
    var linLable:GloabLineView!
    
    let buttonWidth:CGFloat = 73
    let buttonHeight:CGFloat = 30
    let buttonSpaceWidth:CGFloat = 10
    var gloableBottomOrderClouse:GloableBottomOrderClouse!
    init(frame:CGRect, titles:[String], types:[CustomButtonType],gloableBottomOrderClouse:@escaping GloableBottomOrderClouse) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        for i in 1...titles.count {
            let frame = CGRect.init(x: SCREENWIDTH - (CGFloat(i) * (buttonWidth + buttonSpaceWidth)) - 5 , y: 9.5, width: buttonWidth, height: buttonHeight)
            let customBtn = CustomButton.init(frame: frame, title: titles[i - 1], tag: i, titleFont: App_Theme_PinFan_R_13_Font!, type: types[i - 1], pressClouse: { (buttonTag) in
                gloableBottomOrderClouse(buttonTag)
            })
            customBtn.tag = i
            self.addSubview(customBtn)
        }
        linLable = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        self.addSubview(linLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CustomButtonType {
    case withNoBoarder
    case withBoarder
    case withBackBoarder
    case widthDisbale
    
}
typealias CustomButtonClouse = (_ tag:NSInteger) -> Void
class CustomButton: UIButton {
    
    init(frame:CGRect, title:String, tag:NSInteger?, titleFont:UIFont, type:CustomButtonType, pressClouse:@escaping CustomButtonClouse) {
        super.init(frame: frame)
        self.setTitle(title, for: UIControlState())
        self.titleLabel?.font = titleFont
        self.layer.masksToBounds = true
        self.frame = frame
        if tag != nil {
            self.tag = tag!
        }
        switch type {
        case .withNoBoarder:
            self.setWithNoBoarderButton()
        case .withBoarder:
            self.layer.cornerRadius = 2.0
            self.setWithBoarderButton()
        case .withBackBoarder:
            self.layer.cornerRadius = 2.0
            self.setwithonBoarderButton()
        default:
            self.layer.cornerRadius = 2.0
            self.setWithDisbleBoarderButton()
        }
        self.reactive.controlEvents(.touchUpInside).observe { (action) in
            if tag != nil {
                self.tag = 1000
            }
            pressClouse(tag!)
        }
    }
    
    func setWithNoBoarderButton(){
        self.buttonSetTitleColor(App_Theme_4BD4C5_Color, sTitleColor: App_Theme_40C6B7_Color)
    }
    
    func setWithBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_4BD4C5_Color, sTitleColor: App_Theme_40C6B7_Color)
    }
    
    func setWithDisbleBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_BBC1CB_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_BBC1CB_Color, sTitleColor: App_Theme_BBC1CB_Color)
    }
    
    func setwithonBoarderButton(){
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: self.frame.size.width, height: self.frame.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let GloableTitleListLabelHeight:CGFloat = 41
let GloableTitleListLabelHSpace:CGFloat = 13
let GloableTitleListLabelVSpace:CGFloat = 12

enum GloableLabelType {
    case selectType
    case nomalType
}
typealias GloableTitleListClouse = (_ title:String, _ index:Int) -> Void
class GloableTitleList: UIView {
    var maxHeight:CGFloat = 0
    var originX:CGFloat = 0
    var originY:CGFloat = 0
    var titleCount:NSInteger = 0
    var gloableTitleListClouse:GloableTitleListClouse!
    
    init(frame:CGRect, title:NSArray, selectIndex:NSInteger) {
        super.init(frame: frame)
        titleCount = title.count
        for index in 0...title.count - 1 {
            var labelFrame = CGRect.zero
            let str = title.object(at: index) as! String
            let strWidth = CGFloat(Int((str).widthWithConstrainedHeight(str , font: App_Theme_PinFan_R_13_Font!, height: 41) + 54))
            labelFrame = CGRect.init(x: originX, y: originY, width: strWidth, height: GloableTitleListLabelHeight)
            if labelFrame.maxX > frame.size.width {
                originX = 0
                originY = labelFrame.maxY + GloableTitleListLabelVSpace
                labelFrame = CGRect.init(x: originX, y: originY, width: strWidth, height: GloableTitleListLabelHeight)
            }
            let label = self.createLabel(str, frame: labelFrame, type: .nomalType)
            if index == selectIndex {
                self.updateLabelType(label, type: .selectType)
            }
            label.tag = index + 100
            originX = label.frame.maxX + GloableTitleListLabelHSpace
            let singTap = UITapGestureRecognizer.init(target: self, action: #selector(GloableTitleList.tapGesture(_:)))
            singTap.numberOfTapsRequired = 1
            singTap.numberOfTouchesRequired = 1
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(singTap)
            self.addSubview(label)
        }
        maxHeight = (self.viewWithTag(title.count - 1 + 100)?.frame)!.maxY
    }
    
    func tapGesture(_ tap:UITapGestureRecognizer) {
        for index in 0...titleCount - 1 {
            let label = self.viewWithTag(index + 100) as! UILabel
            if index + 100 == tap.view?.tag {
                self.updateLabelType(label, type: .selectType)
            }else{
                self.updateLabelType(label, type: .nomalType)
            }
        }
        if self.gloableTitleListClouse != nil {
            let label = self.viewWithTag((tap.view?.tag)!) as! UILabel
            self.gloableTitleListClouse(label.text!, (tap.view?.tag)! - 100)
        }
    }
    
    func createLabel(_ title:String, frame:CGRect, type:GloableLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = title
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = App_Theme_PinFan_R_13_Font
        self.updateLabelType(label, type: type)
        return label
    }
    
    func updateLabelType(_ label:UILabel, type:GloableLabelType) {
        if type == .nomalType {
            label.backgroundColor = UIColor.white
            label.layer.cornerRadius = 3.0
            label.layer.borderWidth = 0.5
            label.textColor = UIColor.init(hexString: App_Theme_556169_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_556169_Color).cgColor
        }else{
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.cornerRadius = 3.0
            label.layer.borderWidth = 0.1
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GloableShareView: UIView, UIGestureRecognizerDelegate, CAAnimationDelegate {
    var detailView:UIView!
    var shareView:UIView!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var cancelButton:UIButton!
    var height:CGFloat = 0
    var wxSession:UIButton!
    var wxTimeLine:UIButton!
    var weiboTimeLine:UIButton!
    var qqSeession:UIButton!
    var qqTimeLine:UIButton!
    var shareImage:UIImage!
    var shareModel:TicketShowModel!
    var ticketImage:UIImage!
    var shareUrl:String!
    init(title:String, model:TicketShowModel?, image:UIImage?, url:String?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        shareImage = image
        self.tag = 10000
        if image == nil {
            ticketImage = SaveImageTools.sharedInstance.LoadImage("\((model?.id)!).png", path: "TicketShowImages", isSmall: false) != nil ? SaveImageTools.sharedInstance.LoadImage("\((model?.id)!).png", path: "TicketShowImages", isSmall: false) : UIImage.init(named: "AboutUs_Logo")
            shareModel = model
        }
        if url != nil {
            shareUrl = url
        }
        self.backgroundColor = UIColor.init(hexString: App_Theme_384249_Color, andAlpha: 0.5)
        detailView = UIView()
        detailView.backgroundColor = UIColor.white
        self.setUpTitleView(title)
        
        self.setUpCancelButton()
        self.addShareButton()
        detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 188)
        self.addSubview(detailView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GloableServiceView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT - 188, width: SCREENWIDTH, height: 188)
            }, completion: { completion in
                
        })
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer){
        self.removwSelf()
    }
    
    func removwSelf(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 188)
            }, completion: { completion in
                self.removeFromSuperview()
        })
    }
    
    func setUpCancelButton(){
        cancelButton =  UIButton(type: .custom)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.removwSelf()
        }
        cancelButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 10, width: 40, height: 40)
        cancelButton.setImage(UIImage.init(named: "Btn_Close"), for: UIControlState())
        detailView.addSubview(cancelButton)
    }
    
    func addShareButton(){
        shareView = UIView.init()
        var maxX:CGFloat = -16
        if WXApi.isWXAppInstalled() {
            wxSession = UIButton(type: .custom)
            wxSession.buttonSetImage(UIImage.init(named: "Wechat_Normal")!, sImage: UIImage.init(named: "Wechat_Pressed")!)
            wxSession.reactive.controlEvents(.touchUpInside).observe({ (action) in
                GloableSetEvent("shareTicket", lable: "WeChatSession", parameters: nil)
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeChatSession(self.shareModel.title, description: self.shareModel.venue.address, image: self.ticketImage, url: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWeChatScreenShotImage(self.shareImage, type: 0)
                }
                self.removwSelf()
            })
            wxSession.tag = 100
            wxSession.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                wxSession.layer.add(self.setUpAnimation(wxSession.layer.position.y - 98, velocity: 6.0), forKey: "wxSession")
                shareView.addSubview(wxSession)
            } else {
                shareView.addSubview(wxSession)
                // Fallback on earlier versions
            }
            maxX = wxSession.frame.maxX
            
            wxTimeLine = UIButton(type: .custom)
            wxTimeLine.tag = 101
            wxTimeLine.buttonSetImage(UIImage.init(named: "Moment_Normal")!, sImage: UIImage.init(named: "Moment_Pressed")!)
            wxTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                GloableSetEvent("shareTicket", lable: "WeChatTimeLine", parameters: nil)
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeChatTimeLine(self.shareModel.title, description: self.shareModel.venue.address, image: self.ticketImage, url: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWeChatScreenShotImage(self.shareImage, type: 1)
                }
                self.removwSelf()
            })
            wxTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                wxTimeLine.layer.add(self.setUpAnimation(wxTimeLine.layer.position.y - 98, velocity: 5.5), forKey: "wxTimeLine")
                shareView.addSubview(wxTimeLine)
            } else {
                shareView.addSubview(wxTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(wxTimeLine)
            maxX = wxTimeLine.frame.maxX
        }
        
        if WeiboSDK.isWeiboAppInstalled() {
            weiboTimeLine = UIButton(type: .custom)
            weiboTimeLine.tag = 102
            weiboTimeLine.buttonSetImage(UIImage.init(named: "Weibo_Normal")!, sImage: UIImage.init(named: "Weibo_Pressed")!)
            weiboTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                GloableSetEvent("shareTicket", lable: "weiboTimeLine", parameters: nil)
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeiboWebUrl("\(self.shareModel.title)--\(self.shareModel.venue.address)-\(self.shareUrl)", webTitle: self.shareModel.title, image: self.ticketImage, webDescription: self.shareModel.venue.address, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWBScreenShotImag(self.shareImage, text: "良票")
                }
            })
            weiboTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                weiboTimeLine.layer.add(self.setUpAnimation(weiboTimeLine.layer.position.y - 98, velocity: 5.0), forKey: "weiboTimeLine")
                shareView.addSubview(weiboTimeLine)
            } else {
                shareView.addSubview(weiboTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(weiboTimeLine)
            maxX = weiboTimeLine.frame.maxX
        }
        
        if TencentOAuth.iphoneQQInstalled() {
            qqSeession = UIButton(type: .custom)
            qqSeession.tag = 103
            qqSeession.buttonSetImage(UIImage.init(named: "QQ_Normal")!, sImage: UIImage.init(named: "QQ_Pressed")!)
            shareView.addSubview(qqSeession)
            qqSeession.reactive.controlEvents(.touchUpInside).observe({ (action) in
                GloableSetEvent("shareTicket", lable: "qqSeession", parameters: nil)
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareQQSessionWebUrl("良票", webTitle: self.shareModel.title,imageUrl: "\(self.shareModel.cover)",  webDescription: self.shareModel.venue.address, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareQQScreenShotImage(self.shareImage, type: 0)
                }
                self.removwSelf()
            })
            qqSeession.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                qqSeession.layer.add(self.setUpAnimation(qqSeession.layer.position.y - 98, velocity: 4.5), forKey: "qqSeession")
                shareView.addSubview(qqSeession)
            } else {
                shareView.addSubview(qqSeession)
                // Fallback on earlier versions
            }
            maxX = qqSeession.frame.maxX
        }
        
        if TencentOAuth.iphoneQZoneInstalled() {
            qqTimeLine = UIButton(type: .custom)
            qqTimeLine.tag = 104
            qqTimeLine.buttonSetImage(UIImage.init(named: "QZone_Normal")!, sImage: UIImage.init(named: "QZone_Pressed")!)
            qqTimeLine.frame = CGRect(x: maxX + 16, y: 90, width: 50, height: 50)
            qqTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                GloableSetEvent("shareTicket", lable: "qqTimeLine", parameters: nil)
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareQQTimeLineUrl("良票", webTitle: self.shareModel.title,imageUrl: "\(self.shareModel.cover)", webDescription: self.shareModel.venue.address, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareQQScreenShotImage(self.shareImage, type: 1)
                }
                self.removwSelf()
            })
            qqTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                qqTimeLine.layer.add(self.setUpAnimation(qqTimeLine.layer.position.y - 98, velocity: 4.0), forKey: "qqTimeLine")
                shareView.addSubview(qqTimeLine)
            } else {
                shareView.addSubview(qqTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(qqTimeLine)
            maxX = qqTimeLine.frame.maxX
        }
        
        shareView.frame = CGRect(x: (SCREENWIDTH - maxX)/2, y: 0, width: maxX, height: 188)
        self.detailView.addSubview(shareView)
    }
    
    func setUpTitleView(_ title:String){
        let recommentTitle = UILabel()
        let width = title.widthWithConstrainedHeight(title, font: App_Theme_PinFan_M_13_Font!, height: 20)
        recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 45, width: width, height: 20)
        recommentTitle.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        recommentTitle.font = App_Theme_PinFan_M_13_Font
        recommentTitle.text = title
        recommentTitle.textAlignment = .center
        detailView.addSubview(recommentTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        let touchPoint = touch.location(in: self)
        return touchPoint.y < SCREENHEIGHT - (self.height + 160) ? true : false
    }
    
    @available(iOS 9.0, *)
    func setUpAnimation(_ float:CGFloat,velocity:CGFloat) ->CASpringAnimation{
        let ani = CASpringAnimation.init(keyPath: "position.y")
        ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
        ani.stiffness = 1000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
        ani.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        ani.initialVelocity = velocity;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
        ani.duration = ani.settlingDuration;
        ani.toValue = float
        ani.delegate = self
        ani.isRemovedOnCompletion = false
        ani.fillMode = kCAFillModeForwards;
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        return ani
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.wxSession != nil {
            if anim == self.wxSession.layer.animation(forKey: "wxSession") {
                var frame = self.wxSession.frame
                frame.origin.y =  90
                self.wxSession.frame = frame
            }
        }
        if self.wxTimeLine != nil {
            if anim == self.wxTimeLine.layer.animation(forKey: "wxTimeLine") {
                var frame = self.wxTimeLine.frame
                frame.origin.y =  90
                self.wxTimeLine.frame = frame
            }
        }
        if self.weiboTimeLine != nil {
            if anim == self.weiboTimeLine.layer.animation(forKey: "weiboTimeLine") {
                var frame = self.weiboTimeLine.frame
                frame.origin.y =  90
                self.weiboTimeLine.frame = frame
            }
        }
        
        if self.qqSeession != nil {
            if anim == self.qqSeession.layer.animation(forKey: "qqSeession") {
                var frame = self.qqSeession.frame
                frame.origin.y =  90
                self.qqSeession.frame = frame
            }
        }
        
        if self.qqTimeLine != nil {
            if anim == self.qqTimeLine.layer.animation(forKey: "qqTimeLine") {
                var frame = self.qqTimeLine.frame
                frame.origin.y =  90
                self.qqTimeLine.frame = frame
            }
        }
    }
}













