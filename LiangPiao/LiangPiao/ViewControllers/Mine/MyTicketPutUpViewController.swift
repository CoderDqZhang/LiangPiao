//
//  MyTicketPutUpViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit



class MyTicketPutUpViewController: UIViewController {

    var tableView:UITableView!
    var ticketToolsView:UIView!
    var cell:TicketToolsTableViewCell!
    var viewModel = MyTicketPutUpViewModel()
    var bottomView:GloableBottomButtonView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItems()
        self.talKingDataPageName = "我的挂票"
        self.setUpView()
        self.bindeViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.enabled = true
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(PickUpTickeTableViewCell.self, forCellReuseIdentifier: "PickUpTickeTableViewCell")
        tableView.registerClass(PicketUpSessionTableViewCell.self, forCellReuseIdentifier: "PicketUpSessionTableViewCell")
        tableView.registerClass(TiketPickeUpInfoTableViewCell.self, forCellReuseIdentifier: "TiketPickeUpInfoTableViewCell")
        tableView.registerClass(TicketToolsTableViewCell.self, forCellReuseIdentifier: "TicketToolsTableViewCell")
        tableView.registerClass(TicketMapTableViewCell.self, forCellReuseIdentifier: "TicketMapTableViewCell")
        tableView.registerClass(NoneTicketTableViewCell.self, forCellReuseIdentifier: "NoneTicketTableViewCell")
        self.view.addSubview(tableView)
        
        ticketToolsView = UIView(frame: CGRectMake(0,-2,SCREENWIDTH,42))
        ticketToolsView.hidden = true
        ticketToolsView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(ticketToolsView)
        
        bottomView = GloableBottomButtonView(frame: nil, title: "继续挂票", tag: 1) { (tag) in
            print("点击方法")
        }
        self.view.addSubview(bottomView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-bottomView.frame.size.height)
        }
    }
    
    func bindeViewModel(){
        viewModel.controller = self
        if viewModel.sellManagerModel.sessionCount != 1 {
            viewModel.requestTicketSession()
        }else{
            self.tableView.reloadData()
        }
    }
    
    func setUpNavigationItems() {
        
        self.isShowTicketNavigationBar(false)
        self.setNavigationItemBack()
        
    }
    
    func shareItemPress(sender:UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isShowTicketNavigationBar(isShowTicket:Bool) {
        self.navigationItem.title = "我的挂票"
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func ticketToolsViewShow(tag:NSInteger, frame:CGRect) {
        self.isShowTicketNavigationBar(true)
        switch tag {
        case 1:
            if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
            if self.view.viewWithTag(100) == nil {
                let ticketPrice = ToolView(frame: CGRectMake(0, frame.origin.y + 42, SCREENWIDTH, SCREENHEIGHT), data: viewModel.ticketPriceArray)
                ticketPrice.tag = 100
                ticketPrice.toolViewSelectIndexPathRow = { indexPath, str in
                    self.view.viewWithTag(100)?.removeFromSuperview()
                    if indexPath.row != 0 {
                        Notification(ToolViewNotifacationName, value: "100")
                        self.isShowTicketNavigationBar(false)
                        self.viewModel.sortTickeByOriginTicketPrice(str as? String)
                    }else{
                        Notification(ToolViewNotifacationName, value: "100")
                        self.isShowTicketNavigationBar(false)
                        self.viewModel.sortTickeByOriginTicketPrice("0")
                    }
                }
                self.view.addSubview(ticketPrice)
            }else{
                self.view.viewWithTag(100)?.removeFromSuperview()
            }
        case 2:
            if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
            if self.view.viewWithTag(200) == nil {
                let ticketRow = ToolView(frame: CGRectMake(0, frame.origin.y + 42, SCREENWIDTH, SCREENHEIGHT), data: viewModel.ticketRowArray)
                ticketRow.tag = 200
                ticketRow.toolViewSelectIndexPathRow = { indexPath, str in
                    self.view.viewWithTag(200)?.removeFromSuperview()
                    if indexPath.row != 0 {
                        Notification(ToolViewNotifacationName, value: "200")
                        self.isShowTicketNavigationBar(false)
                        self.viewModel.sortTickeByRowTicketPrice(str as? String)
                    }else{
                        Notification(ToolViewNotifacationName, value: "200")
                        self.isShowTicketNavigationBar(false)
                        self.viewModel.sortTickeByOriginTicketPrice("0")
                    }
                }
                self.view.addSubview(ticketRow)
            }else{
                self.view.viewWithTag(200)?.removeFromSuperview()
            }
        default:
            break
        }
    }
    
    func ticketToolsViewSortPrice(type:TicketSortType){
        if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
        if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
        viewModel.sortTicket(type)
    }
    
    func hiderTicketToolsView(){
        if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
        if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
    }
    
    func updateTicketViewFrame(tag:NSInteger){
        let rectInTableView = tableView.rectForRowAtIndexPath(NSIndexPath.init(forRow: 3, inSection: 0))
        let rect = tableView.convertRect(rectInTableView, toView: tableView.superview)
        if !ticketToolsView.hidden {
            self.view.viewWithTag(tag)?.frame.origin.y = 42
        }else if rect.origin.y > 0 {
            self.view.viewWithTag(tag)?.frame.origin.y = rect.origin.y + 42
        }
        
    }
    
}

extension MyTicketPutUpViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeight(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.view.viewWithTag(100) != nil {
            self.updateTicketViewFrame(100)
        }else if self.view.viewWithTag(200) != nil {
            self.updateTicketViewFrame(200)
        }
        
        if scrollView.contentOffset.y > viewModel.tableViewHeight(0) + viewModel.tableViewHeight(1) {
            ticketToolsView.hidden = false
            if ticketToolsView.viewWithTag(1000) == nil {
                let ticketView = cell.setUpDescriptionView()
                ticketView.tag = 1000
                ticketToolsView.addSubview(ticketView)
                let lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 1, width: SCREENWIDTH - 30, height: 0.5))
                ticketToolsView.addSubview(lineLabel)
            }
        }else{
            ticketToolsView.hidden = true
        }
    }
}

extension MyTicketPutUpViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewnumberOfRowsInSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("PickUpTickeTableViewCell", forIndexPath: indexPath) as! PickUpTickeTableViewCell
            viewModel.tableViewCellPickUpTickeTableViewCell(cell)
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("PicketUpSessionTableViewCell", forIndexPath: indexPath) as! PicketUpSessionTableViewCell
            viewModel.tableViewCellPicketUpSessionTableViewCell(cell)
            cell.selectionStyle = .None
            return cell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("TicketToolsTableViewCell", forIndexPath: indexPath) as! TicketToolsTableViewCell
            cell.selectionStyle = .None
            cell.ticketCellClouse = { tag in
                let rectInTableView = tableView.rectForRowAtIndexPath(indexPath)
                let rect = tableView.convertRect(rectInTableView, toView: tableView.superview)
                if !self.ticketToolsView.hidden {
                    self.ticketToolsViewShow(tag, frame: self.ticketToolsView.frame)
                }else{
                    self.ticketToolsViewShow(tag, frame: rect)
                }
            }
            cell.ticketCellSortClouse = { tag,type in
                self.ticketToolsViewSortPrice(type)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("TiketPickeUpInfoTableViewCell", forIndexPath: indexPath) as! TiketPickeUpInfoTableViewCell
            viewModel.tableViewCellTickerInfoTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
}

