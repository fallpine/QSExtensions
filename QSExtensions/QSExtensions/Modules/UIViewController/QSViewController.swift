//
//  QSViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/21.
//  Copyright © 2019 Song. All rights reserved.
//

import RxSwift
import RxCocoa

class QSViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        rx.qs_viewDidLoad
            .bind { [unowned self] _ in
                self.title = "UIViewController"

                self.view.backgroundColor = .red

                self.qs_setNavBarShadowImage(isHidden: true, color: .blue)
                self.qs_setNavBarBgColor(.yellow)
        }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.qs_setExtendNavBar(isExtend: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        qs_setNavBarShadowImage(isHidden: false, color: .lightGray)
        qs_setNavBarBgColor(.white)
    }
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
}
