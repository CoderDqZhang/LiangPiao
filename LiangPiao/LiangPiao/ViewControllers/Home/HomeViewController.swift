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

class HomeViewController: BaseViewController {

    var tableView:UITableView!
    
    var cell:HomeSearchTableViewCell!
    
    var searchNavigationBar = HomeSearchNavigationBar(frame: CGRectMake(0,0,SCREENWIDTH, 64),font:Home_Navigation_Search_Font)
    override func viewDidLoad() {
        self.setUpTableView()
        
        self.view.addSubview(searchNavigationBar)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.registerClass(HomeSearchTableViewCell.self, forCellReuseIdentifier: "HomeSearchTableViewCell")
        tableView.registerClass(HomeToolsTableViewCell.self, forCellReuseIdentifier: "HomeToolsTableViewCell")
        tableView.registerClass(HomeScrollerTableViewCell.self, forCellReuseIdentifier: "HomeScrollerTableViewCell")
        tableView.registerClass(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(-20)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
    }
    
    func navigationPushTicketPage(index:NSInteger) {
        switch index {
        case 0:
//            let ticketPage = BaseTicketsPageViewController()
            let ticketPage = AddressViewController()
            ticketPage.title = "演唱会"
            ticketPage.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ticketPage, animated: true)
        case 1:
            let ticketPage = OrderDetailViewController()
            ticketPage.title = "订单详情"
            ticketPage.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ticketPage, animated: true)
        default:
            let ticketPage = TicketPageViewController()
            ticketPage.progressHeight = 0
            ticketPage.progressWidth = 0
            ticketPage.adjustStatusBarHeight = true
            ticketPage.progressColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
            ticketPage.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ticketPage, animated: true)
        }
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    return 255
                case 1:
                    return 100
                default:
                    return 152
            }
        default:
            switch indexPath.row {
                case 0:
                    return 57
                default:
                    return 140
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            break;
        default:
            if indexPath.row != 0 {
                self.navigationController?.pushViewController(TicketSceneViewController(), animated: true)
            }
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if #available(iOS 10.0, *) {
            searchNavigationBar.backgroundColor = UIColor.init(displayP3Red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: scrollView.contentOffset.y/165)
        } else {
            searchNavigationBar.backgroundColor = UIColor.init(red: 75.0/255.0, green: 212.0/255.0, blue: 197.0/255.0, alpha: scrollView.contentOffset.y/165)
            // Fallback on earlier versions
        }
        if scrollView.contentOffset.y > 165 {
            searchNavigationBar.searchField.hidden = false
        }else{
            searchNavigationBar.searchField.hidden = true
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
        switch section {
        case 0:
            return 2
        default:
            return 10
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 0.0001
        default:
            return 10
        }
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
               
                recommentTitle.textColor = UIColor.init(hexString: Home_Recommend_RecommentTitle_Color)
                recommentTitle.font = Home_Recommend_RecommentTitle_Font
                recommentTitle.text = "热门推荐"
                cell?.contentView.addSubview(recommentTitle)
                
                let lineLabel = GloabLineView(frame: CGRectMake(CGRectGetMinX(recommentTitle.frame) - 50, 40, 30, 0.5))
                lineLabel.setLineColor(UIColor.init(hexString: Custom_Line_Color))
                cell?.contentView.addSubview(lineLabel)
                let lineLabel1 = GloabLineView(frame: CGRectMake(CGRectGetMaxX(recommentTitle.frame) + 20, 40, 30, 0.5))
                lineLabel1.setLineColor(UIColor.init(hexString: Custom_Line_Color))
                cell?.contentView.addSubview(lineLabel1)
                cell!.selectionStyle = .None
                return cell!
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("RecommendTableViewCell", forIndexPath: indexPath) as! RecommendTableViewCell
                cell.selectionStyle = .None
                return cell
            }
        }
        
        
    }
    
}
