//
//  RequestUrl.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation

//https://itunes.apple.com/us/app/liang-piao-da-mai-yong-le/id1170039060?mt=8

//测试服
let BaseStr = "liangpiao.me/"
//正式服
//let BaseStr = "niceticket.cc/"
let BaseURL = "https://api.\(BaseStr)"


//登录api
let LoginUrl = "\(BaseURL)user/login/"
//验证码
let LoginCode = "\(BaseURL)user/login_code/"
//用户头像
let UserAvatar = "\(BaseURL)user/avatar/"
//修改用户信息
let UserInfoChange = "\(BaseURL)user/"
//添加地址
let AddAddress = "\(BaseURL)user/address/"
//编辑地址
let EditAddress = "\(BaseURL)user/address/"

//演出分类 api
let TicketCategory = "\(BaseURL)show/category/"
//热门演出
let TickeHot = "\(BaseURL)show/hot/"

let TickeCategoty = "\(BaseURL)show/category/"
//分类列表
let TickeCategotyList = "\(BaseURL)show/list/"
//首页banner
let HomeBanner = "\(BaseURL)banner/"
//演出场次
let TickeSession = "\(BaseURL)show/"
//演出详细信息
let TickeDescription = "\(BaseURL)show/"
//http://api.liangpiao.me/show/3535216735/session/3535216726/
//订单付款信息
let OrderPayInfo = "\(BaseURL)order/pay_info/"
//创建订单
let OrderCreate = "\(BaseURL)order/create/"
//订单列表
let OrderListUrl = "\(BaseURL)order/list/"
//修改订单状态
let OrderChangeShatus = "\(BaseURL)order/"
//搜索
let TicketSearchUrl = "\(BaseURL)show/search/"
//http://api.liangpiao.me?kw=%E7%BE%BD%E6%B3%89

//挂票区域
let TicketSellRegion = "\(BaseURL)supplier/ticket/"

//收藏
let TicketFavorite = "\(BaseURL)user/favorite/"
//卖家订单列表
let SupplierOrderList = "\(BaseURL)supplier/order/"
//卖家挂票列表
let SupplierTicketList = "\(BaseURL)supplier/ticket/"
//提现余额
let WallBlance = "\(BaseURL)account/"
//提现详情
let WallHistory = "\(BaseURL)account/history/"
//提现
let WallWithDraw = "\(BaseURL)account/withdraw/"
//卖家卖票
let SellTicket = "\(BaseURL)supplier/show/"
//卖票状态
let SellTicketStatus = "\(BaseURL)supplier/ticket/"
//热门卖票
let HotSellURl = "\(BaseURL)show/hot_sell/"
//搜索卖票
let SearchSellURl = "\(BaseURL)/show/search/sell/"
//待完善当个场次
let OneShowTicketUrl = "\(BaseURL)supplier/show/"
//订单快递信息
let OrderExpress = "\(BaseURL)supplier/order"
//分享
let ShareUrl = "http://www.\(BaseStr)show/"
let UserProtocol = "http://www.\(BaseStr)protocol/"

//充值
let TopUpUrl = "\(BaseURL)account/recharge/"

//TEST
let ExpressDeliveryUrl = "http://testapi.kdniao.cc:8081/api/dist"

let ExpressOrderHandleUrl = "http://api.kdniao.cc/Ebusiness/EbusinessOrderHandle.aspx"
