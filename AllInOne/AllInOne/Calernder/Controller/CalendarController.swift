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

class CalendarController: UIViewController {
    //属性
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
    
    lazy var calendarView : CalendarInfoView = {
       let view = CalendarInfoView()
        view.frame = CGRect(x: 0, y: 400, width: ScreenW, height: 400)
        return view
    }()
    
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
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo((self.navigationController?.navigationBar.frame.maxY)!)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(0)
            make.height.equalTo(400)
        }
        
        calendar.locale = NSLocale(localeIdentifier: "zh-CN") as Locale
        self.lunar = true
        
//        calendar.calendarHeaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
//        calendar.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
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
        self.title = "万年历"
        view.addSubview(calendarView)
        subViewsLayut()
        requetst(date: Date())
    }
    
}

//y控件约束
extension CalendarController {
    private func subViewsLayut() {
        
    }
}

//网络请求
extension CalendarController {
    
    private func requetst(date: Date) {
//        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        let stringTime = dateFormatter.string(from: date)
        
        let params = ["key":APPKEY,"date":stringTime]
        Alamofire.request(kCalendarAPI, method: .get, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let model = CalendarModel(jsonData: json)
                self.calendarView.model = model
                
            case .failure:
                print("失败")
            }
        }
    }
}

//MARK:- calenda代理
extension CalendarController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        
        requetst(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard self.lunar else {
            return nil
        }
        return self.lunarFormatter.string(from: date)
    }

}
