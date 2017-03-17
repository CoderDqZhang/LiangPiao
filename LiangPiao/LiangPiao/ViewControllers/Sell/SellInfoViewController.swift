//
//  SellInfoViewController.swift
//  LiangPiao
//
//  Created by Zhang on 16/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellInfoViewController: UIViewController {

    var viewModel = MySellConfimViewModel.shareInstance
    var tableView:UITableView!
    var bottomButton:GloableBottomButtonView!
    var sellType:ZHPickView!
    var ticketRegion:ZHPickView!
    var ticketRow:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "挂票"
        self.bindViewModel()
        self.setUpView()
        self.setNavigationItem()
        self.talKingDataPageName = "挂票"
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    deinit {
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
        if sellType != nil {
            sellType.remove()
        }
        if ticketRegion != nil {
            ticketRegion.remove()
        }
        if ticketRow != nil {
            ticketRow.remove()
        }
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        tableView.registerClass(MySellServiceTableViewCell.self, forCellReuseIdentifier: "MySellServiceTableViewCell")
        tableView.registerClass(TicketStatusTableViewCell.self, forCellReuseIdentifier: "TicketStatusTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-44)
        }
        
        bottomButton = GloableBottomButtonView.init(frame: nil, title: "立即挂票", tag: nil, action: { (tag) in
            self.viewModel.sellFormModel.saveOrUpdate()
            self.viewModel.requestSellTicketPost()
        })
        
        self.view.addSubview(bottomButton)
        
    }
    
    func setNavigationItem(){
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "卖票须知", style: .Plain, target: self, action: #selector(MySellConfimViewController.rightItemPress))
    }
    
    func rightItemPress(){
        KWINDOWDS().addSubview(GloableServiceView.init(title: "卖票规则", message: self.viewModel.messageTitle()))
    }
    
    func bindViewModel() {
        viewModel.infoController = self
    }
    
    func showSellTypePickerView(){
        if sellType == nil {
            sellType = ZHPickView(pickviewWithArray: viewModel.getSellType() as [AnyObject], isHaveNavControler: false)
            sellType.setPickViewColer(UIColor.whiteColor())
            sellType.setPickViewColer(UIColor.whiteColor())
            sellType.setTintColor(UIColor.whiteColor())
            sellType.tag = 0
            sellType.setToolbarTintColor(UIColor.whiteColor())
            sellType.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            sellType.delegate = self
        }
        
        sellType.show()
    }
    
    func showTicketRegionPickerView(){
        if ticketRegion == nil {
            ticketRegion = ZHPickView(pickviewWithArray: viewModel.getRegionArray() as [AnyObject], isHaveNavControler: false)
            ticketRegion.setPickViewColer(UIColor.whiteColor())
            ticketRegion.setPickViewColer(UIColor.whiteColor())
            ticketRegion.setTintColor(UIColor.whiteColor())
            ticketRegion.tag = 1
            ticketRegion.setToolbarTintColor(UIColor.whiteColor())
            ticketRegion.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            ticketRegion.delegate = self
        }
        
        ticketRegion.show()
    }
    
    func showTicketRowPickerView(){
        if ticketRow == nil {
            ticketRow = ZHPickView(pickviewWithPlistName: "TicketRow", isHaveNavControler: false)
            ticketRow.setPickViewColer(UIColor.whiteColor())
            ticketRow.setPickViewColer(UIColor.whiteColor())
            ticketRow.setTintColor(UIColor.whiteColor())
            ticketRow.tag = 2
            ticketRow.setToolbarTintColor(UIColor.whiteColor())
            ticketRow.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            ticketRow.delegate = self
        }
        
        ticketRow.show()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func mySellConfimView() -> UIView {
        let orderListView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,10))
        orderListView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    func hiderPickerView(tag:NSInteger) {
        for index in 0...2 {
            if index != tag {
                if sellType != nil {
                    sellType.remove()
                }
                if ticketRegion != nil {
                    ticketRegion.remove()
                }
                if ticketRow != nil {
                    ticketRow.remove()
                }
            }
        }
    }
}

extension SellInfoViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.sellInfoViewNumberSection()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return self.mySellConfimView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.sellInfotableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.sellInfoTableViewDidSelect(indexPath)
    }
}

extension SellInfoViewController : UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sellInfoNumberRowSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCell(cell, indexPath: indexPath)
                cell.selectionStyle = .None
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("TicketStatusTableViewCell", forIndexPath: indexPath) as! TicketStatusTableViewCell
            viewModel.tableViewTicketStatusTableViewCell(cell)
            cell.selectionStyle = .None
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("MySellServiceTableViewCell", forIndexPath: indexPath) as! MySellServiceTableViewCell
            viewModel.tableViewMySellServiceTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        }
    }
}

extension SellInfoViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        self.hiderPickerView(pickView.tag)
        if resultString != nil {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: pickView.tag, inSection: 0)) as! GloabTitleAndDetailImageCell
            viewModel.updateGloabTitleAndDetailImageCell(cell, row:pickView.tag, title:resultString)
            if pickView.tag != 2 {
                self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow:pickView.tag + 1, inSection: 0))
            }
        }
    }
}
