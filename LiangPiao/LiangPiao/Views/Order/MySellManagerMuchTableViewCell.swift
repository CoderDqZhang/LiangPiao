//
//  MySellManagerMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellManagerMuchTableViewCell: UITableViewCell {

    var muchInfoLabel:UILabel!
    var muchLabel:UILabel!
    var muchmLabel:UILabel!
    var handerButton:UIButton!
    var linLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "售卖价格："
        muchInfoLabel.font = App_Theme_PinFan_R_12_Font
        muchInfoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.font = App_Theme_PinFan_R_18_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchLabel.text = "360-826"
        
        muchmLabel = UILabel()
        muchmLabel.font = App_Theme_PinFan_R_12_Font
        muchmLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchmLabel.text = "元"
        self.contentView.addSubview(muchmLabel)
        
        self.contentView.addSubview(muchLabel)
        
        handerButton = UIButton(type: .Custom)
        handerButton.layer.masksToBounds = true
        handerButton.layer.cornerRadius = 2.0
        handerButton.setImage(UIImage.init(named: "Btn_More_Normal"), forState: .Normal)
        handerButton.setImage(UIImage.init(named: "Btn_More_Press"), forState: .Selected)
        handerButton.titleLabel?.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(handerButton)
        
        linLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setMuchLabelText(text:String){
        muchLabel.text = text
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(1)
            })
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.muchInfoLabel.snp_right).offset(4)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            muchmLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.muchLabel.snp_right).offset(4)
                make.top.equalTo(self.snp_top).offset(21)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(2)
            })
            
            handerButton.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(8)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.size.equalTo(CGSizeMake(80, 30))
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
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
