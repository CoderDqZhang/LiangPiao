//
//  GloabView.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

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
    
    func setUpView(font:UIFont?) {
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRectMake(15, 15, (searchImage?.size.width)!, (searchImage?.size.height)!)
        
        cancelButton = UIButton(type: .Custom)
        cancelButton.frame = CGRectMake(SCREENWIDTH - 64, 27,64, 30)
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = App_Theme_PinFan_L_17_Font
        cancelButton.hidden = true
        cancelButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            if self.searchNavigationBarCancelClouse != nil{
                self.searchNavigationBarCancelClouse()
            }
        }
        self.addSubview(cancelButton)
        
        searchField = HomeBandSearchField(frame:CGRectMake(20, 27,SCREENWIDTH - 40, 30))
        
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholderInRect(CGRectMake(20, 0, searchField.frame.size.width, searchField.frame.size.height))
        if font == nil {
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        }else{
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        }
        searchField.delegate = self
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        searchField.leftView = leftImage
        searchField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.leftViewMode = .Always
        searchField.returnKeyType = .Search
        searchField.font = App_Theme_PinFan_R_14_Font
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        searchField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        searchField.clearButtonMode = .Always
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
    init(frame:CGRect, title:String, searchClouse:GloableSearchBarClouse) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        
        titleLabel = UILabel(frame: CGRect.init(x: 50, y: 22, width: frame.size.width - 100, height: 40))
        titleLabel.text = title
        titleLabel.textAlignment = .Center
        titleLabel.font = App_Theme_PinFan_L_17_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(titleLabel)
        
        searchButton = UIButton(type: .Custom)
        searchButton.setImage(UIImage.init(named: "Icon_Search_W")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        searchButton.frame = CGRect.init(x: frame.size.width - 50, y: 22, width: 40, height: 40)
        searchButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            searchClouse()
        }
        self.addSubview(searchButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSearchNavigationBar : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.searchTextFieldBecomFirstRespoder != nil {
            self.searchTextFieldBecomFirstRespoder()
        }
        textField.frame = CGRectMake(20, 27,SCREENWIDTH - 84, 30)
        cancelButton.hidden = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
    }
}

class GloabView: UIView {

}

class GloabLineView: UIView {
    
    let lineLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        lineLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.addSubview(lineLabel)
    }
    
    func setLineColor(color:UIColor){
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
        titleLabel.frame = CGRectMake(0, 5, frame.size.width, 18)
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        titleLabel.textAlignment = .Center
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        let detailLabel:UILabel! = UILabel()
        detailLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 1, frame.size.width, 13)
        detailLabel.text = detail
        detailLabel.font = App_Theme_PinFan_R_11_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        detailLabel.textAlignment = .Center
        self.addSubview(detailLabel)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GlobalNavigationBarView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func singleTapPress(sender:UITapGestureRecognizer) {
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
        titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        titleLabel.font = App_Theme_PinFan_L_17_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        titleLabel.textAlignment = .Center
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GlobalNavigationBarView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func singleTapPress(sender:UITapGestureRecognizer) {
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
        self.backgroundColor = UIColor.clearColor()
    }
    
    func setUpView(titles:[String], types:NSArray?){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        var originX:CGFloat = 0
        var i = 1
        for str in titles {
            let stringWidth = str.widthWithConstrainedHeight(str, font: App_Theme_PinFan_R_10_Font!, height: 16)
            let statusLabel = UILabel(frame: CGRectMake(originX, 0, CGFloat(Int(stringWidth)) + 6, 16))
            statusLabel.text = str
            statusLabel.tag = i
            i = i + 1
            statusLabel.font = App_Theme_PinFan_R_10_Font
            statusLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            statusLabel.textAlignment = .Center
            statusLabel.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            statusLabel.layer.cornerRadius = 1.5
            statusLabel.clipsToBounds = true
            statusLabel.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            statusLabel.layer.masksToBounds = true
            originX = CGRectGetMaxX(statusLabel.frame) + 4
            self.addSubview(statusLabel)
            
        }
        viewWidth = CGRectGetMaxX((self.viewWithTag(titles.count)?.frame)!)
        if types != nil {
            for i in types! {
                let label = self.viewWithTag(NSInteger(i as! NSNumber))
                label?.backgroundColor = UIColor.init(hexString: App_Theme_FF7A5E_Color)
            }
        }
    }
    
    func updateStatuesBgColor(types:NSArray?, bgColors:NSArray?){
        for i in types! {
            let label = self.viewWithTag(NSInteger(i as! NSNumber))
            let bgStr = ((bgColors! as NSArray).objectAtIndex(Int(i as! NSNumber))  as! String)
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
        addButton = UIButton(type: .Custom)
        addButton.setTitle("新增收货地址", forState: .Normal)
        addButton.titleLabel?.font = App_Theme_PinFan_R_15_Font
        addButton.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), forState: .Normal)
        addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        addButton.setImage(UIImage.init(named: "Icon_Add"), forState: .Normal)
        addButton.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size:CGSize.init(width: SCREENWIDTH, height: 49))
        self.addSubview(addButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        addButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(-1)
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self.snp_left).offset(0)
            make.right.equalTo(self.snp_right).offset(0)
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


