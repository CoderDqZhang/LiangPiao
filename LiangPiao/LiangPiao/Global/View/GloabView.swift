//
//  GloabView.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let Line_BackGround_Color = "E9EBF2"


class HomeSearchNavigationBar: UIView {
    
    var searchField:HomeBandSearchField!
    
    init(frame: CGRect, font:UIFont?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: HomePage_brand_BackGroudColor)
        self.setUpView(font)
    }
    
    func setUpView(font:UIFont?) {
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRectMake(15, 15, (searchImage?.size.width)!, (searchImage?.size.height)!)
        searchField = HomeBandSearchField(frame:CGRectMake(20, 27,SCREENWIDTH - 40, 30))
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholderInRect(CGRectMake(20, 0, searchField.frame.size.width, searchField.frame.size.height))
        if font == nil {
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员、场馆...", attributes: [NSFontAttributeName:HomeSearch_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: HomePage_Search_Color)])
        }else{
            searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员、场馆...", attributes: [NSFontAttributeName:font!,NSForegroundColorAttributeName:UIColor.init(hexString: HomePage_Search_Color)])
        }
        searchField.delegate = self
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        searchField.leftView = leftImage
        searchField.tintColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.leftViewMode = .Always
        self.addSubview(searchField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeSearchNavigationBar : UITextFieldDelegate {
    
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

class GlobalTicketStatus : UIView {
    
    var globalNavigationClouse:GlobalNavigationClouse!
    var viewWidth:CGFloat = 0
    init(frame:CGRect, titles:[String], types:NSArray?) {
        super.init(frame:frame)
        var originX:CGFloat = 0
        var i = 1
        for str in titles {
            let stringWidth = str.widthWithConstrainedHeight(str, font: Home_Ticket_Status_Font!, height: 16) + 6
            let statusLabel = UILabel(frame: CGRectMake(originX, 0, stringWidth, 16))
            statusLabel.text = str
            statusLabel.tag = i
            i = i + 1
            statusLabel.font = Home_Ticket_Status_Font
            statusLabel.textColor = UIColor.init(hexString: Home_Ticket_Status_Title_Color)
            statusLabel.textAlignment = .Center
            statusLabel.backgroundColor = UIColor.init(hexString: Home_Ticket_Status_BackGround_NColor)
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
    
    func getMaxWidth() ->CGFloat {
        return viewWidth
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

