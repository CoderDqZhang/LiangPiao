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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItems()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(TicketDescripTableViewCell.self, forCellReuseIdentifier: "TicketDescripTableViewCell")
        tableView.registerClass(TicketNumberTableViewCell.self, forCellReuseIdentifier: "TicketNumberTableViewCell")
        tableView.registerClass(TickerInfoTableViewCell.self, forCellReuseIdentifier: "TickerInfoTableViewCell")
        tableView.registerClass(TicketToolsTableViewCell.self, forCellReuseIdentifier: "TicketToolsTableViewCell")
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        ticketToolsView = UIView(frame: CGRectMake(0,64,SCREENWIDTH,42))
        ticketToolsView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(ticketToolsView)
    }

    
    func setUpNavigationItems() {
        
        self.isShowTicketNavigationBar(false)
        self.setNavigationItemBack()
        let likeItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Like_Normal")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(TicketDescriptionViewController.likeItemPress(_:) as (TicketDescriptionViewController) -> (UIBarButtonItem) -> ()))
        let shareItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Share_Normal")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(TicketDescriptionViewController.shareItemPress(_:)))
        self.navigationItem.rightBarButtonItems = [shareItem,likeItem]

    }
    
    func likeItemPress(sender:UIBarButtonItem) {
        
    }
    
    func shareItemPress(sender:UIBarButtonItem) {
        
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
            if self.view.viewWithTag(300) != nil { self.view.viewWithTag(300)?.removeFromSuperview()}
            if self.view.viewWithTag(100) == nil {
                let ticketPrice = ToolView(frame: CGRectMake(0, frame.origin.y + 42, SCREENWIDTH, SCREENHEIGHT), data: ["220","250","820","900"])
                ticketPrice.tag = 100
                ticketPrice.toolViewSelectIndexPathRow = { indexPath, str in
                    Notification(ToolViewNotifacationName, value: "100")
                    self.view.viewWithTag(100)?.removeFromSuperview()
                    self.isShowTicketNavigationBar(false)
                }
                self.view.addSubview(ticketPrice)
            }else{
                self.view.viewWithTag(100)?.removeFromSuperview()
            }
        case 2:
            if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
            if self.view.viewWithTag(300) != nil { self.view.viewWithTag(300)?.removeFromSuperview()}
            if self.view.viewWithTag(200) == nil {
                let ticketRow = ToolView(frame: CGRectMake(0, frame.origin.y + 42, SCREENWIDTH, SCREENHEIGHT), data: ["1","2","3","4","5"])
                ticketRow.tag = 200
                ticketRow.toolViewSelectIndexPathRow = { indexPath, str in
                    Notification(ToolViewNotifacationName, value: "200")
                    self.view.viewWithTag(200)?.removeFromSuperview()
                    self.isShowTicketNavigationBar(false)
                }
                self.view.addSubview(ticketRow)
            }else{
                self.view.viewWithTag(200)?.removeFromSuperview()
            }
        default:
            if self.view.viewWithTag(100) != nil { self.view.viewWithTag(100)?.removeFromSuperview()}
            if self.view.viewWithTag(200) != nil { self.view.viewWithTag(200)?.removeFromSuperview()}
            if self.view.viewWithTag(300) == nil {
                let sortPrice = ToolView(frame: CGRectMake(0, frame.origin.y + 42, SCREENWIDTH, SCREENHEIGHT), data: ["22","33","44","55","66"])
                sortPrice.toolViewSelectIndexPathRow = { indexPath, str in
                    Notification(ToolViewNotifacationName, value: "300")
                    self.view.viewWithTag(300)?.removeFromSuperview()
                    self.isShowTicketNavigationBar(false)
                }
                sortPrice.tag = 300
                self.view.addSubview(sortPrice)
            }else{
                self.view.viewWithTag(300)?.removeFromSuperview()
            }
        }
    }
    
    func updateTicketViewFrame(tag:NSInteger){
        let rectInTableView = tableView.rectForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0))
        let rect = tableView.convertRect(rectInTableView, toView: tableView.superview)
        if !ticketToolsView.hidden {
            self.view.viewWithTag(tag)?.frame.origin.y = 102
        }else if rect.origin.y > 42 {
            self.view.viewWithTag(tag)?.frame.origin.y = rect.origin.y + 42
        }
        
    }

}

extension TicketDescriptionViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 188
        case 1:
            return 80
        case 2:
            return 42
        default:
            return 60
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(TicketConfirmViewController(), animated: true)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.view.viewWithTag(100) != nil {
            self.updateTicketViewFrame(100)
        }else if self.view.viewWithTag(200) != nil {
            self.updateTicketViewFrame(200)
        }else if self.view.viewWithTag(300) != nil {
            self.updateTicketViewFrame(300)
        }
        
        if scrollView.contentOffset.y > 200 {
            ticketToolsView.hidden = false
            if ticketToolsView.viewWithTag(1000) == nil {
                let ticketView = cell.setUpDescriptionView()
                ticketView.tag = 1000
                ticketToolsView.addSubview(ticketView)
            }
        }else{
            ticketToolsView.hidden = true
        }
    }
}

extension TicketDescriptionViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("TicketNumberTableViewCell", forIndexPath: indexPath) as! TicketNumberTableViewCell
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
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("TickerInfoTableViewCell", forIndexPath: indexPath) as! TickerInfoTableViewCell
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
}

