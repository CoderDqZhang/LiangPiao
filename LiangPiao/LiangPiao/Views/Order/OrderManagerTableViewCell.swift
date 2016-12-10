//
//  OrderManagerTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
enum TicketImageViewsType {
    case OneImage
    case TwoOrMore
}

class TicketImageViews: UIView {
    var imageView:UIImageView = UIImageView()
    var imageViewSplash1:UIImageView = UIImageView()
    var imageViewSplash2:UIImageView = UIImageView()
    
    init(imageUrl:String, frame:CGRect, type:TicketImageViewsType?) {
        super.init(frame: frame)
        imageView.frame = CGRect.init(x: 0, y: 8, width: frame.size.width, height: frame.size.height - 8)
        imageViewSplash1.frame = CGRect.init(x: 8, y: 0, width: frame.size.width - 16, height: (frame.size.width - 16) * frame.size.height / frame.size.width)
        imageViewSplash2.frame = CGRect.init(x: 4, y: 4, width: frame.size.width - 8, height: (frame.size.width - 8) * frame.size.height / frame.size.width)
        self.addSubview(imageViewSplash1)
        self.addSubview(imageViewSplash2)
        self.addSubview(imageView)
        self.setImage(imageView)
        self.setImage(imageViewSplash1)
        self.setImage(imageViewSplash2)
        imageView.sd_setImageWithURL(NSURL.init(string: imageUrl), placeholderImage: UIImage.init(named: "Feeds_Default_Cover")) { (image, error, cacheType, url) in
            if type == nil || type == .OneImage {
                self.imageViewSplash1.hidden = true
                self.imageViewSplash2.hidden = true
            }
            if type == .TwoOrMore {
                self.imageViewSplash1.hidden = false
                self.imageViewSplash2.hidden = false
                self.imageViewSplash1.image = image
                self.imageViewSplash1.alpha = 0.2
                self.imageViewSplash2.image = image
                self.imageViewSplash2.alpha = 0.4
            }
        }
    }
    
    func setImageType(imageUrl:String,type:TicketImageViewsType?){
        imageView.sd_setImageWithURL(NSURL.init(string: imageUrl), placeholderImage: UIImage.init(named: "Feeds_Default_Cover")) { (image, error, cacheType, url) in
            if type == nil || type == .OneImage {
                self.imageViewSplash1.hidden = true
                self.imageViewSplash2.hidden = true
            }
            if type == .TwoOrMore {
                self.imageViewSplash1.hidden = false
                self.imageViewSplash2.hidden = false
                self.imageViewSplash1.image = image
                self.imageViewSplash1.alpha = 0.2
                self.imageViewSplash2.image = image
                self.imageViewSplash2.alpha = 0.4
            }
        }

    }
    
    func setImage(image:UIImageView){
        image.layer.cornerRadius = 2.0
        image.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OrderManagerTableViewCell: UITableViewCell {

    var ticketPhoto:TicketImageViews!
    var ticketTitle:UILabel!
    var ticketRow:UILabel!
    var ticketTime:UILabel!
    var ticketMuch:UILabel!
    var ticketSelledNumber:UILabel!
    
    var tickType:OrderType = .orderWaitPay
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = TicketImageViews(imageUrl: "http://7xsatk.com1.z0.glb.clouddn.com/6b20c1598794e54b2983eab6e78d48e5.jpg?imageMogr/v2/format/jpg/thumbnail/277x373", frame: CGRect.init(x: 15, y: 22, width: 82, height: 118), type: .TwoOrMore)
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "刘若英“Renext”世界巡回演唱会北京站预售"
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: 3.0)
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_15_Font
        ticketTitle.numberOfLines = 0
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "场次：2016.12.18-2016.12.20"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketTime)
        
        ticketMuch = UILabel()
        ticketMuch.text = "票面：380、580（290x2上下本联票）、68…"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketMuch.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketMuch)
        
        ticketRow = UILabel()
        ticketRow.text = "座位：2016.12.18-2016.12.20"
        ticketRow.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketRow.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketRow)
        
        ticketSelledNumber = UILabel()
        ticketSelledNumber.text = "已售：0"
        ticketSelledNumber.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketSelledNumber.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketSelledNumber)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(title:String, cover:String, session:String, much:String, ticketCount:String, soldCount:String, isMoreTicket:Bool){
        
        ticketTitle.text = title
        ticketTime.text = "场次：\(session)"
        ticketMuch.text = "票面：\(much)"
        ticketSelledNumber.text = "在售：\(ticketCount)   已售：\(soldCount)"
        if isMoreTicket {
            ticketRow.hidden = true
            ticketMuch.snp_remakeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketSelledNumber.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            ticketPhoto.setImageType(cover, type: .TwoOrMore)
        }else{
            ticketRow.hidden = false
            ticketMuch.snp_remakeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketRow.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            ticketPhoto.setImageType(cover, type: .OneImage)
        }
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(22)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.size.equalTo(CGSizeMake(82, 118))
            })
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(27)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketTime.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketMuch.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketRow.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketRow.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketSelledNumber.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            
            ticketSelledNumber.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
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
