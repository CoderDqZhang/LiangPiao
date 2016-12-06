
//
//  MyWallHeaderTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallHeaderTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var detailBtn:UIButton!
    var muchmLable:UILabel!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.setUpView()
    }
    
    func setUpView() {
        
        muchLabel = UILabel()
        muchLabel.text = "650.20"
        muchLabel.font = App_Theme_PinFan_R_50_Font
        muchLabel.textAlignment = .Center
        muchLabel.textColor = UIColor.whiteColor()
        self.contentView.addSubview(muchLabel)
        
        muchmLable = UILabel()
        muchmLable.text = "账户余额（元）"
        muchmLable.font = App_Theme_PinFan_R_14_Font
        muchmLable.textAlignment = .Center
        muchmLable.textColor = UIColor.whiteColor()
        self.contentView.addSubview(muchmLable)
        
        let image = UIImage.init(named: "Btn_More")
        detailBtn = UIButton(type: .Custom)
        detailBtn.titleLabel?.font = App_Theme_PinFan_R_12_Font
        detailBtn.setTitle("明细", forState: .Normal)
        let stringWidth = detailBtn.titleLabel?.text?.widthWithConstrainedHeight((detailBtn.titleLabel?.text)!, font: App_Theme_PinFan_R_12_Font!, height: 20)
        detailBtn.setImage(UIImage.init(named: "Btn_More"), forState: .Normal)
        detailBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(image?.size.width)!, 0, (image?.size.width)!)
        detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, stringWidth! + 5, -2, -stringWidth!)
        self.contentView.addSubview(detailBtn)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchmLable.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(39)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.muchmLable.snp_bottom).offset(10)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            detailBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(100)
                make.left.equalTo(self.muchLabel.snp_right).offset(12)
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
