//
//  SellTicketsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class OrderListViewController: BaseViewController {

    var tableView:UITableView!
    var viewModel:OrderListViewModel = OrderListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.navigationItem.title = viewModel.listTitle()
        self.talKingDataPageName = "订单列表"
//        self.navigationController!.title = viewModel.listTitle()
        // Do any additional setup after loading the view.
    }

    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.register(OrderTicketInfoTableViewCell.self, forCellReuseIdentifier: "OrderTicketInfoTableViewCell")
        tableView.register(OrderHandleTableViewCell.self, forCellReuseIdentifier: "OrderHandleTableViewCell")
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.setUpRefreshData()
        self.bindViewModel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func orderListView() -> UIView {
        let orderListView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 10))
        orderListView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    func bindViewModel(){
        viewModel.controller = self
        if UserInfoModel.isLoggedIn() {
            viewModel.requestOrderList(self,isNext: false)
        }
    }
    
    func setUpLoadMoreData(){
        self.tableView.mj_footer = LiangPiaoLoadMoreDataFooter(refreshingBlock: {
            self.viewModel.requestOrderList(self, isNext:true)
        })
    }
    
    func setUpRefreshData(){
        self.tableView.mj_header = LiangNomalRefreshHeader(refreshingBlock: {
            self.viewModel.requestOrderList(self, isNext:false)
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

extension OrderListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
}

extension OrderListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.orderListView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNumberTableViewCell", for: indexPath) as! OrderNumberTableViewCell
            cell.isUserInteractionEnabled = false
            viewModel.tableViewOrderCellIndexPath(indexPath, cell: cell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTicketInfoTableViewCell", for: indexPath) as! OrderTicketInfoTableViewCell
            viewModel.tableViewOrderTicketInfoCellIndexPath(indexPath,cell:cell)
            cell.backgroundColor = UIColor.white
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHandleTableViewCell", for: indexPath) as! OrderHandleTableViewCell
            viewModel.tableViewOrderHandleCellIndexPath(indexPath, cell:cell, controller:self)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension OrderListViewController : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetDidTap(_ scrollView: UIScrollView!) {
        viewModel.requestOrderList(self, isNext: false)
    }
}

extension OrderListViewController :DZNEmptyDataSetSource {
    
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
