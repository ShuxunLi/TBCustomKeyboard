//
//  TBkeyboardAmountView.swift
//  TestSwift
//
//  Created by 聚财道 on 2018/7/23.
//  Copyright © 2018年 聚财道. All rights reserved.
//

import UIKit

class TBkeyboardAmountView: UIView {
    /*
     {
     +100,    +200,   +500,  +1000,     del,
     1(4),    2(5),   3(6),  +5000,
     4(8),    5(9),   6(10),  0(11),    done,
     7(12),   8(13),  9(14),   hide,
     }
     */
    
    weak var delegate: TBKeyboardDelegate?

    let row = 4
    let column = 5
    
    let kTBKeyboardPriceKeyCount   =    18
    let kTBKeyboardPriceKeyAdd100  =     0
    let kTBKeyboardPriceKeyAdd200  =     1
    let kTBKeyboardPriceKeyAdd500  =     2
    let kTBKeyboardPriceKeyAdd1000 =     3
    let kTBKeyboardPriceKeyAdd5000 =     7
    let kTBKeyboardPriceHideIndex  =    15
    let kTBKeyboardPriceDelIndex   =    16
    let kTBKeyboardPriceDoneIndex  =    17
    
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

extension TBkeyboardAmountView {
    
    func configuration(frame: CGRect){
        var keyX: CGFloat = 0
        var keyY: CGFloat = 0
        let keyWidth:CGFloat = frame.size.width / CGFloat(column)
        let keyHeight:CGFloat = frame.size.height / CGFloat(row)
        for i in 0 ..< kTBKeyboardPriceKeyCount {
            
            // 控制位置
            if (i < 16 && i > 0) {
                if (i % (column - 1) == 0) {
                    keyX = 0
                    keyY = keyY + keyHeight
                }
            }else if(i > 15){
                keyX = 4 * keyWidth
                if (i == 16) {
                    keyY = 0
                }else{
                    keyY = 2 * keyHeight
                }
            }
            // 创建按钮
            let button = TBKeyboardButton(type: .custom)
            if (i < 16) { // 左四列
                button.frame = CGRect(x: keyX, y: keyY, width: keyWidth, height: keyHeight)
            }else{ // 最右一列
                button.frame = CGRect(x: keyX, y: keyY, width: keyWidth, height: 2 * keyHeight)
            }
            button.clickedButtonClosure = {
                (type: TBKeyButtonType, backStr: String) -> Void in
                self.delegate?.postValueToViewController(type, backStr)
            }
            self.addSubview(button)
            
            if (i == kTBKeyboardPriceDelIndex) {
                button.type = .del
            } else if (i == kTBKeyboardPriceDoneIndex) {
                button.type = .done
                button.backgroundColor = UIColor("#FD9326")
                button.setTitleColor(UIColor.white, for: .normal)
            }else if (i == kTBKeyboardPriceHideIndex) {
                button.type = .hide
            }else if (i == kTBKeyboardPriceKeyAdd100) {
                button.type = .add100
            }else if (i == kTBKeyboardPriceKeyAdd200) {
                button.type = .add200
            }else if (i == kTBKeyboardPriceKeyAdd500) {
                button.type = .add500
            }else if (i == kTBKeyboardPriceKeyAdd1000) {
                button.type = .add1000
            }else if (i == kTBKeyboardPriceKeyAdd5000) {
                button.type = .add5000
            }else {
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
        
        var viewW:CGFloat = keyWidth * 4
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
        
        let keys = ["+100", "+200", "+500", "+1000", "+5000"]
        
        for i in 0 ..< buttonArray.count {
            let button = buttonArray[i]
            switch i {
            case 0 ..< 4:
                button.setTitle(keys[i], for: .normal)
            case 7:
                button.setTitle(keys[4], for: .normal)
            case 11:
                button.setTitle("0", for: .normal)
            case kTBKeyboardPriceDoneIndex:
                button.setTitle("下单", for: .normal)
            case kTBKeyboardPriceHideIndex:
                button.setImage(UIImage(named: "btn_keyborad_hide"), for: .normal)
            case kTBKeyboardPriceDelIndex:
                button.setImage(UIImage(named: "btn_keyborad_delete"), for: .normal)
            default:
                let remainder =  i % 4  // 1~9 公式为 (quotient - 1) * 3 + remainder + 1
                let quotient  =  i / 4  // 化简 3 * quotient + remainder -2
                button.setTitle("\(3 * quotient + remainder - 2)", for: .normal)
            }
        }
    }
}
