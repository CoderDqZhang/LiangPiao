//
//  MySellConfimViewController.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellConfimViewController: UIViewController {
    
    var tableView:UITableView!
    var expressage:ZHPickView!
    var viewModel = MySellConfimViewModel.shareInstance
    var bottomButton:GloableBottomButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "挂票"
        self.view.backgroundColor = UIColor.white
        self.setNavigationItem()
        self.bindViewModel()
        self.talKingDataPageName = "挂票"
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    deinit {
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.register(MySellConfimHeaderTableViewCell.self, forCellReuseIdentifier: "MySellConfimHeaderTableViewCell")
        tableView.register(GloabTitleNumberCountTableViewCell.self, forCellReuseIdentifier: "GloabTitleNumberCountTableViewCell")
        tableView.register(MySellTicketTableViewCell.self, forCellReuseIdentifier: "MySellTicketTableViewCell")
        tableView.register(MySellTicketMuchTableViewCell.self, forCellReuseIdentifier: "MySellTicketMuchTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
        
        bottomButton = GloableBottomButtonView.init(frame: nil, title: "继续", tag: nil, action: { (tag) in
            self.viewModel.pushSellInfo()
        })
        if !self.viewModel.isChange {
            self.bottomButton.button.isEnabled = false
            self.bottomButton.button.buttonSetThemColor(App_Theme_DDE0E5_Color, selectColor: App_Theme_DDE0E5_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
            self.bottomButton.button.backgroundColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        }else{
            self.bottomButton.button.isEnabled = true
            self.bottomButton.button.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
        }
        
        self.view.addSubview(bottomButton)
        
    }
    
    func setNavigationItem(){
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "卖票须知", style: .plain, target: self, action: #selector(MySellConfimViewController.rightItemPress))
    }
    
    func rightItemPress(){
        KWINDOWDS().addSubview(GloableServiceView.init(title: "卖票须知", message: self.viewModel.messageTitle()))
    }
    
    func bindViewModel() {
        viewModel.controller = self
        viewModel.requestSellTicket()
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

extension MySellConfimViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
}

extension MySellConfimViewController : UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellConfimHeaderTableViewCell", for: indexPath) as! MySellConfimHeaderTableViewCell
            viewModel.tableViewMySellConfimHeaderTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellTicketTableViewCell", for: indexPath) as! MySellTicketTableViewCell
            viewModel.tableViewCellMySellTicketTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleNumberCountTableViewCell", for: indexPath) as! GloabTitleNumberCountTableViewCell
            viewModel.tableViewCellGloabTitleNumberCountTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySellTicketMuchTableViewCell", for: indexPath) as! MySellTicketMuchTableViewCell
            viewModel.tableViewCellMySellTicketMuchTableViewCell(cell, indexPath:indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}
