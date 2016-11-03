//
//  TicketNumberTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

let NumberTickButtonWidth:CGFloat = 44
let NumberTickButtonHeight:CGFloat = 34

class NumberTickView: UIView {
    var downButton:UIButton!
    var upButton:UIButton!
    var numberLabel:UILabel!
    var number:NSInteger = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.init(hexString: Home_Ticker_DescripNumber_bordColor).CGColor
        self.layer.borderWidth = 1.0
        downButton = UIButton(type: .Custom)
        downButton.setTitle("-", forState: .Normal)
        downButton.frame = CGRectMake(0, 0, NumberTickButtonWidth, NumberTickButtonHeight)
        downButton.setTitleColor(UIColor.init(hexString: Home_Ticker_DescripNumber_bordColor), forState: .Normal)
        downButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (object) in
            if self.number > 1 {
                self.number = self.number - 1
                self.numberLabel.text = "\(self.number)"
            }
        }
        self.addSubview(downButton)
        
        upButton = UIButton(type: .Custom)
        upButton.setTitle("+", forState: .Normal)
        upButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (object) in
            self.number = self.number + 1
            self.numberLabel.text = "\(self.number)"
        }
        upButton.setTitleColor(UIColor.init(hexString: Home_Ticker_DescripNumber_bordColor), forState: .Normal)
        upButton.frame = CGRectMake(self.frame.size.width - NumberTickButtonWidth, 0, NumberTickButtonWidth, NumberTickButtonHeight)
        self.addSubview(upButton)
        numberLabel = UILabel()
        numberLabel.text = "\(self.number)"
        numberLabel.textColor = UIColor.init(hexString: Home_Ticker_DescripNumber_bordColor)
        numberLabel.layer.borderColor = UIColor.init(hexString: Home_Ticker_DescripNumber_bordColor).CGColor
        numberLabel.layer.borderWidth = 1.0
        numberLabel.font = Home_Ticker_DescripNumber_bordFont
        numberLabel.frame = CGRectMake(NumberTickButtonWidth, 0, self.frame.size.width - 2 * NumberTickButtonWidth, NumberTickButtonHeight)
        numberLabel.textAlignment = .Center
        self.addSubview(numberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TicketNumberTableViewCell: UITableViewCell {

    var ticketNumber:UILabel!
    var lineLabel:GloabLineView!
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
        ticketNumber.textColor = UIColor.init(hexString: Home_Ticker_DescripNumber_Color)
        ticketNumber.font = Home_Ticker_DescripNumber_Font!
        self.contentView.addSubview(ticketNumber)
        
        numberTickView = NumberTickView(frame: CGRectMake(SCREENWIDTH - 140 - 15, 22.5, 140, 34))
        numberTickView.backgroundColor = UIColor.whiteColor()
        self.addSubview(numberTickView)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 139.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNumber.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
//            numberTickView.snp_makeConstraints(closure: { (make) in
//                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
//                make.right.equalTo(self.contentView.snp_right).offset(-15)
//            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
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
