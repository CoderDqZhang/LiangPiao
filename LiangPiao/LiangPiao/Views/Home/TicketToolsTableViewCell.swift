//
//  TicketToolsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift

typealias ToolViewSelectIndexPathRow = (_ indexPath:IndexPath, _ str:AnyObject) -> Void

class ToolView:UIView {
    
    var tableView:UITableView!
    var dataArray:NSArray!
    var toolViewSelectIndexPathRow:ToolViewSelectIndexPathRow!
    var singnalTap:UITapGestureRecognizer!
    
    init(frame: CGRect,data:NSArray) {
        super.init(frame: frame)
        let image = UIImage.init(color: UIColor.init(hexString: App_Theme_384249_Color, andAlpha: 0.6), size: frame.size)

        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(imageView)
        self.backgroundColor = UIColor.init(red: 56.0/255.0, green: 66.0/255.0, blue: 73.0/255.0, alpha: 0.9)
        
        dataArray = NSArray(array: data as [AnyObject], copyItems: true)
        
//        singnalTap = UITapGestureRecognizer(target: self, action: #selector(ToolView.viewSignalTap(_:)))
//        singnalTap.numberOfTapsRequired = 1
//        singnalTap.numberOfTouchesRequired = 1
//        self.addGestureRecognizer(singnalTap)
        
//        let effectView = UIVisualEffectView(effect: UIBlurEffect.init(style: .Light))
//        effectView.frame = self.frame
//        effectView.contentView.addSubview(imageView)
//        self.addSubview(effectView)
        
        
        self.setUpTableView()
        
    }
    
    func viewSignalTap(_ sender:UITapGestureRecognizer) {
        if toolViewSelectIndexPathRow != nil {
//            self.toolViewSelectIndexPathRow(indexPath:NSIndexPath(forRow: 0, inSection: 0), str: "")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableView(){
        tableView = UITableView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH, height: CGFloat(6 * 50)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
}

extension ToolView : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if toolViewSelectIndexPathRow != nil {
            if indexPath.row == 0 {
                self.toolViewSelectIndexPathRow(indexPath, "" as AnyObject)
            }else{
//                self.toolViewSelectIndexPathRow(indexPath, dataArray[indexPath.row - 1])
            }
        }
    }
}

extension ToolView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdenf = "ToolView"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdenf)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdenf)
        }
        let detailLabel = UILabel()
        if indexPath.row == 0 {
            detailLabel.text = "全部"
            detailLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        }else{
            detailLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
            detailLabel.text = "\(dataArray[indexPath.row - 1])"
        }
        detailLabel.font = App_Theme_PinFan_R_12_Font
        cell?.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo((cell?.contentView.snp.centerY)!).offset(0)
            make.left.equalTo((cell?.contentView.snp.left)!).offset(25)
        })
        cell?.selectionStyle = .none
        cell?.updateConstraintsIfNeeded()
        let lineLabel = GloabLineView(frame: CGRect(x: 15,y: 49.5,width: SCREENWIDTH - 30, height: 0.5))
        cell?.contentView.addSubview(lineLabel)
        return cell!
    }
}

enum TicketToolsViewType {
    case left
    case center
    case right
}
enum TicketSortType {
    case downType
    case upType
    case noneType
}

typealias TicketToolsClouse = (_ tag:NSInteger) -> Void
typealias TicketToolsSortClouse = (_ tag:NSInteger, _ type:TicketSortType) -> Void
class TicketToolsView: UIView {
    var toolsLabel:UILabel!
    var imageView:UIImageView!
    dynamic var isShow:Bool = false
    var ticketToolsClouse:TicketToolsClouse!
    var ticketToolsSortClouse:TicketToolsSortClouse!
    
    var racDisposable: Disposable!
    var ticketSortType:TicketSortType = .noneType
    
    fileprivate var myContext = 0

