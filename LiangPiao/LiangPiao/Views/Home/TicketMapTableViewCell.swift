//
//  TicketMapTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketMapTableViewCell: UITableViewCell {

    var ticketMap:UIView!
    var didMakeConstraits:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
    
        ticketMap = UIView()
        ticketMap.backgroundColor = UIColor.init(hexString: GlobalCell_Detail_Color)
        self.contentView.addSubview(ticketMap)
        
        self.updateConstraintsIfNeeded()
    }
    
//    override func updateConstraints() {
//        if !self.didMakeConstraits {
//            ticketMap.snp_makeConstraints(closure: { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(0)
//                make.right.equalTo(self.contentView.snp_right).offset(0)
//                make.top.equalTo(self.contentView.snp_top).offset(0)
//                make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//            })
//            
//            self.didMakeConstraits = true
//        }
//        super.updateConstraints()
//    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
