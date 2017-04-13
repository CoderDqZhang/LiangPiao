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
        self.backgroundColor = UIColor.white
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
        lineLabel.isHidden = true
    }
    
    func setData(_ title:String, much:String){
        withDrawName.text = title
        withDrawMuch.text = much
        
    }
    
    func setUpLabel(_ title:String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        label.font = App_Theme_PinFan_R_12_Font
        return label
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            statuesImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(43)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 58, height: 58))
            })
            
            statuesDetail.snp.makeConstraints({ (make) in
                make.top.equalTo(self.statuesImageView.snp.bottom).offset(17)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            })
            
            withDrawmName.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.withDrawmMuch.snp.top).offset(-15)
            })
            
            withDrawName.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.withDrawmMuch.snp.top).offset(-15)
            })
            
            withDrawmMuch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-28)
            })
            
            withDrawMuch.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-28)
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
