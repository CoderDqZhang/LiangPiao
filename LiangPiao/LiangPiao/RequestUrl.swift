//
//  RequestUrl.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation

//https://itunes.apple.com/us/app/liang-piao-da-mai-yong-le/id1170039060?mt=8

let BaseStr = "liangpiao.me/"
//let BaseStr = "niceticket.cc/"
let BaseURL = "http://api.\(BaseStr)"


let LoginUrl = "\(BaseURL)user/login/"
let LoginCode = "\(BaseURL)user/login_code/"
let UserAvatar = "\(BaseURL)user/avatar/"
let UserInfoChange = "\(BaseURL)user/"

let AddAddress = "\(BaseURL)user/address/"
let EditAddress = "\(BaseURL)user/address/"

//演出分类 api
let TicketCategory = "\(BaseURL)show/category/"
let TickeHot = "\(BaseURL)show/hot/"

let TickeCategoty = "\(BaseURL)show/category/"
let TickeCategotyList = "\(BaseURL)show/list/"

let TickeSession = "\(BaseURL)show/"

let TickeDescription = "\(BaseURL)show/"
//http://api.liangpiao.me/show/3535216735/session/3535216726/
let OrderPayInfo = "\(BaseURL)order/pay_info/"
let OrderCreate = "\(BaseURL)order/create/"
let OrderListUrl = "\(BaseURL)order/list/"
let OrderChangeShatus = "\(BaseURL)order/"
let TicketSearchUrl = "\(BaseURL)show/search/"
//http://api.liangpiao.me?kw=%E7%BE%BD%E6%B3%89
let TicketFavorite = "\(BaseURL)user/favorite/"
let SupplierOrderList = "\(BaseURL)supplier/order/"
let SupplierTicketList = "\(BaseURL)supplier/ticket/"
let WallBlance = "\(BaseURL)account/"
let WallHistory = "\(BaseURL)account/history/"
let WallWithDraw = "\(BaseURL)account/withdraw/"
let SellTicket = "\(BaseURL)supplier/show/"
let SellTicketStatus = "\(BaseURL)supplier/ticket/"
let HotSellURl = "\(BaseURL)show/hot_sell/"
//待完善当个场次
let OneShowTicketUrl = "\(BaseURL)supplier/show/"

let ShareUrl = "http://www.\(BaseStr)show/"
let UserProtocol = "http://www.\(BaseStr)protocol/"
