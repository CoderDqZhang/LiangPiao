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
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(OrderExpressTableViewCell.self, forCellReuseIdentifier: "OrderExpressTableViewCell")
        tableView.register(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.register(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func bindViewModel(){
        viewModel.controller = self
        viewModel.isRecivi = viewModel.present.isSelect
        viewModel.isVisite = viewModel.visite.isSelect
        viewModel.updateDeliveryType()
        self.tableView.reloadData()
        
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
        let saveItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(OrderDeliveryTypeViewController.saveDeviliType))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    func saveDeviliType(){
        viewModel.saveDelivery()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func cellOrderExpressTableViewCell(_ tableView:UITableView,indexPath:IndexPath) -> OrderExpressTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderExpressTableViewCell", for: indexPath) as! OrderExpressTableViewCell
        cell.selectionStyle = .none
        viewModel.talbleViewcellOrderExpressTableViewCell(cell, indexPath: indexPath)
        return cell
    }
    
    func cellGloabTitleAndSwitchBarTableViewCell(_ tableView:UITableView,indexPath:IndexPath) -> GloabTitleAndSwitchBarTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndSwitchBarTableViewCell", for: indexPath) as! GloabTitleAndSwitchBarTableViewCell
        cell.selectionStyle = .none
        viewModel.talbleViewCellGloabTitleAndSwitchBarTableViewCell(cell, indexPath: indexPath, controller:self)
        cell.titleLabel.font = App_Theme_PinFan_R_14_Font
        return cell
    }
    
    func cellGloabTextFieldCell(_ tableView:UITableView,indexPath:IndexPath) -> GloabTextFieldCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTextFieldCell", for: indexPath) as! GloabTextFieldCell
        cell.selectionStyle = .none
        cell.textField.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        cell.textField.font = App_Theme_PinFan_R_13_Font
        viewModel.talbleViewCellGloabTextFieldCell(cell, indexPath: indexPath)
        return cell
    }
    
}

extension OrderDeliveryTypeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
}

extension OrderDeliveryTypeViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.type {
        case .nomal:
            switch indexPath.row {
            case 0:
                return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
            default:
                return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
            }
        case .all:
            switch indexPath.row {
            case 0,1,5:
                return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
            default:
                return cellGloabTextFieldCell(tableView, indexPath: indexPath)
            }
        default:
            if viewModel.type == .visite {
                switch indexPath.row {
                case 0,1,2:
                    return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
                default:
                    return cellGloabTextFieldCell(tableView, indexPath: indexPath)
                }
            }else{
                switch indexPath.row {
                case 0,1,5:
                    return cellGloabTitleAndSwitchBarTableViewCell(tableView, indexPath: indexPath)
                default:
                    return cellGloabTextFieldCell(tableView, indexPath: indexPath)
                }
            }
        }
    }
}
