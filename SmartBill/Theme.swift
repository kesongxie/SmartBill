//
//  Theme.swift
//  SmartBill
//
//  Created by Xie kesong on 12/1/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit
struct Theme{
    let billBackgroundImageUrl: String
    let sliderBackgroundImageUrl: String
    let mainViewBackgroundColor: UIColor
    let sliderViewBackgroundColor: UIColor
    let splitPickerViewBackgroundColor: UIColor
    let splitPickerViewFontColor: UIColor
    let percentagePickerViewBackgroundColor: UIColor
    let percentagePickerViewFontColor: UIColor
    let subTotalAfterFontColor: UIColor
    let weekDayFontColor: UIColor
    let keyBoardApperance: UIKeyboardAppearance
    
    init(billBackgroundImageUrl: String, sliderBackgroundImageUrl: String, mainViewBackgroundColor: UIColor, sliderViewBackgroundColor: UIColor, splitPickerViewBackgroundColor: UIColor, splitPickerViewFontColor: UIColor, percentagePickerViewBackgroundColor: UIColor, percentagePickerViewFontColor: UIColor, subTotalAfterFontColor: UIColor, weekDayFontColor: UIColor, keyBoardApperance: UIKeyboardAppearance ){
        self.billBackgroundImageUrl = billBackgroundImageUrl
        self.sliderBackgroundImageUrl = sliderBackgroundImageUrl
        self.mainViewBackgroundColor = mainViewBackgroundColor
        self.sliderViewBackgroundColor = sliderViewBackgroundColor
        self.splitPickerViewBackgroundColor = splitPickerViewBackgroundColor
        self.percentagePickerViewBackgroundColor = percentagePickerViewBackgroundColor
        self.splitPickerViewFontColor = splitPickerViewFontColor
        self.percentagePickerViewFontColor = percentagePickerViewFontColor
        self.subTotalAfterFontColor = subTotalAfterFontColor
        self.weekDayFontColor = weekDayFontColor
        self.keyBoardApperance = keyBoardApperance
    }
}
