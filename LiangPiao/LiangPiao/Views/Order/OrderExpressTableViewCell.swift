//
//  OrderExpressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderExpressTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var switchBar:UISwitch!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.text = "普通快递（8元）、顺丰快递（13元）"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.font = App_Theme_PinFan_R_12_Font
        detailLabel.text = "超出部分由商家自行承担"
        detailLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(detailLabel)
        
        switchBar = UISwitch()
        switchBar.onTintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        switchBar.setOn(true, animated: true)
        self.contentView.addSubview(switchBar)
        
        lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 90.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hiderLineLabel(){
        lineLabel.isHidden = true
    }
    
    func setData(_ title:String, detail:String, isSelect:Bool){
        self.updataSwitchBar(isSelect)
    }
    
    func updataSwitchBar(_ isSelect:Bool){
        switchBar.setOn(isSelect, animated: true)
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(26)
            })
            
            detailLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            })
            
            switchBar.snp.makeConstraints({ (make) in
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
