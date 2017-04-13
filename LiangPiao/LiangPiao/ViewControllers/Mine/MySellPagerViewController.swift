//
//  MySellPagerViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellPagerViewController: TYTabButtonPagerController {

    let viewModel = MySellViewModel()
    
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.navigationItem.title = "我的挂票"
        self.setUpNavigationItem()
        self.setUpPageViewControllerStyle()
        self.setUpView()
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }

    func setUpPageViewControllerStyle(){
        let str = "订单交易"
        let width = str.widthWithConstrainedHeight(str, font: App_Theme_PinFan_R_13_Font!, height: 20)
        self.collectionLayoutEdging = SCREENWIDTH / 2 - width * 2 + 3
        self.pagerBarColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.cellSpacing = 57
        self.cellEdging = 10
        self.progressHeight = 2
        self.progressEdging = 0
        self.contentTopEdging = 40
        self.normalTextFont = App_Theme_PinFan_R_13_Font
        self.selectedTextFont = App_Theme_PinFan_R_13_Font
        self.normalTextColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        self.selectedTextColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.selectedTextFont = App_Theme_PinFan_R_13_Font
    }
    
    func setUpView(){
        let lineView = GloabLineView(frame: CGRect(x: 0, y: 40, width: SCREENWIDTH, height: 0.5))
        self.view.addSubview(lineView)
    }
    
    func bindViewModel(){
        viewModel.controller = self
//        viewModel.requestCategotyDic(self,index:index)
    }
    
    func setUpNavigationItem() {
        self.setNavigationItemBack()
        //        let filtterItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Filter_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.filterPress(_:)))
        //        let searchItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Search_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.searchPress(_:)))
        //        self.navigationItem.rightBarButtonItem = searchItem
    }
    
    func pageViewControllerDidSelectIndexPath(_ index:Int) {
        self.index = index
    }
    
    func filterPress(_ sender:UIBarButtonItem) {
        
    }
    
    func searchPress(_ sender:UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func setBarStyle(_ barStyle: TYPagerBarStyle) {
        super.setBarStyle(barStyle)
    }
    
    // MARK: - TYTabButtonDelegate
    override func pagerController(_ pagerController: TYTabPagerController!, configreCell cell: UICollectionViewCell!, forItemTitle title: String!, at indexPath: IndexPath!) {
        super.pagerController(pagerController, configreCell: cell, forItemTitle: title, at: indexPath)
    }
    
    override func pagerController(_ pagerController: TYTabPagerController!, didScrollToTabPageIndex index: Int) {
//        viewModel.pagerControllerDidScrollToTabPageIndex(index)
    }
    
    override func pagerController(_ pagerController: TYPagerController!, transitionFrom fromIndex: Int, to toIndex: Int, animated: Bool) {
        
    }
    
    override func pagerController(_ pagerController: TYPagerController!, willAddViewController index: Int) {
//        viewModel.willAddViewController = index
    }
    
    // MARK: - TYTabButtonDataSource
    override func numberOfControllersInPagerController() -> Int {
        return viewModel.numberOfControllersInPagerController()
    }
    override func pagerController(_ pagerController: TYPagerController!, titleFor index: Int) -> String! {
        return viewModel.pagerControllerTitleForIndex(index)
    }
    
    override func pagerController(_ pagerController: TYPagerController!, numberFor index: Int) -> String! {
        return "0"
    }
    
    override func pagerController(_ pagerController: TYPagerController!, controllerFor index: Int) -> UIViewController! {
        return viewModel.pagerControllerControllerForIndex(index)
    }
}
