//
//  AllTransactionsViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 21/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import RealmSwift

class AllTransactionsViewController: UIViewController {
   
    @IBOutlet weak var bottomView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencyTotal: UILabel!
    @IBOutlet weak var currencyIncome: UILabel!
    @IBOutlet weak var currencyExpence: UILabel!
    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenceLabel: UILabel!
    @IBOutlet weak var arrowUpDownImage: UIImageView!
    @IBOutlet weak var balanceViewConstraints: NSLayoutConstraint!
    let realm = try! Realm()
    var AllTransaction : Results<RealmDataSave>?
    var menuOut = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UIUpdate()
        load()
        Sum()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func balanceViewButton(_ sender: UIButton) {
        upDownButton()
        UIUpdate()
    }
    
}
extension AllTransactionsViewController {
    func upDownButton() {
        
        if menuOut == false {
            bottomView.constant = 124
            balanceViewConstraints.constant = 0
            arrowUpDownImage.image = UIImage(named: "arrowUp")
            menuOut = true
        }else{
            bottomView.constant = 0
            balanceViewConstraints.constant = 20
            arrowUpDownImage.image = UIImage(named: "arrowDown")
            menuOut = false
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("animation completed")
        }
    }
    func UIUpdate() {
        let Image =   arrowUpDownImage.image?.withRenderingMode(.alwaysTemplate)
        arrowUpDownImage.image = Image
        arrowUpDownImage.tintColor = UIColor.white
    }
    
}
//MARK: - Tableview delegate
extension AllTransactionsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTransaction?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        tableView.backgroundColor = UIColor(named: "ViewColor")
        cell.backgroundColor = UIColor(named: "ViewColor")
        if let List = AllTransaction?[indexPath.row] {
            if List.incomeStringRealm != "" {
                cell.incomeExpenceLabel.text = "\(List.incomeamountRealm)"
                cell.categoryLabel.text = List.categoryRealm
                cell.incomeExpenceLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                cell.categoryLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                cell.currencyLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if List.expenceStringRealm != "" {
                cell.incomeExpenceLabel.text = "\(List.expenceamountRealm)"
                cell.categoryLabel.text = List.categoryRealm
                cell.incomeExpenceLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                cell.categoryLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                cell.currencyLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension AllTransactionsViewController{
    func load() {
        AllTransaction = realm.objects(RealmDataSave.self)
        tableView.reloadData()
    }
    func Sum () {
       let totalSumOfIncome: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "incomeamountRealm")
        let totalSumOfExpence: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "expenceamountRealm")
        incomeLabel.text = "\(totalSumOfIncome)"
        expenceLabel.text = "\(totalSumOfExpence)"
        totalBalance.text = "\(totalSumOfIncome + totalSumOfExpence)"
        
    }
}
