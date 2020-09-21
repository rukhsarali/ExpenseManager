//
//  DateTimePickerViewController.swift
//  Expense Manager
//
//  Created by Rukhsar on 18/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
protocol DateTimePickerDelegate {
    func dateTimeData(date : String , time : String , day : String)
}
class DateTimePickerViewController: UIViewController {
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateTimeLabelView: UIView!
    @IBOutlet weak var okBtnView: UIView!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var dateString = ""
    var timeString = ""
    var dayString = ""
    var delegate : DateTimePickerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerOutlet.datePickerMode = .dateAndTime
        updateUI()
        // Do any additional setup after loading the view.
       
    }
    

    @IBAction func okButton(_ sender: UIButton) {
        delegate?.dateTimeData(date: dateString, time: timeString , day: dayString )
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // date and time picker
    @IBAction func dateTimePicker(_ sender: UIDatePicker, forEvent event: UIEvent) {
         
        dateString = "\(sender.date.getDayMonthYearHourMinuteSecond().day)/\(sender.date.getDayMonthYearHourMinuteSecond().month)/\(sender.date.getDayMonthYearHourMinuteSecond().year)"
        timeString = "\(sender.date.getDayMonthYearHourMinuteSecond().hour):\(sender.date.getDayMonthYearHourMinuteSecond().minute)"
        dayString = "\(sender.date.getDayMonthYearHourMinuteSecond().day)"
        dateLabel.text = "Date : \(dateString)"
        timeLabel.text = "Time : \(timeString)"
//        print(dateString)
//        print(timeString)
        
        
    }
    
}
//MARK: - UI update method
extension DateTimePickerViewController {
   private func updateUI () {
        dateTimeView.layer.cornerRadius = 8
        cancelBtnView.layer.cornerRadius = 8
        okBtnView.layer.cornerRadius = 8
        dateTimeLabelView.roundCorners(corners: [.topRight , .topLeft], cornerRadius: 8)
    }
}
//MARK: - for date and time methods
extension Date {
    static func calculateDate(day: Int , month : Int , year : Int , hour : Int , minute: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/DD HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let calculateDate = formatter.date(from: "\(year)/\(month)/\(day)/\(hour)/\(minute)")
        
        return calculateDate!
    }
    func getDayMonthYearHourMinuteSecond() -> (day: Int , month : Int , year : Int , hour : Int , minute: Int ) {
        let calender = Calendar.current
        let day = calender.component(.day, from: self)
        let month = calender.component(.month, from: self)
        let year = calender.component(.year, from: self)
        let hour = calender.component(.hour, from: self)
        let minute = calender.component(.minute, from: self)
        
        
        return (day , month , year , hour , minute  )
    }
}
