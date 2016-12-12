//
//  PickUpViewController.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TopUpViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = TopUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "钱包充值"
        self.talKingDataPageName = "钱包充值"
        self.setupForDismissKeyboard()
        self.setUpNavigationItem()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(TopUpMuchTableViewCell.self, forCellReuseIdentifier: "TopUpMuchTableViewCell")
        tableView.registerClass(TopUpTypeTableViewCell.self, forCellReuseIdentifier: "TopUpTypeTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
    }
    
    func bindViewModel(){
        //        viewModel.reloadTableView = { _ in
        //            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
        //        }
        
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension TopUpViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

extension TopUpViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("TopUpMuchTableViewCell", forIndexPath: indexPath) as! TopUpMuchTableViewCell
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("TopUpTypeTableViewCell", forIndexPath: indexPath) as! TopUpTypeTableViewCell
                cell.selectionStyle = .None
                viewModel.tableViewTopUpTypeTableViewCell(cell, indexPath:indexPath)
                return cell
            }
        default:
            let cellIndef = "CleanTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIndef)
                let topUpButton = UIButton(type: .Custom)
                topUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                topUpButton.setTitle("充值", forState: .Normal)
                topUpButton.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
                topUpButton.layer.cornerRadius = 2.0
                topUpButton.layer.masksToBounds = true
                topUpButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
                cell?.contentView.addSubview(topUpButton)
                topUpButton.snp_makeConstraints(closure: { (make) in
                    make.edges.equalTo(UIEdgeInsetsMake(0, 15, 0, -15))
                })
            }
            cell?.backgroundColor = UIColor.clearColor()
            cell?.contentView.backgroundColor = UIColor.clearColor()
            
            return cell!
        }
    }
}

extension TopUpViewController : UITextFieldDelegate {
    
}

