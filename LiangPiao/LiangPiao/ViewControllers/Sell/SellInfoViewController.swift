//
//  SellInfoViewController.swift
//  LiangPiao
//
//  Created by Zhang on 16/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellInfoViewController: UIViewController {

    var viewModel = MySellConfimViewModel.shareInstance
    var tableView:UITableView!
    var bottomButton:GloableBottomButtonView!
    var sellType:ZHPickView!
    var ticketRegion:ZHPickView!
    var ticketRow:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "挂票"
        self.bindViewModel()
        self.setUpView()
        self.setNavigationItem()
        self.talKingDataPageName = "挂票"
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    deinit {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
        if sellType != nil {
            sellType.remove()
        }
        if ticketRegion != nil {
            ticketRegion.remove()
        }
        if ticketRow != nil {
            ticketRow.remove()
        }
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.register(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        tableView.register(MySellServiceTableViewCell.self, forCellReuseIdentifier: "MySellServiceTableViewCell")
        tableView.register(TicketStatusTableViewCell.self, forCellReuseIdentifier: "TicketStatusTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
        
        bottomButton = GloableBottomButtonView.init(frame: nil, title: "立即挂票", tag: nil, action: { (tag) in
            self.viewModel.sellFormModel.saveOrUpdate()
            self.viewModel.requestSellTicketPost()
        })
        
        self.view.addSubview(bottomButton)
        
    }
    
    func setNavigationItem(){
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "卖票须知", style: .plain, target: self, action: #selector(MySellConfimViewController.rightItemPress))
    }
    
    func rightItemPress(){
        KWINDOWDS().addSubview(GloableServiceView.init(title: "卖票规则", message: self.viewModel.messageTitle()))
    }
    
    func bindViewModel() {
        viewModel.infoController = self
    }
    
    func showSellTypePickerView(){
        if sellType == nil {
            sellType = ZHPickView(pickviewWith: viewModel.getSellType() as [AnyObject], isHaveNavControler: false)
            sellType.setPickViewColer(UIColor.white)
            sellType.setPickViewColer(UIColor.white)
            sellType.setTintColor(UIColor.white)
            sellType.tag = 0
            sellType.setToolbarTintColor(UIColor.white)
            sellType.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            sellType.delegate = self
        }
        
        sellType.show()
    }
    
    func showTicketRegionPickerView(){
        if ticketRegion == nil {
            ticketRegion = ZHPickView(pickviewWith: viewModel.getRegionArray() as [AnyObject], isHaveNavControler: false)
            ticketRegion.setPickViewColer(UIColor.white)
            ticketRegion.setPickViewColer(UIColor.white)
            ticketRegion.setTintColor(UIColor.white)
            ticketRegion.tag = 1
            ticketRegion.setToolbarTintColor(UIColor.white)
            ticketRegion.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            ticketRegion.delegate = self
        }
        
        ticketRegion.show()
    }
    
    func showTicketRowPickerView(){
        if ticketRow == nil {
            ticketRow = ZHPickView(pickviewWithPlistName: "TicketRow", isHaveNavControler: false)
            ticketRow.setPickViewColer(UIColor.white)
            ticketRow.setPickViewColer(UIColor.white)
            ticketRow.setTintColor(UIColor.white)
            ticketRow.tag = 2
            ticketRow.setToolbarTintColor(UIColor.white)
            ticketRow.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            ticketRow.delegate = self
        }
        
        ticketRow.show()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func mySellConfimView() -> UIView {
        let orderListView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 10))
        orderListView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        orderListView.addSubview(imageView)
        
        return orderListView
    }
    
    func hiderPickerView(_ tag:NSInteger) {
        for index in 0...2 {
            if index != tag {
                if sellType != nil {
                    sellType.remove()
                }
                if ticketRegion != nil {
                    ticketRegion.remove()
                }
                if ticketRow != nil {
                    ticketRow.remove()
                }
            }
        }
    }
}

extension SellInfoViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sellInfoViewNumberSection()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
            return self.mySellConfimView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.sellInfotableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sellInfoTableViewDidSelect(indexPath)
    }
}

extension SellInfoViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sellInfoNumberRowSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,1:
            switch indexPath.row {
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCell(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketStatusTableViewCell", for: indexPath) as! TicketStatusTableViewCell
            viewModel.tableViewTicketStatusTableViewCell(cell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellServiceTableViewCell", for: indexPath) as! MySellServiceTableViewCell
            viewModel.tableViewMySellServiceTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension SellInfoViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        self.hiderPickerView(pickView.tag)
        if resultString != nil {
            var cell:GloabTitleAndDetailImageCell!
            if pickView.tag == 0 {
//                self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow:pickView.tag + 1, inSection: 1))
                cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! GloabTitleAndDetailImageCell
            }else if pickView.tag == 1 {
                self.tableView(tableView, didSelectRowAt: IndexPath.init(row:1, section: 0))
                cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! GloabTitleAndDetailImageCell
            }else if pickView.tag == 2 {
                self.tableView(tableView, didSelectRowAt: IndexPath.init(row:0, section: 1))
                cell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! GloabTitleAndDetailImageCell
            }
            if cell != nil {
                viewModel.updateGloabTitleAndDetailImageCell(cell, row:pickView.tag, title:resultString)
            }
        }
    }
}
