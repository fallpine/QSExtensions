//
//  QSTimerViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSTimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Timer"
        
        view.addSubview(numLab)
        numLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        view.addSubview(createBtn)
        createBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(numLab.snp.bottom).offset(60.0)
        }
        
        view.addSubview(pauseBtn)
        pauseBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(createBtn.snp.bottom).offset(30.0)
        }
        
        view.addSubview(restartBtn)
        restartBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pauseBtn.snp.bottom).offset(30.0)
        }
        
        view.addSubview(invalidateBtn)
        invalidateBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(restartBtn.snp.bottom).offset(30.0)
        }
    }
    
    // MARK: - Func
    @objc private func createTimer() {
        timer = Timer.qs_init(timeInterval: 0.5, timeOut: { [unowned self] (timer) in
            self.numCount += 1
            self.numLab.text = "\(self.numCount)"
        })
    }
    
    @objc private func pauseTimer() {
        timer?.qs_pause()
    }
    
    @objc private func restartTimer() {
        timer?.qs_restart()
    }
    
    @objc private func invalidateTimer() {
        timer?.qs_invalidate()
    }
    
    // MARK: - Property
    private var numCount: Int = 0
    private var timer: Timer?
    
    // MARK: - Widget
    private lazy var numLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 18.0)
        lab.textAlignment = .center
        lab.text = "0"
        return lab
    }()
    
    private lazy var createBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("创建", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(self.createTimer), for: .touchUpInside)
        return btn
    }()
    
    private lazy var pauseBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("暂停", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(self.pauseTimer), for: .touchUpInside)
        return btn
    }()
    
    private lazy var restartBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("重新开始", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(self.restartTimer), for: .touchUpInside)
        return btn
    }()
    
    private lazy var invalidateBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("终止", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(self.invalidateTimer), for: .touchUpInside)
        return btn
    }()
}
