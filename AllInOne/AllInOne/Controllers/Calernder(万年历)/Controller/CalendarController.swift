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
import WCDBSwift

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
    
    //日程数据
    var dakaInfoS: Array = [DakaInfo]() {
        didSet {
            tableView.reloadData()
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
        btn.frame = CGRect(x: 20, y: 20, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tabV = UITableView(frame: CGRect(x: 0, y: kCalenderViewH+20, width: ScreenW, height: ScreenH-310), style: .plain)
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
        self.view.addSubview(tableView)
        self.view.addSubview(addTaskBtn)
        
        self.tableView.reloadData()
        
// 上下滑动展开日历 禁用
//        self.view.addGestureRecognizer(self.scopeGesture)
//        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
//        self.view.addSubview(emptyView)
//        self.view.bringSubviewToFront(emptyView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        getDakaInfo()
    }
    
    //检测是否有新建的打卡记录
    func getDakaInfo() {
        
        let dataBase: Database
        dataBase = Database(withPath: BaseDBPath)
        
        do {
            let dakaInfos: [DakaInfo] = try dataBase.getObjects(fromTable: BaseDakaTable)
            if dakaInfos.count > 0 {
                dakaInfoS = dakaInfos.reversed()
            }
        } catch {
            print("查找失败")
        }
    }
    
    func createDakaView(dakaInfo: DakaInfo) {
        let dakaView = BaseShadowView(frame: CGRect(x: kMagin, y: kCalenderViewH + 20, width: ScreenW-kMagin*2, height: 80))
        let dakaInfoView = DakaInfoView(frame: CGRect(x: 0, y: 0, width: ScreenW-kMagin*2, height: 80))
        dakaInfoView.infoTitle = dakaInfo.dakaName
        dakaView.addSubview(dakaInfoView)
        view.addSubview(dakaView)
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
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension CalendarController: UITableViewDelegate,UITableViewDataSource {
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dakaInfoS.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalenderTaskCell = tableView.dequeueReusableCell(withIdentifier: kCalenderTaskCellID)! as! CalenderTaskCell
        cell.selectionStyle = .none
        let dakaInfo = dakaInfoS[indexPath.row]
        cell.infoTitle = dakaInfo.dakaName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CalenderTaskCell = tableView.dequeueReusableCell(withIdentifier: kCalenderTaskCellID)! as! CalenderTaskCell
        cell.selecteBtn.isSelected = true
    }
    
}
