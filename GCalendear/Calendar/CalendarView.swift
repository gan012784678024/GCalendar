//
//  CalendarView.swift
//  NewSeller
//
//  Created by zlq002 on 2017/3/28.
//  Copyright © 2017年 zlq002. All rights reserved.
//

import UIKit

class CalendarView: UIView ,UICollectionViewDelegate, UICollectionViewDataSource{

    /**是否可选择超出今日的时间 默认不可以*/
    let isBeyondNow : Bool?=false
    
    /**闭包回调  返回选中时间 */
    var calendarBlock : ((_ date : Date) ->Void)?
    
    /**UICollectionView */
    lazy var GCollectionView : UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        
        let itemWidth : CGFloat = self.frame.width / 7
        let itemHeight : CGFloat = (self.frame.height - 40) / 7
        
        layout.itemSize = CGSize(width:itemWidth,height:itemHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: self.headView.frame.maxY, width: self.frame.width, height: self.frame.height - self.headView.frame.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(GCalendarCell.self, forCellWithReuseIdentifier:"GCalendarCell")
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    /*头视图 */
    lazy var headView : UIView! = {
        let id = UIView.init()
        
        return id
    }()
    /**显示日期label */
    lazy var monthLabel : UILabel! = {
        let id = UILabel.creatBaseLabel(textColor: UIColor.k333333(), font: 16)
        id.textAlignment = NSTextAlignment.center
        
        return id
    }()
    /**上个月 */
    lazy var lastMonthBtn : UIButton! = {
        let id = UIButton.creatBaseButton(text: "上个月", font: UIFont.systemFont(ofSize: 16), textColor: UIColor.k333333(), imageStr: nil)
        id.titleLabel?.textAlignment = NSTextAlignment.center
        id.addTarget(self, action: #selector(self.clickLastMonthButton(sender:)), for: UIControlEvents.touchUpInside)
        return id
    }()
    /**下个月 */
    lazy var nextMonthBtn : UIButton! = {
        let id : UIButton = UIButton.creatBaseButton(text: "下个月", font: UIFont.systemFont(ofSize: 16), textColor: UIColor.k333333(), imageStr: nil)
        id.titleLabel?.textAlignment = NSTextAlignment.center
        id.addTarget(self, action: #selector(self.clickNextMonthButton(sender:)), for: UIControlEvents.touchUpInside)
        return id
    }()
    
    /**weekArray */
    var weekDayArray = ["日","一","二","三","四","五","六"]
    
    /**这个月的第一天是星期几 */
    lazy var firstWeekday : NSInteger! = {
        return self.firstWeekdayInThisMonth(date : Date())
    }()
    /**今天时间 */
    var today : Date!
    
    fileprivate var _date : Date!
    var date : Date!{
        
        set{
            _date = newValue
            self.firstWeekday = self.firstWeekdayInThisMonth(date : newValue)
            self.monthLabel.text = self.date.stringFromDate("yyyy-MM")
           self.GCollectionView.reloadData()
        }get{
            return _date
        }
    }
    override init(frame : CGRect){
        super.init(frame: frame)
        
        self.headView.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: 40)
        self.addSubview(self.headView)
        
        self.lastMonthBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: self.headView.frame.height)
        self.headView.addSubview(self.lastMonthBtn)
        
        self.monthLabel.frame = CGRect.init(x: 50, y: 0, width: self.frame.width - 100, height: self.headView.frame.height)
        self.headView.addSubview(self.monthLabel)
        
        self.nextMonthBtn.frame = CGRect.init(x: self.frame.width - 50, y: 0, width: 50, height: self.headView.frame.height)
        self.headView.addSubview(self.nextMonthBtn)
        
        self.addSubview(self.GCollectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: 代理
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return weekDayArray.count
        }else{
            return 42
        }
        
        
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : GCalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GCalendarCell", for: indexPath) as! GCalendarCell
        
        if indexPath.section == 0 {
            cell.dateLabel.text = self.weekDayArray[indexPath.row]
            cell.dateLabel.textColor = UIColor.red
        }else{

            let daysInThisMonth : Int = self.totaldaysInMonth(date : self.date)
            
            
            var day = 0
            
            let i = indexPath.row
            
            if i < self.firstWeekday {
                cell.dateLabel.text = ""
                
            }else if i > (self.firstWeekday + daysInThisMonth - 1){
                
                cell.dateLabel.text = ""
                
            }else{
                
                day = i - self.firstWeekday + 1;
                
                cell.dateLabel.text = "\(day)"
                
                cell.dateLabel.textColor = UIColor.colorWithHexString("6f6f6f")
                //this month
                if self.today.stringFromDate("yyyy-MM") == self.date.stringFromDate("yyyy-MM"){
                    
                    if day == self.day(date : Date()) {
                        cell.dateLabel.textColor = UIColor.red
                    } else if day > self.day(date : self.date) {
                        cell.dateLabel.textColor = UIColor.colorWithHexString("cbcbcb")
                        
                    }
                }else if self.today.compare(self.date) == ComparisonResult.orderedAscending {
                    cell.dateLabel.textColor = UIColor.colorWithHexString("cbcbcb")
                    
                }

            
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {

            var day = 0
            let i = indexPath.row
            day = i - self.firstWeekday + 1
            
            if day>self.totaldaysInMonth(date: self.date)||day<1 {
                if day>self.totaldaysInMonth(date: self.date) {
                    return
                }
                return
            }
            
            var components : DateComponents = DateComponents()
            components = Calendar.current.dateComponents([.year,.month,.day], from: self.date)
            components.timeZone = TimeZone(abbreviation: "CST")
            components.day = day
            let date = Calendar.current.date(from: components)!
            if Date().timeIntervalSince(date) < 0 && !self.isBeyondNow!{
                return
            }
            self.calendarBlock?(date)
        }
        
        
    }
    //MARK: --------方法-----------
    /**点击了上个月 */
    func clickLastMonthButton(sender : UIButton){
        
        UIView.transition(with: self, duration: 0.5, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            
            self.date = self.lastMonth(date: self.date)
            
        })
    }
    /**点击下个月 */
    func clickNextMonthButton(sender : UIButton){
        UIView.transition(with: self, duration: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations: {
            self.date = self.nextMonth(date: self.date)
        })
    }
    //今天是几号
    func day(date : Date)->NSInteger{
        var components : DateComponents = DateComponents()
        components = Calendar.current.dateComponents([.year,.month,.day], from: date)
        return components.day!
        
    }
    //这个月有几天
    func totaldaysInMonth(date : Date) -> Int{
//        range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date as Date)
        let daysInLastMonth : Range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)!
        
        return daysInLastMonth.count
    }
    
    //这个月的第一天是周几
    func firstWeekdayInThisMonth(date : Date) ->NSInteger{
        
        var calendar : Calendar = Calendar.current
        
        calendar.firstWeekday = 1
        
        var comp : DateComponents = DateComponents()
        
        comp = calendar.dateComponents([.year,.month,.day], from: Date())
        
        comp.day = 1
        
        let firstDayOfMonthDate : Date = calendar.date(from: comp)!
        
        let firstWeekday : Int = calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: firstDayOfMonthDate)!
            
        return firstWeekday - 1;
    }
    //下一个月的时间
    func nextMonth(date : Date) ->Date{
        
        var dateComponents : DateComponents = DateComponents.init()
        
        dateComponents.month = 1
        
        let newDate : Date = Calendar.current.date(byAdding: dateComponents, to: date)!
        
        return newDate
    }
    //上一个月的时间
    func lastMonth(date : Date) ->Date{
        
        var dateComponents : DateComponents = DateComponents.init()
        
        dateComponents.month = -1
        let newDate : Date = Calendar.current.date(byAdding: dateComponents, to: date)!
        return newDate
    }
}
