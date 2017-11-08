//
//  TicketSceneViewController.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketSceneViewController: UIViewController {

    var tableView:UITableView!
    let viewModel = TicketSessionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.bindViewModel()
        self.talKingDataPageName = "场次"
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        self.setNavigationItemBack()

        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(TicketSceneTableViewCell.self, forCellReuseIdentifier: "TicketSceneTableViewCell")
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        let navigationBar = GlobalNavigationBarView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH - 150, height: 42), title: viewModel.model.title, detail: viewModel.model.showDate)
        self.navigationItem.titleView = navigationBar
    }

    func bindViewModel(){
        viewModel.controller = self
        viewModel.requestTicketSession(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TicketSceneViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAtIndexPath(indexPath)
    }
}

extension TicketSceneViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketSceneTableViewCell", for: indexPath) as! TicketSceneTableViewCell
        cell.selectionStyle = .none
        viewModel.cellForRowAtIndexPath(indexPath, cell: cell)
        return cell
    }
    
}

