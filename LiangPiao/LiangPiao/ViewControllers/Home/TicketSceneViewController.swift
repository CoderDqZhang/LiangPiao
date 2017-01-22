//
//  TicketSceneViewController.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketSceneViewController: UIViewController {

    var tableView:UITableView!
    let viewModel = TicketSessionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.bindViewModel()
        self.talKingDataPageName = "场次"
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        self.setNavigationItemBack()

        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(TicketSceneTableViewCell.self, forCellReuseIdentifier: "TicketSceneTableViewCell")
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        let navigationBar = GlobalNavigationBarView(frame: CGRectMake(0, 0, SCREENWIDTH - 150, 42), title: viewModel.model.title, detail: viewModel.model.showDate)
        self.navigationItem.titleView = navigationBar
    }

    func bindViewModel(){
        viewModel.controller = self
        viewModel.requestTicketSession(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TicketSceneViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.didSelectRowAtIndexPath(indexPath)
    }
}

extension TicketSceneViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TicketSceneTableViewCell", forIndexPath: indexPath) as! TicketSceneTableViewCell
        cell.selectionStyle = .None
        viewModel.cellForRowAtIndexPath(indexPath, cell: cell)
        return cell
    }
    
}

