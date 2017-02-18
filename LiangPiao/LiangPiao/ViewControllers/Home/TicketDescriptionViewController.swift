//
//  TicketDescriptionViewController.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketDescriptionViewController: UIViewController {

    var tableView:UITableView!
    var navigationBar:GlobalNavigationBarView!
    var ticketToolsView:UIView!
    var cell:TicketToolsTableViewCell!
    var session:ShowSessionModel!
    let  viewModel = TicketDescriptionViewModel()
    
    var likeButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItems()
        self.talKingDataPageName = "演出详情"
        self.bindeViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.enabled = true
    }
    
    func setUpView() {
        if tableView == nil {
            tableView = UITableView(frame: CGRectZero, style: .Plain)
            tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .None
            tableView.keyboardDismissMode = .OnDrag
            tableView.registerClass(TicketDescripTableViewCell.self, forCellReuseIdentifier: "TicketDescripTableViewCell")
            tableView.registerClass(TicketNumberTableViewCell.self, forCellReuseIdentifier: "TicketNumberTableViewCell")
            tableView.registerClass(TickerInfoTableViewCell.self, forCellReuseIdentifier: "TickerInfoTableViewCell")
            tableView.registerClass(TicketToolsTableViewCell.self, forCellReuseIdentifier: "TicketToolsTableViewCell")
            tableView.registerClass(TicketMapTableViewCell.self, forCellReuseIdentifier: "TicketMapTableViewCell")
            tableView.registerClass(NoneTicketTableViewCell.self, forCellReuseIdentifier: "NoneTicketTableViewCell")
            self.view.addSubview(tableView)
            
            tableView.snp_makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            }
            ticketToolsView = UIView(frame: CGRectMake(0,-2,SCREENWIDTH,42))
            ticketToolsView.hidden = true
            ticketToolsView.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(ticketToolsView)
        }
    }

    func bindeViewModel(){
        viewModel.controller = self
        viewModel.requestTicketSession()
    }
    
    func updataLikeImage(){
        var image:UIImage!
        if viewModel.model != nil && UserInfoModel.isLoggedIn() {
            if viewModel.model.show.isFavorite != nil{
                if viewModel.model.show.isFavorite == true {
                    image = UIImage.init(named: "Icon_Liked_Normal")?.imageWithRenderingMode(.AlwaysOriginal)
                }else{
                    image = UIImage.init(named: "Icon_Like_Normal")?.imageWithRenderingMode(.AlwaysOriginal)
                }
            }else{
                image = UIImage.init(named: "Icon_Like_Normal")?.imageWithRenderingMode(.AlwaysOriginal)
            }
        }else{
            image = UIImage.init(named: "Icon_Like_Normal")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        likeButton = UIButton(type: .Custom)
        likeButton.frame = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        likeButton.setImage(image, forState: .Normal)
        likeButton.setImage(UIImage.init(named: "Icon_Like_Press"), forState: .Selected)
        likeButton.addTarget(self, action: #selector(TicketDescriptionViewController.likeItemPress(_:)), forControlEvents: .TouchUpInside)
        
        let likeItem = UIBarButtonItem.init(customView: likeButton)
        
        let shareItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Share_Normal")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(TicketDescriptionViewController.shareItemPress(_:)))
        shareItem.setBackgroundImage(UIImage.init(named: "Icon_Share_Press"), forState: .Selected, barMetrics: .Default)
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    func setUpNavigationItems() {
        self.isShowTicketNavigationBar(false)
        self.setNavigationItemBack()
    }
    
    func likeItemPress(sender:UIButton) {
        if UserInfoModel.isLoggedIn() {
            if viewModel.model.show.isFavorite == nil {
                viewModel.model.show.isFavorite = false
            }
            if viewModel.model.show.isFavorite == true {
                viewModel.requestDeleteCollectTicket()
                viewModel.model.show.isFavorite = false
                likeButton.setImage(UIImage.init(named: "Icon_Like_Normal")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
            }else{
                viewModel.requestCollectTicket()
                viewModel.model.show.isFavorite = true
                likeButton.setImage(UIImage.init(named: "Icon_Liked_Normal")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
            }
        }else{
            NavigationPushView(self, toConroller: LoginViewController())
        }
    }
    
    func shareItemPress(sender:UIBarButtonItem) {
        var url = ""
        if viewModel.ticketModel.session != nil {
            url = "\(ShareUrl)\(viewModel.ticketModel.id)/session/\(viewModel.ticketModel.session.id)"
        }else if viewModel.ticketModel.session != nil {
            url = "\(ShareUrl)\(viewModel.ticketModel.id)/session/\(viewModel.ticketModel.session.id)"
        }
        KWINDOWDS().addSubview(GloableShareView.init(title: "推荐给好友", model: self.viewModel.ticketModel, image: nil, url: url))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isShowTicketNavigationBar(isShowTicket:Bool) {
//        if !isShowTicket {
//            navigationBar = GlobalNavigationBarView(frame: CGRectMake(0, 0, SCREENWIDTH - 150, 42), title: "万有音乐系 陈粒《小梦大半》2016巡.", detail: "2016.11.12 20:00")
//            self.navigationItem.titleView = navigationBar
//        }else{
//            if navigationBar != nil {
//                navigationBar.hidden  = true
//                navigationBar.removeFromSuperview()
//            }
//            self.navigationItem.titleView =  GlobalNavigationBarView(frame: CGRectMake(0, 0, SCREENWIDTH - 150, 42), title: "《小梦大半》2016巡.", detail: "2016.11.12 20:00")
//        }
        self.navigationItem.title = "立即购票"
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

extension TicketDescriptionViewController : UITableViewDelegate {
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
        
        if scrollView.contentOffset.y > viewModel.tableViewHeight(0) + viewModel.tableViewHeight(1) + viewModel.tableViewHeight(2) {
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

extension TicketDescriptionViewController : UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCellWithIdentifier("TicketDescripTableViewCell", forIndexPath: indexPath) as! TicketDescripTableViewCell
            viewModel.configCellTicketDescripTableViewCell(cell)
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("TicketMapTableViewCell", forIndexPath: indexPath) as! TicketMapTableViewCell
            viewModel.configTicketMapTableViewCell(cell, indexPath:indexPath)
            cell.selectionStyle = .None
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("TicketNumberTableViewCell", forIndexPath: indexPath) as! TicketNumberTableViewCell
            viewModel.configCellTicketNumberTableViewCell(cell)
            cell.selectionStyle = .None
            return cell
        
        case 3:
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
            if viewModel.model.ticketList.count == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NoneTicketTableViewCell", forIndexPath: indexPath) as! NoneTicketTableViewCell
                cell.selectionStyle = .None
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("TickerInfoTableViewCell", forIndexPath: indexPath) as! TickerInfoTableViewCell
                viewModel.configCellTickerInfoTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .None
                return cell
            }
        }
        
    }
    
}

