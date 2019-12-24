//
//  QSDateViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSDateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Date"
        
        view.addSubview(scrView)
        scrView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 日期转换为字符串
        scrView.addSubview(dateStrLab)
        dateStrLab.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.left.right.equalToSuperview()
            make.top.equalTo(100.0)
        }
        dateStrLab.text = "时间：" + Date.init().qs_changeToString()
        
        // 转换为时间戳
        scrView.addSubview(secondTimestampLab)
        secondTimestampLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateStrLab.snp.bottom).offset(30.0)
        }
        secondTimestampLab.text = "时间戳(秒)：" + Date.init().qs_changeToSecondTimestamp()
        
        // 转换为时间戳
        scrView.addSubview(milliSecondTimestampLab)
        milliSecondTimestampLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(secondTimestampLab.snp.bottom).offset(30.0)
        }
        milliSecondTimestampLab.text = "时间戳(毫秒)：" + Date.init().qs_changeToMilliSecondTimestamp()
        
        // 时间差
        scrView.addSubview(intervalLab)
        intervalLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(milliSecondTimestampLab.snp.bottom).offset(30.0)
        }
        let interval = Date.init().qs_theDateTo(-1).qs_intervalToNow()
        intervalLab.text = "时间差(一天前)：" + "\(interval.days)" + " " + "\(interval.hours)" + " " + "\(interval.minutes)" + " " + "\(interval.seconds)"
        
        // 这个月有多少天
        scrView.addSubview(daysInMonthLab)
        daysInMonthLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(intervalLab.snp.bottom).offset(30.0)
        }
        let daysInMonth = Date.init().qs_daysInMonth()
        daysInMonthLab.text = "这个月有多少天：" + "\(daysInMonth)"
        
        // 星期几
        scrView.addSubview(weekDayLab)
        weekDayLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(daysInMonthLab.snp.bottom).offset(30.0)
        }
        let weekDay = Date.init().qs_weekDay()
        weekDayLab.text = "星期几：" + "\(weekDay)"
        
        // 当前日
        scrView.addSubview(currentDayLab)
        currentDayLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(weekDayLab.snp.bottom).offset(30.0)
        }
        let currentDay = Date.init().qs_day()
        currentDayLab.text = "当前日：" + "\(currentDay)"
        
        // 当前月
        scrView.addSubview(currentMonthLab)
        currentMonthLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentDayLab.snp.bottom).offset(30.0)
        }
        let currentMonth = Date.init().qs_month()
        currentMonthLab.text = "当前月：" + "\(currentMonth)"
        
        // 当前年
        scrView.addSubview(currentYearLab)
        currentYearLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentMonthLab.snp.bottom).offset(30.0)
        }
        let currentYear = Date.init().qs_year()
        currentYearLab.text = "当前年：" + "\(currentYear)"
        
        // 当前时
        scrView.addSubview(currentHourLab)
        currentHourLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentYearLab.snp.bottom).offset(30.0)
        }
        let currentHour = Date.init().qs_hour()
        currentHourLab.text = "当前时：" + "\(currentHour)"
        
        // 当前分
        scrView.addSubview(currentMinuteLab)
        currentMinuteLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentHourLab.snp.bottom).offset(30.0)
        }
        let currentMinute = Date.init().qs_minute()
        currentMinuteLab.text = "当前分：" + "\(currentMinute)"
        
        // 是否是昨天
        scrView.addSubview(isYesterdayLab)
        isYesterdayLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentMinuteLab.snp.bottom).offset(30.0)
        }
        let yesterday = Date.init().qs_theDateTo(-1)
        isYesterdayLab.text = "是否是昨天" + yesterday.qs_changeToString() + "：" + "\(yesterday.qs_isYesterday())"
        
        // 是否是今天
        scrView.addSubview(isTodayLab)
        isTodayLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(isYesterdayLab.snp.bottom).offset(30.0)
        }
        isTodayLab.text = "是否是今天" + yesterday.qs_changeToString() + "：" + "\(yesterday.qs_isToday())"
        
        // 是否是明天
        scrView.addSubview(isTomorrowLab)
        isTomorrowLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(isTodayLab.snp.bottom).offset(30.0)
            make.bottom.equalTo(-100.0)
        }
        isTomorrowLab.text = "是否是明天" + yesterday.qs_changeToString() + "：" + "\(yesterday.qs_isTomorrow())"
    }
    
    // MARK: - Widget
    private lazy var scrView: UIScrollView = {
        let scr = UIScrollView.init()
        scr.backgroundColor = .white
        return scr
    }()
    
    private lazy var dateStrLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var secondTimestampLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var milliSecondTimestampLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var intervalLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var daysInMonthLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var weekDayLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var currentDayLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var currentMonthLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var currentYearLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var currentHourLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var currentMinuteLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var isYesterdayLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var isTodayLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var isTomorrowLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
}
