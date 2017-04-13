//
//  HomeToolsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let imageSizeWidth:CGFloat = 34
let imageSizeHeight:CGFloat = 34

let margerSizeWidth:Int = Int(SCREENWIDTH - 44 - 250)/4

typealias HomePageCenterClouse = (_ index:NSInteger) ->Void

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
            imageView.frame = CGRect(x: originX + 8, y: originY, width: imageSizeWidth, height: imageSizeHeight)
            imageView.isUserInteractionEnabled = true
            
            let titleLabel = UILabel(frame: CGRect(x: originX, y: imageView.frame.maxY + 7, width: 50, height: 17))
            titleLabel.text = titleArray[i].title
            titleLabel.textAlignment = .center
            titleLabel.font = App_Theme_PinFan_R_12_Font
            titleLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
            self.addSubview(titleLabel)
            
            
            originX = titleLabel.frame.maxX + CGFloat(margerSizeWidth)
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(HomePageCenter.singleTapPress(_:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(singleTap)
            self.addSubview(imageView)
            
        }
    }
    
    func singleTapPress(_ sender:UITapGestureRecognizer) {
        if homePageCenterClouse != nil {
            homePageCenterClouse((sender.view?.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

typealias HomeToolsClouse = (_ index:NSInteger) -> Void

class HomeToolsTableViewCell: UITableViewCell {

    var homeToolsClouse:HomeToolsClouse!
    let imageArray = ["Icon_Live","Icon_Opera","Icon_Concert","Icon_Sport","Icon_All"]
    let titles = ["演唱会","话剧歌剧","音乐会","体育赛事","全部"]
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
        let centerView = HomePageCenter(frame: CGRect(x: 22, y: 23, width: SCREENWIDTH - 44, height: 68), titleArray: homeModel)
        centerView.homePageCenterClouse = { index in
            if self.homeToolsClouse != nil {
                self.homeToolsClouse(index)
            }
        }
        self.contentView.addSubview(centerView)
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
