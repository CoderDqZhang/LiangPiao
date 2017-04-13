//
//  ZDQFlowViewItem.swift
//  TestFlowView
//
//  Created by Zhang on 8/2/16.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum ZDQFlowViewItemType {
    case itemSelect
    case itemUnSelect
    case itemWaitSelect
    case itemCancel
    case itemNext
    case itemCancelDone
    case itemDone
}

class ZDQFlowViewItem: UIView {

    var titleLabel:UILabel!
    var imageView:UIImageView!
    var itemType:ZDQFlowViewItemType!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.frame = CGRect(x: 14, y: 0, width: 17, height: 17)
        self.addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_R_11_Font
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: -6, y: imageView.frame.maxY + 6, width: 57, height: 16)
        self.addSubview(titleLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ title:String, type:ZDQFlowViewItemType){
        itemType = type
        switch type {
        case .itemDone:
            imageView.image = UIImage.init(named: "Icon_Done")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        case .itemSelect:
            imageView.image = UIImage.init(named: "Icon_Done")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        case .itemUnSelect:
            imageView.image = UIImage.init(named: "Icon_Undone")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        case .itemWaitSelect:
            imageView.image = UIImage.init(named: "Icon_Undone")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        case .itemNext:
            imageView.image = UIImage.init(named: "Icon_Undone")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        case .itemCancelDone:
            imageView.image = UIImage.init(named: "Icon_Undone")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        default:
            imageView.image = UIImage.init(named: "Icon_Undone")
            titleLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        }
        titleLabel.text = title
    }
}
