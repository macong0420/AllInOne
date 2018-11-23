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

let kCalendarInfoCellID = "kCalendarInfoCellID"

class CalendarController: UIViewController,UIGestureRecognizerDelegate {
    //属性
    private weak var calendar: FSCalendar!
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
    
    fileprivate let lunarFormatter = LunarFormatter()
    
    lazy var tableView: UITableView = {
        let tabV = UITableView(frame: CGRect(x: 0, y: 400, width: ScreenW, height: ScreenH-300), style: .plain)
        tabV.backgroundColor = UIColor.orange
        tabV.register(CalendarInfoCell.self, forCellReuseIdentifier: kCalendarInfoCellID)
        tabV.delegate = self
        tabV.dataSource = self
        return tabV
    }()
    
    var model: CalendarModel?
    
//    lazy var calendarView : CalendarInfoView = {
//       let view = CalendarInfoView()
//        view.frame = CGRect(x: 0, y: 400, width: ScreenW, height: 400)
//        return view
//    }()
    
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
        self.view.addSubview(tableView)
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
//        view.addSubview(calendarView)
        subViewsLayut()
        requetst(date: Date())
    }
    
}

//y控件约束
extension CalendarController {
    private func subViewsLayut() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(calendar.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(ScreenH-400)
        }
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
                self.model = model
                self.tableView.reloadData()
                
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
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {

        calendar.frame.size.height = bounds.height
        self.tableView.frame.origin.y = calendar.frame.maxY + 10
        self.tableView.frame.size.height = ScreenH - bounds.height - self.navigationController!.navigationBar.frame.height
        self.view.layoutIfNeeded()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    
}

extension CalendarController: UITableViewDelegate,UITableViewDataSource {
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalendarInfoCell = tableView.dequeueReusableCell(withIdentifier: kCalendarInfoCellID)! as! CalendarInfoCell
        cell.model = self.model
        return cell
    }
    
}
