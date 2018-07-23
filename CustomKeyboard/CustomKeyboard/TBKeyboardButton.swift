//
//  TBKeyboardButton.swift
//  TestSwift
//
//  Created by 聚财道 on 2018/7/20.
//  Copyright © 2018年 聚财道. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class TBKeyboardButton: UIButton {
    
    typealias blockClosure = (TBKeyButtonType, String) ->Void
    var clickedButtonClosure: blockClosure?
    
    let buttonFont = UIFont.systemFont(ofSize: 15)
    let titleColor = UIColor("#333333")
    
    var type: TBKeyButtonType = .other
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension TBKeyboardButton{
    func configuration(){
        backgroundColor = .white
        self.setTitleColor(titleColor, for: .normal)
        self.setBackgroundImage(UIImage.createImage(with: UIColor("#dfdfdf")), for: .highlighted)
        self.addTarget(self, action: #selector(keyClicked(_:)), for: .touchUpInside)
    }
    @objc private func  keyClicked(_ sender: TBKeyboardButton){
        var contentText = ""
        if sender.type == .other{
            guard let str = sender.titleLabel?.text else {
                fatalError("keyboard other error")
            }
            contentText = str
        }
        self.clickedButtonClosure!(sender.type, contentText)
    }
}
