//
//  TBKeyboardPriceView.swift
//  TestSwift
//
//  Created by 聚财道 on 2018/7/20.
//  Copyright © 2018年 聚财道. All rights reserved.
//

import UIKit

class TBKeyboardPriceView: UIView {
    /*
     0,   1,   2,   del
     3,   4,   5,
     6,   7,   8,   done
     .,  10,hide,
     */
    
    weak var delegate: TBKeyboardDelegate?
    
    let row = 4
    let column = 4
    
    let kTBKeyboardPriceKeyCount =    14
    let kTBKeyboardPricePointIndex =  9
    let kTBKeyboardPriceHideIndex =   11
    let kTBKeyboardPriceDelIndex =    12
    let kTBKeyboardPriceDoneIndex =   13
    
    lazy var buttonArray = [UIButton]()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension TBKeyboardPriceView {
    
    func configuration(frame: CGRect){
        var keyX: CGFloat = 0
        var keyY: CGFloat = 0
        let keyWidth:CGFloat = frame.size.width / CGFloat(column)
        let keyHeight:CGFloat = frame.size.height / CGFloat(row)
        for i in 0 ..< kTBKeyboardPriceKeyCount {
            // 控制位置
            if (i < 12 && i > 0) {
                if (i % (column - 1) == 0) {
                    keyX = 0
                    keyY = keyY + keyHeight
                }
            }else if(i > 11){
                keyX = 3 * keyWidth
                if (i == 12) {
                    keyY = 0
                }else{
                    keyY = 2 * keyHeight
                }
            }
            // 创建按钮
            let button = TBKeyboardButton(type: .custom)
            if (i < 12) { // 左三列
                button.frame = CGRect(x: keyX, y: keyY, width: keyWidth, height: keyHeight)
            }else{ // 最右一列
                button.frame = CGRect(x: keyX, y: keyY, width: keyWidth, height: 2 * keyHeight)
            }
            
            button.clickedButtonClosure = {
                (type: TBKeyButtonType, backStr: String) -> Void in
                self.delegate?.postValueToViewController(type, backStr)
            }
            self.addSubview(button)
            if (i == kTBKeyboardPricePointIndex) {
                button.type = .point
            } else if (i == kTBKeyboardPriceDelIndex) {
                button.type = .del
            } else if (i == kTBKeyboardPriceDoneIndex) {
                button.type = .done
                button.backgroundColor = UIColor("#FD9326")
                button.setTitleColor(UIColor.white, for: .normal)
            }else if (i == kTBKeyboardPriceHideIndex) {
                button.type = .hide
            }else{
                button.type = .other
            }
            keyX += keyWidth;
            buttonArray.append(button)
        }
        createSplitLine(frame: frame)
        assignValue()
    }
    
    private  func createSplitLine(frame: CGRect){
        var viewX:CGFloat = 0
        var viewY:CGFloat = 0
        let keyWidth:CGFloat = frame.size.width / CGFloat(column)
        let keyHeight:CGFloat = frame.size.height / CGFloat(row)
        
        var viewW:CGFloat = keyWidth * 3
        var viewH:CGFloat = 0.5
        
        // 左三排水平分隔线
        for _ in 0 ..< row + 1 {
            let view = UIView(frame: CGRect(x: viewX, y: viewY, width: viewW, height: viewH))
            view.backgroundColor = UIColor("#dfdfdf")
            self.addSubview(view)
            viewY = viewY + keyHeight
        }
        
        for i in 0 ..< 2 {
            let view = UIView(frame: CGRect(x: viewW, y: CGFloat(2 * i) * keyHeight, width: keyWidth, height: viewH))
            view.backgroundColor = UIColor("#dfdfdf")
            self.addSubview(view)
            viewY = viewY + keyHeight
        }
        
        // 垂直分隔线
        viewX = keyWidth
        viewY = 0
        viewW = 0.5
        viewH = frame.size.height
        
        for _ in 0 ..< column - 1 {
            let view = UIView(frame: CGRect(x: viewX, y: viewY, width: viewW, height: viewH))
            view.backgroundColor = UIColor("#dfdfdf")
            self.addSubview(view)
            viewX = viewX + keyWidth
        }
    }
    
    private func assignValue(){
        for i in 0 ..< buttonArray.count {
           let button = buttonArray[i]
            switch i {
            case 0 ..< 9:
                button.setTitle("\(i+1)", for: .normal)
            case 10:
                button.setTitle("0", for: .normal)
            case kTBKeyboardPricePointIndex:
                button.setTitle(".", for: .normal)
            case kTBKeyboardPriceDoneIndex:
                button.setTitle("下单", for: .normal)
            case kTBKeyboardPriceHideIndex:
                button.setImage(UIImage(named: "btn_keyborad_hide"), for: .normal)
            case kTBKeyboardPriceDelIndex:
                button.setImage(UIImage(named: "btn_keyborad_delete"), for: .normal)
            default:
                fatalError("button count Error")
            }
        }
    }
}
