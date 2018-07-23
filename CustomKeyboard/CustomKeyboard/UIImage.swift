//
//  UIImage.swift
//  TestSwift
//
//  Created by 聚财道 on 2018/7/20.
//  Copyright © 2018年 聚财道. All rights reserved.
//

import UIKit

extension UIImage{
    open class func createImage(with color: UIColor) -> UIImage?{
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
}

