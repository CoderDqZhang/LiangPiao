//
//  BuyTicketsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SellTicketsViewController: BaseViewController {

    var tableView:UITableView!
    var searchTableView:GlobalSearchTableView!
    var searchViewModel = SearchViewModel.shareInstance
    var viewModel = SellViewModel()
    var searchNavigationBar = HomeSearchNavigationBar(frame: CGRect(x: 0,y: -64,width: SCREENWIDTH, height: 64),font:App_Theme_PinFan_L_12_Font)
    var searchBarView:GloableSearchNavigationBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchNavigatioBarClouse()
        self.setUpView()
        self.setUpNavigationItem()
        self.talKingDataPageName = "卖票"
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if searchTableView == nil || searchTableView.isHidden {
            self.tabBarController?.tabBar.isHidden = false
        }else{
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    func setUpView() {
        searchBarView = GloableSearchNavigationBarView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH, height: 64), title:"挂票", searchClouse:{ _ in
            self.searchButtonPress()
        })
        self.view.addSubview(searchBarView)
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.register(SellRecommondTableViewCell.self, forCellReuseIdentifier: "SellRecommondTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, -44, 0))
        }
        self.setUpRefreshData()
    }
    
    func setUpRefreshData(){
        self.tableView.mj_header = LiangNomalRefreshHeader(refreshingBlock: {
            self.viewModel.requestHotTicket()
        })
    }
    
    func setUpNavigationItem(){
        searchNavigationBar.searchField.placeholder = "搜索想转卖的演出..."
        self.view.addSubview(searchNavigationBar)
    }
    
    func searchButtonPress(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.searchBarView.frame = CGRect.init(x: 0, y: -64, width: SCREENWIDTH, height: 64)
            self.searchNavigationBar.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64)
            }, completion: { completion in
                self.searchNavigationBar.searchField.becomeFirstResponder()
        })
    }
    
    func cancelButtonPress(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.searchBarView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64)
            self.searchNavigationBar.frame = CGRect.init(x: 0, y: -64, width: SCREENWIDTH, height: 64)
            }, completion: { completion in
                self.searchNavigationBar.searchField.resignFirstResponder()
        })
    }
    
    func bindViewModel(){
        searchViewModel.controllerS = self
        viewModel.controller = self
        viewModel.requestHotTicket()
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

        searchViewModel.searchViewModelClouse = { _ in
            self.view.endEditing(true)
        }
    }
    
    func cancelSearchTable() {
        self.cancelButtonPress()
        self.searchNavigationBar.searchField.frame = CGRect(x: 20, y: 27,width: SCREENWIDTH - 40, height: 30)
        self.searchNavigationBar.cancelButton.isHidden = true
        searchNavigationBar.searchField.isHidden = false
        searchNavigationBar.searchField.resignFirstResponder()
        searchTableView.isHidden = true
        searchNavigationBar.searchField.text = ""
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setSearchNavigatioBarClouse(){
        searchNavigationBar.searchTextFieldBecomFirstRespoder = { _ in
            self.searchViewModel.searchType = .ticketSellHistory
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

extension SellTicketsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellRecommondTableViewCell", for: indexPath) as! SellRecommondTableViewCell
        cell.selectionStyle = .none
        viewModel.tableViewtableViewSellRecommondTableViewCell(cell, indexPath: indexPath)
        return cell
    }
}

extension SellTicketsViewController : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetDidTap(_ scrollView: UIScrollView!) {
        self.viewModel.requestHotTicket()
    }
}

extension SellTicketsViewController :DZNEmptyDataSetSource {
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_F6F7FA_Color)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "点击屏幕，重新加载"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)], range: NSRange(location: 0, length: str.length))
        attribute.addAttributes([NSFontAttributeName:App_Theme_PinFan_R_16_Font!], range: NSRange.init(location: 0, length: str.length))
        return attribute
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -70
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 27
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty_order")?.withRenderingMode(.alwaysOriginal)
    }
}

