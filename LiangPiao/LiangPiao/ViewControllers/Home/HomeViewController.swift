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
import ReactiveSwift
import ReactiveCocoa

class HomeViewController: BaseViewController {

    var tableView:UITableView!
    
    var cell:HomeSearchTableViewCell!
    var searchTableView:GlobalSearchTableView!
    var searchViewModel = SearchViewModel.shareInstance
    var homeRefreshView = LiangPiaoHomeRefreshHeader(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 88))
    
    var searchNavigationBar = HomeSearchNavigationBar(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH, height: IPHONEX ? 88 : 64),font:App_Theme_PinFan_L_12_Font)
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        self.setUpTableView()
        self.setSearchNavigatioBarClouse()
        self.setUpMJRefeshView()
        self.view.addSubview(searchNavigationBar)
        searchNavigationBar.isHidden = true
        self.bindViewModel()
        self.talKingDataPageName = "首页"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.register(HomeSearchTableViewCell.self, forCellReuseIdentifier: "HomeSearchTableViewCell")
        tableView.register(HomeToolsTableViewCell.self, forCellReuseIdentifier: "HomeToolsTableViewCell")
        tableView.register(HomeScrollerTableViewCell.self, forCellReuseIdentifier: "HomeScrollerTableViewCell")
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.register(AllTicketTableViewCell.self, forCellReuseIdentifier: "AllTicketTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(IPHONEX ? -50 : -30, 0, 0, 0))
        }
    }
    
    func setUpMJRefeshView(){
        homeRefreshView.isHidden = true
        self.view.addSubview(homeRefreshView)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.refreshHomeData()
            self.viewModel.requestHotTicket(self.tableView)
        })
    }
    
    func refreshHomeData(){
        homeRefreshView.isHidden = false
        homeRefreshView.startAnimation()
    }
    
    func endRefreshView(){
        homeRefreshView.isHidden = true
        homeRefreshView.stopAnimation()
    }
    
    func bindViewModel(){
        viewModel.controller = self
        searchViewModel.controller = self
        viewModel.requestHotTicket(tableView)
        viewModel.requestBanner()
        
        searchNavigationBar.searchField.reactive.continuousTextValues.observeValues { (value) in
            if self.searchTableView != nil {
                self.searchViewModel.requestSearchTicket(value!, searchTable: self.searchTableView)
            }
        }
        
        let result = searchNavigationBar.searchField.reactive.producer(forKeyPath: "text")
        result.start { (value) in
            if self.searchTableView != nil {
                self.searchViewModel.requestSearchTicket(value.value as! String, searchTable: self.searchTableView)
            }
        }
        //取消按钮
        searchViewModel.searchViewModelClouse = { _ in
            self.searchNavigationBar.searchField.isHidden = false
            self.view.endEditing(true)
        }
        //搜索历史
        searchViewModel.searchViewShowHistoryModelClouse = { str in
            self.searchNavigationBar.searchField.text = str
        }
    }
    
    func cancelSearchTable() {
        self.searchNavigationBar.searchField.frame = CGRect(x: 20, y: IPHONEX ? 47 : 27,width: SCREENWIDTH - 40, height: 30)
        self.searchNavigationBar.cancelButton.isHidden = true
//        if #available(iOS 10.0, *) {
//            searchNavigationBar.backgroundColor = UIColor.init(displayP3Red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: 1)
//        } else {
//            searchNavigationBar.backgroundColor = UIColor.init(red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: 1)
//            // Fallback on earlier versions
//        }
        if tableView.contentOffset.y > 165 {
            searchNavigationBar.searchField.isHidden = false
        }else{
            searchNavigationBar.searchField.isHidden = true
        }
        searchNavigationBar.searchField.text = ""
        searchNavigationBar.searchField.resignFirstResponder()
        searchTableView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setSearchNavigatioBarClouse(){
        searchNavigationBar.searchTextFieldBecomFirstRespoder = { _ in
            if self.searchTableView == nil {
                self.searchTableView = GlobalSearchTableView(frame: CGRect(x: 0, y: self.searchNavigationBar.frame.maxY, width: SCREENWIDTH, height: SCREENHEIGHT - self.searchNavigationBar.frame.maxY))
                self.view.addSubview(self.searchTableView)
            }else{
                self.searchTableView.isHidden = false
            }
            self.tabBarController?.tabBar.isHidden = true
        }
        searchNavigationBar.searchNavigationBarCancelClouse = { _ in
            self.cancelSearchTable()
        }
    }
    
    func searchViewController() {
        searchNavigationBar.backgroundColor = UIColor.init(red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: 1)
        searchNavigationBar.isHidden = false
        searchNavigationBar.searchField.isHidden = false
        searchNavigationBar.searchField.becomeFirstResponder()
    }
    
    func navigationPushTicketPage(_ index:NSInteger) {
        viewModel.navigationPushTicketPage(index)
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 165 {
            searchNavigationBar.searchField.isHidden = false
            searchNavigationBar.isHidden = false
            searchNavigationBar.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            if self.searchTableView == nil || self.searchTableView.isHidden {
                self.tabBarController?.tabBar.isHidden = false
            }else{
                self.tabBarController?.tabBar.isHidden = true
            }
        }else{
            if self.searchTableView == nil || self.searchTableView.isHidden {
                searchNavigationBar.searchField.isHidden = true
                searchNavigationBar.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
            }else{
                self.tabBarController?.tabBar.isHidden = true
            }
        }
        if cell != nil {
            if scrollView.contentOffset.y < 0 {
                cell.cellBackView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: SCREENWIDTH, height: 255 - scrollView.contentOffset.y)
            }
        }
    }
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchTableViewCell", for: indexPath) as! HomeSearchTableViewCell
                cell.location.setTitle(viewModel.locationStr, for: UIControlState())
                cell.homeSearchTableViewCellClouse = { _ in
                    self.searchViewModel.searchType = .ticketShowHistory
                    if self.searchTableView != nil {
                        self.searchTableView.bindViewModel()
                    }
                    self.searchViewController()
                }
                
                cell.location.reactive.controlEvents(.touchUpInside).observe({ (action) in
                    _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "更多城市正在开拓中...", autoHidder: true)
//                    self.viewModel.showLocationData()
                })
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeToolsTableViewCell", for: indexPath) as! HomeToolsTableViewCell
                cell.selectionStyle = .none
                cell.homeToolsClouse = { index in
                    self.navigationPushTicketPage(index)
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScrollerTableViewCell", for: indexPath) as! HomeScrollerTableViewCell
                viewModel.tableViewHomeScrollerTableViewCell(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        default:
            switch indexPath.row {
            case 0:
                let cellIdentifier = "RecommentDetailCell"
                var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                }else{
                    for subView in (cell?.contentView.subviews)! {
                        subView.removeFromSuperview()
                    }
                }
                let recommentTitle = UILabel()
                if IPHONE_VERSION >= 9 {
                    recommentTitle.frame = CGRect(x: (SCREENWIDTH - 56) / 2, y: 30, width: 56, height: 20)
                }else{
                    recommentTitle.frame = CGRect(x: (SCREENWIDTH - 69) / 2, y: 30, width: 69, height: 20)
                }
               
                recommentTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                recommentTitle.font = App_Theme_PinFan_M_14_Font
                recommentTitle.text = "近期热门"
                cell?.contentView.addSubview(recommentTitle)
                
                let lineLabel = GloabLineView(frame: CGRect(x: recommentTitle.frame.minX - 50, y: 40, width: 30, height: 0.5))
                lineLabel.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
                cell?.contentView.addSubview(lineLabel)
                let lineLabel1 = GloabLineView(frame: CGRect(x: recommentTitle.frame.maxX + 20, y: 40, width: 30, height: 0.5))
                lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
                cell?.contentView.addSubview(lineLabel1)
                cell!.selectionStyle = .none
                return cell!
            case viewModel.numberOfRowsInSection(indexPath.section) - 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AllTicketTableViewCell", for: indexPath) as! AllTicketTableViewCell
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as! RecommendTableViewCell
                cell.selectionStyle = .none
                viewModel.cellData(cell, indexPath:indexPath)
                return cell
            }
        }
    }
}
