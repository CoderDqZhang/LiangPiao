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
        cellBackView.image = UIImage.init(color: UIColor.init(hexString: App_Theme_4BD4C5_Color), size: CGSize(width: SCREENWIDTH, height: 255))
        self.contentView.addSubview(cellBackView)
        
        let searchImage = UIImage.init(named: "Icon_Search")
        let leftImage = UIImageView(image: searchImage)
        leftImage.frame  = CGRect(x: 0, y: 15, width: (searchImage?.size.width)!, height: (searchImage?.size.height)!)
        searchField = HomeBandSearchField()
        searchField.layer.cornerRadius = 4.0
        searchField.drawPlaceholder(in: CGRect(x: 20, y: 0, width: searchField.frame.size.width, height: searchField.frame.size.height))
        searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索想专卖的演出...", attributes: [NSFontAttributeName:App_Theme_PinFan_L_14_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BBC1CB_Color)])
        searchField.layer.borderColor = UIColor.init(hexString: App_Theme_40C6B7_Color).cgColor
        searchField.layer.borderWidth = 0.5
        searchField.layer.masksToBounds = true
        searchField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        searchField.leftView = leftImage
        searchField.returnKeyType = .search
        searchField.clipsToBounds = true
        searchField.font = App_Theme_PinFan_L_14_Font
        searchField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        searchField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        searchField.returnKeyType = .search
        searchField.backgroundColor = UIColor.white
        searchField.leftViewMode = .always
        searchField.isUserInteractionEnabled = true
        searchField.isEnabled = false
        self.contentView.addSubview(searchField)
        
        //        searchBack.frame = CGRectMake(19, 181, SCREENWIDTH - 38, 48)
        //        searchBack.layer.cornerRadius = 4.0
        //        searchBack.layer.masksToBounds = true
        //        searchBack.backgroundColor = UIColor.init(hexString: App_Theme_40C6B7_Color);
        //        self.contentView.addSubview(searchBack)
        
        searchFieldView.frame = searchField.frame
        let sigleTap = UITapGestureRecognizer(target: self, action: #selector(HomeSearchTableViewCell.sigleTapPress(_:)))
        searchFieldView.backgroundColor = UIColor.clear
        sigleTap.numberOfTapsRequired = 1
        sigleTap.numberOfTouchesRequired = 1
        searchFieldView.addGestureRecognizer(sigleTap)
        self.contentView.addSubview(searchFieldView)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            searchField.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(40)
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
                make.height.equalTo(46)
            })
            
            searchFieldView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.bottom).offset(40)
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func sigleTapPress(_ sender:UITapGestureRecognizer) {
        if self.homeSearchTableViewCellClouse != nil {
            self.homeSearchTableViewCellClouse()
        }
    }
    
}
