//
//  DeverliyTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class DeverliyTableViewCell: UITableViewCell {

    var infoLabel:UILabel!
    var titleImage:UIImageView!
    var detailImage:UIImageView!
    var linLabel:GloabLineView!
    
    var didMakeContraints:Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        infoLabel = UILabel()
        infoLabel.numberOfLines = 1
        infoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        infoLabel.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(infoLabel)
        
        titleImage = UIImageView()
        titleImage.image = UIImage.init(named: "Icon_Address")
        self.contentView.addSubview(titleImage)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(_ trac:Trace) {
        for str in deverliyDic.allKeys {
            if str as! String == trac.acceptStation {
                self.infoLabel.text = "物流追踪  \((trac.acceptStation)!)  单号：\((trac.acceptTime)!)"
                return
            }
        }
        self.infoLabel.text = "物流追踪 \((trac.acceptStation)!) \((trac.acceptTime)!)"
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            infoLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.titleImage.snp.right).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-35)
            })
            
            titleImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(12)
                make.size.equalTo(CGSize.init(width: 27, height: 27))
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            detailImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            self.didMakeContraints = true
            
        }
        super.updateConstraints()
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
