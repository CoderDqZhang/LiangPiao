//
//  MySellHeaderTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 09/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class GloableHotTicketView: UIView {
    init(frame:CGRect, titleArray:NSArray?) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MySellHeaderTableViewCell: UITableViewCell {
    
    var searchField:UITextField!
    var didMakeConstraints:Bool = false
    
    let searchFieldView = UIView()
    
    var homeSearchTableViewCellClouse:HomeSearchTableViewCellClouse!
    var cellBackView:UIImageView!
    var hotTicketView:GloableHotTicketView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.setUpView()
    }
    
    func setUpView() {
        
        cellBackView = UIImageView()
        cellBackView.image = UIImage.init(color: UIColor.init(hexString: App_Theme_4BD4C5_Color), size: CGSizeMake(SCREENWIDTH, 255))
        self.contentView.addSubview(cellBackView)
        
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRectMake(0, 15, (searchImage?.size.width)!, (searchImage?.size.height)!)
        searchField = HomeBandSearchField()
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholderInRect(CGRectMake(20, 0, searchField.frame.size.width, searchField.frame.size.height))
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索想专卖的演出...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
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
            
            searchField.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(40)
                make.left.equalTo(self.contentView.snp_left).offset(20)
                make.right.equalTo(self.contentView.snp_right).offset(-20)
                make.height.equalTo(46)
            })
            
            searchFieldView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_bottom).offset(40)
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
