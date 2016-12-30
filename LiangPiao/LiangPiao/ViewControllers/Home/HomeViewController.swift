//
//  HomeViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SnapKit
import MJRefresh
import ReactiveCocoa

class HomeViewController: BaseViewController {

    var tableView:UITableView!
    
    var cell:HomeSearchTableViewCell!
    var searchTableView:GlobalSearchTableView!
    var searchViewModel = SearchViewModel.shareInstance
    var homeRefreshView = LiangPiaoHomeRefreshHeader(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 88))
    
    var searchNavigationBar = HomeSearchNavigationBar(frame: CGRectMake(0,0,SCREENWIDTH, 64),font:App_Theme_PinFan_L_12_Font)
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        self.setUpTableView()
        self.setSearchNavigatioBarClouse()
        self.setUpMJRefeshView()
        self.view.addSubview(searchNavigationBar)
        searchNavigationBar.hidden = true
        self.bindViewModel()
        self.talKingDataPageName = "首页"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.registerClass(HomeSearchTableViewCell.self, forCellReuseIdentifier: "HomeSearchTableViewCell")
        tableView.registerClass(HomeToolsTableViewCell.self, forCellReuseIdentifier: "HomeToolsTableViewCell")
        tableView.registerClass(HomeScrollerTableViewCell.self, forCellReuseIdentifier: "HomeScrollerTableViewCell")
        tableView.registerClass(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.registerClass(AllTicketTableViewCell.self, forCellReuseIdentifier: "AllTicketTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(-20, 0, 0, 0))
        }
    }
    
    func setUpMJRefeshView(){
        homeRefreshView.hidden = true
        self.view.addSubview(homeRefreshView)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.refreshHomeData()
            self.viewModel.requestHotTicket(self.tableView)
        })
    }
    
    func refreshHomeData(){
        homeRefreshView.hidden = false
        homeRefreshView.startAnimation()
    }
    
    func endRefreshView(){
        homeRefreshView.hidden = true
        homeRefreshView.stopAnimation()
    }
    
    func bindViewModel(){
        viewModel.requestHotTicket(tableView)
        viewModel.controller = self
        searchViewModel.controller = self
        RACSignal.interval(1, onScheduler: RACScheduler.currentScheduler()).subscribeNext { (str) in
            
        }
        let single = searchNavigationBar.searchField
            .rac_textSignal()
            .distinctUntilChanged()
        single.throttle(0.1).subscribeNext { (str) in
            if self.searchTableView != nil {
                self.searchViewModel.requestSearchTicket(str as! String, searchTable: self.searchTableView)
            }
        }
        
        searchViewModel.searchViewModelClouse = { _ in
            self.searchNavigationBar.searchField.hidden = false
            self.view.endEditing(true)
        }
    }
    
    func cancelSearchTable() {
        self.searchNavigationBar.searchField.frame = CGRectMake(20, 27,SCREENWIDTH - 40, 30)
        self.searchNavigationBar.cancelButton.hidden = true
        if #available(iOS 10.0, *) {
            searchNavigationBar.backgroundColor = UIColor.init(displayP3Red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: tableView.contentOffset.y/165)
        } else {
            searchNavigationBar.backgroundColor = UIColor.init(red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: tableView.contentOffset.y/165)
            // Fallback on earlier versions
        }
        if tableView.contentOffset.y > 165 {
            searchNavigationBar.searchField.hidden = false
        }else{
            searchNavigationBar.searchField.hidden = true
        }
        searchNavigationBar.searchField.resignFirstResponder()
        searchTableView.hidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    func setSearchNavigatioBarClouse(){
        searchNavigationBar.searchTextFieldBecomFirstRespoder = { _ in
            self.searchViewModel.searchType = .TicketShowModel
            if self.searchTableView == nil {
                self.searchTableView = GlobalSearchTableView(frame: CGRectMake(0, CGRectGetMaxY(self.searchNavigationBar.frame), SCREENWIDTH, SCREENHEIGHT - CGRectGetMaxY(self.searchNavigationBar.frame)))
                self.view.addSubview(self.searchTableView)
            }else{
                self.searchTableView.hidden = false
            }
            self.tabBarController?.tabBar.hidden = true
        }
        searchNavigationBar.searchNavigationBarCancelClouse = { _ in
            self.cancelSearchTable()
        }
    }
    
    func searchViewController() {
        searchNavigationBar.backgroundColor = UIColor.init(red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: 1)
        searchNavigationBar.hidden = false
        searchNavigationBar.searchField.hidden = false
        searchNavigationBar.searchField.becomeFirstResponder()
    }
    
    func navigationPushTicketPage(index:NSInteger) {
        viewModel.navigationPushTicketPage(index)
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 165 {
            searchNavigationBar.searchField.hidden = false
            searchNavigationBar.hidden = false
            searchNavigationBar.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            if self.searchTableView == nil || self.searchTableView.hidden {
                self.tabBarController?.tabBar.hidden = false
            }else{
                self.tabBarController?.tabBar.hidden = true
            }
        }else{
            if self.searchTableView == nil || self.searchTableView.hidden {
                searchNavigationBar.searchField.hidden = true
                searchNavigationBar.hidden = true
                self.tabBarController?.tabBar.hidden = false
            }else{
                self.tabBarController?.tabBar.hidden = true
            }
        }
        if cell != nil {
            if scrollView.contentOffset.y < 0 {
                cell.cellBackView.frame = CGRectMake(0, scrollView.contentOffset.y, SCREENWIDTH, 255 - scrollView.contentOffset.y)
            }
        }
    }
}

