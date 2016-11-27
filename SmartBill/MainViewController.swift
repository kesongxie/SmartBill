//
//  MainViewController.swift
//  SmartBill
//
//  Created by Xie kesong on 11/25/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var currencySymbol: UILabel!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var dragIconImageView: UIImageView!
    
    var tipFactor: Double?{
        didSet{
            percentageLabel?.text = String(tipFactor! * 100)
        }
    }
    
    //max character input for bill text field
    let maxCharCount = 8
    
    // numerical value for tip
    var billAmount: Double = 0
    
    var tipAmount: String!{
        didSet{
            self.tipAmountLabel.text = tipAmount
        }
    }
    
    enum titleStatus{
        case refreshing
        case initial
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update UI
        setScrollView()
        setNavigationBarUI()
        setBillTextField()
        setTipFactor()
        setTipView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     * MARK: - UI Set Up
     *       - scrollView set up
     *       - set Bill Text Field
     *       - Update navigation bar UI
     *       - update TipView UI
     */
    
    func setScrollView(){
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.delegate = self
    }
    
    func setBillTextField(){
        self.billTextField.delegate = self
        self.billTextField.becomeFirstResponder()
        self.billTextField.addTarget(self, action: #selector(self.billTextFieldTextDidChange), for: UIControlEvents.editingChanged)
        if let placeHolder = self.billTextField.placeholder{
            self.billTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.6)])
        }
    }
    
    func setNavigationBarUI(){
        self.navigationController?.navigationBar.barTintColor = StyleConstant.NavigationBar.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = StyleConstant.NavigationBar.titleTextAttribute
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setTipView(){
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        let amount = billAmount
        let tipNum = (amount * tipFactor!) as NSNumber
        self.tipAmount = currencyFormatter.string(from: tipNum)
    }
    
    func setTipFactor(){
        self.tipFactor = 0.15
    }
    
    /*
     * MARK: - Bill text field control event
     */
 
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
    
    
    func updateTitle(status: titleStatus){
        switch status{
        case .initial:
            self.title = AppName
        case .refreshing:
            self.title = "CALCULATING..."
        }
    }
    
    func toggleDragIconRotation(){
        self.dragIconImageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)

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
        if let billString = textField.text{
            if string == ""{
                //delete button pressed
                return true
            }else if billString.characters.count == 1 && billString.characters.first == "0" && string != "."{
                //replace the leading 0
                textField.text = ""
            }else if billString.characters.count >= self.maxCharCount{
                return false
            }else if string == "."{
                //make sure the input is valid
                if textField.text!.contains("."){
                    return false
                }
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //self.toggleDragIconRotation()
        return true
    }
    
}

extension MainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -40{
            UIView.animate(withDuration: 0.3, animations: {
                self.billTextField.resignFirstResponder()
                self.updateTitle(status: .refreshing)
                UIView.animate(withDuration: 1.0,
                    animations: {
                        self.toggleDragIconRotation()
                    },
                    completion: {
                        completed in
                        if completed{
                          //  self.dragIconImageView.isHidden = true
                        }
                    })
            })
        }
    }
    
    
}








