//
//  TicketNumberTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketNumberTableViewCell: UITableViewCell {

    var ticketNumber:UILabel!
    var numberTickView:NumberTickView!
    var lineLable:GloabLineView!
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
        
        numberTickView = NumberTickView.init(frame: CGRect(x: SCREENWIDTH - 128 - 15, y: 8, width: 128, height: 32), buttonWidth: 40, type: .confirm)
        numberTickView.backgroundColor = UIColor.white
        
        
        
        self.contentView.addSubview(numberTickView)
    
        lineLable = GloabLineView(frame: CGRect(x: 15,y: 49,width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNumber.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            self.didMakeConstraints = true
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
