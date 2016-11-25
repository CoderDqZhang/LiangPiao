//
//  TicketPageViewController.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SnapKit

let kCollectionLayoutEdging:CGFloat = 29
let kCellSpacing:CGFloat = 10

class TicketPageViewController: TYTabButtonPagerController {

    let viewModel = TicketCategoryViewModel.sharedInstance
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "演出"
        self.setUpNavigationItem()
        self.setUpPageViewControllerStyle()
        self.setUpView()
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    func setUpPageViewControllerStyle(){
        self.collectionLayoutEdging = kCollectionLayoutEdging
        self.pagerBarColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        self.cellSpacing = kCellSpacing
        self.cellEdging = 10
        self.progressHeight = 2
        self.progressEdging = 0
        self.contentTopEdging = 40
        self.normalTextFont = Home_Page_Ticket_NomalFont
        self.selectedTextFont = Home_Page_Ticket_Font
        self.normalTextColor = UIColor.init(hexString: Home_Page_Ticket_NomalColor)
        self.selectedTextColor = UIColor.init(hexString: Home_Page_Ticket_Color)
        self.selectedTextFont = Home_Page_Ticket_Font
    }
    
    func setUpView(){
        let lineView = GloabLineView(frame: CGRectMake(0, 40, SCREENWIDTH, 0.5))
        self.view.addSubview(lineView)
    }

    func bindViewModel(){
        viewModel.requestCategotyDic(self,index:index)
    }
    
    func setUpNavigationItem() {
        self.setNavigationItemBack()
        let filtterItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Filter_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.filterPress(_:)))
        let searchItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Search_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.searchPress(_:)))
        self.navigationItem.rightBarButtonItems = [searchItem,filtterItem]
    }
    
    func pageViewControllerDidSelectIndexPath(index:Int) {
        self.index = index
    }
    
    func filterPress(sender:UIBarButtonItem) {
        
    }
    
    func searchPress(sender:UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func setBarStyle(barStyle: TYPagerBarStyle) {
        super.setBarStyle(barStyle)
    }
    
    // MARK: - TYTabButtonDelegate
    override func pagerController(pagerController: TYTabPagerController!, configreCell cell: UICollectionViewCell!, forItemTitle title: String!, atIndexPath indexPath: NSIndexPath!) {
        super.pagerController(pagerController, configreCell: cell, forItemTitle: title, atIndexPath: indexPath)
    }
    
    override func pagerController(pagerController: TYTabPagerController!, didScrollToTabPageIndex index: Int) {
        viewModel.pagerControllerDidScrollToTabPageIndex(index)
    }
    
    override func pagerController(pagerController: TYPagerController!, transitionFromIndex fromIndex: Int, toIndex: Int, animated: Bool) {
        
    }
    
    override func pagerController(pagerController: TYPagerController!, willAddViewController index: Int) {
        viewModel.willAddViewController = index
    }
    
    // MARK: - TYTabButtonDataSource
    override func numberOfControllersInPagerController() -> Int {
        return viewModel.numberOfControllersInPagerController()
    }
    override func pagerController(pagerController: TYPagerController!, titleForIndex index: Int) -> String! {
        return viewModel.pagerControllerTitleForIndex(index)
    }
    
    override func pagerController(pagerController: TYPagerController!, numberForIndex index: Int) -> String! {
        return "0"
    }
    override func pagerController(pagerController: TYPagerController!, controllerForIndex index: Int) -> UIViewController! {
        return viewModel.pagerControllerControllerForIndex(index)
    }

}