typealias GloableBottomButtonViewClouse = (tag:NSInteger?) -> Void

class GloableBottomButtonView: UIView {
   
    var button:UIButton!
    init(frame:CGRect?, title:String, tag:NSInteger?, action:GloableBottomButtonViewClouse?) {
        if frame == nil {
            super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENWIDTH, height: 49))
        }else{
            super.init(frame: frame!)
        }
        self.userInteractionEnabled = true
        self.setUpButton(title)
        button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (btnTouchUp) in
            if action != nil {
                action!(tag:self.button.tag)
            }
        }
        button.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func setUpButton(title:String) {
        button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
        button.titleLabel?.font = App_Theme_PinFan_R_15_Font
        button.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), forState: .Normal)
        button.titleLabel?.textAlignment = .Center
        button.tag = 1
        self.addSubview(button)
        self.updateConstraintsIfNeeded()
    }
    
    func updateButtonTitle(title:String) {
        button.setTitle(title, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//let NumberTickButtonWidth:CGFloat = 44
let NumberTickButtonHeight:CGFloat = 34

class NumberTickView: UIView {
    var downButton:UIButton!
    var upButton:UIButton!
    var numberTextField:UITextField!
    var number:NSInteger = 1
    init(frame:CGRect, buttonWidth:CGFloat) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.init(hexString: App_Theme_384249_Color).CGColor
        self.layer.borderWidth = 0.5
        downButton = UIButton(type: .Custom)
        downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), forState: .Normal)
        downButton.frame = CGRectMake(0, 0, buttonWidth, frame.size.height)
        downButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (object) in
            if self.number > 1 {
                self.number = self.number - 1
                self.numberTextField.text = "\(self.number)"
            }
            self.setNumberDownColor()
        }
        self.addSubview(downButton)
        
        upButton = UIButton(type: .Custom)
        upButton.setImage(UIImage.init(named: "Icon_Add_Normal"), forState: .Normal)
        upButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (object) in
            self.number = self.number + 1
            self.numberTextField.text = "\(self.number)"
            self.setNumberDownColor()
        }
        upButton.frame = CGRectMake(self.frame.size.width - buttonWidth, 0, buttonWidth, frame.size.height)
        self.addSubview(upButton)
        numberTextField = UITextField()
        numberTextField.text = "\(self.number)"
        numberTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        numberTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        numberTextField.layer.borderColor = UIColor.init(hexString: App_Theme_384249_Color).CGColor
        numberTextField.layer.borderWidth = 0.5
        numberTextField.font = App_Theme_PinFan_M_15_Font
        numberTextField.frame = CGRectMake(buttonWidth, 0, self.frame.size.width - 2 * buttonWidth, frame.size.height)
        numberTextField.textAlignment = .Center
        self.addSubview(numberTextField)
    }
    
    func setNumberDownColor(){
        if self.number == 1 {
            self.downButton.setImage(UIImage.init(named: "Icon_Reduce_Disable"), forState: .Normal)
        }else{
            self.downButton.setImage(UIImage.init(named: "Icon_Reduce_Normal"), forState: .Normal)
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
        detailView.backgroundColor = UIColor.whiteColor()
        self.setUpTitleView(title!)
        let height = self.setUpDetailView(message!)
        
        detailView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height + 160)

        self.setUpCancelButton()
        self.addSubview(detailView)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GloableServiceView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        UIView.animateWithDuration(AnimationTime, animations: {
            self.detailView.frame = CGRectMake(0, SCREENHEIGHT - height - 160, SCREENWIDTH, height + 160)
            }, completion: { completion in
                
        })
    }
    
    func singleTapPress(sender:UITapGestureRecognizer){
        self.removwSelf()
    }
    
    func removwSelf(){
        UIView.animateWithDuration(AnimationTime, animations: {
            self.detailView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, self.height + 160)
            }, completion: { completion in
                self.removeFromSuperview()
        })
    }
    
    func setUpDetailView(message:String) -> CGFloat {
        let height = message.heightWithConstrainedWidth(message, font: App_Theme_PinFan_R_17_Font!, width: SCREENWIDTH - 30)
        detailLabel = UILabel()
        detailLabel.text = message
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        detailLabel.font = App_Theme_PinFan_R_13_Font
        UILabel.changeLineSpaceForLabel(detailLabel, withSpace: TitleLineSpace)
        detailLabel.textAlignment = .Center
        detailLabel.sizeToFit()
        detailLabel.frame = CGRectMake(15, 96, SCREENWIDTH - 30, height)
        detailView.addSubview(detailLabel)
        self.height = height
        return height
    }
    
    func setUpCancelButton(){
        cancelButton =  UIButton(type: .Custom)
        cancelButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.removwSelf()
        }
        cancelButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 10, width: 40, height: 40)
        cancelButton.setImage(UIImage.init(named: "Btn_Close"), forState: .Normal)
        detailView.addSubview(cancelButton)
    }
    
    func setUpTitleView(title:String){
        let recommentTitle = UILabel()
        let width = title.widthWithConstrainedHeight(title, font: App_Theme_PinFan_M_14_Font!, height: 20)
        if IPHONE_VERSION >= 9 {
            recommentTitle.frame = CGRectMake((SCREENWIDTH - width) / 2, 48, width, 20)
        }else{
            recommentTitle.frame = CGRectMake((SCREENWIDTH - width) / 2, 48, width, 20)
        }
        
        recommentTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        recommentTitle.font = App_Theme_PinFan_M_14_Font
        recommentTitle.text = title
        recommentTitle.textAlignment = .Center
        detailView.addSubview(recommentTitle)
        
        let lineLabel = GloabLineView(frame: CGRectMake(CGRectGetMinX(recommentTitle.frame) - 50, 58, 30, 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
        detailView.addSubview(lineLabel)
        let lineLabel1 = GloabLineView(frame: CGRectMake(CGRectGetMaxX(recommentTitle.frame) + 20, 58, 30, 0.5))
        lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
        detailView.addSubview(lineLabel1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool{
        let touchPoint = touch.locationInView(self)
        return touchPoint.y < SCREENHEIGHT - (self.height + 160) ? true : false
    }
}

enum CustomButtonType {
    case withNoBoarder
    case withBoarder
    case withBackBoarder
    
}
typealias CustomButtonClouse = (tag:NSInteger) -> Void
class CustomButton: UIButton {
    
    init(frame:CGRect, title:String, tag:NSInteger?, titleFont:UIFont, type:CustomButtonType, pressClouse:CustomButtonClouse) {
        super.init(frame: frame)
        self.setTitle(title, forState: .Normal)
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
        default:
            self.layer.cornerRadius = 2.0
            self.setwithonBoarderButton()
        }
        self.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            if tag != nil {
                self.tag = 1000
            }
            pressClouse(tag:self.tag)
        }
    }
    
    func setWithNoBoarderButton(){
        self.buttonSetTitleColor(App_Theme_4BD4C5_Color, sTitleColor: App_Theme_40C6B7_Color)
    }
    
    func setWithBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_4BD4C5_Color, sTitleColor: App_Theme_40C6B7_Color)
    }
    
    func setwithonBoarderButton(){
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
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
typealias GloableTitleListClouse = (title:String, index:Int) -> Void
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
            var labelFrame = CGRectZero
            let str = title.objectAtIndex(index) as! String
            let strWidth = CGFloat(Int((str).widthWithConstrainedHeight(str , font: App_Theme_PinFan_R_13_Font!, height: 41) + 54))
            labelFrame = CGRect.init(x: originX, y: originY, width: strWidth, height: GloableTitleListLabelHeight)
            if CGRectGetMaxX(labelFrame) > frame.size.width {
                originX = 0
                originY = CGRectGetMaxY(labelFrame) + GloableTitleListLabelVSpace
                labelFrame = CGRect.init(x: originX, y: originY, width: strWidth, height: GloableTitleListLabelHeight)
            }
            let label = self.createLabel(str, frame: labelFrame, type: .nomalType)
            if index == selectIndex {
                self.updateLabelType(label, type: .selectType)
            }
            label.tag = index + 100
            originX = CGRectGetMaxX(label.frame) + GloableTitleListLabelHSpace
            let singTap = UITapGestureRecognizer.init(target: self, action: #selector(GloableTitleList.tapGesture(_:)))
            singTap.numberOfTapsRequired = 1
            singTap.numberOfTouchesRequired = 1
            label.userInteractionEnabled = true
            label.addGestureRecognizer(singTap)
            self.addSubview(label)
        }
        maxHeight = CGRectGetMaxY((self.viewWithTag(title.count - 1 + 100)?.frame)!)
    }
    
    func tapGesture(tap:UITapGestureRecognizer) {
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
            self.gloableTitleListClouse(title: label.text!, index:(tap.view?.tag)! - 100)
        }
    }
    
    func createLabel(title:String, frame:CGRect, type:GloableLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = title
        label.textAlignment = .Center
        label.layer.masksToBounds = true
        label.font = App_Theme_PinFan_R_13_Font
        self.updateLabelType(label, type: type)
        return label
    }
    
    func updateLabelType(label:UILabel, type:GloableLabelType) {
        if type == .nomalType {
            label.backgroundColor = UIColor.whiteColor()
            label.layer.cornerRadius = 3.0
            label.layer.borderWidth = 0.5
            label.textColor = UIColor.init(hexString: App_Theme_556169_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_556169_Color).CGColor
        }else{
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.cornerRadius = 3.0
            label.layer.borderWidth = 0.1
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













