//
//  TicketRemarkTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 09/01/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TicketRemarkTableViewCell: UITableViewCell {

    var messageLabel:UILabel!
    var linLabel:UILabel!
    
    var didMakeConstraints:Bool = false

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        linLabel = UILabel()
        linLabel.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.contentView.addSubview(linLabel)
        
        messageLabel = UILabel()
        messageLabel.font = App_Theme_PinFan_R_12_Font
        messageLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        messageLabel.numberOfLines = 0
        self.contentView.addSubview(messageLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        messageLabel.text = "备注：\(model.message)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            linLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(0)
                make.height.equalTo(0.5)
            })
            
            messageLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
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
