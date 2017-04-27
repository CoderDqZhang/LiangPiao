//
//  DeverliyImageTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/4/25.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class DeverliyImageTableViewCell: UITableViewCell {

    var deverliyImageView:UIImageView!
    
    var didMakeContraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        deverliyImageView = UIImageView()
        self.contentView.addSubview(deverliyImageView)
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(_ image:UIImage) {
        deverliyImageView.image = image
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            deverliyImageView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(16)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.size.equalTo(CGSize.init(width: 50, height: 50))
            })
            self.didMakeContraints = true
            
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
