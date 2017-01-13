
//
//  NotificationViewController.swift
//  LiangPiao
//
//  Created by Zhang on 07/01/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import WebKit

class NotificationViewController: UIViewController {

    var webView:WKWebView!
    var url:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItemBack()
        self.view.backgroundColor = UIColor.whiteColor()
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
        webView.navigationDelegate = self
        webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: url)!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NotificationViewController : WKNavigationDelegate {
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        Tools.shareInstance.showMessage(KWINDOWDS(), msg: "加载失败", autoHidder: true)
    }
}
