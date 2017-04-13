//
//  DetailAcountTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class DetailAcountTableViewCell: UITableViewCell {

    var muchInfoLabel:UILabel!
    var muchLabel:UILabel!
    var timeLabel:UILabel!
    var linLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "提现"
        muchInfoLabel.font = App_Theme_PinFan_R_14_Font
        muchInfoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.font = App_Theme_PinFan_R_15_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchLabel.text = "0.00"
        self.contentView.addSubview(muchLabel)
        
        timeLabel = UILabel()
        timeLabel.font = App_Theme_PinFan_R_12_Font
        timeLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        timeLabel.text = "2016.12.18 20:25"
        self.contentView.addSubview(timeLabel)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 64.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }

    func setData(_ model:HisList){
        muchInfoLabel.text = model.desc
        timeLabel.text = model.created
        let str = "\(model.amount)".muchType("\((model.amount)!)")
        muchLabel.text = "\((model.optionDesc)!)\(str)"
        if model.optionDesc == "+" {
            muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        }else{
            muchLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(15)
            })
            
            timeLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.muchInfoLabel.snp.bottom).offset(2)
            })
            
            muchLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(-4)
            })
            
//            linLabel.snp.makeConstraints({ (make) in
//                make.left.equalTo(self.contentView.snp.left).offset(15)
//                make.right.equalTo(self.contentView.snp.right).offset(-15)
//                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
//            })
            
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
