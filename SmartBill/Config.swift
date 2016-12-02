//
//  Config.swift
//  SmartBill
//
//  Created by Xie kesong on 11/27/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

let AppName = "SMART BILL"
let MaxSplitCount = 8
// 10 minutes for the state to be restorable
let ExpireDuration = 10.0
let BillAmountInfoDateKey = "BillAmountInfoDate"
let BillAmountInfoAmountKey = "billAmountInfoAmount"

let nightTheme = Theme(
    billBackgroundImageUrl: StyleConstant.NightTheme.billBackgroundImageUrl,
    sliderBackgroundImageUrl: StyleConstant.NightTheme.sliderBackgroundImageUrl,
    mainViewBackgroundColor: StyleConstant.NightTheme.mainViewBackgroundColor,
    sliderViewBackgroundColor: StyleConstant.NightTheme.sliderViewBackgroundColor,
    splitPickerViewBackgroundColor: StyleConstant.NightTheme.splitPickerViewBackgroundColor,
    splitPickerViewFontColor: StyleConstant.NightTheme.splitPickerViewFontColor,
    percentagePickerViewBackgroundColor: StyleConstant.NightTheme.percentagePickerViewBackgroundColor,
    percentagePickerViewFontColor: StyleConstant.NightTheme.percentagePickerViewFontColor,
    subTotalAfterFontColor: StyleConstant.NightTheme.subTotalAfterFontColor,
    weekDayFontColor: StyleConstant.NightTheme.weekDayFontColor,
    keyBoardApperance: StyleConstant.NightTheme.keyBoardApperance
)

let dayTheme = Theme(
    billBackgroundImageUrl: StyleConstant.DayTheme.billBackgroundImageUrl,
    sliderBackgroundImageUrl: StyleConstant.DayTheme.sliderBackgroundImageUrl,
    mainViewBackgroundColor: StyleConstant.DayTheme.mainViewBackgroundColor,
    sliderViewBackgroundColor: StyleConstant.DayTheme.sliderViewBackgroundColor,
    splitPickerViewBackgroundColor: StyleConstant.DayTheme.splitPickerViewBackgroundColor,
    splitPickerViewFontColor: StyleConstant.DayTheme.splitPickerViewFontColor,
    percentagePickerViewBackgroundColor: StyleConstant.DayTheme.percentagePickerViewBackgroundColor,
    percentagePickerViewFontColor: StyleConstant.DayTheme.percentagePickerViewFontColor,
    subTotalAfterFontColor: StyleConstant.DayTheme.subTotalAfterFontColor,
    weekDayFontColor: StyleConstant.DayTheme.weekDayFontColor,
    keyBoardApperance: StyleConstant.DayTheme.keyBoardApperance
)

enum ThemeState: Int{
    case night = 0, day
}
