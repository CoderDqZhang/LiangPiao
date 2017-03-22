//
//  OrderStatusViewController.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = OrderStatusViewModel()
    var payView:GloableBottomButtonView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.setUpView()
        self.setUpNavigationItem()
        // Do any additional setup after loading the view.
    }

    func setUpNavigationItem(){
        self.navigationItem.title = "订单详情"
        self.talKingDataPageName = "卖家订单详情"
        self.setNavigationItemBack()
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(ReciveAddressTableViewCell.self, forCellReuseIdentifier: "ReciveAddressTableViewCell")
        tableView.registerClass(OrderTicketInfoTableViewCell.self, forCellReuseIdentifier: "OrderTicketInfoTableViewCell")
        tableView.registerClass(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.registerClass(OrderStatusTableViewCell.self, forCellReuseIdentifier: "OrderStatusTableViewCell")
        tableView.registerClass(OrderStatusMuchTableViewCell.self, forCellReuseIdentifier: "OrderStatusMuchTableViewCell")
        tableView.registerClass(DeverliyTableViewCell.self, forCellReuseIdentifier: "DeverliyTableViewCellSellDetail")
        tableView.registerClass(OrderPayTableViewCell.self, forCellReuseIdentifier: "OrderPayTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        payView = GloableBottomButtonView.init(frame: nil, title: "立即发货", tag: 1, action: { (tag) in
            if self.viewModel.model.status == 3 {
                self.viewModel.requestOrderStatusChange()
            }
        })
        self.view.addSubview(payView)
        self.updateTableView(self.viewModel.model.status)
        
    }
    
    func bindViewModel(){
        viewModel.controller = self
    }
    func updateTableView(status:Int) {
        if status == 3 {
            if payView != nil {
                payView.hidden = false
            }else{
                payView = GloableBottomButtonView.init(frame: nil, title: "立即发货", tag: 1, action: { (tag) in
                    if self.viewModel.model.status == 3 {
                        self.viewModel.requestOrderStatusChange()
                    }
                })
                self.view.addSubview(payView)
            }
            
            if status == 3 {
                payView.updateButtonTitle("立即发货")
            }
            tableView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.view.snp_top).offset(0)
                make.left.equalTo(self.view.snp_left).offset(0)
                make.right.equalTo(self.view.snp_right).offset(0)
                make.bottom.equalTo(self.view.snp_bottom).offset(-49)
            })
        }else{
            self.viewModel.getDeverliyTrac()
            if payView != nil {
                payView.hidden = true
            }
            tableView.snp_remakeConstraints { (make) in
                make.top.equalTo(self.view.snp_top).offset(0)
                make.left.equalTo(self.view.snp_left).offset(0)
                make.right.equalTo(self.view.snp_right).offset(0)
                make.bottom.equalTo(self.view.snp_bottom).offset(0)
            }
        }
    }
    
    func widthDrawFooterView() -> UIView{
        let footView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,100))
        footView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRectMake(0,-0.5,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        let service = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,14), text: "订单时间：\(viewModel.model.created)")
        footView.addSubview(service)
        let servicePhone = self.createLabel(CGRectMake(15,36,SCREENWIDTH - 30,14), text: "客服电话：400-873-8011")
        footView.addSubview(servicePhone)
        let serviceTime = self.createLabel(CGRectMake(15,52,SCREENWIDTH - 30,14), text: "客服工作时间：周一至周六 09:00-21:00")
        footView.addSubview(serviceTime)
        
        return footView
    }
    
    func createLabel(frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        return label
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrderStatusViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.orderStatusTableViewDidSelect(tableView, indexPath: indexPath)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

extension OrderStatusViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewFooterViewHeight(section)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !viewModel.isCancel() {
            if section == 1 {
                return self.widthDrawFooterView()
            }else{
                return nil
            }
        }
        return self.widthDrawFooterView()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if !viewModel.isCancel() {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusTableViewCell", forIndexPath: indexPath) as! OrderStatusTableViewCell
                    viewModel.tableViewCellOrderStatusTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .None
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCellWithIdentifier("ReciveAddressTableViewCell", forIndexPath: indexPath) as! ReciveAddressTableViewCell
                    viewModel.tableViewCellReciveAddressTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .None
                    return cell
                default:
                    if viewModel.deverliyModel != nil {
                        let cell = tableView.dequeueReusableCellWithIdentifier("DeverliyTableViewCellSellDetail", forIndexPath: indexPath) as! DeverliyTableViewCell
                        viewModel.tableViewCellDeverliyTableViewCell(cell, indexPath: indexPath)
                        cell.selectionStyle = .None
                        return cell
                    }else{
                        var cell = tableView.dequeueReusableCellWithIdentifier("defaultCell")
                        if cell == nil {
                            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "defaultCell")
                        }
                        return cell!
                    }
                    
                }
            default:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderNumberTableViewCell", forIndexPath: indexPath) as! OrderNumberTableViewCell
                    viewModel.tableViewCellOrderNumberTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .None
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderTicketInfoTableViewCell", forIndexPath: indexPath) as! OrderTicketInfoTableViewCell
                    cell.selectionStyle = .None
                    viewModel.tableViewCellOrderTicketInfoTableViewCell(cell, indexPath:indexPath)
                    cell.backgroundColor = UIColor.whiteColor()
                    let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
                    cell.contentView.addSubview(lineLabel)
                    lineLabel.snp_makeConstraints { (make) in
                        make.left.equalTo(cell.contentView.snp_left).offset(15)
                        make.right.equalTo(cell.contentView.snp_right).offset(-15)
                        make.bottom.equalTo(cell.contentView.snp_bottom).offset(0)
                        make.height.equalTo(0.5)
                    }
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderPayTableViewCell", forIndexPath: indexPath) as! OrderPayTableViewCell
                    viewModel.tableViewCellOrderPayTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .None
                    return cell
                default:
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusMuchTableViewCell", forIndexPath: indexPath) as! OrderStatusMuchTableViewCell
                        viewModel.tableViewCellOrderMuchTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .None
                    return cell
                }
            }
        }else{
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderNumberTableViewCell", forIndexPath: indexPath) as! OrderNumberTableViewCell
                viewModel.tableViewCellOrderNumberTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .None
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderTicketInfoTableViewCell", forIndexPath: indexPath) as! OrderTicketInfoTableViewCell
                cell.selectionStyle = .None
                viewModel.tableViewCellOrderTicketInfoTableViewCell(cell, indexPath:indexPath)
                let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
                cell.contentView.addSubview(lineLabel)
                lineLabel.snp_makeConstraints { (make) in
                    make.left.equalTo(cell.contentView.snp_left).offset(15)
                    make.right.equalTo(cell.contentView.snp_right).offset(-15)
                    make.bottom.equalTo(cell.contentView.snp_bottom).offset(0)
                    make.height.equalTo(0.5)
                }
                cell.backgroundColor = UIColor.whiteColor()
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderPayTableViewCell", forIndexPath: indexPath) as! OrderPayTableViewCell
                viewModel.tableViewCellOrderPayTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusMuchTableViewCell", forIndexPath: indexPath) as! OrderStatusMuchTableViewCell
                viewModel.tableViewCellOrderMuchTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .None
                return cell
            }
        }
    }
}

