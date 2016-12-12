//
//  HomeSearchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SnapKit

class HomeBandSearchField: UITextField {
    
    override func drawPlaceholderInRect(rect: CGRect) {
        super.drawPlaceholderInRect(CGRectMake(0, self.frame.height * 0.5 + 0.5, 0, 0))
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(CGRectMake(0, self.frame.height * 0.5 + 0.5, 0, 0))
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        return super.leftViewRectForBounds(CGRectMake(20, self.frame.height * 0.5 + 0.5, 0, 0))
    }
}

typealias HomeSearchTableViewCellClouse = () ->Void

class HomeSearchTableViewCell: UITableViewCell {

    var logoImage:UIImageView!
    var location:UIButton!
    var searchField:UITextField!
    var didMakeConstraints:Bool = false
    
    let searchFieldView = UIView()
    
    var homeSearchTableViewCellClouse:HomeSearchTableViewCellClouse!
    var cellBackView:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.setUpView()
    }
    
    func setUpView() {
        
        cellBackView = UIImageView()
        cellBackView.image = UIImage.init(color: UIColor.init(hexString: App_Theme_4BD4C5_Color), size: CGSizeMake(SCREENWIDTH, 255))
        self.contentView.addSubview(cellBackView)
        
        logoImage = UIImageView()
        logoImage.image = UIImage.init(named: "Homepage_Brand_Logo")
        self.contentView.addSubview(logoImage)
        
        location = UIButton()
        let title = "北京"
        location.setTitle(title, forState: .Normal)
        let stringWidth = title.widthWithConstrainedHeight(title, font: App_Theme_PinFan_R_12_Font!, height: 17) + 6
        let image = UIImage.init(named: "Icon_Selected_Location")
        location.buttonSetTitleColor(App_Theme_FFFFFF_Color, sTitleColor: nil)
        location.titleLabel?.font = App_Theme_PinFan_R_12_Font!
        location.titleEdgeInsets = UIEdgeInsetsMake(0, -(image?.size.width)!, 0, (image?.size.width)!)
        location.imageEdgeInsets = UIEdgeInsetsMake(0, stringWidth, -3, -stringWidth)
        location.setImage(image, forState: .Normal)
        self.contentView.addSubview(location)
        
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRectMake(0, 15, (searchImage?.size.width)!, (searchImage?.size.height)!)
        searchField = HomeBandSearchField()
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholderInRect(CGRectMake(20, 0, searchField.frame.size.width, searchField.frame.size.height))
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索演出名称、演员...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        searchField.layer.borderColor = UIColor.init(hexString: App_Theme_40C6B7_Color).CGColor
        searchField.layer.borderWidth = 0.5
        searchField.layer.masksToBounds = true
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        searchField.leftView = leftImage
        searchField.returnKeyType = .Search
        searchField.clipsToBounds = true
        searchField.font = App_Theme_PinFan_L_14_Font
        searchField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        searchField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        searchField.returnKeyType = .Search
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.leftViewMode = .Always
        searchField.userInteractionEnabled = true
        searchField.enabled = false
        self.contentView.addSubview(searchField)
    
//        searchBack.frame = CGRectMake(19, 181, SCREENWIDTH - 38, 48)
//        searchBack.layer.cornerRadius = 4.0
//        searchBack.layer.masksToBounds = true
//        searchBack.backgroundColor = UIColor.init(hexString: App_Theme_40C6B7_Color);
//        self.contentView.addSubview(searchBack)
        
        searchFieldView.frame = searchField.frame
        let sigleTap = UITapGestureRecognizer(target: self, action: #selector(HomeSearchTableViewCell.sigleTapPress(_:)))
        searchFieldView.backgroundColor = UIColor.clearColor()
        sigleTap.numberOfTapsRequired = 1
        sigleTap.numberOfTouchesRequired = 1
        searchFieldView.addGestureRecognizer(sigleTap)
        self.contentView.addSubview(searchFieldView)
         
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            logoImage.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(92)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.size.equalTo(CGSizeMake(52, 48))
            })
            
            location.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(121)
                make.left.equalTo(self.logoImage.snp_right).offset(15)
                make.height.equalTo(17)
            })
            
            searchField.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.logoImage.snp_bottom).offset(44)
                make.left.equalTo(self.contentView.snp_left).offset(20)
                make.right.equalTo(self.contentView.snp_right).offset(-20)
                make.height.equalTo(46)
            })
            
            searchFieldView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.logoImage.snp_bottom).offset(44)
                make.left.equalTo(self.contentView.snp_left).offset(20)
                make.right.equalTo(self.contentView.snp_right).offset(-20)
                make.height.equalTo(46)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func sigleTapPress(sender:UITapGestureRecognizer) {
        if self.homeSearchTableViewCellClouse != nil {
            self.homeSearchTableViewCellClouse()
        }
    }

}
