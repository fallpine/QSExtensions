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
        scrView.qs_didScroll = { (sView) in
            print("qs_didScroll")
        }
        
        let imgArr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550900621459&di=a284dcb615570c39251c16d82c10321c&imgtype=0&src=http%3A%2F%2Fwww.pptbz.com%2Fpptpic%2FUploadFiles_6909%2F201306%2F2013062320262198.jpg",
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550900653396&di=16da218d8d8b0eb1d1fd73a5dc2637bb&imgtype=0&src=http%3A%2F%2Fwww.pptok.com%2Fwp-content%2Fuploads%2F2012%2F08%2Fxunguang-4.jpg",
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550900670112&di=2a4c19d6a1b8cab6566ef29725f6303d&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FZZ5EGyuUCp9hBPk6_s4Ehg%3D%3D%2F5727171351132208489.jpg"]
        
        var lastImgView = UIImageView.init()
        for i in 0 ..< imgArr.count {
            let imgView = UIImageView.init()
            scrView.addSubview(imgView)
            imgView.snp.makeConstraints { (make) in
                if i == 0 {
                    make.left.equalToSuperview()
                } else {
                    make.left.equalTo(lastImgView.snp.right).offset(0.0)
                }
                
                make.width.equalTo(view.qs_width)
                make.height.equalTo(200.0)
                make.top.bottom.equalToSuperview()
                
                if i == (imgArr.count - 1) {
                    make.right.equalToSuperview()
                }
            }
            
            lastImgView = imgView
            imgView.qs_setImage(with: imgArr[i], placeholder: nil)
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
            self.scrView.qs_scrollToUpPage(scrollDirection: .horizontal, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { [unowned self] in
                btn.isEnabled = !self.scrView.qs_isScrolledToLeft
                self.nextBtn.isEnabled = !self.scrView.qs_isScrolledToRight
            }
        }
        
        nextBtn.qs_setAction { [unowned self] (btn) in
            self.scrView.qs_scrollToNextPage(scrollDirection: .horizontal, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { [unowned self] in
                btn.isEnabled = !self.scrView.qs_isScrolledToRight
                self.previousBtn.isEnabled = !self.scrView.qs_isScrolledToLeft
            }
        }
    }
    
    // MARK: - Widget
    private lazy var scrView: UIScrollView = {
        let view = UIScrollView.init()
        view.backgroundColor = .lightGray
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
