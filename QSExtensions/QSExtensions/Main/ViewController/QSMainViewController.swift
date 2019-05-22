//
//  QSMainViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit
import SnapKit

class QSMainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        qs_setNavBarShadowImage(isHidden: true, color: .blue)
        qs_setExtendNavBar(isExtend: false)
        qs_setNavBarBgColor(.yellow)
    }
    
    // MARK: - Property
    private lazy var viewModel: QSMainViewModel = {
        let vm = QSMainViewModel.init()
        return vm
    }()
    
    // MARK: - Widget
    private lazy var tableView: UITableView = {
        let table = UITableView.init()
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
}

extension QSMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let text = viewModel.dataSource[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
}

extension QSMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(QSDateViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(QSMd5ViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(QSEncodeViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(QSStringViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(QSTimerViewController(), animated: true)
        case 5:
            navigationController?.pushViewController(QSUIBarButtonItemViewController(), animated: true)
        case 6:
            navigationController?.pushViewController(QSUIButtonViewController(), animated: true)
        case 7:
            navigationController?.pushViewController(QSUIColorViewController(), animated: true)
        case 8:
            navigationController?.pushViewController(QSUIFontViewController(), animated: true)
        case 9:
            navigationController?.pushViewController(QSUIImageViewController(), animated: true)
        case 10:
            navigationController?.pushViewController(QSUIImageViewViewController(), animated: true)
        case 11:
            navigationController?.pushViewController(QSUILabelViewController(), animated: true)
        case 12:
            navigationController?.pushViewController(QSUITextFieldViewController(), animated: true)
        case 13:
            navigationController?.pushViewController(QSUITextViewViewController(), animated: true)
        case 14:
            navigationController?.pushViewController(QSUIViewViewController(), animated: true)
        case 15:
            navigationController?.pushViewController(QSViewController(), animated: true)
        default:
            break
        }
    }
}
