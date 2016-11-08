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

    let allTicketViewController = AllTicketViewController()
    let muiscTicketViewController = MuiscTicketViewController()
    let operaTicketViewController = OperaTicketViewController()
    let sportTicketViewController = SportTicketViewController()
    let otherTicketViewController = OtherTicketViewController()
    var pageViewControllers:NSArray!
    let pageViewTitles = ["全部","音乐会","话剧和歌剧","体育比赛","其他"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "演出"
        self.setUpNavigationItem()
        pageViewControllers = [allTicketViewController,muiscTicketViewController,operaTicketViewController,sportTicketViewController,otherTicketViewController]
        self.setUpPageViewControllerStyle()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpPageViewControllerStyle(){
        var stringSize:CGFloat = 0
        for string in pageViewTitles {
            let width = string.widthWithConstrainedHeight(string, font: Home_Page_Ticket_Font!, height: 18)
            stringSize = stringSize + width
        }
        self.adjustStatusBarHeight = true
        let cellEdging = ((SCREENWIDTH - kCollectionLayoutEdging * 2 - stringSize - CGFloat(5) * kCellSpacing) / CGFloat(9))
        self.collectionLayoutEdging = kCollectionLayoutEdging
        self.pagerBarColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        self.cellSpacing = kCellSpacing
        self.cellEdging = cellEdging
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

    
    func setUpNavigationItem() {
        self.setNavigationItemBack()
        let filtterItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Filter_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.filterPress(_:)))
        let searchItem = UIBarButtonItem(image: UIImage.init(named: "Icon_Search_Normal")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TicketPageViewController.searchPress(_:)))
        self.navigationItem.rightBarButtonItems = [searchItem,filtterItem]
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
    
    // MARK: - TYTabButtonDataSource
    override func numberOfControllersInPagerController() -> Int {
        return pageViewTitles.count
    }
    override func pagerController(pagerController: TYPagerController!, titleForIndex index: Int) -> String! {
        return pageViewTitles[index]
    }
    
    override func pagerController(pagerController: TYPagerController!, numberForIndex index: Int) -> String! {
        return "0"
    }
    override func pagerController(pagerController: TYPagerController!, controllerForIndex index: Int) -> UIViewController! {
        return pageViewControllers[index] as! UIViewController
    }

}


