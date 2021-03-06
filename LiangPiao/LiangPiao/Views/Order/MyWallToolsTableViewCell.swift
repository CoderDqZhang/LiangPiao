
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
        self.contentView.backgroundColor = UIColor.white
        self.setUpView()
    }
    
    func setUpView() {
        let titles = ["可用余额 (元)","押金余额 (元)","待结算票款 (元)"]
        let details = ["0.00","0.00","0.00"]

        var originX:CGFloat = 0
        
        for index in 0...2 {
            let toolsView = self.createToolsView(CGRect.init(x: originX, y: 0, width: ToolsViewWidth, height: ToolsViewHeight), title: titles[index], detail: details[index], tag: index)
            originX = toolsView.frame.maxX
            if index != 2 {
                let lineLabel = GloabLineView.init(frame: CGRect.init(x: originX, y: 16, width: 0.5, height: ToolsViewHeight - 32))
                self.contentView.addSubview(lineLabel)
            }
            self.contentView.addSubview(toolsView)
        }
        let lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: ToolsViewHeight - 0.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(_ blance:String, freeze:String, preString:String) {
        let blanceLabel = self.contentView.viewWithTag(0)?.viewWithTag(10) as! UILabel
        blanceLabel.text = blance
        
        let freezeLabel = self.contentView.viewWithTag(1)?.viewWithTag(11) as! UILabel
        freezeLabel.text = freeze
        
        let preLabel = self.contentView.viewWithTag(2)?.viewWithTag(12) as! UILabel
        preLabel.text = preString
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
    
    func createToolsView(_ frame:CGRect, title:String, detail:String, tag:NSInteger) ->UIView{
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
        detailLabel.tag = tag + 10
        view.addSubview(detailLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(view.snp.top).offset(23)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
