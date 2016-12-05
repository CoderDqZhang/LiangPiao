//
//  MySellManagerViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellManagerViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:MySellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        self.setUpNavigationItem()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
    }
    
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(OrderManagerTableViewCell.self, forCellReuseIdentifier: "OrderManagerTableViewCell")
        tableView.registerClass(MySellManagerMuchTableViewCell.self, forCellReuseIdentifier: "MySellManagerMuchTableViewCell")
        tableView.registerClass(MySellAttentionTableViewCell.self, forCellReuseIdentifier: "MySellAttentionTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        
        self.bindViewModel()
        
    }
    
    func bindViewModel(){
        //        viewModel.reloadTableView = { _ in
        //            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
        //        }
        
    }
    
    func mySellOrderManagerListView() -> UIView {
        let orderListView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,10))
        orderListView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MySellManagerViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.mySellOrderManagerTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

extension MySellManagerViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.mySellOrderManagerNumberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mySellOrderManagerNumbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.mySellOrderManagerListView()
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.mySellOrderManagerTableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderManagerTableViewCell", forIndexPath: indexPath) as! OrderManagerTableViewCell
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("MySellManagerMuchTableViewCell", forIndexPath: indexPath) as! MySellManagerMuchTableViewCell
            cell.selectionStyle = .None
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("MySellAttentionTableViewCell", forIndexPath: indexPath) as! MySellAttentionTableViewCell
            cell.selectionStyle = .None
            return cell
        }
    }
    
}
