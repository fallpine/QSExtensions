//
//  QSViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIViewController"
        
        view.backgroundColor = .red
        
        qs_setNavBarShadowImage(isHidden: true, color: .blue)
        qs_setExtendNavBar(isExtend: false)
        qs_setNavBarBgColor(.yellow)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        qs_setNavBarShadowImage(isHidden: true, color: .blue)
//        qs_setExtendNavBar(isExtend: false)
        qs_setNavBarBgColor(.white)
//        qs_useNavLargeTitle(false)
//        qs_setNavTitle()
    }
}