    init(frame:CGRect, title:String, image:UIImage?, type:TicketToolsViewType) {
        super.init(frame: frame)
        self.setUpView(frame, title:title, image:image, type:type)
        if type == .right {
            let single = UITapGestureRecognizer(target: self, action: #selector(TicketToolsView.pricePress(_:)))
            single.numberOfTapsRequired = 1
            single.numberOfTouchesRequired = 1
            self.addGestureRecognizer(single)
        }else if  type == .left {
            let single = UITapGestureRecognizer(target: self, action: #selector(TicketToolsView.singlePress(_:)))
            single.numberOfTapsRequired = 1
            single.numberOfTouchesRequired = 1
            self.addGestureRecognizer(single)
//            racDisposable = rac_observeKeyPath("isShow", options: .New, observer: self) { (object, objects, newValue, oldValue) in
//                self.startAnimation()
//            }
        }else{
            let single = UITapGestureRecognizer(target: self, action: #selector(TicketToolsView.singlePress(_:)))
            single.numberOfTapsRequired = 1
            single.numberOfTouchesRequired = 1
            self.addGestureRecognizer(single)
//            racDisposable = rac_observeKeyPath("isShow", options: .New, observer: self) { (object, objects, newValue, oldValue) in
//            }
        }

    }
    deinit {
        racDisposable = nil
    }
    
    func singlePress(_ sender:UITapGestureRecognizer) {
        if (ticketToolsClouse != nil) {
            self.ticketToolsClouse((sender.view?.tag)!)
        }
    }
    
    func pricePress(_ sender:UITapGestureRecognizer) {
        if (ticketToolsSortClouse != nil) {
            if self.ticketSortType == .noneType || self.ticketSortType == .upType {
                self.imageView.image = UIImage.init(named: "Icon_Ranking_03")
                self.ticketSortType = .downType
            }else{
                self.imageView.image = UIImage.init(named: "Icon_Ranking_02")
                self.ticketSortType = .upType
            }
            self.ticketToolsSortClouse((sender.view?.tag)!, self.ticketSortType)
        }
    }
    
    
    func setUpView(_ frame:CGRect, title:String, image:UIImage?, type:TicketToolsViewType) {
        toolsLabel = UILabel()
        toolsLabel.text = title
        toolsLabel.isUserInteractionEnabled = true
        toolsLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        toolsLabel.font = App_Theme_PinFan_R_12_Font
        self.addSubview(toolsLabel)
        
        if image != nil {
            imageView = UIImageView()
            imageView.image = image
            imageView.isUserInteractionEnabled = true
            self.addSubview(imageView)
        }
    
        switch type {
        case .left:
            self.tag = 1
            toolsLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.left.equalTo(self.snp.left).offset(10)
            })
            imageView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY).offset(1)
                make.left.equalTo(self.toolsLabel.snp.right).offset(12)
            })
        case .center:
            self.tag = 2
            self.layer.borderColor = UIColor.init(hexString: App_Theme_E9EBF2_Color).cgColor
            self.layer.borderWidth = 0.5
            toolsLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.centerX.equalTo(self.snp.centerX).offset(0)
            })
        default:
            self.tag = 3
            imageView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.right.equalTo(self.snp.right).offset(0)
            })
            toolsLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.right.equalTo(self.imageView.snp.left).offset(-12)
            })
        }
    }
    
    func startAnimation() {
        //创建旋转动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //旋转角度
        anim.toValue = 1 * Double.pi
        //旋转指定角度需要的时间
        anim.duration = 1
        //旋转重复次数
        anim.repeatCount = MAXFLOAT
        //动画执行完后不移除
        anim.isRemovedOnCompletion = true
        //将动画添加到视图的laye上
        imageView.layer.add(anim, forKey: nil)
        //取消动画
        imageView.layer.removeAllAnimations()
        //这个是旋转方向的动画
        UIView.animate(withDuration: AnimationTime, animations: { () -> Void in
            //指定旋转角度是180°
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(Double.pi))
        }) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let TicketToolsViewWidth = (SCREENWIDTH - 30)/3
typealias TicketCellClouse = (_ tag:NSInteger) ->Void
typealias TicketCellSortClouse = (_ tag:NSInteger, _ type:TicketSortType) ->Void

class TicketToolsTableViewCell: UITableViewCell {

    var nomalPriceTick:TicketToolsView!
    var rowTicket:TicketToolsView!
    var sortPriceTick:TicketToolsView!
    var didMakeContraints:Bool = false
    var toolsView: UIView!
    
    var lineLabel:GloabLineView!

    var toplineLabel:GloabLineView!
    
    var ticketCellClouse:TicketCellClouse!
    var ticketCellSortClouse:TicketCellSortClouse!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        toolsView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 42))
        self.contentView.addSubview(toolsView)
        
        nomalPriceTick = TicketToolsView(frame: CGRect(x: 15, y: 0, width: TicketToolsViewWidth, height: 42), title: "票面原价", image: UIImage.init(named: "Icon_Selected_Form_Normal")!, type: .left)
        nomalPriceTick.ticketToolsClouse = { tag in
            if self.nomalPriceTick.isShow {
                self.nomalPriceTick.isShow = false
            }else{
                self.nomalPriceTick.isShow = true
            }
            if self.rowTicket.isShow {
                self.rowTicket.isShow = false
            }
            if self.sortPriceTick.isShow {
                self.sortPriceTick.isShow = false
            }
            if self.ticketCellClouse != nil {
                self.ticketCellClouse(tag)
            }
        }
        toolsView.addSubview(nomalPriceTick)
        
        rowTicket = TicketToolsView(frame: CGRect(x: TicketToolsViewWidth + 15, y: 0, width: TicketToolsViewWidth, height: 42), title: "座位", image: nil, type: .center)
        rowTicket.ticketToolsClouse = { tag in
            if self.rowTicket.isShow {
                self.rowTicket.isShow = false
            }else{
                self.rowTicket.isShow = true
            }
            if self.nomalPriceTick.isShow {
                self.nomalPriceTick.isShow = false
            }
            if self.sortPriceTick.isShow {
                self.sortPriceTick.isShow = false
            }
        
            if self.ticketCellClouse != nil {
                self.ticketCellClouse(tag)
            }
        }
        toolsView.addSubview(rowTicket)
        
        sortPriceTick = TicketToolsView(frame: CGRect(x: TicketToolsViewWidth * 2 + 15, y: 0, width: TicketToolsViewWidth, height: 42), title: "售价", image: UIImage.init(named: "Icon_Ranking")!, type: .right)
        sortPriceTick.ticketToolsSortClouse = { tag, type in
            if self.sortPriceTick.isShow {
                self.sortPriceTick.isShow = false
            }else{
                self.sortPriceTick.isShow = true
            }
            if self.rowTicket.isShow {
                self.rowTicket.isShow = false
            }
            if self.sortPriceTick.isShow {
                self.sortPriceTick.isShow = false
            }
            if self.ticketCellSortClouse != nil {
                self.ticketCellSortClouse(tag,type)
            }
        }
        toolsView.addSubview(sortPriceTick)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 41.5, width: SCREENWIDTH - 30, height: 0.5))
        toolsView.addSubview(lineLabel)
        
