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
        self.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
    }
    
    func setUpView() {
        
        cellBackView = UIImageView()
        cellBackView.image = UIImage.init(color: UIColor.init(hexString: App_Theme_4BD4C5_Color), size: CGSize(width: SCREENWIDTH, height: 255))
        self.contentView.addSubview(cellBackView)
        
        nameAndePhone = UILabel()
        nameAndePhone.font = App_Theme_PinFan_R_16_Font
        nameAndePhone.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
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
        editProfileImage.isHidden = true
        self.contentView.addSubview(editProfileImage)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ namePhone:String, photoImage:String, isLogin:Bool) {
        nameAndePhone.text = namePhone
        if isLogin {
            editProfileImage.isHidden = false
            if SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage", isSmall: false) == nil {
                photoImageView.sd_setImage(with: URL.init(string: photoImage), placeholderImage: UIImage.init(named: "Avatar_Default"), options: .retryFailed) { (image, error, cache, url) in
                    if error == nil && image != nil && url != nil {
                        _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
                    }else{
                        _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: UIImage.init(named: "Avatar_Default")!, path: "headerImage")
                    }
                }
            }else{
                photoImageView.image = SaveImageTools.sharedInstance.LoadImage("photoImage.png", path: "headerImage", isSmall: false)
            }
        }else{
            editProfileImage.isHidden = true
            photoImageView.image = UIImage.init(named: "Avatar_Default")
        }
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            nameAndePhone.snp.makeConstraints({ (make) in
                make.top.equalTo(self.photoImageView.snp.bottom).offset(20)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            })
            
            photoImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(67)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 100, height: 100))
            })
            
            defaultImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(64)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 106, height: 106))
            })
            
            editProfileImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.photoImageView.snp.top).offset(8)
                make.left.equalTo(self.photoImageView.snp.left).offset(83)
                make.size.equalTo(CGSize.init(width: 27, height: 27))
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

}
