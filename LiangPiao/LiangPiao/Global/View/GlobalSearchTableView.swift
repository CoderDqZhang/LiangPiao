//
//  GlobalSearchTableView.swift
//  LiangPiao
//
//  Created by Zhang on 11/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
typealias SearchDidSelectClouse = (_ indexPath:IndexPath) ->Void
class GlobalSearchTableView: UIView {

    var tableView:UITableView!
    var searchDidSelectClouse:SearchDidSelectClouse!
    var viewModel = SearchViewModel.shareInstance
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        
    }
    
    func setUpView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
        tableView.register(SellRecommondTableViewCell.self, forCellReuseIdentifier: "SellRecommondTableViewCell")
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: "SearchHistoryTableViewCell")

        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
         self.bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(){
        viewModel.tableView = self.tableView
        viewModel.gloableTable = self
    }
}
extension GlobalSearchTableView : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.searchTableNumberOfSectionsInTableView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.searchTableTableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        return viewModel.searchTablaTableViewDidSelectRowAtIndexPath(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.searchTablaTableViewHeightForHeaderInSection(section)
    }
}
extension GlobalSearchTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchTableNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searchType == .ticketShowModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as! RecommendTableViewCell
            viewModel.searchTableCellData(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }else if viewModel.searchType == .ticketSell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SellRecommondTableViewCell", for: indexPath) as! SellRecommondTableViewCell
            viewModel.searchTableCellDatas(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
            viewModel.searchHistoryCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension GlobalSearchTableView : DZNEmptyDataSetDelegate {

}

extension GlobalSearchTableView :DZNEmptyDataSetSource {
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor {
        return UIColor.init(hexString: App_Theme_F6F7FA_Color)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = viewModel.emptyPlachTextTitle()
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)], range: NSRange(location: 0, length: str.length))
        attribute.addAttributes([NSFontAttributeName:App_Theme_PinFan_R_16_Font!], range: NSRange.init(location: 0, length: str.length))
        return attribute
    }
    
    func offset(forEmptyDataSet scrollView: UIScrollView!) -> CGPoint {
        return CGPoint(x: 0, y: 64)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -130
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 30
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "Icon_Search_Empty")
    }
}

