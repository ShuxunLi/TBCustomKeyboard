//
//  TBKeyboard.swift
//  TestSwift
//
//  Created by 聚财道 on 2018/7/20case
//  Copyright © 2018年 聚财道case  All rights reserved.
//

import Foundation


public enum TBKeyButtonType: Int {
    case del = 1       // 删除
    case done = 2      // 下单
    case hide          // 隐藏键盘
    case point         // 点
    case add100
    case add200
    case add500
    case add1000
    case add5000
    case other
}

public  enum  TBKeyboardType: Int {
    case  price                    // 委托价格
    case  sharesNumber             // 全部
}

protocol TBKeyboardDelegate: NSObjectProtocol {
     func postValueToViewController(_ type: TBKeyButtonType, _ str: String)
}


