//
//  FavoriteViewController.swift
//  LiangPiao
//
//  Created by Zhang on 11/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FavoriteViewController: UIViewController {

    var tableView:UITableView!
    let viewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        self.talKingDataPageName = "想看的演出"
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavigationItem() {
        self.navigationItem.title = "想看的演出"
        self.setNavigationItemBack()
        
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.setUpRefreshView()
    }
    
    func bindViewModel(){
        viewModel.requestFavoriteTicket(self,isNext:false)
    }
    
    func setUpRefreshView(){
        self.tableView.mj_header = LiangNomalRefreshHeader(refreshingBlock: {
            self.viewModel.requestFavoriteTicket(self, isNext:false)
        })
    }
    
    func setUpLoadMoreData(){
        self.tableView.mj_footer = LiangPiaoLoadMoreDataFooter(refreshingBlock: {
            self.viewModel.requestFavoriteTicket(self, isNext:true)
        })
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
extension FavoriteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller: self)
    }
}

extension FavoriteViewController : UITableViewDataSource {
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
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as! RecommendTableViewCell
        viewModel.cellData(cell, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
extension FavoriteViewController : DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetDidTap(_ scrollView: UIScrollView!) {
        viewModel.requestFavoriteTicket(self, isNext: false)
    }
}

extension FavoriteViewController :DZNEmptyDataSetSource {
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_F6F7FA_Color)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "还没有想看的演出\n先去首页看看吧"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)], range: NSRange(location: 0, length: str.length))
        attribute.addAttributes([NSFontAttributeName:App_Theme_PinFan_R_16_Font!], range: NSRange.init(location: 0, length: str.length))
        return attribute
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 27
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "Icon_Search_Empty")
    }
}

