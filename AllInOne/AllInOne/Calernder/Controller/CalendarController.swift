//
//  CalendarController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/21.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import EventKit

class CalendarController: UIViewController,FSCalendarDataSource, FSCalendarDelegate {
    private weak var calendar: FSCalendar!
    fileprivate var gregorian = Calendar(identifier: .chinese)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate var lunar: Bool = false {
        didSet {
            self.calendar.reloadData()
        }
    }
    
    fileprivate let lunarFormatter = LunarFormatter()
    
    override func loadView() {
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: self.view.bounds.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        self.view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.locale = NSLocale(localeIdentifier: "zh-CN") as Locale
        self.lunar = true
        
        calendar.calendarHeaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        calendar.swipeToChooseGesture.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FSCalendar"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard self.lunar else {
            return nil
        }
        return self.lunarFormatter.string(from: date)
    }

}
