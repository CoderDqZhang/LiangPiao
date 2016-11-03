//
//  HomeScrollerTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class HomeScrollerTableViewCell: UITableViewCell {

    var cycleScrollView:SDCycleScrollView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.setUpView()
    }
    
    func setUpView() {
        if cycleScrollView == nil {
            cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, SCREENWIDTH, 152), delegate: self, placeholderImage: UIImage.init(named: "Banner_Default_Cover"))
            cycleScrollView.pageDotColor = UIColor.whiteColor()
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            cycleScrollView.pageControlDotSize = CGSizeMake(6, 6)
            self.contentView.addSubview(cycleScrollView)
            //         --- 轮播时间间隔，默认1.0秒，可自定义
            cycleScrollView.autoScroll = true
            dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), { 
                self.cycleScrollView.imageURLStringsGroup = ["Banner_Default_Cover","Banner_Default_Cover","Banner_Default_Cover","Banner_Default_Cover","Banner_Default_Cover"]
            })
        }
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

extension HomeScrollerTableViewCell : SDCycleScrollViewDelegate {
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didScrollToIndex index: Int) {
        
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
    }
}
