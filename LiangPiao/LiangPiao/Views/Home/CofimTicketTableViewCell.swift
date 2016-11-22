//
//  CofimTicketTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class CofimTicketTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketMuch:UILabel!
    var ticketRow:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: Home_OrderConfirmCell_Color)
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = UIImageView()
        ticketPhoto.layer.cornerRadius = 3
        ticketPhoto.layer.masksToBounds = true
        ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover")
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "万有音乐系 陈粒《小梦大半》2016巡回演唱会"
        ticketTitle.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Title_Color)
        ticketTitle.font = Home_OrderConfirmCell_Title_Font
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "时间：2016.12.18 20:25"
        ticketTime.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Info_Color)
        ticketTime.font = Home_OrderConfirmCell_Info_Font
        self.contentView.addSubview(ticketTime)
        
        ticketLocation = UILabel()
        ticketLocation.text = "场馆：大隐剧院 朝阳区光华路9号世贸天阶 C 座时尚大厦5楼"
//        let attributedString = NSMutableAttributedString(string: ticketLocation.text!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 1.5
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: ticketLocation.text!.length))
//        ticketLocation.attributedText = attributedString
        UILabel.changeLineSpaceForLabel(ticketLocation, withSpace: 3.0)
        ticketLocation.numberOfLines = 0
        ticketLocation.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Info_Color)
        ticketLocation.font = Home_OrderConfirmCell_Info_Font
        self.contentView.addSubview(ticketLocation)
        
        ticketMuch = UILabel()
        ticketMuch.text = "票面：960（480x2上下本联票）x2"
        ticketMuch.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Info_Color)
        ticketMuch.font = Home_OrderConfirmCell_Info_Font
        self.contentView.addSubview(ticketMuch)
        
        ticketRow = UILabel()
        ticketRow.text = "座位：优先择座"
        ticketRow.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Info_Color)
        ticketRow.font = Home_OrderConfirmCell_Info_Font
        self.contentView.addSubview(ticketRow)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
                make.width.equalTo(82)
            })
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(17)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.height.equalTo(21)
            })
            
            ticketTime.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketTitle.snp_bottom).offset(9)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketLocation.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketTime.snp_bottom).offset(2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketLocation.snp_bottom).offset(2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            
            ticketRow.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketMuch.snp_bottom).offset(2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
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
