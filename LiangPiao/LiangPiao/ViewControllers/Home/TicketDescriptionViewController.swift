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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
    }
    
    func setUpView() {
        if tableView == nil {
            tableView = UITableView(frame: CGRect.zero, style: .plain)
            tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.contentInset.top = 0
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.keyboardDismissMode = .onDrag
            tableView.register(TicketDescripTableViewCell.self, forCellReuseIdentifier: "TicketDescripTableViewCell")
            tableView.register(TickerInfoTableViewCell.self, forCellReuseIdentifier: "TickerInfoTableViewCell")
            tableView.register(TicketToolsTableViewCell.self, forCellReuseIdentifier: "TicketToolsTableViewCell")
//            tableView.registerClass(TicketMapTableViewCell.self, forCellReuseIdentifier: "TicketMapTableViewCell")
            tableView.register(NoneTicketTableViewCell.self, forCellReuseIdentifier: "NoneTicketTableViewCell")
            self.view.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            }
            ticketToolsView = UIView(frame: CGRect(x: 0,y: -2,width: SCREENWIDTH,height: 42))
            ticketToolsView.isHidden = true
            ticketToolsView.backgroundColor = UIColor.white
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
                    image = UIImage.init(named: "Icon_Liked_Normal")?.withRenderingMode(.alwaysOriginal)
                }else{
                    image = UIImage.init(named: "Icon_Like_Normal")?.withRenderingMode(.alwaysOriginal)
                }
            }else{
                image = UIImage.init(named: "Icon_Like_Normal")?.withRenderingMode(.alwaysOriginal)
            }
        }else{
            image = UIImage.init(named: "Icon_Like_Normal")?.withRenderingMode(.alwaysOriginal)
        }
        likeButton = UIButton(type: .custom)
        likeButton.frame = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        likeButton.setImage(image, for: UIControlState())
        likeButton.setImage(UIImage.init(named: "Icon_Like_Press"), for: .selected)
        likeButton.addTarget(self, action: #selector(TicketDescriptionViewController.likeItemPress(_:)), for: .touchUpInside)
        
        let likeItem = UIBarButtonItem.init(customView: likeButton)
        
        let shareItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Share_Normal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(TicketDescriptionViewController.shareItemPress(_:)))
        shareItem.setBackgroundImage(UIImage.init(named: "Icon_Share_Press"), for: .selected, barMetrics: .default)
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    func setUpNavigationItems() {
        self.isShowTicketNavigationBar(false)
        self.setNavigationItemBack()
    }
    
    func likeItemPress(_ sender:UIButton) {
        if UserInfoModel.isLoggedIn() {
            if viewModel.model.show.isFavorite == nil {
                viewModel.model.show.isFavorite = false
            }
            if viewModel.model.show.isFavorite == true {
                viewModel.requestDeleteCollectTicket()
                viewModel.model.show.isFavorite = false
                likeButton.setImage(UIImage.init(named: "Icon_Like_Normal")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
            }else{
                viewModel.requestCollectTicket()
                viewModel.model.show.isFavorite = true
                likeButton.setImage(UIImage.init(named: "Icon_Liked_Normal")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
            }
        }else{
            NavigationPushView(self, toConroller: LoginViewController())
        }
    }
    
    func shareItemPress(_ sender:UIBarButtonItem) {
        var url = ""
        if viewModel.ticketModel.session != nil {
            url = "\(ShareUrl)\((viewModel.ticketModel.id)!)/session/\((viewModel.ticketModel.session.id)!)"
        }else if viewModel.ticketModel.session != nil {
            url = "\(ShareUrl)\((viewModel.ticketModel.id)!)/session/\((viewModel.ticketModel.session.id)!)"
        }
        KWINDOWDS().addSubview(GloableShareView.init(title: "推荐给好友", model: self.viewModel.ticketModel, image: nil, url: url))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isShowTicketNavigationBar(_ isShowTicket:Bool) {
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

extension TicketDescriptionViewController : UITableViewDelegate {
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
        
        if scrollView.contentOffset.y > viewModel.tableViewHeight(0) + viewModel.tableViewHeight(1) + viewModel.tableViewHeight(2) {
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

extension TicketDescriptionViewController : UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketDescripTableViewCell", for: indexPath) as! TicketDescripTableViewCell
            viewModel.configCellTicketDescripTableViewCell(cell)
            cell.setHiddenLine(true)
            cell.selectionStyle = .none
            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCellWithIdentifier("TicketMapTableViewCell", forIndexPath: indexPath) as! TicketMapTableViewCell
//            viewModel.configTicketMapTableViewCell(cell, indexPath:indexPath)
//            cell.selectionStyle = .None
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCellWithIdentifier("TicketNumberTableViewCell", forIndexPath: indexPath) as! TicketNumberTableViewCell
//            viewModel.configCellTicketNumberTableViewCell(cell)
//            cell.selectionStyle = .None
//            return cell
        
        case 1:
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
            if viewModel.model.ticketList.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoneTicketTableViewCell", for: indexPath) as! NoneTicketTableViewCell
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TickerInfoTableViewCell", for: indexPath) as! TickerInfoTableViewCell
                viewModel.configCellTickerInfoTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
        
    }
    
}

