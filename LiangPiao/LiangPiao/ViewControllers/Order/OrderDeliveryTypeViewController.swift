//
//  OrderDeliveryTypeViewController.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderDeliveryTypeViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = OrderDeliveryTypeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItem()
        self.setUpView()
        self.navigationItem.title =  "配送方式"
        self.talKingDataPageName = "配送方式"
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(OrderExpressTableViewCell.self, forCellReuseIdentifier: "OrderExpressTableViewCell")
        tableView.registerClass(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.registerClass(OrderExpressDetailTableViewCell.self, forCellReuseIdentifier: "OrderExpressDetailTableViewCell")
        tableView.registerClass(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func bindViewModel(){
        
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
        let saveItem = UIBarButtonItem.init(title: "保存", style: .Plain, target: self, action: #selector(OrderDeliveryTypeViewController.saveDelivery))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    func saveDelivery(){
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func cellOrderExpressTableViewCell(tableView:UITableView,indexPath:NSIndexPath) -> OrderExpressTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderExpressTableViewCell", forIndexPath: indexPath) as! OrderExpressTableViewCell
        cell.selectionStyle = .None
        
        return cell
    }
    
    func cellGloabTitleAndSwitchBarTableViewCell(tableView:UITableView,indexPath:NSIndexPath) -> GloabTitleAndSwitchBarTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndSwitchBarTableViewCell", forIndexPath: indexPath) as! GloabTitleAndSwitchBarTableViewCell
        cell.selectionStyle = .None
        viewModel.talbleViewCellGloabTitleAndSwitchBarTableViewCell(cell, indexPath: indexPath, controller:self)
        return cell
    }
    
    func cellGloabTextFieldCell(tableView:UITableView,indexPath:NSIndexPath) -> GloabTextFieldCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("GloabTextFieldCell", forIndexPath: indexPath) as! GloabTextFieldCell
        cell.selectionStyle = .None
        viewModel.talbleViewCellGloabTextFieldCell(cell, indexPath: indexPath)
        return cell
    }
    
    func cellOrderExpressDetailTableViewCell(tableView:UITableView,indexPath:NSIndexPath) -> OrderExpressDetailTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderExpressDetailTableViewCell", forIndexPath: indexPath) as! OrderExpressDetailTableViewCell
        cell.selectionStyle = .None
        viewModel.talbleViewCellOrderExpressDetailTableViewCell(cell, indexPath: indexPath)
        return cell
    }
}

extension OrderDeliveryTypeViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
}

extension OrderDeliveryTypeViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch viewModel.type {
        case .Nomal:
            switch indexPath.row {
            case 0:
                return cellOrderExpressTableViewCell(tableView, indexPath: indexPath)
            default:
                return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
            }
        case .All:
            switch indexPath.row {
            case 0:
                return cellOrderExpressTableViewCell(tableView, indexPath: indexPath)
            case 1,5:
                return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
            case 2,6:
                return cellOrderExpressDetailTableViewCell(tableView, indexPath: indexPath)
            default:
                return cellGloabTextFieldCell(tableView, indexPath: indexPath)
            }
        default:
            if viewModel.type == .Visite {
                switch indexPath.row {
                case 0:
                    return cellOrderExpressTableViewCell(tableView, indexPath: indexPath)
                case 4,5:
                    return cellGloabTextFieldCell(tableView, indexPath: indexPath)
                case 1,2:
                    return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
                default:
                    return cellOrderExpressDetailTableViewCell(tableView, indexPath: indexPath)
                }
            }else{
                switch indexPath.row {
                case 0:
                    return cellOrderExpressTableViewCell(tableView, indexPath: indexPath)
                case 1,5:
                    return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
                case 2:
                    return cellOrderExpressDetailTableViewCell(tableView, indexPath: indexPath)
                default:
                    return cellGloabTextFieldCell(tableView, indexPath: indexPath)
                }
            }
        }
    }
}
