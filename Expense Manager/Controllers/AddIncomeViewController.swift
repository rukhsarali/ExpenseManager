//
//  AddIncomeViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 14/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import DLRadioButton
class AddIncomeViewController: UIViewController {
    @IBOutlet weak var incomeButtonOutlet: DLRadioButton!
    @IBOutlet weak var expenseButtonOutlet: DLRadioButton!
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(button: incomeButtonOutlet)
        updateUI(button: expenseButtonOutlet)
    }
    @IBAction func categoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goTocategory", sender: self)
    }
}
//MARK: - check button and its UI
extension AddIncomeViewController {
    @IBAction func incomeExpenseBtnClicked(_ sender: UIButton) {
        if sender.currentTitle == "Income"{
            expenseButtonOutlet.isSelected = false
            print(sender.currentTitle!)
        }else if sender.currentTitle == "Expense" {
            print(sender.currentTitle!)
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
extension AddIncomeViewController : selectedCategoryDelegatesIncome {
    func selectedCategoryItem(string: String) {
        if string != "" {
            selectedCategoryLabel.text = string
        }else{
            selectedCategoryLabel.text = "Category"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? IncomeCategoryViewController{
            vc.delegate = self
        }
    }
}
