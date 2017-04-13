//
//  MySellManagerViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MySellManagerViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:MySellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.setUpNavigationItem()
        self.talKingDataPageName = "品类管理"
        self.bindViewModel()

        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
    }
    
    
    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(OrderManagerTableViewCell.self, forCellReuseIdentifier: "OrderManagerTableViewCell")
        tableView.register(MySellManagerMuchTableViewCell.self, forCellReuseIdentifier: "MySellManagerMuchTableViewCell")
        tableView.register(MySellAttentionTableViewCell.self, forCellReuseIdentifier: "MySellAttentionTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.setUpRefreshData()
        
    }
    
    func bindViewModel(){
        self.viewModel.requestOrderManager()
    }
    
    func setUpRefreshData(){
        self.tableView.mj_header = LiangNomalRefreshHeader(refreshingBlock: {
            self.viewModel.requestOrderManager()
        })
    }
    
    func mySellOrderManagerListView() -> UIView {
        let orderListView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 10))
        orderListView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 4))
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.mySellOrderManagerTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension MySellManagerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.mySellOrderManagerNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mySellOrderManagerNumbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.mySellOrderManagerListView()
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.mySellOrderManagerTableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderManagerTableViewCell", for: indexPath) as! OrderManagerTableViewCell
            viewModel.tableViewCellOrderManagerTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellManagerMuchTableViewCell", for: indexPath) as! MySellManagerMuchTableViewCell
            viewModel.tableViewCellMySellManagerMuchTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellAttentionTableViewCell", for: indexPath) as! MySellAttentionTableViewCell
            viewModel.tableViewCellMySellAttentionTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension MySellManagerViewController : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
}

extension MySellManagerViewController :DZNEmptyDataSetSource {
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_F6F7FA_Color)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "您暂未挂票，在挂票页可以上票哦~"
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
