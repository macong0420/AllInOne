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
    
    //日程数据
    var taskArray: Array = [Any]() {
        didSet {
            
        }
    }
    
    var selectDate = Date()
    
    //添加日程按钮
    lazy var addTaskBtn: UIButton = {
        let img = UIImage(named: "AddTask")!
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: (ScreenW-img.size.width)/2, y: ScreenH-img.size.height-20, width: img.size.width, height: img.size.height)
        btn.setBackgroundImage(img, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(addTaskBtnAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "Close")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 40, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tabV = UITableView(frame: CGRect(x: 0, y: 480, width: ScreenW, height: ScreenH-380), style: .plain)
        tabV.backgroundColor = UIColor.white
        tabV.register(CalenderTaskCell.self, forCellReuseIdentifier: kCalenderTaskCellID)
        tabV.separatorColor = .clear
        tabV.delegate = self
        tabV.dataSource = self
        return tabV
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
        view.addGradientLayer(frame: view.bounds, colors: [UIColor(hex: "4D6AD5").cgColor, UIColor(hex: "9660A0").cgColor])
        self.view = view
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = FSCalendar(frame: CGRect(x: 20, y: 80, width: self.view.bounds.width-40, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.clear
        self.view.addSubview(calendar)
        self.calendar = calendar
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(80)
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
        self.view.addSubview(closeBtn)
        self.view.addSubview(tableView)
        self.view.addSubview(addTaskBtn)
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        subViewsLayut()
        self.tableView.reloadData()
        self.view.addSubview(emptyView)
        self.view.bringSubviewToFront(emptyView)
    }
    
    //添加task
    @objc func addTaskBtnAction() {
    
        let addVC = AddTaskController(chooseDate: self.selectDate)
        
        self.present(addVC, animated: true) {
            
        }
    }
    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
}

//控件约束
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
        self.tableView.frame.origin.y = calendar.frame.maxY + 10
        self.tableView.frame.size.height = ScreenH - bounds.height - 20
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
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalenderTaskCell = tableView.dequeueReusableCell(withIdentifier: kCalenderTaskCellID)! as! CalenderTaskCell
        return cell
    }
    
}
