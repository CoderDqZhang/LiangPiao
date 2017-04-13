//
//  ProfileImageTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

    var nameAndePhone:UILabel!
    var photoImageView:UIButton!
    
    var detailImage:UIImageView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        nameAndePhone = UILabel()
        nameAndePhone.text = "修改头像"
        nameAndePhone.font = App_Theme_PinFan_R_14_Font
        nameAndePhone.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(nameAndePhone)
        
        photoImageView = UIButton(type: .custom)
        photoImageView.layer.cornerRadius = 28
        photoImageView.isUserInteractionEnabled = false
        photoImageView.layer.masksToBounds = true
        photoImageView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        photoImageView.setImage(UIImage.init(named: "Icon_Camera"), for: UIControlState())
        self.contentView.addSubview(photoImageView)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ namePhone:String, photoImage:UIImage) {
        nameAndePhone.text = namePhone
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            nameAndePhone.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            photoImageView.snp.makeConstraints({ (make) in
                make.right.equalTo(self.detailImage.snp.left).offset(-14)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 56, height: 56))
            })
            
            detailImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
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
