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
        static let translucent = false
    }
    
    struct NightTheme{
        static let billBackgroundImageUrl = "night-theme"
        static let sliderBackgroundImageUrl = "night-slider"
        static let mainViewBackgroundColor = UIColor.black
        static let sliderViewBackgroundColor = UIColor.black
        static let splitPickerViewBackgroundColor = UIColor.black
        static let percentagePickerViewBackgroundColor = UIColor.black
        static let splitPickerViewFontColor = UIColor.white
        static let percentagePickerViewFontColor = UIColor.white
        static let subTotalAfterFontColor = UIColor.white
        static let weekDayFontColor = UIColor.white
        static let keyBoardApperance = UIKeyboardAppearance.dark
    }
    
    struct DayTheme{
        static let billBackgroundImageUrl = "day-theme"
        static let sliderBackgroundImageUrl = "day-slider"
        static let mainViewBackgroundColor = UIColor.white
        static let sliderViewBackgroundColor = UIColor.white
        static let splitPickerViewBackgroundColor = UIColor.white
        static let percentagePickerViewBackgroundColor = UIColor.white
        static let splitPickerViewFontColor = UIColor.black
        static let percentagePickerViewFontColor = UIColor.black
        static let subTotalAfterFontColor = UIColor.black
        static let weekDayFontColor = UIColor.white
        static let keyBoardApperance = UIKeyboardAppearance.light
    }
}
