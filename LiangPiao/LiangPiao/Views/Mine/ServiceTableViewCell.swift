//
//  ServiceTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    var nameAndePhone:UILabel!
    var sigleTap:UITapGestureRecognizer!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpView() {
        
        sigleTap = UITapGestureRecognizer(target: self, action: #selector(ServiceTableViewCell.sigleTapPress(_:)))
        sigleTap.numberOfTapsRequired = 1
        sigleTap.numberOfTouchesRequired = 1
        
        nameAndePhone = UILabel()
        nameAndePhone.numberOfLines = 0
        nameAndePhone.userInteractionEnabled = true
        nameAndePhone.font = Mine_Address_Name_Font
        nameAndePhone.addGestureRecognizer(sigleTap)
        nameAndePhone.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        let str = "客服电话：400-873-8011\n工作时间：周一至周六 09:00-21:00"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: Mine_Service_Color)], range: NSRange(location: 0, length: 5))
        attribute.addAttributes([NSFontAttributeName:Mine_Service_Font!], range: NSRange.init(location: 0, length: 5))
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: Mine_Service_Color)], range: NSRange(location: 18, length: 22))
        attribute.addAttributes([NSFontAttributeName:Mine_Service_Font!], range: NSRange.init(location: 18, length: 22))
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: Mine_Service_mColor)], range: NSRange(location: 5, length: 12))
        attribute.addAttributes([NSFontAttributeName:Mine_Service_Font!], range: NSRange.init(location: 5, length: 12))
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 9
        attribute.addAttributes([NSParagraphStyleAttributeName:paragraph], range: NSRange.init(location: 0, length: str.length))
        nameAndePhone.attributedText = attribute
        nameAndePhone.textAlignment = .Center
        self.contentView.addSubview(nameAndePhone)
        
        self.updateConstraintsIfNeeded()
    }
    
    func sigleTapPress(sender:UITapGestureRecognizer) {
        AppCallViewShow(self.contentView, phone: "400-873-8011")
    }
    
    func setData(namePhone:String, photoImage:UIImage) {
        nameAndePhone.text = namePhone
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            nameAndePhone.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-40)
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