extension HomeViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("HomeSearchTableViewCell", forIndexPath: indexPath) as! HomeSearchTableViewCell
                cell.homeSearchTableViewCellClouse = { _ in
                    self.searchViewController()
                }
                cell.location.rac_signalForControlEvents(.TouchUpInside).subscribeNext({ (action) in
                    MainThreadAlertShow("更多城市正在开拓中...", view: KWINDOWDS())
                })
                cell.selectionStyle = .None
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("HomeToolsTableViewCell", forIndexPath: indexPath) as! HomeToolsTableViewCell
                cell.selectionStyle = .None
                cell.homeToolsClouse = { index in
                    self.navigationPushTicketPage(index)
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("HomeScrollerTableViewCell", forIndexPath: indexPath) as! HomeScrollerTableViewCell
                cell.selectionStyle = .None
                return cell
            }
        default:
            switch indexPath.row {
            case 0:
                let cellIdentifier = "RecommentDetailCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
                }else{
                    for subView in (cell?.contentView.subviews)! {
                        subView.removeFromSuperview()
                    }
                }
                let recommentTitle = UILabel()
                if IPHONE_VERSION >= 9 {
                    recommentTitle.frame = CGRectMake((SCREENWIDTH - 56) / 2, 30, 56, 20)
                }else{
                    recommentTitle.frame = CGRectMake((SCREENWIDTH - 69) / 2, 30, 69, 20)
                }
               
                recommentTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                recommentTitle.font = App_Theme_PinFan_M_14_Font
                recommentTitle.text = "近期尾票"
                cell?.contentView.addSubview(recommentTitle)
                
                let lineLabel = GloabLineView(frame: CGRectMake(CGRectGetMinX(recommentTitle.frame) - 50, 40, 30, 0.5))
                lineLabel.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
                cell?.contentView.addSubview(lineLabel)
                let lineLabel1 = GloabLineView(frame: CGRectMake(CGRectGetMaxX(recommentTitle.frame) + 20, 40, 30, 0.5))
                lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
                cell?.contentView.addSubview(lineLabel1)
                cell!.selectionStyle = .None
                return cell!
            case viewModel.numberOfRowsInSection(indexPath.section) - 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("AllTicketTableViewCell", forIndexPath: indexPath) as! AllTicketTableViewCell
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("RecommendTableViewCell", forIndexPath: indexPath) as! RecommendTableViewCell
                cell.selectionStyle = .None
                viewModel.cellData(cell, indexPath:indexPath)
                return cell
            }
        }
    }
}
