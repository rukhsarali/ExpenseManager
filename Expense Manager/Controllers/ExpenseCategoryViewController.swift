//
//  ExpenseCategoryViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 17/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
protocol selectedCategoryDelegateExpense {
    func selectedCategoryItem (string : String)
}
class ExpenseCategoryViewController: UIViewController {
    let categoryItems = ["Business","Clothing","Drinks" , "Education","Food", "Fuel","Fun",
                         "Hospital","Hotel","Loan", "Medical", "Merchandise", "Movie",
                         "Other", "Personal", "Pets","Restaurant","Salary",
                         "Shopping", "Tips","Transport"]
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryLableView: UIView!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var saveBtnView: UIView!
    var selectedItem = ""
    var delegate : selectedCategoryDelegateExpense?   // protocol
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.delegate = self
        tableView.dataSource = self
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
extension ExpenseCategoryViewController {
    func updateUI () {
        categoryView.layer.cornerRadius = 8
        saveBtnView.layer.cornerRadius = 8
        cancelBtnView.layer.cornerRadius = 8
        categoryLableView.round(corners: [.topRight , .topLeft], cornerRadius: 8)
    }
}
//MARK: - for custom corner raduis change method
extension UIView {
    func rounds(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}
//MARK: - tableView methods
extension ExpenseCategoryViewController : UITableViewDelegate , UITableViewDataSource {
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
        print(selectedItem)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
