//
//  WithDrawStatusViewController.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawStatusViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = WithDreaViewModel()
    var name:String!
    var amount:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItem()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem(){
        self.navigationItem.title = "提现详情"
        self.talKingDataPageName = "提现详情"
        self.navigationItem.hidesBackButton = true
//        self.setNavigationItemCleanButton()
    }

    func setUpView(){
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(WithDrawStatusHeaderCell.self, forCellReuseIdentifier: "WithDrawStatusHeaderCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
    }
    
    func bindViewModel(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func widthDrawFooterView() -> UIView{
        let drawFooter = UIView(frame: CGRectMake(0,0,SCREENWIDTH,30))
        drawFooter.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        drawFooter.addSubview(imageView)
        return drawFooter
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

extension WithDrawStatusViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        viewModel.mySellOrderTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

extension WithDrawStatusViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 0.000001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.widthDrawFooterView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("WithDrawStatusHeaderCell", forIndexPath: indexPath) as! WithDrawStatusHeaderCell
            cell.setData(name, much: amount)
            cell.selectionStyle = .None
            return cell
        default:
            let cellIndef = "CleanTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIndef)
                let topUpButton = CustomButton.init(frame: CGRect.init(x: 15 , y: 0, width: SCREENWIDTH - 30, height: 49), title: "完成", tag: nil, titleFont: App_Theme_PinFan_M_15_Font!, type: .withBackBoarder) { (tag) in
                    for controller in (self.navigationController?.viewControllers)! {
                        if controller is MyWalletViewController {
                            NSNotificationCenter.defaultCenter().postNotificationName(BlanceNumberChange, object: nil)
                            self.navigationController?.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
                cell?.contentView.addSubview(topUpButton)
            }
            cell?.backgroundColor = UIColor.clearColor()
            cell?.contentView.backgroundColor = UIColor.clearColor()
            return cell!
        }
    }
}
