//
//  GloabTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class GloabTableViewCell: NSObject {

}

class GloabTitleAndDetailCell: UITableViewCell {
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.font = App_Theme_PinFan_R_13_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(detailLabel)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    func setData(title:String, detail:String) {
        self.titleLabel.text = title
        self.detailLabel.text = detail
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}

class GloabTitleAndFieldCell: UITableViewCell {
    var titleLabel:UILabel!
    var textField:UITextField!
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        textField = UITextField()
        textField.font = App_Theme_PinFan_R_13_Font
        textField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        textField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(textField)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setTextFieldText(text:String) {
        textField.text = text
        textField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
    }
    
    
    
    func setData(title:String, detail:String) {
        titleLabel.text = title
        textField.placeholder = detail
        textField.attributedPlaceholder = NSAttributedString.init(string: detail, attributes: [NSFontAttributeName:App_Theme_PinFan_R_13_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)])
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.width.equalTo(70)
            })
            
            textField.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.titleLabel.snp_right).offset(6)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}

class GloabTitleAndDetailImageCell: UITableViewCell {
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var detailImage:UIImageView!
    
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.font = App_Theme_PinFan_R_13_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        self.contentView.addSubview(detailLabel)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(title:String, detail:String) {
        self.titleLabel.text = title
        detailLabel.text = detail
        if detailLabel.text == "未选择" {
            detailLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        }else{
            detailLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        }
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15.5)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.detailImage.snp_left).offset(-10)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailImage.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}

class GloabTitleAndImageCell: UITableViewCell {
    var titleLabel:UILabel!
    var detailImage:UIImageView!
    
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Checkbox_Normal")
        self.contentView.addSubview(detailImage)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(title:String, isSelect:Bool) {
        titleLabel.text = title
        if isSelect {
           detailImage.image = UIImage.init(named: "Checkbox_Selected")
        }else{
            detailImage.image = UIImage.init(named: "Checkbox_Normal")
        }
    }
    
    func updateImageView(isSelect:Bool){
        if isSelect {
            detailImage.image = UIImage.init(named: "Checkbox_Selected")
        }else{
            detailImage.image = UIImage.init(named: "Checkbox_Normal")
        }
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailImage.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(1)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}

class GloabTextFieldCell: UITableViewCell {

    var textField:UITextField!
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        textField = UITextField()
        textField.font = App_Theme_PinFan_R_13_Font
        textField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        textField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(textField)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(title:String, detail:String) {
        textField.placeholder = detail
        textField.attributedPlaceholder = NSAttributedString.init(string: detail, attributes: [NSFontAttributeName:App_Theme_PinFan_R_13_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)])
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
        
            textField.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}

class GloabImageTitleAndImageCell: UITableViewCell {
    var titleLabel:UILabel!
    var infoImageView:UIImageView!
    var detailImage:UIImageView!
    
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        infoImageView = UIImageView()
        self.contentView.addSubview(infoImageView)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(title:String, infoImage:UIImage) {
        self.titleLabel.text = title
        infoImageView.image = infoImage
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.infoImageView.snp_right).offset(9)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            infoImageView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailImage.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(1)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
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
}
