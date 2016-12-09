//
//  MySellPriceTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellPriceTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var dicount:UILabel!
    var price:UILabel!
    var price1:UILabel!
    var selectEnabel:NSMutableArray = NSMutableArray()
    dynamic var selectTag:NSInteger = 1
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        titleLabel = UILabel(frame:CGRect.init(x: 15, y: 26, width: 85, height: 18))
        titleLabel.text = "售卖数量"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        titleLabel.font = App_Theme_PinFan_R_13_Font!
        self.contentView.addSubview(titleLabel)
        
        dicount = self.crateLabel(CGRectMake(15, 60, ReciveLabelWidth, 50), tag: 1, titleString: "粉丝团全年套票优惠", type: .Select)
        self.contentView.addSubview(dicount)
        
        price = self.crateLabel(CGRectMake(CGRectGetMaxX(dicount.frame) + 12, 60, ReciveLabelWidth, 50), tag: 2, titleString: "280", type: .Nomal)
        self.contentView.addSubview(price)
        
        price1 = self.crateLabel(CGRectMake(CGRectGetMaxX(price.frame) + 12, 60, ReciveLabelWidth, 50), tag: 3, titleString: "380", type: .Nomal)
        self.contentView.addSubview(price1)
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func crateLabel(frame:CGRect, tag:NSInteger, titleString:String, type:ReciveViewLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.tag = tag
        label.text = titleString
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.layer.cornerRadius = 2.0
        label.layer.masksToBounds = true
        label.font = App_Theme_PinFan_R_13_Font!
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ReciveTableViewCell.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        label.addGestureRecognizer(singleTap)
        self.upDataLabelType(type, label: label)
        return label
    }
    
    func upDataLabelType(type:ReciveViewLabelType, label:UILabel){
        switch type {
        case .Select:
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.userInteractionEnabled = true
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            break
        case .Nomal:
            label.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            label.userInteractionEnabled = true
            label.layer.borderWidth = 1
            break
        default:
            label.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).CGColor
            label.userInteractionEnabled = false
            label.layer.borderWidth = 1
            break
        }
    }
    
    func selectView(tag:NSInteger){
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        tagView.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        if tag == 1 {
            for str in self.selectEnabel {
                if str as! String == "2" {
                    self.nomalView(2)
                }else if str as! String == "3" {
                    self.nomalView(3)
                }
            }
        }else if tag == 2{
            for str in self.selectEnabel {
                if str as! String == "1" {
                    self.nomalView(1)
                }else if str as! String == "3" {
                    self.nomalView(3)
                }
            }
        }else if tag == 3{
            for str in self.selectEnabel {
                if str as! String == "1" {
                    self.nomalView(1)
                }else if str as! String == "2" {
                    self.nomalView(2)
                }
            }
        }
    }
    
    func nomalView(tag:NSInteger) {
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        tagView.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
        tagView.layer.borderWidth = 1.0
        tagView.backgroundColor = UIColor.whiteColor()
    }
    
    func makeClouse(tag:NSInteger){
        selectTag = tag
       
    }
    
    
    func singleTapPress(sender:UITapGestureRecognizer) {
        self.selectView((sender.view?.tag)!)
        self.makeClouse((sender.view?.tag)!)
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
