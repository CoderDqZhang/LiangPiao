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
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(MyWallHeaderTableViewCell.self, forCellReuseIdentifier: "MyWallHeaderTableViewCell")
        tableView.registerClass(MyWallToolsTableViewCell.self, forCellReuseIdentifier: "MyWallToolsTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
        let topUpButton = self.createButton(CGRect.init(x: SpaceTopUpAndWidth, y: SCREENHEIGHT - 79 - 64, width: TopUpAndWithdrawWidth, height: 49), title: "充值", backGroundColor: UIColor.whiteColor(), titleColor: UIColor.init(hexString: App_Theme_4BD4C5_Color))
        topUpButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            NavigationPushView(self, toConroller: TopUpViewController())
        }
        self.view.addSubview(topUpButton)
        
        let withdraw = self.createButton(CGRect.init(x: SpaceTopUpAndWidth + CGRectGetMaxX(topUpButton.frame), y: SCREENHEIGHT - 79 - 64, width: TopUpAndWithdrawWidth, height: 49), title: "提现", backGroundColor: UIColor.init(hexString: App_Theme_4BD4C5_Color), titleColor: UIColor.whiteColor())
        withdraw.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            NavigationPushView(self, toConroller: WithDrawViewController())
        }
        self.view.addSubview(withdraw)
        
        let ruleButton = UIButton(type: .Custom)
        ruleButton.setTitleColor(UIColor.init(hexString: App_Theme_4BD4C5_Color), forState: .Normal)
        ruleButton.titleLabel?.font = App_Theme_PinFan_R_13_Font
        ruleButton.setTitle("查看规则说明", forState: .Normal)
        ruleButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            NavigationPushView(self, toConroller: MyWallRuleViewController())
        }
        self.view.addSubview(ruleButton)
        
        ruleButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX).offset(0)
            make.bottom.equalTo(withdraw.snp_top).offset(-41)
        }
        
    }
    
    func createButton(frame:CGRect, title:String, backGroundColor:UIColor, titleColor:UIColor) ->UIButton {
        let button = UIButton(type: .Custom)
        button.frame = frame
        button.setTitle(title, forState: .Normal)
        button.layer.cornerRadius = 2.0
        button.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(titleColor, forState: .Normal)
        button.backgroundColor = backGroundColor
        return button
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
}

extension MyWalletViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
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
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("MyWallHeaderTableViewCell", forIndexPath: indexPath) as! MyWallHeaderTableViewCell
            cell.detailBtn.rac_signalForControlEvents(.TouchUpInside).subscribeNext({ (action) in
                NavigationPushView(self, toConroller: DetailAccountViewController())
            })
            cell.selectionStyle = .None
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("MyWallToolsTableViewCell", forIndexPath: indexPath) as! MyWallToolsTableViewCell
            cell.selectionStyle = .None
            return cell
        }
    }
    
}

