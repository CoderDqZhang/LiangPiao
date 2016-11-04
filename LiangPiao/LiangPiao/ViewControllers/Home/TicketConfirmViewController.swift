//
//  TicketConfirmViewController.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketConfirmViewController: UIViewController {

    var receiveView:ReciveView!
    var orderFormView:OrderFormView!
    var orderConfirm:ConfirmView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "确认订单"
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    func setUpView() {
        self.setNavigationItemBack()
        
        receiveView = ReciveView(frame: CGRectMake(0, 64, SCREENWIDTH, 86))
        receiveView.reciveViewClouse = { tag in
            if tag == 1 {
                self.orderFormView.formType = .withNomal
            }else{
                 self.orderFormView.formType = .withAddress
            }
            self.orderFormView.formAddress = tag
            self.orderFormView.upDataTableView()
        }
        self.view.addSubview(receiveView)
        
        orderConfirm = ConfirmView(frame: CGRectMake(0, SCREENHEIGHT - 49, SCREENHEIGHT, 49))
        self.view.addSubview(orderConfirm)
        
        orderFormView = OrderFormView(frame: CGRectMake(0, CGRectGetMaxY(receiveView.frame), SCREENWIDTH, SCREENHEIGHT - CGRectGetMaxY(receiveView.frame) - 49), type: .withNomal)
        self.view.addSubview(orderFormView)
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
