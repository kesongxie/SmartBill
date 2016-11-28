//
//  StyleConstant.swift
//  SmartBill
//
//  Created by Xie kesong on 11/25/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

struct StyleConstant{
    static let systemFontName = "Avenir"
    static let systemFontNameMeidum = "Avenir-Medium"
    static let systemFontNameBold = "Avenir-Heavy"

    struct NavigationBar{
        static let backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        static let titleTextAttribute = [NSForegroundColorAttributeName: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0), NSFontAttributeName: UIFont(name: systemFontNameBold, size: 17.0)! ]
    }
}
