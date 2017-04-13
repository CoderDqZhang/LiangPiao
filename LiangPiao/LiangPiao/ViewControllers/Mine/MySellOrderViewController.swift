//
//  MySellViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MySellOrderViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:MySellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.setUpNavigationItem()
        self.talKingDataPageName = "订单交易-卖家"
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
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.register(OrderTicketInfoTableViewCell.self, forCellReuseIdentifier: "OrderTicketInfoTableViewCell")
        tableView.register(MySellOrderMuchTableViewCell.self, forCellReuseIdentifier: "MySellOrderMuchTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.setUpRefreshData()
        
    }
    
    func bindViewModel(){
        self.viewModel.requesrSellOrder(false)
    }
    
    func mySellOrderListView() -> UIView {
        let orderListView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 10))
        orderListView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    func setUpLoadMoreData(){
        self.tableView.mj_footer = LiangPiaoLoadMoreDataFooter(refreshingBlock: {
            self.viewModel.requesrSellOrder(true)
        })
    }
    
    func setUpRefreshData(){
        self.tableView.mj_header = LiangNomalRefreshHeader(refreshingBlock: {
            self.viewModel.requesrSellOrder(false)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MySellOrderViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.mySellOrderTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension MySellOrderViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.mySellOrderNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mySellOrderNumbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.mySellOrderListView()
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.mySellTableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNumberTableViewCell", for: indexPath) as! OrderNumberTableViewCell
            viewModel.tableViewCellOrderNumberTableViewCell(cell, indexPath:indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTicketInfoTableViewCell", for: indexPath) as! OrderTicketInfoTableViewCell
            cell.selectionStyle = .none
            viewModel.tableViewCellOrderTicketInfoTableViewCell(cell, indexPath:indexPath)
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellOrderMuchTableViewCell", for: indexPath) as! MySellOrderMuchTableViewCell
            cell.selectionStyle = .none
            viewModel.tableViewCellMySellOrderMuchTableViewCell(cell, indexPath:indexPath)
            return cell
        }
    }
    
}

extension MySellOrderViewController : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}

extension MySellOrderViewController :DZNEmptyDataSetSource {
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_F6F7FA_Color)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "暂时还没有订单"
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
