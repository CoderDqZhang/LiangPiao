//
//  mySellOrderMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellOrderMuchTableViewCell: UITableViewCell {

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
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额："
        muchInfoLabel.font = App_Theme_PinFan_R_12_Font
        muchInfoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.font = App_Theme_PinFan_R_18_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchLabel.text = "688.00"
        
        muchmLabel = UILabel()
        muchmLabel.font = App_Theme_PinFan_R_12_Font
        muchmLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchmLabel.text = "元"
        self.contentView.addSubview(muchmLabel)
        
        self.contentView.addSubview(muchLabel)
        
        handerButton = UIButton(type: .custom)
        handerButton.setTitle("立即发货", for: UIControlState())
        handerButton.layer.masksToBounds = true
        handerButton.layer.cornerRadius = 2.0
        handerButton.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        handerButton.titleLabel?.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(handerButton)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setSellData(_ model:OrderList){
        muchLabel.text = "\((model.total)!)"
        handerButton.isHidden = true
        if model.status == 3 {
            handerButton.isHidden = false
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(1)
            })
            muchLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.muchInfoLabel.snp.right).offset(6)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            muchmLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.muchLabel.snp.right).offset(6)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(1)
            })
            
            handerButton.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 80, height: 30))
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

    override func setSelected( _ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
