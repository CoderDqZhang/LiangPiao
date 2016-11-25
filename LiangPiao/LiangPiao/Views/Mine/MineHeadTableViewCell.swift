//
//  MineHeadTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class MineHeadTableViewCell: UITableViewCell {

    var nameAndePhone:UILabel!
    var editProfileImage:UIImageView!
    var photoImageView:UIImageView!
    var defaultImage:UIImageView!
    var cellBackView:UIImageView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
    }
    
    func setUpView() {
        
        cellBackView = UIImageView()
        cellBackView.image = UIImage.init(color: UIColor.init(hexString: App_Theme_BackGround_Color), size: CGSizeMake(SCREENWIDTH, 255))
        self.contentView.addSubview(cellBackView)
        
        nameAndePhone = UILabel()
        nameAndePhone.font = Mine_Header_Name_Font
        nameAndePhone.textColor = UIColor.init(hexString: Mine_Header_Name_Color)
        self.contentView.addSubview(nameAndePhone)
        
        defaultImage = UIImageView()
        defaultImage.layer.cornerRadius = 53
        defaultImage.layer.masksToBounds = true
        defaultImage.image = UIImage.init(named: "Avatar_Default")
        self.contentView.addSubview(defaultImage)
        
        photoImageView = UIImageView()
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.masksToBounds = true
        photoImageView.image = UIImage.init(named: "Checkbox_Selected")
        self.contentView.addSubview(photoImageView)
        
        editProfileImage = UIImageView()
        editProfileImage.image = UIImage.init(named: "Icon_Edit_Normal")
        editProfileImage.hidden = true
        self.contentView.addSubview(editProfileImage)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(namePhone:String, photoImage:String, isLogin:Bool) {
        nameAndePhone.text = namePhone
        if isLogin {
            editProfileImage.hidden = false
            if SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage") == nil {
                photoImageView.sd_setImageWithURL(NSURL.init(string: photoImage), placeholderImage: UIImage.init(named: "Avatar_Default"), options: .RetryFailed) { (image, error, cache, url) in
                }
            }else{
                photoImageView.image = SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage")
            }
        }else{
            editProfileImage.hidden = true
            photoImageView.image = UIImage.init(named: "Avatar_Default")
        }
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            nameAndePhone.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.photoImageView.snp_bottom).offset(20)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            photoImageView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(67)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.size.equalTo(CGSizeMake(100, 100))
            })
            
            defaultImage.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(64)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.size.equalTo(CGSizeMake(106, 106))
            })
            
            editProfileImage.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.photoImageView.snp_top).offset(8)
                make.left.equalTo(self.photoImageView.snp_left).offset(83)
                make.size.equalTo(CGSizeMake(27, 27))
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

}
