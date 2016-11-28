//
//  BarButtonItemExtension.swift
//  SmartBill
//
//  Created by Xie kesong on 11/27/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    func stylized(){
         self.setTitleTextAttributes([NSFontAttributeName: UIFont(name: StyleConstant.systemFontNameMeidum, size: 17.0)!], for: .normal)
    }
}
