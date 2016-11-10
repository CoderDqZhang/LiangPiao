//
//  MIneViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    var tableView:UITableView!
    var cell:MineHeadTableViewCell!
    let viewModel = MineViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem() {
        self.navigationItem.title = "收货地址管理"
        self.setNavigationItemBack()
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(MineHeadTableViewCell.self, forCellReuseIdentifier: "MineHeadTableViewCell")
        tableView.registerClass(GloabImageTitleAndImageCell.self, forCellReuseIdentifier: "GloabImageTitleAndImageCell")
        tableView.registerClass(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(-20)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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

extension MineViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
//            let controller = LoginViewController()
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            let controller = MyProfileViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        case 2:
            let controller = AddressViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        case 3:
            let controller = SettingViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break;
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if cell != nil {
            if scrollView.contentOffset.y < 0 {
                cell.cellBackView.frame = CGRectMake(0, scrollView.contentOffset.y, SCREENWIDTH, 255 - scrollView.contentOffset.y)
            }
        }
    }
}

extension MineViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath.row)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("MineHeadTableViewCell", forIndexPath: indexPath) as! MineHeadTableViewCell
            cell.setData("开往春天的地铁", photoImage: UIImage.init(named: "Avatar_Default")!)
            cell.selectionStyle = .None
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("ServiceTableViewCell", forIndexPath: indexPath) as! ServiceTableViewCell
            cell.selectionStyle = .None
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GloabImageTitleAndImageCell", forIndexPath: indexPath) as! GloabImageTitleAndImageCell
            cell.setData(viewModel.cellTitle(indexPath.row), infoImage: viewModel.cellImage(indexPath.row))
            cell.selectionStyle = .None
            return cell
        }
    }

}
