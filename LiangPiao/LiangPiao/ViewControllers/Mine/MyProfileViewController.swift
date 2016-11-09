//
//  MyProfileViewController.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:MyProfileViewModel = MyProfileViewModel()
    
    var sexPickerView:ZHPickView!
    var birthDayPickerView:ZHPickView!
    var cityPickerView:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "完善资料"
        self.setUpView()
        self.setNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    func setNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(MyProfileViewController.saveItemPress(_:)))
    }
    
    func saveItemPress(sender:UIBarButtonItem) {
        
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        tableView.registerClass(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    func showSexPickerView(){
        sexPickerView = ZHPickView(pickviewWithArray: ["男","女"], isHaveNavControler: false)
        sexPickerView.setPickViewColer(UIColor.whiteColor())
        sexPickerView.setPickViewColer(UIColor.whiteColor())
        sexPickerView.setTintColor(UIColor.whiteColor())
        sexPickerView.setToolbarTintColor(UIColor.whiteColor())
        sexPickerView.setTintFont(Mine_Service_Font, color: UIColor.init(hexString: App_Theme_Text_Color))
        sexPickerView.delegate = self
        sexPickerView.show()
    }
    
    func showBirthDayPickerView(){
//        sexPickerView = ZHPickView(datePickWithDate: NSDate(), datePickerMode: .Date, isHaveNavControler: false)
//        sexPickerView.setPickViewColer(UIColor.whiteColor())
//        sexPickerView.setTintColor(UIColor.whiteColor())
//        sexPickerView.setToolbarTintColor(UIColor.whiteColor())
//        sexPickerView.setTintFont(Mine_Service_Font, color: UIColor.init(hexString: App_Theme_Text_Color))
//        sexPickerView.delegate = self
//        sexPickerView.show()
    }
    
    func showCityPickerView(){
        cityPickerView = ZHPickView(pickviewWithPlistName: "city", isHaveNavControler: false)
        cityPickerView.setPickViewColer(UIColor.whiteColor())
        cityPickerView.setTintColor(UIColor.whiteColor())
        cityPickerView.setToolbarTintColor(UIColor.whiteColor())
        cityPickerView.setTintFont(Mine_Service_Font, color: UIColor.init(hexString: App_Theme_Text_Color))
        cityPickerView.delegate = self
        cityPickerView.show()
    }

}

extension MyProfileViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            
        }else{
            switch indexPath.row {
            case 1:
                self.showSexPickerView()
            case 2:
                self.showBirthDayPickerView()
            case 3:
                self.showCityPickerView()
            default:
                break;
            }
        }
    }
}

extension MyProfileViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileImageTableViewCell", forIndexPath: indexPath) as! ProfileImageTableViewCell
            cell.selectionStyle = .None
            return cell
        default:
            switch indexPath.row {
            case 0,4:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailCell", forIndexPath: indexPath) as! GloabTitleAndDetailCell
                cell.setData(viewModel.cellTitle(indexPath), detail: "测试")
                cell.detailLabel.textColor = UIColor.init(hexString: GlobalCell_Detail_Color)
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.setData(viewModel.cellTitle(indexPath), detail: "测试")
                cell.selectionStyle = .None
                return cell
            }
            
        }
    }
}

extension MyProfileViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        
    }
}
