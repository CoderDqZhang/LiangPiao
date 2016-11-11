//
//  GlobalSearchTableView.swift
//  LiangPiao
//
//  Created by Zhang on 11/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
typealias SearchDidSelectClouse = (indexPath:NSIndexPath) ->Void
class GlobalSearchTableView: UIView {

    var tableView:UITableView!
    var dataArray = []
    var searchDidSelectClouse:SearchDidSelectClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.separatorStyle = .None
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        self.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GlobalSearchTableView : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.searchDidSelectClouse != nil {
            self.searchDidSelectClouse(indexPath:indexPath)
        }
    }
}
extension GlobalSearchTableView : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecommendTableViewCell", forIndexPath: indexPath) as! RecommendTableViewCell
        cell.selectionStyle = .None
        return cell
    }
}

extension GlobalSearchTableView : DZNEmptyDataSetDelegate {
}

extension GlobalSearchTableView :DZNEmptyDataSetSource {
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "搜索你关注的演出"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: APP_State_EmptyData_Color)], range: NSRange(location: 0, length: str.length))
        attribute.addAttributes([NSFontAttributeName:APP_State_EmptyData_Font!], range: NSRange.init(location: 0, length: str.length))
        return attribute
    }
    
    func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
        return CGPointMake(0, 64)
    }
    
    func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return -130
    }
    
    func spaceHeightForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 30
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "Icon_Search_Default")
    }
}

