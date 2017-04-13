//
//  TicketSceneTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketSceneTableViewCell: UITableViewCell {

    var timeImageView:UIImageView!
    var timeTitle:UILabel!
    var ticketmMuch:UILabel!
    var ticketMuch:UILabel!
    var lineLabel:GloabLineView!
    var didMakeContraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        timeImageView = UIImageView()
        timeImageView.image = UIImage.init(named: "Icon_Date")
        self.contentView.addSubview(timeImageView)
        
        ticketmMuch = UILabel()
        ticketmMuch.text = "元起"
        ticketmMuch.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        ticketmMuch.font = App_Theme_PinFan_R_10_Font
        self.contentView.addSubview(ticketmMuch)
        
        ticketMuch = UILabel()
        ticketMuch.text = "暂时缺票"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketMuch.font = App_Theme_PinFan_R_21_Font
        self.contentView.addSubview(ticketMuch)
        
        timeTitle = UILabel()
        timeTitle.text = "2016.10.14 周五 20:00"
        timeTitle.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        timeTitle.font = App_Theme_PinFan_R_15_Font
        self.contentView.addSubview(timeTitle)

        lineLabel = GloabLineView(frame: CGRect(x: 15, y: self.contentView.bounds.size.height - 0.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model:ShowSessionModel) {
        if model.ticketStatus != 0 || model.minPrice == 0 {
            let mMuch = model.ticketCount == 0 ? "暂时缺票" : "元起"
            ticketmMuch.text = mMuch
            let much = mMuch == "暂时缺票" ? "" : "\((model.minPrice)!)"
            ticketMuch.text = much
        }else{
            ticketmMuch.text = "元起"
            ticketMuch.text = "\((model.minPrice)!)"
        }
        timeTitle.text = model.name
        
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            timeImageView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 24, height: 24))
            })
            
            ticketmMuch.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(3)
                make.height.equalTo(14)
            })
            
            ticketMuch.snp.makeConstraints({ (make) in
                make.right.equalTo(self.ticketmMuch.snp.left).offset(-4)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            timeTitle.snp.makeConstraints({ (make) in
                make.left.equalTo(self.timeImageView.snp.right).offset(8)
                make.right.lessThanOrEqualTo(self.ticketMuch.snp.left).offset(-10)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            lineLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
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
