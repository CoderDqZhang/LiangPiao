//
//  SearchHistoryTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/5/19.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

typealias SearchHistoryTableViewCellClouse = (_ tag:NSInteger, _ text:String) -> Void

class SearchHistoryTableViewCell: UITableViewCell {

    var searchTitle:UILabel!
    var closeBtn:UIButton!
    let detailImage = UIImageView()
    var lineLabel:GloabLineView!
    
    var searchHistoryTableViewCellClouse:SearchHistoryTableViewCellClouse!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        
        searchTitle = UILabel()
        searchTitle.text = "历史搜索"
        searchTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        searchTitle.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(searchTitle)
        
        detailImage.image = UIImage.init(named: "search_Icon_Info")
        self.contentView.addSubview(detailImage)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        
        closeBtn = UIButton.init(type: .custom)
        closeBtn.setImage(UIImage.init(named: "Btn_Close_Normal"), for: .normal)
        closeBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            if self.searchHistoryTableViewCellClouse != nil {
                self.searchHistoryTableViewCellClouse(self.closeBtn.tag, self.searchTitle.text!)
            }
        }
        self.contentView.addSubview(closeBtn)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ title:String, indexPath:IndexPath) {
        
        searchTitle.text = title
        closeBtn.tag = indexPath.row
        self.updateConstraintsIfNeeded()
    }
    
//    func updateCellButtonTag(_ tag: NSInteger) {
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            searchTitle.snp.makeConstraints({ (make) in
                make.left.equalTo(self.detailImage.snp.right).offset(10)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            detailImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 13, height: 13))
            })
            
            closeBtn.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-1)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 40, height: 40))

            })
            
            lineLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected( _ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
