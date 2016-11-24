//
//  Tools.swift
//  LiangPiao
//
//  Created by Zhang on 23/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MBProgressHUD

let CustomViewWidth:CGFloat = 190
let CustomViewFont = IPHONE_VERSION > 9 ? UIFont.systemFontOfSize(14.0):UIFont.init(name: ".HelveticaNeueInterface-Regular", size: 14.0)
let TextLabelMarger:CGFloat = 20

class HUDCustomView: UIView {
    class func customViewWidthMessage(message:String) -> AnyObject {
        let customView =  UIView(frame: CGRect.init(x: CGFloat(UIScreen.mainScreen().bounds.size.width - CustomViewWidth) / 2, y: (UIScreen.mainScreen().bounds.size.height - 60) / 2, width: CustomViewWidth, height: 60))
        let messageHeight = message.heightWithConstrainedWidth(message, font: CustomViewFont!, width: CustomViewWidth - TextLabelMarger * 2)
        var frame = customView.frame
        if messageHeight > 60 {
            frame.size.height = messageHeight
            frame.origin.y = (UIScreen.mainScreen().bounds.size.height - messageHeight) / 2
        }else{
            frame.size.height = 60;
        }
        customView.frame = frame;
        customView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        customView.addSubview(HUDCustomView.setUpLabel(frame, text: message))
        return customView;
    }
    
    class func setUpLabel(frame:CGRect, text:String) -> UILabel{
        let textLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: CustomViewWidth - TextLabelMarger * 2, height: frame.size.height))
        textLabel.font = CustomViewFont
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.whiteColor()
        textLabel.text = text
        textLabel.textAlignment = .Center
        return textLabel;
    }
}

class Tools: NSObject {

    
    override init() {
        
    }
    
    static let shareInstance = Tools()
    
    func showMessage(view:UIView, msg:String, autoHidder:Bool) -> MBProgressHUD {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = .Text
        hud.bezelView.backgroundColor = UIColor.init(hexString: App_Theme_Text_Color, andAlpha: 0.7)
        hud.label.text = msg
        hud.label.textColor = UIColor.whiteColor()
        hud.hideAnimated(true, afterDelay: 2.0)
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        return hud
    }
    
    func showErrorMessage(errorDic:AnyObject) ->MBProgressHUD {
        let errorModel = ErrorModel.init(fromDictionary: errorDic as! NSDictionary)
        var errorMsg:String = ""
        for i in 0...errorModel.errors.count - 1 {
            let error = errorModel.errors[i]
            print("errorType = \(error.type)--->ErrorString=\(error.error[0])")
            errorMsg =  error.error[0]
        }
        return self.showMessage(KWINDOWDS!, msg:errorMsg , autoHidder: true)
    }
    
    func showNetWorkError(error:AnyObject) ->MBProgressHUD {
        let netWorkError = (error as! NSError)
        print(netWorkError)
        return self.showMessage(KWINDOWDS!, msg:netWorkError.localizedDescription , autoHidder: true)
    }
}
