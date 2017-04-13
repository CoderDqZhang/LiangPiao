//
//  TicketMapTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class TicketMapTableViewCell: UITableViewCell {

    var ticketMap:UIImageView!
    
    var didMakeConstraits:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
    
        ticketMap = UIImageView()
        self.contentView.addSubview(ticketMap)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ imageUrl:String){
//        ticketMap.sd_setImage(with: URL.init(string: imageUrl), placeholderImage: UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: 170))) { (image, error, cache, url) in
//            
//        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraits {
            ticketMap.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            })
            
            self.didMakeConstraits = true
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
