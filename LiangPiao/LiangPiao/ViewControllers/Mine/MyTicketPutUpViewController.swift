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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(PickUpTickeTableViewCell.self, forCellReuseIdentifier: "PickUpTickeTableViewCell")
        tableView.register(PicketUpSessionTableViewCell.self, forCellReuseIdentifier: "PicketUpSessionTableViewCell")
        tableView.register(TiketPickeUpInfoTableViewCell.self, forCellReuseIdentifier: "TiketPickeUpInfoTableViewCell")
        tableView.register(TicketToolsTableViewCell.self, forCellReuseIdentifier: "TicketToolsTableViewCell")
        tableView.register(TicketMapTableViewCell.self, forCellReuseIdentifier: "TicketMapTableViewCell")
        tableView.register(NoneTicketTableViewCell.self, forCellReuseIdentifier: "NoneTicketTableViewCell")
        self.view.addSubview(tableView)
        
        ticketToolsView = UIView(frame: CGRect(x: 0,y: -2,width: SCREENWIDTH,height: 42))
        ticketToolsView.isHidden = true
        ticketToolsView.backgroundColor = UIColor.white
        self.view.addSubview(ticketToolsView)
        
        bottomView = GloableBottomButtonView(frame: nil, title: "继续挂票", tag: 1) { (tag) in
            if self.viewModel.isSellTicketVC {
                self.popSellTicketVC()
            }else{
                let ret = self.viewModel.tempList.count == 0 ? true : false
                self.viewModel.continuePutUpTicket(nil, isNoneTicket: ret)
            }
        }
        self.view.addSubview(bottomView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-bottomView.frame.size.height)
        }
    }
    
    func popSellTicketVC(){
        for controller in (self.navigationController?.viewControllers)! {
            if controller is MySellConfimViewController {
                self.navigationController?.popToViewController(controller, animated: true)
                return
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func bindeViewModel(){
        viewModel.controller = self
        if viewModel.ticketShowModel.sessionCount != 1 {
            viewModel.requestTicketSession()
        }else{
            viewModel.oneSession()
            self.tableView.reloadData()
        }
    }
    
    func setUpNavigationItems() {
        
        self.isShowTicketNavigationBar(false)
        self.setNavigationItemBack()
        
    }
    
    func shareItemPress(_ sender:UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isShowTicketNavigationBar(_ isShowTicket:Bool) {
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
    func ticketToolsViewShow(_ tag:NSInteger, frame:CGRect) {
        self.isShowTicketNavigationBar(true)
        switch tag {
        case 1:
            if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
            if self.view.viewWithTag(100) == nil {
                let ticketPrice = ToolView(frame: CGRect(x: 0, y: frame.origin.y + 42, width: SCREENWIDTH, height: SCREENHEIGHT), data: viewModel.ticketPriceArray)
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
                let ticketRow = ToolView(frame: CGRect(x: 0, y: frame.origin.y + 42, width: SCREENWIDTH, height: SCREENHEIGHT), data: viewModel.ticketRowArray)
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
    
    func ticketToolsViewSortPrice(_ type:TicketSortType){
        if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
        if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
        viewModel.sortTicket(type)
    }
    
    func hiderTicketToolsView(){
        if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
        if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
    }
    
    func updateTicketViewFrame(_ tag:NSInteger){
        let rectInTableView = tableView.rectForRow(at: IndexPath.init(row: 3, section: 0))
        let rect = tableView.convert(rectInTableView, to: tableView.superview)
        if !ticketToolsView.isHidden {
            self.view.viewWithTag(tag)?.frame.origin.y = 42
        }else if rect.origin.y > 0 {
            self.view.viewWithTag(tag)?.frame.origin.y = rect.origin.y + 42
        }
        
    }
    
}

extension MyTicketPutUpViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeight(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.view.viewWithTag(100) != nil {
            self.updateTicketViewFrame(100)
        }else if self.view.viewWithTag(200) != nil {
            self.updateTicketViewFrame(200)
        }
        
        if scrollView.contentOffset.y > viewModel.tableViewHeight(0) + viewModel.tableViewHeight(1) {
            ticketToolsView.isHidden = false
            if ticketToolsView.viewWithTag(1000) == nil {
                let ticketView = cell.setUpDescriptionView()
                ticketView.tag = 1000
                ticketToolsView.addSubview(ticketView)
                let lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 1, width: SCREENWIDTH - 30, height: 0.5))
                ticketToolsView.addSubview(lineLabel)
            }
        }else{
            ticketToolsView.isHidden = true
        }
    }
}

extension MyTicketPutUpViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewnumberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickUpTickeTableViewCell", for: indexPath) as! PickUpTickeTableViewCell
            viewModel.tableViewCellPickUpTickeTableViewCell(cell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicketUpSessionTableViewCell", for: indexPath) as! PicketUpSessionTableViewCell
            viewModel.tableViewCellPicketUpSessionTableViewCell(cell)
            cell.selectionStyle = .none
            return cell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "TicketToolsTableViewCell", for: indexPath) as! TicketToolsTableViewCell
            cell.selectionStyle = .none
            cell.ticketCellClouse = { tag in
                let rectInTableView = tableView.rectForRow(at: indexPath)
                let rect = tableView.convert(rectInTableView, to: tableView.superview)
                if !self.ticketToolsView.isHidden {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TiketPickeUpInfoTableViewCell", for: indexPath) as! TiketPickeUpInfoTableViewCell
            viewModel.tableViewCellTickerInfoTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
}

