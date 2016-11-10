//
//  MineHeadTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MineHeadTableViewCell: UITableViewCell {

    var nameAndePhone:UILabel!
    var editProfileImage:UIImageView!
    var photoImageView:UIImageView!
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
        
        photoImageView = UIImageView()
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.masksToBounds = true
        photoImageView.image = UIImage.init(named: "Checkbox_Selected")
        self.contentView.addSubview(photoImageView)
        
        editProfileImage = UIImageView()
        editProfileImage.image = UIImage.init(named: "Icon_Edit_Normal")
        self.contentView.addSubview(editProfileImage)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(namePhone:String, photoImage:UIImage) {
        nameAndePhone.text = namePhone
        photoImageView.image = photoImage
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            nameAndePhone.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.photoImageView.snp_bottom).offset(18)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            photoImageView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(64)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.size.equalTo(CGSizeMake(100, 100))
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
