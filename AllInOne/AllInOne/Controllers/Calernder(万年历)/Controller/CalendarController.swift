//
//  CalendarController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/21.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import EventKit
import Alamofire
import SwiftyJSON

let kCalenderTaskCellID = "kCalenderTaskCellID"
private let kCalenderViewY = 0
private let kCalenderViewH: CGFloat = 250

class CalendarController: UIViewController,UIGestureRecognizerDelegate {
    //属性
    private weak var calendar: FSCalendar!
    fileprivate let lunarFormatter = LunarFormatter()
    
    fileprivate var gregorian = Calendar(identifier: .chinese)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //上下滑动切换月 周 日历手势
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    fileprivate var lunar: Bool = false {
        didSet {
            self.calendar.reloadData()
        }
    }
    
    var selectDate = Date()
    
    
    //关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "Close")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 20, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    
    lazy var emptyView: TaskEmptyView = {
       
        let view = TaskEmptyView(frame: CGRect(x: 0, y: 500, width: ScreenW, height: ScreenW/3 + 50))
        return view
    }()
    
    var model: CalendarModel?
    var historyModel: CalendarHistoryContentModel? //历史上的今天
    
    //--------------------系统方法重写----------------------
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
//        view.addGradientLayer(frame: view.bounds, colors: [UIColor(hex: "4D6AD5").cgColor, UIColor(hex: "9660A0").cgColor])
        view.backgroundColor = UIColor.white
        self.view = view
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: ScreenW, height: kCalenderViewH))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.clear
        self.view.addSubview(calendar)
        self.calendar = calendar

        /* 不显示农历
        calendar.locale = NSLocale(localeIdentifier: "zh-CN") as Locale
        self.lunar = true
        */
        calendar.backgroundColor = BaseColor
//        calendar.calendarHeaderView.backgroundColor = BaseColor //日期头部背景色
        calendar.headerHeight = 60
        
        
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0; //上一月 下一月 透明度 0 就是隐藏
        calendar.appearance.headerDateFormat = "yyyy-MM"     //头部日期格式
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        calendar.swipeToChooseGesture.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "万年历"
        self.view.addSubview(closeBtn)
        
// 上下滑动展开日历 禁用
//        self.view.addGestureRecognizer(self.scopeGesture)
//        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
//        self.view.addSubview(emptyView)
//        self.view.bringSubviewToFront(emptyView)
    }
    

    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
}



/*
//网络请求
extension CalendarController {
    
    /// 宜 忌
    private func requetst(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringTime = dateFormatter.string(from: date)
        
        let params = ["key":APPKEY,"date":stringTime]
        Alamofire.request(kCalendarAPI, method: .get, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let model = CalendarModel(jsonData: json)
                self.model = model
                self.tableView.reloadData()
                
            case .failure:
                print("失败")
            }
        }
    }
    
    private func requeatHistoryToday(date : Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let stringTime = dateFormatter.string(from: date)
        
        let params = ["key":APPKEY,"day":stringTime]
        Alamofire.request(kHistoryTodayAPI, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let model = CalendarHistoryContentModel(jsonData: json)
                self.historyModel = model
                self.tableView.reloadData()
                
            case .failure:
                print("失败")
            }
        }
    }
}
 */

//MARK:- calenda代理
extension CalendarController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        selectDate = date
//        requetst(date: date)
//        requeatHistoryToday(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard self.lunar else {
            return nil
        }
        return self.lunarFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {

        calendar.frame.size.height = bounds.height
        
        self.view.layoutIfNeeded()
    }

//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
//        if shouldBegin {
//            let velocity = self.scopeGesture.velocity(in: self.view)
//            switch self.calendar.scope {
//            case .month:
//                return velocity.y < 0
//            case .week:
//                return velocity.y > 0
//            }
//        }
//        return shouldBegin
//    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
