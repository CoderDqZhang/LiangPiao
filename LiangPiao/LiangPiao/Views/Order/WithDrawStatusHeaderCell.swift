//
//  WithDrawStatusHeaderCell.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawStatusHeaderCell: UITableViewCell {

    var statuesImageView:UIImageView!
    var withDrawmName:UILabel!
    var withDrawmMuch:UILabel!
    var statuesDetail:UILabel!
    var withDrawName:UILabel!
    var withDrawMuch:UILabel!
    var touUpSelectImage:UIImageView!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        statuesImageView = UIImageView()
        statuesImageView.image = UIImage.init(named: "Icon_Finished")
        self.contentView.addSubview(statuesImageView)
        
        withDrawmName = self.setUpLabel("支付宝账号")
        self.contentView.addSubview(withDrawmName)
        
        withDrawName = self.setUpLabel("rancan@163.com")
        self.contentView.addSubview(withDrawName)
        
        withDrawmMuch = self.setUpLabel("提现金额")
        self.contentView.addSubview(withDrawmMuch)
        
        withDrawMuch = self.setUpLabel("200.00元")
        self.contentView.addSubview(withDrawMuch)

        statuesDetail = UILabel()
        statuesDetail.text = "提现申请已提交"
        statuesDetail.font = App_Theme_PinFan_R_16_Font
        statuesDetail.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.contentView.addSubview(statuesDetail)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hiderLineLabel(){
        lineLabel.hidden = true
    }
    
    func setData(title:String, much:String){
        withDrawName.text = title
        withDrawMuch.text = much
        
    }
    
    func setUpLabel(title:String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .Center
        label.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        label.font = App_Theme_PinFan_R_12_Font
        return label
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            statuesImageView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(43)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.size.equalTo(CGSizeMake(58, 58))
            })
            
            statuesDetail.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.statuesImageView.snp_bottom).offset(17)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            withDrawmName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.withDrawmMuch.snp_top).offset(-15)
            })
            
            withDrawName.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.withDrawmMuch.snp_top).offset(-15)
            })
            
            withDrawmMuch.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-28)
            })
            
            withDrawMuch.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-28)
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
