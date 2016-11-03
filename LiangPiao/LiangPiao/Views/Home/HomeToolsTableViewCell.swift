//
//  HomeToolsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let imageSizeWidth:CGFloat = 50
let imageSizeHeight:CGFloat = 50

typealias HomePageCenterClouse = (index:NSInteger) ->Void

class HomePageCenter: UIView {
    
    var homePageCenterClouse:HomePageCenterClouse!
    
    init(frame:CGRect,titleArray:[HomeCenterModel]) {
        super.init(frame: frame)
        var originX:CGFloat = 0
        var originY:CGFloat = 0
        
        for i in 0...titleArray.count - 1 {
            let imageView = UIImageView()
            imageView.image = titleArray[i].image
            imageView.tag = i
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 25
            imageView.frame = CGRectMake(originX, originY, imageSizeWidth, imageSizeHeight)
            imageView.userInteractionEnabled = true
            originX = CGRectGetMaxX(imageView.frame) + 32
            if i == 3 {
                originY = CGRectGetMaxY(imageView.frame) + 30
                originX = 0
            }
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(HomePageCenter.singleTapPress(_:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(singleTap)
            self.addSubview(imageView)
        }
    }
    
    func singleTapPress(sender:UITapGestureRecognizer) {
        if homePageCenterClouse != nil {
            homePageCenterClouse(index: (sender.view?.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

typealias HomeToolsClouse = (index:NSInteger) -> Void
class HomeToolsTableViewCell: UITableViewCell {

    var homeToolsClouse:HomeToolsClouse!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        var homeModel:[HomeCenterModel] = []
        let model = HomeCenterModel()
        model.image = UIImage.init(color: UIColor.init(hexString: HomePage_Brand_ImageColor), size: CGSizeMake(50, 50))
        model.title = nil
        for _ in 0...7 {
            homeModel.append(model)
        }
        let centerView = HomePageCenter(frame: CGRectMake(40, 40, SCREENWIDTH - 56, 130), titleArray: homeModel)
        centerView.homePageCenterClouse = { index in
            if self.homeToolsClouse != nil {
                self.homeToolsClouse(index:index)
            }
        }
        self.addSubview(centerView)
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
