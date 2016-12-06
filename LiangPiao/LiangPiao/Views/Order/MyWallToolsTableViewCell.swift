
//
//  MyWallToolsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let ToolsViewWidth:CGFloat = SCREENWIDTH / 3
let ToolsViewHeight:CGFloat = 80

class MyWallToolsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        let titles = ["可用余额 (元)","冻结余额 (元)","即将到账 (元)"]
        let details = ["600.00","50.20","00.00"]

        var originX:CGFloat = 0
        
        for index in 0...2 {
            let toolsView = self.createToolsView(CGRect.init(x: originX, y: 0, width: ToolsViewWidth, height: ToolsViewHeight), title: titles[index], detail: details[index], tag: index)
            originX = CGRectGetMaxX(toolsView.frame)
            if index != 2 {
                let lineLabel = GloabLineView.init(frame: CGRect.init(x: originX, y: 12, width: 0.5, height: ToolsViewHeight - 24))
                self.contentView.addSubview(lineLabel)
            }
            self.contentView.addSubview(toolsView)
        }
        let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: ToolsViewHeight - 0.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
    
    func createToolsView(frame:CGRect, title:String, detail:String, tag:NSInteger) ->UIView{
        let view = UIView(frame: frame)
        view.tag = tag
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        titleLabel.font = App_Theme_PinFan_R_12_Font
        view.addSubview(titleLabel)
        
        let detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        detailLabel.font = App_Theme_PinFan_R_14_Font
        view.addSubview(detailLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(20)
            make.top.equalTo(view.snp_top).offset(20)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(20)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
        }
        
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
