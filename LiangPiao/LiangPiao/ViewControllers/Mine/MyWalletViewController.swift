//
//  MyWalletViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let TopUpAndWithdrawWidth:CGFloat = (SCREENWIDTH - 45) / 2
let SpaceTopUpAndWidth:CGFloat = 15

class MyWalletViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = MyWallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItem()
        self.setUpView()
        self.navigationItem.title =  "账户钱包"
        self.talKingDataPageName = "账户钱包"
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(MyWallHeaderTableViewCell.self, forCellReuseIdentifier: "MyWallHeaderTableViewCell")
        tableView.register(MyWallToolsTableViewCell.self, forCellReuseIdentifier: "MyWallToolsTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
        let topUpButton = self.createButton(CGRect.init(x: SpaceTopUpAndWidth, y: SCREENHEIGHT - 79 - 64, width: (SCREENWIDTH - 3 * SpaceTopUpAndWidth) / 2, height: 49), title: "充值", backGroundColor: UIColor.white, titleColor: UIColor.init(hexString: App_Theme_4BD4C5_Color))
        topUpButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.viewModel.pushTopUpViewController()
        }
        self.view.addSubview(topUpButton)
        
        let withdraw = CustomButton.init(frame: CGRect.init(x: SCREENWIDTH / 2 + SpaceTopUpAndWidth / 2, y: SCREENHEIGHT - 79 - 64, width: (SCREENWIDTH - 3 * SpaceTopUpAndWidth) / 2, height: 49), title: "提现", tag: 1, titleFont: App_Theme_PinFan_M_15_Font!, type: .withBackBoarder) { (tag) in
            let controllerVC = WithDrawViewController()
            controllerVC.viewModel.maxMuch = "\(self.viewModel.model.balance)".muchType("\((self.viewModel.model.balance)!)")
            NavigationPushView(self, toConroller: controllerVC)
        }
        self.view.addSubview(withdraw)
            
        let ruleButton = CustomButton.init(frame: CGRect.zero, title: "查看规则说明", tag: 2, titleFont: App_Theme_PinFan_M_13_Font!, type: .withNoBoarder) { (tag) in
            KWINDOWDS().addSubview(GloableServiceView.init(title: "规则说明", message: self.viewModel.messageTitle()))
        }
        self.view.addSubview(ruleButton)
        
        ruleButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.bottom.equalTo(withdraw.snp.top).offset(-41)
        }
        
    }
    
    func createButton(_ frame:CGRect, title:String, backGroundColor:UIColor, titleColor:UIColor) ->UIButton {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setTitle(title, for: UIControlState())
        if backGroundColor != UIColor.init(hexString: App_Theme_4BD4C5_Color) {
            button.layer.cornerRadius = 2.0
            button.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            button.layer.borderWidth = 1.0
        }
        button.setTitleColor(titleColor, for: UIControlState())
        button.buttonSetThemColor(App_Theme_FFFFFF_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: frame.size.width, height: frame.size.height))
        return button
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
        viewModel.requestMyWall()
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
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

extension MyWalletViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! MyWallHeaderTableViewCell
            cell.cellBackView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: SCREENWIDTH, height: 190 - scrollView.contentOffset.y)
        }
    }
}

extension MyWalletViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
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
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyWallHeaderTableViewCell", for: indexPath) as! MyWallHeaderTableViewCell
            viewModel.tableViewCellMyWallHeaderTableViewCell(cell)
            cell.myWallHeaderTableViewCellClouse = { _ in
                NavigationPushView(self, toConroller: DetailAccountViewController())
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyWallToolsTableViewCell", for: indexPath) as! MyWallToolsTableViewCell
            viewModel.tableViewCellMyWallToolsTableViewCell(cell)
            cell.selectionStyle = .none
            return cell
        }
    }
    
}



