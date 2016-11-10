//
//  OrderFormView.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderFormType {
    case withNomal
    case withAddress
    case withOrderStatues
}

class OrderFormView: UIView {

    var tableView:UITableView!
    var formType:OrderFormType!
    var formAddress:NSInteger = 0
    let viewModel = OrderConfirmViewModel()
    
    init(frame:CGRect, type:OrderFormType) {
        super.init(frame: frame)
        formType = type
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.registerClass(GloabTitleAndImageCell.self, forCellReuseIdentifier: "GloabTitleAndImageCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.registerClass(CofimTicketTableViewCell.self, forCellReuseIdentifier: "CofimTicketTableViewCell")
        tableView.registerClass(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.separatorStyle = .None
        self.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top).offset(0)
            make.left.equalTo(self.snp_left).offset(0)
            make.right.equalTo(self.snp_right).offset(0)
            make.bottom.equalTo(self.snp_bottom).offset(0)
        }
    }
    
    func ticketIntrductView() -> UIView {
        let ticketIntrductView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,67))
        ticketIntrductView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,2))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        ticketIntrductView.addSubview(imageView)
        
        let label = self.createLabel(CGRectMake(15,20,156,17), text: "票品售出后不可退换，可转售")
        ticketIntrductView.addSubview(label)
        return ticketIntrductView
    }
    
    func orderConfirmView() -> UIView {
        let orderConfirmView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,105))
        orderConfirmView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,2))
        imageView.image = UIImage.init(named: "Pattern_Line")//Pattern_Line
        orderConfirmView.addSubview(imageView)
        
        if self.formType != .withNomal {
            let address = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,17), text: "取票地点：北京市朝阳区香河园小区西坝河中里35号楼二层207")
            orderConfirmView.addSubview(address)
            
            let time = self.createLabel(CGRectMake(15,39,SCREENWIDTH - 30,17), text: "取票时间：周一至周五 08:30 - 20:30")
            orderConfirmView.addSubview(time)
            
            let instroduct = self.createLabel(CGRectMake(15,58,SCREENWIDTH - 30,17), text: "凭手机短信取票码取票，客服热线 400-636-2266")
            orderConfirmView.addSubview(instroduct)
        }
        return orderConfirmView
    }
    
    func upDataTableView() {
        self.tableView.reloadData()
    }
    
    func createLabel(frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = Home_Ticket_Introuduct_Font
        label.textColor = UIColor.init(hexString: Home_Ticket_Introuduct_Color)
        return label
    }
    
}

extension OrderFormView : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.formType == .withAddress {
            if section == 0 {
                return 105
            }else if section == 2 {
                return 67
            }else{
                return 10
            }
        }else{
            if section == 2 {
                return 67
            }else{
                return 10
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 48
            default:
                return 52
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            case 4:
                return 52
            default:
                return 48
            }
        default:
            switch indexPath.row {
            case 0:
                return 48
            default:
                return 52
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelect(tableView, indexPath:indexPath)
    }
    
    
}

extension OrderFormView : UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.orderConfirmView()
        }else if section == 2 {
            return self.ticketIntrductView()
        }else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 5
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.formAddress == 3 || self.formAddress == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTextFieldCell", forIndexPath: indexPath) as! GloabTextFieldCell
                cell.selectionStyle = .None
                if indexPath.row == 0 {
                    cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人姓名")
                }else{
                    cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人手机号码")
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                if indexPath.row == 0 {
                    cell.titleLabel.textColor = UIColor.init(hexString: App_Theme_BackGround_Color)
                }else{
                    
                }
                cell.setData(viewModel.configCellLabel(indexPath), detail: "测试")
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("CofimTicketTableViewCell", forIndexPath: indexPath) as! CofimTicketTableViewCell
                cell.selectionStyle = .None
                return cell
            case 1,3:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailCell", forIndexPath: indexPath) as! GloabTitleAndDetailCell
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "360.00元")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "未选择")
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndFieldCell", forIndexPath: indexPath) as! GloabTitleAndFieldCell
                cell.hideLineLabel()
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "备注关于本次交易的特别说明")
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndImageCell", forIndexPath: indexPath) as! GloabTitleAndImageCell
            if indexPath.row == 1 {
                cell.hideLineLabel()
                cell.setData(viewModel.configCellLabel(indexPath), isSelect: false)
            }else{
                cell.setData(viewModel.configCellLabel(indexPath), isSelect: true)
            }
            cell.selectionStyle = .None
            
            return cell
        }
    }
}

enum ReciveViewLabelType {
    case Select
    case Nomal
    case Disable
}

let ReciveLabelWidth:CGFloat = (SCREENWIDTH - 54)/3
typealias ReciveViewClouse = (tag:NSInteger) ->Void

class ReciveView: UIView {
    
    var reciveViewClouse:ReciveViewClouse!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        let express = self.crateLabel(CGRectMake(15, 26, ReciveLabelWidth, 50), tag: 1, titleString: "快递", type: .Select)
        self.addSubview(express)
        
        let arrival = self.crateLabel(CGRectMake(CGRectGetMaxX(express.frame) + 12, 26, ReciveLabelWidth, 50), tag: 2, titleString: "到场取票", type: .Nomal)
        self.addSubview(arrival)
        
        let visit = self.crateLabel(CGRectMake(CGRectGetMaxX(arrival.frame) + 12, 26, ReciveLabelWidth, 50), tag: 3, titleString: "上门自取", type: .Disable)
        self.addSubview(visit)
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func crateLabel(frame:CGRect, tag:NSInteger, titleString:String, type:ReciveViewLabelType) -> UILabel {
        let label = UILabel(frame: frame)
        label.tag = tag
        label.text = titleString
        label.textAlignment = .Center
        label.layer.cornerRadius = 1.0
        label.userInteractionEnabled = true
        label.font = Home_ReciveView_Label_Font!
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ReciveView.singleTapPress(_:)))
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

class ConfirmView: UIView {
    var muchInfoLabel:UILabel!
    var muchLabel:UILabel!
    var payButton:UIButton!
    var didMakeConstraints:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额:"
        muchInfoLabel.font = Home_PayView_Label_Font
        muchInfoLabel.textColor = UIColor.init(hexString: Home_Ticker_Tools_Table_sColor)
        self.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.text = "688.00 元"
        let attributeString = NSMutableAttributedString(string: muchLabel.text!)
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_Much_Font!,
                                     range: NSMakeRange(0,muchLabel.text!.length - 1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor),
                                     range: NSMakeRange(0, muchLabel.text!.length - 1))
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_MuchLabel_Font!,
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_Ticker_Descrip_Color),
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        muchLabel.attributedText = attributeString
        self.addSubview(muchLabel)
        
        payButton = UIButton(type: .Custom)
        payButton.setTitle("提交订单", forState: .Normal)
        payButton.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        payButton.titleLabel?.font = Home_PayView_Button_Title_Font
        payButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            
        }
        payButton.frame = CGRectMake(SCREENWIDTH - 120, 0, 120, 49)
        self.addSubview(payButton)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left).offset(15)
                make.top.equalTo(self.snp_top).offset(16)
//                make.centerY.equalTo(self.snp_centerY).offset(0)
            })
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.muchInfoLabel.snp_right).offset(4)
                make.top.equalTo(self.snp_top).offset(15)
//                make.centerY.equalTo(self.snp_centerY).offset(0)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
