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
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        let express = self.crateLabel(CGRectMake(15, 26, ReciveLabelWidth, 50), tag: 1, titleString: "快递", type: .Select)
        self.addSubview(express)
        
        let arrival = self.crateLabel(CGRectMake(CGRectGetMaxX(express.frame) + 12, 26, ReciveLabelWidth, 50), tag: 2, titleString: "到场取票", type: .Nomal)
        self.addSubview(arrival)
        
        let visit = self.crateLabel(CGRectMake(CGRectGetMaxX(arrival.frame) + 12, 26, ReciveLabelWidth, 50), tag: 3, titleString: "上门自取", type: .Disable)
        self.addSubview(visit)

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
        label.layer.cornerRadius = 1.0
        label.userInteractionEnabled = true
        label.font = Home_ReciveView_Label_Font!
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ReciveTableViewCell.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        label.addGestureRecognizer(singleTap)
        switch type {
        case .Select:
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Select_nColor)
            label.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        case .Nomal:
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
            label.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor).CGColor
            label.layer.borderWidth = 0.5
        default:
            label.textColor = UIColor.init(hexString: Home_ReciveView_Label_Disable_nColor)
            label.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Disable_nColor).CGColor
            label.layer.borderWidth = 0.5
        }
        return label
    }
    
    func selectView(tag:NSInteger){
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.textColor = UIColor.init(hexString: Home_ReciveView_Label_Select_nColor)
        tagView.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        if tag == 1 {
            self.nomalView(2)
            self.nomalView(3)
        }else if tag == 2{
            self.nomalView(1)
            self.nomalView(3)
        }else{
            self.nomalView(1)
            self.nomalView(2)
        }
    }
    
    func nomalView(tag:NSInteger) {
        let tagView = self.viewWithTag(tag) as! UILabel
        tagView.textColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        tagView.layer.borderColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor).CGColor
        tagView.layer.borderWidth = 0.5
        tagView.backgroundColor = UIColor.whiteColor()
        
    }
    
    func singleTapPress(sender:UITapGestureRecognizer) {
        self.selectView((sender.view?.tag)!)
        if self.reciveViewClouse != nil {
            self.reciveViewClouse(tag: (sender.view?.tag)!)
        }
    }

}
