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
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.separatorStyle = .None
        tableView.registerClass(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.registerClass(OrderTicketInfoTableViewCell.self, forCellReuseIdentifier: "OrderTicketInfoTableViewCell")
        tableView.registerClass(OrderHandleTableViewCell.self, forCellReuseIdentifier: "OrderHandleTableViewCell")
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
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
        let orderListView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,10))
        orderListView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    func bindViewModel(){
        viewModel.requestOrderList(self,isNext: false)
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
}

extension OrderListViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.orderListView()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderNumberTableViewCell", forIndexPath: indexPath) as! OrderNumberTableViewCell
            cell.userInteractionEnabled = false
            viewModel.tableViewOrderCellIndexPath(indexPath, cell: cell)
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderTicketInfoTableViewCell", forIndexPath: indexPath) as! OrderTicketInfoTableViewCell
            viewModel.tableViewOrderTicketInfoCellIndexPath(indexPath,cell:cell)
            cell.backgroundColor = UIColor.whiteColor()
            cell.selectionStyle = .None
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderHandleTableViewCell", forIndexPath: indexPath) as! OrderHandleTableViewCell
            cell.selectionStyle = .None
            return cell
        }
    }
}

extension OrderListViewController : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetDidTapView(scrollView: UIScrollView!) {
        viewModel.requestOrderList(self, isNext: false)
    }
}

extension OrderListViewController :DZNEmptyDataSetSource {
    
    func backgroundColorForEmptyDataSet(scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_Empty_BackGround_Color)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "点击屏幕，重新加载"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: APP_State_EmptyData_Color)], range: NSRange(location: 0, length: str.length))
        attribute.addAttributes([NSFontAttributeName:APP_State_EmptyData_Font!], range: NSRange.init(location: 0, length: str.length))
        return attribute
    }
    
    func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return -70
    }
    
    func spaceHeightForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 27
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty_order")?.imageWithRenderingMode(.AlwaysOriginal)
    }
}
