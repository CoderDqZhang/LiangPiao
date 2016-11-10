//
//  HomeToolsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let imageSizeWidth:CGFloat = 43
let imageSizeHeight:CGFloat = 43

typealias HomePageCenterClouse = (index:NSInteger) ->Void

class HomePageCenter: UIView {
    
    var homePageCenterClouse:HomePageCenterClouse!
    
    init(frame:CGRect,titleArray:[HomeCenterModel]) {
        super.init(frame: frame)
        var originX:CGFloat = 0
        let originY:CGFloat = 0
        
        for i in 0...titleArray.count - 1 {
            let imageView = UIImageView()
            imageView.image = titleArray[i].image
            imageView.tag = i
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 21
            imageView.frame = CGRectMake(originX + 4, originY, imageSizeWidth, imageSizeHeight)
            imageView.userInteractionEnabled = true
            
            let titleLabel = UILabel(frame: CGRectMake(originX, CGRectGetMaxY(imageView.frame) + 8, 50, 17))
            titleLabel.text = titleArray[i].title
            titleLabel.textAlignment = .Center
            titleLabel.font = Home_Ticket_Tools_Font
            titleLabel.textColor = UIColor.init(hexString: Home_Ticket_Tools_Color)
            self.addSubview(titleLabel)
            
            originX = CGRectGetMaxX(titleLabel.frame) + (SCREENWIDTH - 30 - 250)/4
//            if i == 3 {
//                originY = CGRectGetMaxY(imageView.frame) + 30
//                originX = 0
//            }
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
    let imageArray = ["Icon_Live","Icon_Concert","Icon_Opera","Icon_Sport","Icon_All"]
    let titles = ["演唱会","音乐会","话剧歌剧","体育赛事","全部"]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        var homeModel:[HomeCenterModel] = []
        
        for i in 0...4 {
            let model = HomeCenterModel()
            model.image = UIImage.init(named: imageArray[i])
            model.title = titles[i]
            homeModel.append(model)
        }
        let centerView = HomePageCenter(frame: CGRectMake(15, 19, SCREENWIDTH - 30, 68), titleArray: homeModel)
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
