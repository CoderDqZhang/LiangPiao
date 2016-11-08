//
//  OrderAddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderAddressTableViewCell: UITableViewCell {

    var orderName:UILabel!
    var orderAddress:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        orderName = UILabel()
        orderName.text = "冉灿    18602035508"
        orderName.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderName.font = Mine_Address_Name_Font
        self.contentView.addSubview(orderName)
        
        orderAddress = UILabel()
        orderAddress.text = "朝阳区香河园小区西坝河中里35号楼二层207"
        orderAddress.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderAddress.font = Mine_Address_Name_Font
        self.contentView.addSubview(orderAddress)
    
        self.updateConstraintsIfNeeded()
    }
    
    func setData(name:String, address:String) {
        orderName.text = name
        orderAddress.text = address
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            self.didMakeConstraints = true
            
            orderName.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(15.5)
                make.left.equalTo(self.contentView.snp_left).offset(15)
            })
            
            orderAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.orderName.snp_bottom).offset(1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
            })
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
