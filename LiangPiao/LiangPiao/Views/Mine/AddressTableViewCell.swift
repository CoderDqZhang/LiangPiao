//
//  AddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AddAddressView: UIView {
    
    var addButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        self.setUpButton()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddAddressView.singTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func setUpButton() {
        addButton = UIButton(type: .Custom)
        addButton.setTitle("新增收货地址", forState: .Normal)
        addButton.titleLabel?.font = Mine_AddAddress_Name_Font
        addButton.setTitleColor(UIColor.init(hexString: Mine_AddAddress_Name_Color), forState: .Normal)
        addButton.userInteractionEnabled = false
        addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        addButton.setImage(UIImage.init(named: "Icon_Add"), forState: .Normal)
        self.addSubview(addButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        addButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(-1)
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.width.equalTo(139)
        }
        super.updateConstraints()
    }
    
    func singTapPress(sender:UITapGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeleteAddressView: UIView {
    
    var deleteButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        self.setUpButton()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddAddressView.singTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    func setUpButton() {
        deleteButton = UIButton(type: .Custom)
        deleteButton.setTitle("删除收货地址", forState: .Normal)
        deleteButton.titleLabel?.font = Mine_AddAddress_Name_Font
        deleteButton.setTitleColor(UIColor.init(hexString: Mine_AddAddress_Name_Color), forState: .Normal)
        deleteButton.userInteractionEnabled = false
//        addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
//        addButton.setImage(UIImage.init(named: "Icon_Add"), forState: .Normal)
        self.addSubview(deleteButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        deleteButton.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        super.updateConstraints()
    }
    
    func singTapPress(sender:UITapGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        nameAndePhone.font = Mine_Address_Name_Font
        nameAndePhone.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        self.contentView.addSubview(nameAndePhone)
        
        addressDetail = UILabel()
        addressDetail.font = Mine_Address_Name_Font
        addressDetail.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
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
        isNomalLabel.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        isNomalLabel.font = Mine_NomalAddress_Name_Font
        isNomalLabel.textColor = UIColor.init(hexString: Mine_NomalAddress_Name_Color)
        self.contentView.addSubview(isNomalLabel)
        
        lineLabel = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:AddressModel) {
        nameAndePhone.text = "\(model.name) \(model.mobileNum)"
        addressDetail.text = "\(model.location) \(model.address)"
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
