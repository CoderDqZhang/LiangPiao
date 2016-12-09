//
//  TicketNumberTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TicketNumberTableViewCell: UITableViewCell {

    var ticketNumber:UILabel!
    var numberTickView:NumberTickView!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        ticketNumber = UILabel()
        ticketNumber.text = "购买数量"
        ticketNumber.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketNumber.font = App_Theme_PinFan_R_13_Font!
        self.contentView.addSubview(ticketNumber)
        
        numberTickView = NumberTickView.init(frame: CGRectMake(SCREENWIDTH - 140 - 15, 22.5, 140, 34), buttonWidth: 40)
        numberTickView.backgroundColor = UIColor.whiteColor()
        
        self.contentView.addSubview(numberTickView)
    
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNumber.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            self.didMakeConstraints = true
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
