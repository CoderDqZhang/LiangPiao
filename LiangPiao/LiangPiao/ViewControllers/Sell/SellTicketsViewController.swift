//
//  BuyTicketsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class SellTicketsViewController: BaseViewController {

    var tableView:UITableView!
    var searchTableView:GlobalSearchTableView!
    var searchViewModel = SearchViewModel.shareInstance
    var viewModel = SellViewModel()
    var searchNavigationBar = HomeSearchNavigationBar(frame: CGRectMake(0,0,SCREENWIDTH, 64),font:App_Theme_PinFan_L_12_Font)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchNavigatioBarClouse()
        self.setUpView()
        self.setUpNavigationItem()
        self.talKingDataPageName = "卖票"
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.registerClass(SellRecommondTableViewCell.self, forCellReuseIdentifier: "SellRecommondTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(44, 0, 0, 0))
        }
        
    }
    
    func setUpNavigationItem(){
        self.view.addSubview(searchNavigationBar)
    }
    
    func bindViewModel(){
        searchViewModel.controllerS = self
        RACSignal.interval(1, onScheduler: RACScheduler.currentScheduler()).subscribeNext { (str) in
            
        }
        let single = searchNavigationBar.searchField
            .rac_textSignal()
            .ignore("")
            .distinctUntilChanged()
        single.throttle(0.5).subscribeNext { (str) in
//            self.searchViewModel.requestSearchTicket(str as! String, searchTable: self.searchTableView)
        }
        searchViewModel.searchViewModelClouse = { _ in
            
            self.cancelSearchTable()
        }
    }
    
    func cancelSearchTable() {
        self.searchNavigationBar.searchField.frame = CGRectMake(20, 27,SCREENWIDTH - 40, 30)
        self.searchNavigationBar.cancelButton.hidden = true
        searchNavigationBar.searchField.hidden = false
        searchNavigationBar.searchField.resignFirstResponder()
        searchTableView.hidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    func setSearchNavigatioBarClouse(){
        searchNavigationBar.searchTextFieldBecomFirstRespoder = { _ in
            self.searchViewModel.searchType = .TicketSell
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension SellTicketsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
}

extension SellTicketsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
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
            recommentTitle.text = "近期热卖"
            cell?.contentView.addSubview(recommentTitle)
            
            let lineLabel = GloabLineView(frame: CGRectMake(CGRectGetMinX(recommentTitle.frame) - 50, 40, 30, 0.5))
            lineLabel.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
            cell?.contentView.addSubview(lineLabel)
            let lineLabel1 = GloabLineView(frame: CGRectMake(CGRectGetMaxX(recommentTitle.frame) + 20, 40, 30, 0.5))
            lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_384249_Color))
            cell?.contentView.addSubview(lineLabel1)
            cell!.selectionStyle = .None
            return cell!
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("SellRecommondTableViewCell", forIndexPath: indexPath) as! SellRecommondTableViewCell
            cell.selectionStyle = .None
//            viewModel.cellData(cell, indexPath:indexPath)
            return cell
        }
    }
}

