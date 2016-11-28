//
//  DateExtension.swift
//  SmartBill
//
//  Created by Xie kesong on 11/27/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import Foundation

extension Date{
    var weekDayString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    var monthString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self).capitalized
    }
    
    var dayString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self).capitalized
    }

    
    
}