//        let signal = NotificationCenter.default.rac_addObserverForName(ToolViewNotifacationName, object: nil)
//        signal.observe { (object) in
//            let str = object.object as! String
//            switch str {
//                case "100":
//                    self.nomalPriceTick.isShow = false
//                case "200":
//                    self.rowTicket.isShow = false
//                default :
//                    self.sortPriceTick.isShow = false
//            }
//        }
        
        self.updateConstraintsIfNeeded()
        
        toplineLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(toplineLabel)
    }
    
    func setUpDescriptionView() -> UIView {
        
        let toolsView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 42))
        let nomalPriceTick = TicketToolsView(frame: CGRect(x: 15, y: 0, width: TicketToolsViewWidth, height: 41), title: "票面价格", image: UIImage.init(named: "Icon_Selected_Form_Normal")!, type: .left)
        let rowTicket = TicketToolsView(frame: CGRect(x: TicketToolsViewWidth + 15, y: 1, width: TicketToolsViewWidth, height: 41), title: "座位", image: UIImage.init(named: "Icon_Selected_Form_Normal")!, type: .center)
        let sortPriceTick = TicketToolsView(frame: CGRect(x: TicketToolsViewWidth * 2 + 15, y: 0, width: TicketToolsViewWidth, height: 41), title: "价格", image: UIImage.init(named: "Icon_Ranking")!, type: .right)
        nomalPriceTick.ticketToolsClouse = { tag in
            if nomalPriceTick.isShow {
                nomalPriceTick.isShow = false
            }else{
                nomalPriceTick.isShow = true
            }
            if rowTicket.isShow {
                rowTicket.isShow = false
            }
            if sortPriceTick.isShow {
                sortPriceTick.isShow = false
            }
            if self.ticketCellClouse != nil {
                self.ticketCellClouse(tag)
            }
        }
        toolsView.addSubview(nomalPriceTick)
        
        
        rowTicket.ticketToolsClouse = { tag in
            if rowTicket.isShow {
                rowTicket.isShow = false
            }else{
                rowTicket.isShow = true
            }
            if nomalPriceTick.isShow {
                nomalPriceTick.isShow = false
            }
            if sortPriceTick.isShow {
                sortPriceTick.isShow = false
            }
            
            if self.ticketCellClouse != nil {
                self.ticketCellClouse(tag)
            }
        }
        toolsView.addSubview(rowTicket)
        
        
        sortPriceTick.ticketToolsSortClouse = { tag, type in
            if sortPriceTick.isShow {
                sortPriceTick.isShow = false
            }else{
                sortPriceTick.isShow = true
            }
            if rowTicket.isShow {
                rowTicket.isShow = false
            }
            if sortPriceTick.isShow {
                sortPriceTick.isShow = false
            }
            if self.ticketCellSortClouse != nil {
                self.ticketCellSortClouse(tag,type)
            }
        }
        toolsView.addSubview(sortPriceTick)
        
        
        let lineLabel = GloabLineView(frame: CGRect(x: 15, y: 41.5, width: SCREENWIDTH - 30, height: 0.5))
        toolsView.addSubview(lineLabel)
        
//        let signal = NotificationCenter.default.rac_addObserverForName(ToolViewNotifacationName, object: nil)
//        signal.observe { (object) in
//            let str = object.object as! String
//            switch str {
//            case "100":
//                self.nomalPriceTick.isShow = false
//            case "200":
//                self.rowTicket.isShow = false
//            default :
//                self.sortPriceTick.isShow = false
//            }
//        }
        
        let toplineLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(toplineLabel)
        
        return toolsView
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ToolViewNotifacationName), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            self.didMakeContraints = true
        }
        super.updateConstraints()
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
