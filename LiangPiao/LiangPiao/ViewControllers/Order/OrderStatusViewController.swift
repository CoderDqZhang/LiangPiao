//
//  OrderStatusViewController.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController, UINavigationControllerDelegate {

    var tableView:UITableView!
    var viewModel = OrderStatusViewModel()
    var reciveView:GloableBottomOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.setUpView()
        self.setUpNavigationItem()
        // Do any additional setup after loading the view.
    }

    func setUpNavigationItem(){
        self.navigationItem.title = "订单详情"
        self.talKingDataPageName = "卖家订单详情"
        self.setNavigationItemBack()
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(ReciveAddressTableViewCell.self, forCellReuseIdentifier: "ReciveAddressTableViewCell")
        tableView.register(OrderTicketInfoTableViewCell.self, forCellReuseIdentifier: "OrderTicketInfoTableViewCell")
        tableView.register(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.register(OrderStatusTableViewCell.self, forCellReuseIdentifier: "OrderStatusTableViewCell")
        tableView.register(OrderStatusMuchTableViewCell.self, forCellReuseIdentifier: "OrderStatusMuchTableViewCell")
        tableView.register(DeverliyTableViewCell.self, forCellReuseIdentifier: "DeverliyTableViewCellSellDetail")
        tableView.register(OrderPayTableViewCell.self, forCellReuseIdentifier: "OrderPayTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        if self.viewModel.model.status == 3 {
            let types = [CustomButtonType.withBackBoarder,CustomButtonType.withBoarder,CustomButtonType.withBoarder]
            let titles = ["立即发货","联系买家",self.viewModel.model.expressInfo.photo != nil && self.viewModel.model.expressInfo.photo == "" ? "上传凭证":"查看凭证"]
            let frame = CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49)
            reciveView = GloableBottomOrder.init(frame:frame
                , titles: titles, types: types, gloableBottomOrderClouse: { (tag) in
                    if tag == 1 {
                        self.viewModel.requestOrderStatusChange()
                    }else if tag == 2 {
                        if self.viewModel.model.ticket.supplier != nil
                        {
                            if self.viewModel.model.user != nil && self.viewModel.model.user.mobileNum != "" {
                                AppCallViewShow(self.view, phone: self.viewModel.model.user.mobileNum)
                            }
                        }
                    }else{
                        if self.viewModel.model.expressInfo.photo == nil {
                            self.viewModel.requestOrderStatusChange()
                        }else if self.viewModel.model.expressInfo.photo != "" {
                            self.viewModel.presentImageBrowse(self.reciveView)
                        }else{
                            self.presentImagePickerView()
                        }
                    }
                    
            })
            self.view.addSubview(reciveView)
        }
        
        self.updateTableView(self.viewModel.model.status)
        
    }
    
    func connectBuyer(){
        AppCallViewShow(self.view, phone: self.viewModel.model.user.mobileNum)
    }
    
    func bindViewModel(){
        viewModel.controller = self
    }
    func updateTableView(_ status:Int) {
        if status == 3 {
            if reciveView != nil {
                reciveView.isHidden = false
            }else{
                let types = [CustomButtonType.withBackBoarder,CustomButtonType.withBoarder,CustomButtonType.withBoarder]
                let titles = ["立即发货","联系买家",self.viewModel.model.expressInfo.photo != nil && self.viewModel.model.expressInfo.photo == "" ? "上传凭证":"查看凭证"]
                let frame = CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49)
                reciveView = GloableBottomOrder.init(frame:frame
                    , titles: titles, types: types, gloableBottomOrderClouse: { (tag) in
                        if tag == 1 {
                            self.viewModel.requestOrderStatusChange()
                        }else if tag == 2 {
                            if self.viewModel.model.ticket.supplier != nil
                            {
                                if self.viewModel.model.user != nil && self.viewModel.model.user.mobileNum != "" {
                                    AppCallViewShow(self.view, phone: self.viewModel.model.user.mobileNum)
                                }
                            }
                        }else{
                            if self.viewModel.model.expressInfo.photo == nil {
                                self.viewModel.requestOrderStatusChange()
                            }else if self.viewModel.model.expressInfo.photo != "" {
                                self.viewModel.presentImageBrowse(self.reciveView)
                            }else{
                                self.presentImagePickerView()
                            }
                            
                        }
                        
                })
                self.view.addSubview(reciveView)
            }
            
            tableView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.view.snp.top).offset(0)
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(-49)
            })
        }else{
            self.viewModel.getDeverliyTrac()
            if reciveView != nil {
                reciveView.isHidden = true
            }
            tableView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.top).offset(0)
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(0)
            }
        }
    }
    
    func widthDrawFooterView() -> UIView{
        let footView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 100))
        footView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: -0.5,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        let service = self.createLabel(CGRect(x: 15,y: 20,width: SCREENWIDTH - 30,height: 14), text: "订单时间：\((viewModel.model.created)!)")
        footView.addSubview(service)
        let servicePhone = self.createLabel(CGRect(x: 15,y: 36,width: SCREENWIDTH - 30,height: 14), text: "客服电话：400-873-8011")
        footView.addSubview(servicePhone)
        let serviceTime = self.createLabel(CGRect(x: 15,y: 52,width: SCREENWIDTH - 30,height: 14), text: "客服工作时间：周一至周六 09:00-21:00")
        footView.addSubview(serviceTime)
        
        return footView
    }
    
    func createLabel(_ frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        return label
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

    func presentImagePickerView(){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (cancelAction) in
            
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let cameraAction = UIAlertAction(title: "拍照", style: .default) { (cancelAction) in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true) {
                    
                }
            }
            controller.addAction(cameraAction)
        }
        
        
        let album = UIAlertAction(title: "相册", style: .default) { (cancelAction) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true) {
                
            }
        }
        controller.addAction(cancel)
        controller.addAction(album)
        self.present(controller, animated: true) {
            
        }
        
    }
    
}

