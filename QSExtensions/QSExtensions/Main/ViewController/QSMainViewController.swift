//
//  QSMainViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit

class QSMainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Main"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [unowned self] in
            self.tableView.qs_setBouncesBg(color: .red)
        }
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
            navigationController?.pushViewController(QSTextFieldViewController(), animated: true)
        case 13:
            navigationController?.pushViewController(QSTextViewViewController(), animated: true)
        case 14:
            navigationController?.pushViewController(QSQSButtonViewController(), animated: true)
        case 15:
            navigationController?.pushViewController(QSUIViewViewController(), animated: true)
        case 16:
            navigationController?.pushViewController(QSViewController(), animated: true)
        case 17:
            navigationController?.pushViewController(QSEqualOriginViewController(), animated: true)
        case 18:
            navigationController?.pushViewController(QSMJRefreshViewController(), animated: true)
        case 19:
            navigationController?.pushViewController(QSUIScrollViewViewController(), animated: true)
        default:
            break
        }
    }
}
