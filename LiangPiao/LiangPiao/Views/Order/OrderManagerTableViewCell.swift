//
//  OrderManagerTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
enum TicketImageViewsType {
    case oneImage
    case twoOrMore
}

class TicketImageViews: UIView {
    var imageView:UIImageView = UIImageView()
    var imageViewSplash1:UIImageView = UIImageView()
    var imageViewSplash2:UIImageView = UIImageView()
    
    init(imageUrl:String?, frame:CGRect, type:TicketImageViewsType?) {
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
        if imageUrl != nil {
            imageView.sd_setImage(with: URL.init(string: imageUrl!), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, rul) in
                
            }, completed: { (image, error, cacheType, url) in
                if type == nil || type == .oneImage {
                    self.imageViewSplash1.isHidden = true
                    self.imageViewSplash2.isHidden = true
                }
                if type == .twoOrMore {
                    self.imageViewSplash1.isHidden = false
                    self.imageViewSplash2.isHidden = false
                    self.imageViewSplash1.image = image
                    self.imageViewSplash1.alpha = 0.2
                    self.imageViewSplash2.image = image
                    self.imageViewSplash2.alpha = 0.4
                }
            })
        }else{
            let image = UIImage.init(named: "Feeds_Default_Cover")
            imageView.image = image
            self.imageViewSplash1.image = image
            self.imageViewSplash1.alpha = 0.2
            self.imageViewSplash2.image = image
            self.imageViewSplash2.alpha = 0.4
            if type == nil || type == .oneImage {
                self.imageViewSplash1.isHidden = true
                self.imageViewSplash2.isHidden = true
            }
            if type == .twoOrMore {
                self.imageViewSplash1.isHidden = false
                self.imageViewSplash2.isHidden = false
            }
        }
    }
    
    func setImageType(_ imageUrl:String,type:TicketImageViewsType?){
        imageView.sd_setImage(with: URL.init(string: imageUrl), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, rul) in
            
        }, completed: { (image, error, cacheType, url) in
            if type == nil || type == .oneImage {
                self.imageViewSplash1.isHidden = true
                self.imageViewSplash2.isHidden = true
            }
            if type == .twoOrMore {
                self.imageViewSplash1.isHidden = false
                self.imageViewSplash2.isHidden = false
                self.imageViewSplash1.image = image
                self.imageViewSplash1.alpha = 0.2
                self.imageViewSplash2.image = image
                self.imageViewSplash2.alpha = 0.4
            }
        })
    }
    
    func setImage(_ image:UIImageView){
        image.layer.cornerRadius = 3.0
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
        self.backgroundColor = UIColor.white
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = TicketImageViews(imageUrl: nil, frame: CGRect.init(x: 15, y: 22, width: 82, height: 118), type: .oneImage)
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "刘若英“Renext”世界巡回演唱会北京站预售"
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
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
    
    func setData(_ title:String, cover:String, session:String, much:String, remainCount:String, soldCount:String, isMoreTicket:Bool){
        
        ticketTitle.text = title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = "场次：\(session)"
        ticketMuch.text = "票面：\(much)"
        ticketSelledNumber.text = "在售：\(remainCount)   已售：\(soldCount)"
        if isMoreTicket {
            ticketRow.isHidden = true
            ticketMuch.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(self.ticketSelledNumber.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            ticketPhoto.setImageType(cover, type: .twoOrMore)
        }else{
            ticketRow.isHidden = false
            ticketMuch.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(self.ticketRow.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            ticketPhoto.setImageType(cover, type: .oneImage)
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(22)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 82, height: 118))
            })
            
            ticketTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(27)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketTime.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketMuch.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketRow.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketRow.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketSelledNumber.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketSelledNumber.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
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
