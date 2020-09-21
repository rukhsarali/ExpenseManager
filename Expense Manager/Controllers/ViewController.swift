//
//  ViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 12/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class ViewController: UIViewController {
    // add income
    @IBOutlet weak var incomebtnView: UIView!
    @IBOutlet weak var incomeBtnImage: UIImageView!
    //add expense
    @IBOutlet weak var expensebtnView: UIView!
    @IBOutlet weak var expensebtnImage: UIImageView!
    //add transaction
    @IBOutlet weak var transactionbtnView: UIView!
    @IBOutlet weak var transactionbtnImage: UIImageView!
    //reports
    @IBOutlet weak var reportbtnView: UIView!
    @IBOutlet weak var reportbtnImage: UIImageView!
    //pic chart
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var pieIncome: UILabel!
    @IBOutlet weak var pieExpence: UILabel!
    @IBOutlet weak var pieBalance: UILabel!
    
    var incomeDataEntry = PieChartDataEntry(value: 0)
    var expenceDataEntry = PieChartDataEntry(value: 0)
    var numberOfDownloadDataEntries = [PieChartDataEntry]()
    var uiButtonUpdate = UIButtonUpdate()
    let realm = try! Realm()
    var RealmRecData : Results<RealmDataSave>?
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBarButton()
        buttonUIUpdate()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        updateChar()
        UpDatePieLabels()
    }
}
//MARK: - All buttons in viewController
extension ViewController {
    @IBAction func addIncomeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAddIncomeExpence", sender: self)
    }
    @IBAction func addExpenseButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAddIncomeExpence", sender: self)
    }
    @IBAction func allTransactionButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAllTransaction", sender: self)
    }
    @IBAction func reportsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToReports", sender: self)
    }
}
//MARK: - button's setting
extension ViewController {
    func buttonUIUpdate () {
        uiButtonUpdate.buttonUI(color: #colorLiteral(red: 0.09803921569, green: 0.4117647059, blue: 0.5490196078, alpha: 1), BtnImage: incomeBtnImage, BtnView: incomebtnView)
        uiButtonUpdate.buttonUI(color: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1), BtnImage: expensebtnImage, BtnView: expensebtnView)
        uiButtonUpdate.buttonUI(color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), BtnImage: transactionbtnImage, BtnView: transactionbtnView)
        uiButtonUpdate.buttonUI(color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), BtnImage: reportbtnImage, BtnView: reportbtnView)
    }
}
//MARK: - chart view setting
extension ViewController {
    func updateChar() {
        let totalSumOfIncome: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "incomeamountRealm")
        let totalSumOfExpence: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "expenceamountRealm")
        incomeDataEntry.value = Double(totalSumOfIncome)
        expenceDataEntry.value = Double(totalSumOfExpence)
        numberOfDownloadDataEntries = [incomeDataEntry , expenceDataEntry]
        pieChartView.holeRadiusPercent = 0.3
        pieChartView.centerText = "center"
        pieChartView.transparentCircleRadiusPercent = 0.4
        pieChartView.centerTextRadiusPercent = 1.1
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) , #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)] 
        pieChartView.data = chartData
    }
    func UpDatePieLabels() {
        let totalSumOfIncome: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "incomeamountRealm")
        let totalSumOfExpence: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "expenceamountRealm")
        pieIncome.text = "\(totalSumOfIncome)"
        pieExpence.text = "\(totalSumOfExpence)"
        pieBalance.text = "\(totalSumOfIncome + totalSumOfExpence)"
    }
}
//MARK: - navigation bar button setting
extension ViewController {
    func customNavigationBarButton() {
        let settingBtn = UIButton(type: .custom) 
        let image = UIImage(named: "Settings")?.withRenderingMode(.alwaysTemplate)
        settingBtn.setImage(image, for: .normal)
        settingBtn.tintColor = UIColor.white
        settingBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        settingBtn.addTarget(self, action: #selector(addSelector), for: UIControl.Event.touchUpInside)
        let settingBarItem = UIBarButtonItem(customView: settingBtn)
        let currWidth = settingBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = settingBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = settingBarItem
        navigationController?.navigationBar.tintColor = UIColor.white  // backbtn color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
    }
    @objc func addSelector () {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
}




