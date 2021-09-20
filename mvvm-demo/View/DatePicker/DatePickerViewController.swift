//
//  DatePickerViewController.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 02/06/2020.
//

import UIKit

class DatePickerViewController: UIViewController {

      @IBOutlet weak var cancelBtn: UIButton!
      @IBOutlet weak var doneBtn: UIButton!
      @IBOutlet weak var datePicker: UIDatePicker!
      @IBOutlet weak var headerTitle: UILabel!
  

      var dateFormat: String!
      var onDateSelectedClosure: ((_ selectedDate: Date, _ formatedDate: String) -> Void)?
      var mode:UIDatePicker.Mode = .date
      
      override func viewDidLoad() {
          super.viewDidLoad()

        datePicker.datePickerMode = mode

          // Do any additional setup after loading the view.
      }
      
      @IBAction func OnDateChanged(_ sender: Any) {
      }
      
      @IBAction func onCancelled(_ sender: Any) {
          
          dismiss(animated: true) {
          }
      }
      
      @IBAction func onDateSelected(_ sender: Any) {
          
          let formatter = DateFormatter()
          formatter.dateFormat = dateFormat
          
          
              let date = datePicker.date
  //            let milliseconds: CLongLong = CLongLong((date.timeIntervalSince1970 * 1000.0).rounded())
  //            print("MILLISECONDS: \(milliseconds)")
              onDateSelectedClosure?(date,formatter.string(from: datePicker!.date))

      
          
          dismiss(animated: true) {
          }
          
      }
}
