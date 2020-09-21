//
//  IncomeCategoryViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 16/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
protocol selectedCategoryDelegatesIncome {
    func selectedCategoryItem (string : String)
}
class IncomeCategoryViewController: UIViewController {
    let categoryItems = ["Business","Clothing","Drinks" , "Education","Food", "Fuel","Fun",
                         "Hospital","Hotel","Loan", "Medical", "Merchandise", "Movie",
                         "Other", "Personal", "Pets","Restaurant","Salary",
                         "Shopping", "Tips","Transport"]
    @IBOutlet weak var categoryLabelView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var selectedItem = ""
    var delegate : selectedCategoryDelegatesIncome?   // protocol
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateUI()
    }
    @IBAction func saveButton(_ sender: UIButton) {
        delegate?.selectedCategoryItem(string: selectedItem)   //protocol
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: - UI update method
extension IncomeCategoryViewController {
    func updateUI () {
        categoryView.layer.cornerRadius = 8
        saveBtnView.layer.cornerRadius = 8
        cancelBtnView.layer.cornerRadius = 8
        categoryLabelView.roundCorners(corners: [.topRight , .topLeft], cornerRadius: 8)
    }
}
//MARK: - tableView methods
extension IncomeCategoryViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoryItems[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        selectedItem = categoryItems[indexPath.row]    //protocol
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}


