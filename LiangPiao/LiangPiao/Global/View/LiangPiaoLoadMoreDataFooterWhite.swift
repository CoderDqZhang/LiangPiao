//
//  LiangPiaoLoadMoreDataFooterWhite.swift
//  LiangPiao
//
//  Created by Zhang on 02/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class LiangPiaoLoadMoreDataFooterWhite: LiangPiaoLoadMoreDataFooter {

    override func placeSubviews() {
        super.placeSubviews()
        self.backgroundColor = UIColor.white
        self.imageView.frame = CGRect.init(x: self.center.x - 14, y: 30, width: 28, height: 28)
        self.loadImageView.frame = CGRect.init(x: self.center.x - 14, y: 30, width: 28, height: 28)
        loadImageView.image = UIImage.init(named: "刷新动画圆点1")
    }
}
