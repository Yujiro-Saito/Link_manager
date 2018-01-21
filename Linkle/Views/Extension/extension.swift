//
//  extension.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2018/01/21.
//  Copyright © 2018年 yujiro_saito. All rights reserved.
//

import UIKit

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
