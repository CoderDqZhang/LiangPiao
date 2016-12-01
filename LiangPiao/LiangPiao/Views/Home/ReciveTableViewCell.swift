//
//  ReciveTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 10/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
enum ReciveViewLabelType {
    case Select
    case Nomal
    case Disable
}

let ReciveLabelWidth:CGFloat = (SCREENWIDTH - 54)/3
typealias ReciveViewClouse = (tag:NSInteger) ->Void

class ReciveTableViewCell: UITableViewCell {

    var reciveViewClouse:ReciveViewClouse!
    var express:UILabel!
    var arrival:UILabel!
    var visit:UILabel!
    var selectEnabel:NSMutableArray = NSMutableArray()
    dynamic var selectTag:NSInteger = 1
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        express = self.crateLabel(CGRectMake(15, 26, ReciveLabelWidth, 50), tag: 1, titleString: "快递", type: .Disable)
        self.contentView.addSubview(express)
        
        arrival = self.crateLabel(CGRectMake(CGRectGetMaxX(express.frame) + 12, 26, ReciveLabelWidth, 50), tag: 2, titleString: "现场取票", type: .Disable)
        self.contentView.addSubview(arrival)
        
        visit = self.crateLabel(CGRectMake(CGRectGetMaxX(arrival.frame) + 12, 26, ReciveLabelWidth, 50), tag: 3, titleString: "上门自取", type: .Disable)
        self.contentView.addSubview(visit)
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
    
    func setData(model:TicketList){
        if selectEnabel.count == 0 {
            let typeArray = model.deliveryType.componentsSeparatedByString(",")
            selectEnabel.removeAllObjects()
            for str in typeArray {
                if str == "1" {
                    selectEnabel.addObject("1")
                    self.upDataLabelType(.Select, label: self.viewWithTag(1) as! UILabel)
                }
                else if str == "2" {
                    selectEnabel.addObject("2")
                    if selectEnabel.count == 1 {
                        self.upDataLabelType(.Select, label: self.viewWithTag(2) as! UILabel)
                        self.makeClouse(2)
                    }else{
                        self.upDataLabelType(.Nomal, label: self.viewWithTag(2) as! UILabel)
                    }
                }else if str == "3" {
                    selectEnabel.addObject("3")
                    if selectEnabel.count == 1 {
                        self.upDataLabelType(.Select, label: self.viewWithTag(3) as! UILabel)
                        self.makeClouse(3)
                    }else{
                        self.upDataLabelType(.Nomal, label: self.viewWithTag(3) as! UILabel)
                    }
                }
            }
            self.updateConstraintsIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func crateLabel(frame:CGRect, tag:NSInteger, titleString:String, type:ReciveViewLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.tag = tag
        label.text = titleString
        label.textAlignment = .Center
        label.layer.cornerRadius = 2.0
        label.layer.masksToBounds = true
        label.font = Home_ReciveView_Label_Font!
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
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Select_nColor)
            label.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
            label.userInteractionEnabled = true
            label.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor).CGColor
            break
        case .Nomal:
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
            label.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor).CGColor
            label.userInteractionEnabled = true
            label.layer.borderWidth = 1
            break
        default:
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Disable_nColor)
            label.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Disable_nColor).CGColor
            label.userInteractionEnabled = false
            label.layer.borderWidth = 1
            break
        }
    }
    
    func selectView(tag:NSInteger){
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        tagView.textColor = UIColor.init(hexString: Home_ReciveView_Label_Select_nColor)
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
        tagView.textColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        tagView.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor).CGColor
        tagView.layer.borderWidth = 1.0
        tagView.backgroundColor = UIColor.whiteColor()
    }
    
    func makeClouse(tag:NSInteger){
        selectTag = tag
        if self.reciveViewClouse != nil {
            self.reciveViewClouse(tag: tag)
        }
    }
    
    func singleTapPress(sender:UITapGestureRecognizer) {
        self.selectView((sender.view?.tag)!)
        self.makeClouse((sender.view?.tag)!)
    }

}
