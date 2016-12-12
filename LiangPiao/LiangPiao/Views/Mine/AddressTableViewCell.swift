//
//  AddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    var nameAndePhone:UILabel!
    var addressDetail:UILabel!
    var selectImage:UIImageView!
    var isNomalLabel:UILabel!
    var lineLabel:GloabLineView!
    var didMakeConstraints:Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        nameAndePhone = UILabel()
        nameAndePhone.font = App_Theme_PinFan_R_14_Font
        nameAndePhone.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(nameAndePhone)
        
        addressDetail = UILabel()
        addressDetail.font = App_Theme_PinFan_R_14_Font
        addressDetail.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        addressDetail.numberOfLines = 0
        self.contentView.addSubview(addressDetail)
        
        selectImage = UIImageView()
        selectImage.image = UIImage.init(named: "Checkbox_Selected")
        self.contentView.addSubview(selectImage)
        
        isNomalLabel = UILabel()
        isNomalLabel.text = "默认地址"
        isNomalLabel.layer.cornerRadius = 1.0
        isNomalLabel.layer.masksToBounds = true
        isNomalLabel.textAlignment = .Center
        isNomalLabel.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        isNomalLabel.font = App_Theme_PinFan_L_11_Font
        isNomalLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.contentView.addSubview(isNomalLabel)
        
        lineLabel = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:AddressModel) {
        nameAndePhone.text = "\(model.name) \(model.mobileNum)"
        let str = "\(model.location)\(model.address)".stringByReplacingOccurrencesOfString(" ", withString: "")
        addressDetail.text = str
        let attributedString = NSMutableAttributedString(string: addressDetail.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: addressDetail.text!.length))
        addressDetail.attributedText = attributedString
        if (model.defaultField != nil) && model.defaultField == true {
           isNomalLabel.hidden = false
        }else{
            isNomalLabel.hidden = true
        }
    }

    func updateSelectImage(isSelect:Bool) {
        if isSelect {
            selectImage.hidden = false
        }else{
            selectImage.hidden = true
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            nameAndePhone.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(16)
                make.left.equalTo(self.contentView.snp_left).offset(15)
            })
            
            addressDetail.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.nameAndePhone.snp_bottom).offset(6)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-70)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-16)
            })
            
            isNomalLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(16)
                make.left.equalTo(self.nameAndePhone.snp_right).offset(14)
                make.size.equalTo(CGSizeMake(54, 16))
            })
            
            selectImage.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
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
