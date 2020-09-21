//
//  AddIncomeViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 14/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import DLRadioButton
import RealmSwift
class AddIncomeViewController: UIViewController {
    let realm = try! Realm()
    var dataGet : Results<RealmDataSave>?
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var incomeButtonOutlet: DLRadioButton!
    @IBOutlet weak var expenseButtonOutlet: DLRadioButton!
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var timeRecLabel: UILabel!
    @IBOutlet weak var dateRecLabel: UILabel!
    var dateTimePickerController = DateTimePickerViewController()
    var incomeString = ""
    var expenceString = ""
    var dayString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(button: incomeButtonOutlet)
        updateUI(button: expenseButtonOutlet)
        dateTimeUpdate()
    }
    @IBAction func categoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goTocategory", sender: self)
    }
    @IBAction func rightNavigationBarBtn(_ sender: UIBarButtonItem) {
        if amountTextField.text != "" && (incomeString != "" || expenceString != "" ){
            navigationController?.popViewController(animated: true)
            saveToRealm()
        }
    }
    @IBAction func dateTimePickerButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDateTimePicker", sender: self)
    }
    @IBAction func modeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMode", sender: self)
    }
}
//MARK: - checkmark button and its UI
extension AddIncomeViewController {
    @IBAction func incomeExpenseBtnClicked(_ sender: UIButton) {
        if sender.currentTitle == "Income"{
            expenseButtonOutlet.isSelected = false
            incomeString = sender.currentTitle!
        }else if sender.currentTitle == "Expense" {
            expenceString = sender.currentTitle!
            incomeButtonOutlet.isSelected = false
        }
    }
    func updateUI(button: DLRadioButton) {
        button.indicatorSize = 12   // inside circle size
        button.iconStrokeWidth = 3 //round btn width
        button.marginWidth = 15   //space between circle and label
        button.iconSize = 25
        button.iconColor = #colorLiteral(red: 0, green: 0.3979387283, blue: 0.5843827128, alpha: 1)
        button.indicatorColor = #colorLiteral(red: 0, green: 0.3979387283, blue: 0.5843827128, alpha: 1)
    }
}
//MARK: - add income category protocols
extension AddIncomeViewController : selectedCategoryDelegatesIncome {
    func selectedCategoryItem(string: String) {
        selectedCategoryLabel.text = string
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? IncomeCategoryViewController{
            vc.delegate = self
        }
        if let vc = segue.destination as? DateTimePickerViewController{
            vc.delegate = self
        }
        if let vc = segue.destination as? PaymentModeViewController {
            vc.delegate = self
        }
    }
}
//MARK: - date picker delegate
extension AddIncomeViewController : DateTimePickerDelegate{
    func dateTimeData(date: String, time: String , day : String) {
        if date != "" && time != "" {
            dateRecLabel.text = date
            timeRecLabel.text = time
            dayString = day
        }else {
            dateTimeUpdate()
        }
    }
    func dateTimeUpdate(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let year_current = calendar.component(.year, from: date)
        let month_current = calendar.component(.month, from: date)
        let day_current = calendar.component(.day, from: date)
        dateRecLabel.text = "\(day_current)/\(month_current)/\(year_current)"
        timeRecLabel.text = "\(hour):\(minutes)"
        dayString = "\(day_current)"
    }
}
//MARK: - payment method delegate
extension AddIncomeViewController : selectedPaymentCategoryDelegates {
    func selectedPaymentItem(string: String) {
        cashLabel.text = string
    }
    
}
//MARK: - save data to realm
extension AddIncomeViewController {
    func saveToRealm() {
        let data = RealmDataSave()
        data.incomeStringRealm = incomeString
        data.expenceStringRealm = expenceString
        let amountInput = amountTextField.text!
        let value = Int(amountInput)
        if incomeString != "" {
            data.incomeamountRealm = value!
        }else if expenceString != "" {
            data.expenceamountRealm = value!
        }
        data.categoryRealm = selectedCategoryLabel.text!
        data.dateRealm = dateRecLabel.text!
        data.timeRealm = timeRecLabel.text!
        data.dayRealm = dayString
        data.noteRealm = noteTextField.text!
        data.paymentModeRealm = cashLabel.text!
        SaveData(saveData: data)
    }
    func SaveData (saveData : RealmDataSave) {
        do {
            try realm.write{
                realm.add(saveData)
            }
        }catch{
            print(error)
        }
    }
}







//back bar btn in navigation controller
// override func didMove(toParent parent: UIViewController?) {
//       if (!(parent?.isEqual(self.parent) ?? false)) {
//           print("Back Button Pressed!")
//       }
//   }
