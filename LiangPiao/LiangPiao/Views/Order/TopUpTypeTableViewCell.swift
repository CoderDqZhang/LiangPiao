//
//  TopUpTypeTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TopUpTypeTableViewCell: UITableViewCell {

    var touUpImage:UIImageView!
    var topUpTitle:UILabel!
    var topUpDetail:UILabel!
    var touUpSelectImage:UIImageView!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        touUpImage = UIImageView()
        self.contentView.addSubview(touUpImage)
        
        touUpSelectImage = UIImageView()
        self.contentView.addSubview(touUpSelectImage)
        
        topUpTitle = UILabel()
        topUpTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        topUpTitle.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(topUpTitle)
        
        topUpDetail = UILabel()
        topUpDetail.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        topUpDetail.font = App_Theme_PinFan_R_11_Font
        self.contentView.addSubview(topUpDetail)
        
        lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 66.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hiderLineLabel(){
        lineLabel.isHidden = true
    }
    
    func setData(_ image:UIImage, title:String, detail:String, isSelect:Bool){
        touUpImage.image = image
        topUpTitle.text = title
        topUpDetail.text = detail
        self.updataSelectImage(isSelect)
    }
    
    func updataSelectImage(_ isSelect:Bool){
        if isSelect {
            touUpSelectImage.image = UIImage.init(named: "Checkbox_Selected")
        }else{
            touUpSelectImage.image = UIImage.init(named: "Checkbox_Normal")
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            touUpImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 17, height: 16))
            })
            
            touUpSelectImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            topUpTitle.snp.makeConstraints({ (make) in
                make.left.equalTo(self.touUpImage.snp.right).offset(12)
                make.top.equalTo(self.contentView.snp.top).offset(16)
            })
            
            topUpDetail.snp.makeConstraints({ (make) in
                make.left.equalTo(self.touUpImage.snp.right).offset(12)
                make.top.equalTo(self.topUpTitle.snp.bottom).offset(2)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
