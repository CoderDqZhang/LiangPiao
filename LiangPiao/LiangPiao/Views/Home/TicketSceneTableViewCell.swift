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

        lineLabel = GloabLineView(frame: CGRectMake(15, self.contentView.bounds.size.height - 0.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model:ShowSessionModel) {
        if model.ticketStatus != 0 || model.minPrice == 0 {
            let mMuch = model.ticketCount == 0 ? "暂时缺票" : "元起"
            ticketmMuch.text = mMuch
            let much = mMuch == "暂时缺票" ? "" : "\(model.minPrice)"
            ticketMuch.text = much
        }else{
            ticketmMuch.text = "元起"
            ticketMuch.text = "\(model.minPrice)"
        }
        timeTitle.text = model.name
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            timeImageView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.size.equalTo(CGSizeMake(24, 24))
            })
            
            ticketmMuch.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3)
                make.height.equalTo(14)
            })
            
            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.ticketmMuch.snp_left).offset(-4)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            timeTitle.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.timeImageView.snp_right).offset(8)
                make.right.lessThanOrEqualTo(self.ticketMuch.snp_left).offset(-10)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
            })
            self.didMakeContraints = true
            
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
