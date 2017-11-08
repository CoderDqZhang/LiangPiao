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
        self.talKingDataPageName = "我的"
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
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.register(MineHeadTableViewCell.self, forCellReuseIdentifier: "MineHeadTableViewCell")
        tableView.register(GloabImageTitleAndImageCell.self, forCellReuseIdentifier: "GloabImageTitleAndImageCell")
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(-20, 0, 0, 0))
        }
        
        self.bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bindViewModel(){
        viewModel.reloadTableView = { _ in
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        }

        viewModel.controller = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createCustomLabel() -> UILabel{
        let label = UILabel.init()
        label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = App_Theme_PinFan_M_11_Font
        label.textAlignment = .center
        label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        return label
    }
}

extension MineViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if cell != nil {
            if scrollView.contentOffset.y < 0 {
                cell.cellBackView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: SCREENWIDTH, height: 255 - scrollView.contentOffset.y)
            }
        }
    }
}

extension MineViewController : UITableViewDataSource {
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
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "MineHeadTableViewCell", for: indexPath) as! MineHeadTableViewCell
            viewModel.tableViewPhotoCell(cell)
            cell.selectionStyle = .none
            return cell
        default:
            switch indexPath.row {
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabImageTitleAndImageCell", for: indexPath) as! GloabImageTitleAndImageCell
                viewModel.tableViewGloabImageTitleAndImageCell(cell, indexPath:indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
    }

}
