//
//  GloabView.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let Line_BackGround_Color = "E9EBF2"

typealias SearchNavigationBarCancelClouse = () ->Void
typealias SearchTextFieldBecomFirstRespoder = () ->Void

class HomeSearchNavigationBar: UIView {
    
    var searchField:HomeBandSearchField!
    var cancelButton:UIButton!
    var searchNavigationBarCancelClouse:SearchNavigationBarCancelClouse!
    var searchTextFieldBecomFirstRespoder:SearchTextFieldBecomFirstRespoder!
    init(frame: CGRect, font:UIFont?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        self.setUpView(font)
    }
    
    func setUpView(font:UIFont?) {
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRectMake(15, 15, (searchImage?.size.width)!, (searchImage?.size.height)!)
        
        cancelButton = UIButton(type: .Custom)
        cancelButton.frame = CGRectMake(SCREENWIDTH - 64, 27,64, 30)
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = Search_TextField_Font
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
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:HomeSearch_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: HomePage_Search_Color)])
        }else{
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:font!,NSForegroundColorAttributeName:UIColor.init(hexString: HomePage_Search_Color)])
        }
        searchField.delegate = self
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        searchField.leftView = leftImage
        searchField.tintColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.leftViewMode = .Always
        searchField.returnKeyType = .Search
        searchField.font = HomeSearch_Default_Font
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:HomeSearch_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: HomePage_Search_Color)])
        searchField.textColor = UIColor.init(hexString: App_Theme_Text_Color)
        searchField.clearButtonMode = .Always
        self.addSubview(searchField)
        self.updateConstraintsIfNeeded()
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
        lineLabel.backgroundColor = UIColor.init(hexString: Line_BackGround_Color)
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
        titleLabel.font = NavigationBar_TitleView_TitleLabel_Font
        titleLabel.textColor = UIColor.init(hexString: NavigationBar_TitleView_TitleLabel_Color)
        titleLabel.textAlignment = .Center
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        let detailLabel:UILabel! = UILabel()
        detailLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 1, frame.size.width, 13)
        detailLabel.text = detail
        detailLabel.font = NavigationBar_TitleView_DetailLabel_Font
        detailLabel.textColor = UIColor.init(hexString: NavigationBar_TitleView_DetailLabel_Color)
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
        titleLabel.font = NavigationBar_Title_Font
        titleLabel.textColor = UIColor.init(hexString: NavigationBar_TitleView_TitleLabel_Color)
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
            let stringWidth = str.widthWithConstrainedHeight(str, font: Home_Ticket_Status_Font!, height: 16)
            let statusLabel = UILabel(frame: CGRectMake(originX, 0, stringWidth, 16))
            statusLabel.text = str
            statusLabel.tag = i
            i = i + 1
            statusLabel.font = Home_Ticket_Status_Font
            statusLabel.textColor = UIColor.init(hexString: Home_Ticket_Status_Title_Color)
            statusLabel.textAlignment = .Center
            statusLabel.backgroundColor = UIColor.init(hexString: Home_Ticket_Status_BackGround_NColor)
            statusLabel.layer.cornerRadius = 1.5
            statusLabel.clipsToBounds = true
            statusLabel.layer.borderColor = UIColor.init(hexString: App_Theme_BackGround_Color).CGColor
            statusLabel.layer.masksToBounds = true
            originX = CGRectGetMaxX(statusLabel.frame) + 4
            self.addSubview(statusLabel)
            
        }
        viewWidth = CGRectGetMaxX((self.viewWithTag(titles.count)?.frame)!)
        if types != nil {
            for i in types! {
                let label = self.viewWithTag(NSInteger(i as! NSNumber))
                label?.backgroundColor = UIColor.init(hexString: Home_Ticket_Status_BackGround_SColor)
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

typealias GloableBottomButtonViewClouse = (tag:NSInteger?) -> Void

class GloableBottomButtonView: UIView {
   
    var button:UIButton!
    init(frame:CGRect?, title:String, tag:NSInteger?, action:GloableBottomButtonViewClouse?) {
        if frame == nil {
            super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENWIDTH, height: 49))
        }else{
            super.init(frame: frame!)
        }
        self.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
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
        button.titleLabel?.font = Mine_AddAddress_Name_Font
        button.setTitleColor(UIColor.init(hexString: Mine_AddAddress_Name_Color), forState: .Normal)
        button.titleLabel?.textAlignment = .Center
        button.tag = 1
        self.addSubview(button)
        self.updateConstraintsIfNeeded()
    }
    
    func updateButtonTitle(title:String) {
        button.setTitle("title", forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

