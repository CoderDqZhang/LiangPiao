//
//  SettingViewController.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:SettingViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.setUpView()
        self.setNavigationItem()
        self.talKingDataPageName = "设置"
        // Do any additional setup after loading the view.
    }
    
    func setNavigationItem() {
        self.setNavigationItemBack()
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
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

extension SettingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
}

extension SettingViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
            cell.setData(viewModel.cellTitle(indexPath), detail: "")
            cell.selectionStyle = .none
            if indexPath.row == viewModel.numbrOfRowInSection(indexPath.section) - 1 {
                cell.hideLineLabel()
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailCell", for: indexPath) as! GloabTitleAndDetailCell
            cell.setData(viewModel.cellTitle(indexPath), detail: "")
            cell.detailLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
            cell.selectionStyle = .none
            cell.hideLineLabel()
            return cell
        }
    }
}

