//
//  QSUIScrollViewViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/8/12.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIScrollViewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UIScrollView"
        
        view.backgroundColor = .white
        
        view.addSubview(scrView)
        scrView.snp.makeConstraints { (make) in
            make.top.equalTo(100.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(200.0)
        }
        scrView.qs_didScroll = { (scrView) in
            print("qs_didScroll")
        }
        
        scrView.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.width.equalTo(view.qs_width)
            make.height.equalTo(200.0)
            make.left.top.bottom.equalToSuperview()
        }
        
        scrView.addSubview(greenView)
        greenView.snp.makeConstraints { make in
            make.width.height.top.bottom.equalTo(redView)
            make.left.equalTo(redView.snp_right)
        }
        
        scrView.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.width.height.top.bottom.equalTo(greenView)
            make.left.equalTo(greenView.snp_right)
            make.right.equalToSuperview()
        }
        
        view.addSubview(previousBtn)
        previousBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20.0)
            make.top.equalTo(scrView.snp.bottom).offset(15.0)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20.0)
            make.top.equalTo(scrView.snp.bottom).offset(15.0)
        }
        
        previousBtn.qs_setAction { [unowned self] (btn) in
            self.scrView.qs_pageUp(direction: .horizontal, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { [unowned self] in
                btn.isEnabled = !self.scrView.qs_isOnTheLeft
                self.nextBtn.isEnabled = !self.scrView.qs_isOnTheRight
            }
        }
        
        nextBtn.qs_setAction { [unowned self] (btn) in
            self.scrView.qs_pageDown(direction: .horizontal, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { [unowned self] in
                btn.isEnabled = !self.scrView.qs_isOnTheRight
                self.previousBtn.isEnabled = !self.scrView.qs_isOnTheLeft
            }
        }
    }
    
    // MARK: - Widget
    private lazy var scrView: UIScrollView = {
        let view = UIScrollView.init()
        view.backgroundColor = .lightGray
        view.isPagingEnabled = true
        return view
    }()
    
    private lazy var redView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var greenView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var blueView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var previousBtn: UIButton = {
        let btn = UIButton.init()
            .qs_setTitleColor(.blue, for: .normal)
            .qs_setTitleColor(.lightGray, for: .disabled)
            .qs_setTitle("上一页", for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton.init()
            .qs_setTitleColor(.blue, for: .normal)
            .qs_setTitleColor(.lightGray, for: .disabled)
            .qs_setTitle("下一页", for: .normal)
        return btn
    }()
}
