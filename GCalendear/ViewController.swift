//
//  ViewController.swift
//  GCalendear
//
//  Created by zlq002 on 2017/3/29.
//  Copyright © 2017年 zlq002. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /**调用 日历控件 */
        let calendarVC : CalendarView = CalendarView.init(frame: CGRect.init(x: 0, y: 50, width: self.view.frame.width, height: 276))
        calendarVC.today = Date()
        calendarVC.date = calendarVC.today
        
        /**选择日期的回调 */
        calendarVC.calendarBlock = {(date : Date) in
            print("日历回调")
        }
        calendarVC.backgroundColor = UIColor.white
        self.view.addSubview(calendarVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

