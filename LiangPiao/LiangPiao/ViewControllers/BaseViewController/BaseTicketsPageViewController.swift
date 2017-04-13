//
//  BaseTicketsPageViewController.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class BaseTicketsPageViewController: UIViewController {

    var tableView:UITableView!
    var isLoadData:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavigationItem() {
        self.setNavigationItemBack()
//        let filtterItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Filter_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.filterPress(_:)))
        let searchItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Search_Normal")?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(TicketPageViewController.searchPress(_:)))
        self.navigationItem.rightBarButtonItems = [searchItem]
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.setUpRefreshView()
    }
    
    func setUpRefreshView(){
        self.tableView.mj_header = LiangNomalRefreshHeaderWhite(refreshingBlock: {
            TicketCategoryViewModel.sharedInstance.refreshDataView(self)
        })
    }
    
    func setUpLoadMoreData(){
        self.tableView.mj_footer = LiangPiaoLoadMoreDataFooterWhite(refreshingBlock: {
            TicketCategoryViewModel.sharedInstance.requestCategotyData(1000, controller: self)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(TicketCategoryViewModel.sharedInstance.selectIdex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(TicketCategoryViewModel.sharedInstance.selectIdex)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseTicketsPageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TicketCategoryViewModel.sharedInstance.tableViewDidSelectRowAtIndexPath(indexPath, controller: self)
    }
}

extension BaseTicketsPageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TicketCategoryViewModel.sharedInstance.numberOfRowsInSection()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as! RecommendTableViewCell
        TicketCategoryViewModel.sharedInstance.tableViewCellForRowAtIndexPath(cell, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
}

