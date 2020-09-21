//
//  PaymentModeViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 21/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
protocol selectedPaymentCategoryDelegates {
    func selectedPaymentItem (string : String)
}
class PaymentModeViewController: UIViewController {
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var paymentLabelView: UIView!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let categoryItems = ["Cash","Credit Card","Debit Card","Net Banking","Cheque", ]
    var selectedItem = ""
    var delegate : selectedPaymentCategoryDelegates?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UIUpdate()
    }
    @IBAction func saveButton(_ sender: UIButton) {
        delegate?.selectedPaymentItem(string: selectedItem)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension PaymentModeViewController {
    func UIUpdate () {
        paymentView.layer.cornerRadius = 8
        saveBtnView.layer.cornerRadius = 8
        cancelBtnView.layer.cornerRadius = 8
        paymentLabelView.roundCorners(corners: [.topRight , .topLeft], cornerRadius: 8)
    }
}
extension PaymentModeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
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
