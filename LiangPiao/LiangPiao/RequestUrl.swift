//
//  RequestUrl.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation

let BaseURL = "http://api.liangpiao.me/"

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

let OrderCreate = "\(BaseURL)order/create/"
let OrderListUrl = "\(BaseURL)order/list/"

let TicketSearchUrl = "\(BaseURL)show/search/"
//http://api.liangpiao.me?kw=%E7%BE%BD%E6%B3%89

let TicketFavorite = "\(BaseURL)user/favorite/"
