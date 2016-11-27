//
//  MainViewController.swift
//  SmartBill
//
//  Created by Xie kesong on 11/25/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var currencySymbol: UILabel!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var tipView: UIView!
    
    let builtInTipFactor = 0.15
    
    let maxCharCount = 9
    
//    var billString: String!
    
    var billAmount: Double = 0
    
    var tipAmount: String?{
        didSet{
            self.tipAmountLabel.text = tipAmount
        }
    }
    
    var autoAppendDecimalPoint = true
    
    var numFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBarUI()
        setBillTextFieldUI()
        setTipView()
        self.billTextField.delegate = self
        self.billTextField.becomeFirstResponder()
        self.billTextField.addTarget(self, action: #selector(self.billTextFieldTextDidChange), for: UIControlEvents.editingChanged)
        self.numFormatter.numberStyle = .currency

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     MARK: - UI Set Up
     */
    
    func setBillTextFieldUI(){
        if let placeHolder = self.billTextField.placeholder{
            self.billTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.6)])
        }
    }
    
    func setNavigationBarUI(){
        self.navigationController?.navigationBar.barTintColor = StyleConstant.navigationBarBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = StyleConstant.navigationBarTitleTextAttribute
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    func setTipView(){
        let amount = billAmount
        let tipNum = (amount * builtInTipFactor) as NSNumber
        self.tipAmount = numFormatter.string(from: tipNum)
    }
    
    
    func billTextFieldTextDidChange(){
        if let billString = self.billTextField.text{
            let noneCurrencyFormatter = NumberFormatter()
            if let num = noneCurrencyFormatter.number(from: billString) as? Double{
                self.billAmount = num
            }else{
                self.billAmount = 0
            }
            setTipView()
        }
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MainViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            //delete button is pressed
            
        }else if textField.text!.characters.count >= self.maxCharCount{
            return false
        }else if string == "."{
            //make sure there is no decimal point present already
            if textField.text!.contains("."){
                return false
            }
        }
        return true
    }
    
    
    
        
}