extension OrderStatusViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        viewModel.uploadImage(image: image)
        self.tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}

extension DelivererPushViewController : UINavigationControllerDelegate {
    
}

extension OrderStatusViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.orderStatusTableViewDidSelect(tableView, indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension OrderStatusViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewFooterViewHeight(section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !viewModel.isCancel() {
            if section == 1 {
                return self.widthDrawFooterView()
            }else{
                return nil
            }
        }
        return self.widthDrawFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.isCancel() {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusTableViewCell", for: indexPath) as! OrderStatusTableViewCell
                    viewModel.tableViewCellOrderStatusTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .none
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReciveAddressTableViewCell", for: indexPath) as! ReciveAddressTableViewCell
                    viewModel.tableViewCellReciveAddressTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .none
                    return cell
                default:
                    if viewModel.deverliyModel != nil && viewModel.deverliyModel.traces.count > 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DeverliyTableViewCellSellDetail", for: indexPath) as! DeverliyTableViewCell
                        viewModel.tableViewCellDeverliyTableViewCell(cell, indexPath: indexPath)
                        cell.selectionStyle = .none
                        return cell
                    }else{
                        var cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
                        if cell == nil {
                            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "defaultCell")
                        }
                        return cell!
                    }
                }
            default:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNumberTableViewCell", for: indexPath) as! OrderNumberTableViewCell
                    viewModel.tableViewCellOrderNumberTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .none
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTicketInfoTableViewCell", for: indexPath) as! OrderTicketInfoTableViewCell
                    cell.selectionStyle = .none
                    viewModel.tableViewCellOrderTicketInfoTableViewCell(cell, indexPath:indexPath)
                    cell.backgroundColor = UIColor.white
                    let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
                    cell.contentView.addSubview(lineLabel)
                    lineLabel.snp.makeConstraints { (make) in
                        make.left.equalTo(cell.contentView.snp.left).offset(15)
                        make.right.equalTo(cell.contentView.snp.right).offset(-15)
                        make.bottom.equalTo(cell.contentView.snp.bottom).offset(0)
                        make.height.equalTo(0.5)
                    }
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPayTableViewCell", for: indexPath) as! OrderPayTableViewCell
                    viewModel.tableViewCellOrderPayTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .none
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusMuchTableViewCell", for: indexPath) as! OrderStatusMuchTableViewCell
                        viewModel.tableViewCellOrderMuchTableViewCell(cell, indexPath:indexPath)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }else{
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNumberTableViewCell", for: indexPath) as! OrderNumberTableViewCell
                viewModel.tableViewCellOrderNumberTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTicketInfoTableViewCell", for: indexPath) as! OrderTicketInfoTableViewCell
                cell.selectionStyle = .none
                viewModel.tableViewCellOrderTicketInfoTableViewCell(cell, indexPath:indexPath)
                let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
                cell.contentView.addSubview(lineLabel)
                lineLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(cell.contentView.snp.left).offset(15)
                    make.right.equalTo(cell.contentView.snp.right).offset(-15)
                    make.bottom.equalTo(cell.contentView.snp.bottom).offset(0)
                    make.height.equalTo(0.5)
                }
                cell.backgroundColor = UIColor.white
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPayTableViewCell", for: indexPath) as! OrderPayTableViewCell
                viewModel.tableViewCellOrderPayTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusMuchTableViewCell", for: indexPath) as! OrderStatusMuchTableViewCell
                viewModel.tableViewCellOrderMuchTableViewCell(cell, indexPath:indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
    }
}

