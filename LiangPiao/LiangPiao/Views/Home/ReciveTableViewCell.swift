//
//  ReciveTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 10/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
enum ReciveViewLabelType {
    case select
    case nomal
    case disable
}

let ReciveLabelWidth:CGFloat = (SCREENWIDTH - 54)/3
typealias ReciveViewClouse = (_ tag:NSInteger) ->Void

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
        express = self.crateLabel(CGRect(x: 15, y: 26, width: ReciveLabelWidth, height: 50), tag: 1, titleString: "快递送票", type: .disable)
        self.contentView.addSubview(express)
        
        arrival = self.crateLabel(CGRect(x: express.frame.maxX + 12, y: 26, width: ReciveLabelWidth, height: 50), tag: 2, titleString: "现场取票", type: .disable)
        self.contentView.addSubview(arrival)
        
        visit = self.crateLabel(CGRect(x: arrival.frame.maxX + 12, y: 26, width: ReciveLabelWidth, height: 50), tag: 3, titleString: "上门自取", type: .disable)
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
    
    func setData(_ model:TicketList){
        if selectEnabel.count == 0 {
            let typeArray = model.deliveryType.components(separatedBy: ",")
            selectEnabel.removeAllObjects()
            for str in typeArray {
                if str == "1" || str == "4" {
                    selectEnabel.add("1")
                    self.upDataLabelType(.select, label: self.viewWithTag(1) as! UILabel)
                }
                else if str == "2" {
                    selectEnabel.add("2")
                    if selectEnabel.count == 1 {
                        self.upDataLabelType(.select, label: self.viewWithTag(2) as! UILabel)
                        self.makeClouse(2)
                    }else{
                        self.upDataLabelType(.nomal, label: self.viewWithTag(2) as! UILabel)
                    }
                }else if str == "3" {
                    selectEnabel.add("3")
                    if selectEnabel.count == 1 {
                        self.upDataLabelType(.select, label: self.viewWithTag(3) as! UILabel)
                        self.makeClouse(3)
                    }else{
                        self.upDataLabelType(.nomal, label: self.viewWithTag(3) as! UILabel)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func crateLabel(_ frame:CGRect, tag:NSInteger, titleString:String, type:ReciveViewLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.tag = tag
        label.text = titleString
        label.textAlignment = .center
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
    
    func upDataLabelType(_ type:ReciveViewLabelType, label:UILabel){
        switch type {
        case .select:
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.isUserInteractionEnabled = true
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            break
        case .nomal:
            label.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            label.isUserInteractionEnabled = true
            label.layer.borderWidth = 1
            break
        default:
            label.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).cgColor
            label.isUserInteractionEnabled = false
            label.layer.borderWidth = 1
            break
        }
    }
    
    func selectView(_ tag:NSInteger){
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
    
    func nomalView(_ tag:NSInteger) {
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        tagView.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
        tagView.layer.borderWidth = 1.0
        tagView.backgroundColor = UIColor.white
    }
    
    func makeClouse(_ tag:NSInteger){
        selectTag = tag
        if self.reciveViewClouse != nil {
            self.reciveViewClouse(tag)
        }
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer) {
        self.selectView((sender.view?.tag)!)
        self.makeClouse((sender.view?.tag)!)
    }

}
