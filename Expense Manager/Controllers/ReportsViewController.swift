//
//  ReportsViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 14/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class ReportsViewController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
   
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var currencyIncome: UILabel!
    @IBOutlet weak var expenceLabel: UILabel!
    @IBOutlet weak var currencyExpence: UILabel!
    
    
    
    var incomeDataEntry = PieChartDataEntry(value: 0)
    var expenceDataEntry = PieChartDataEntry(value: 0)
    var numberOfDownloadDataEntries = [PieChartDataEntry]()
    let realm = try! Realm()
    var RealmRecData : Results<RealmDataSave>?
    override func viewDidLoad() {
        super.viewDidLoad()
    updateChart()
        // Do any additional setup after loading the view.
    }
    
}
extension ReportsViewController {
    func updateChart() {
        let totalSumOfIncome: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "incomeamountRealm")
        let totalSumOfExpence: Int = realm.objects(RealmDataSave.self).sum(ofProperty: "expenceamountRealm")
        incomeDataEntry.value = Double(totalSumOfIncome)
        incomeDataEntry.label = "Income"
        expenceDataEntry.value = Double(totalSumOfExpence)
        expenceDataEntry.label = "Expence"
        numberOfDownloadDataEntries = [incomeDataEntry , expenceDataEntry]
        pieChart.holeRadiusPercent = 0.3
        pieChart.centerText = "center"
        pieChart.transparentCircleRadiusPercent = 0.4
        pieChart.centerTextRadiusPercent = 1.1
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) , #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)]
        pieChart.data = chartData
        
        // income / expence values
        incomeLabel.text = "\(totalSumOfIncome)"
        expenceLabel.text = "\(totalSumOfExpence)"
        
    }
}
