//
//  QSButton.swift
//  QSExtensions
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit
import SnapKit

public class QSButton: UIView {
    /// 按钮类型
    public enum QSButtonStyle {
        case imageLeft       // 图片在左边
        case imageRight      // 图片在右边
        case imageTop        // 图片在上边
        case imageBottom     // 图片在下边
    }
    
    /// 按钮状态
    public enum QSButtonState {
        case normal
        case selected
        case disabled
    }
    
    /// 初始化
    /// - Parameters:
    ///   - btnStyle: 按钮类型
    ///   - margin: 图标和文字的间距
    convenience public init(btnStyle: QSButtonStyle, margin: CGFloat) {
        self.init(frame: .zero)
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(contentInset.left)
            make.top.greaterThanOrEqualTo(contentInset.top)
            make.right.lessThanOrEqualTo(contentInset.right)
            make.bottom.lessThanOrEqualTo(contentInset.bottom)
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(titleLab)
        contentView.addSubview(imageView)
        
        switch btnStyle {
        case .imageLeft:
            imageView.snp.makeConstraints { make in
                make.left.centerY.equalToSuperview()
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
            }
            
            titleLab.snp.makeConstraints { make in
                make.left.equalTo(imageView.snp.right).offset(margin)
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.right.centerY.equalToSuperview()
            }
            
        case .imageRight:
            imageView.snp.makeConstraints { make in
                make.right.centerY.equalToSuperview()
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
            }
            
            titleLab.snp.makeConstraints { make in
                make.right.equalTo(imageView.snp.left).offset(-margin)
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.centerY.equalToSuperview()
            }
            
        case .imageTop:
            imageView.snp.makeConstraints { make in
                make.top.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
            }
            
            titleLab.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(margin)
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.bottom.centerX.equalToSuperview()
            }
            
        case .imageBottom:
            imageView.snp.makeConstraints { make in
                make.bottom.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
            }
            
            titleLab.snp.makeConstraints { make in
                make.bottom.equalTo(imageView.snp.top).offset(-margin)
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.top.centerX.equalToSuperview()
            }
        }
        
        // 点击事件
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapGesture))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - Func
    /// 设置背景颜色
    public func qs_setBackgroundColor(_ color: UIColor, state: QSButtonState) {
        bgColorDict[state] = color
        
        if state == self.state {
            setBackgroundColor(color)
        }
    }
    
    /// 设置文字
    public func qs_setTitle(_ title: String, state: QSButtonState) {
        titleDict[state] = title
        
        if state == self.state {
            setTitle(title)
        }
    }
    
    /// 设置文字字体大小
    public func qs_setTitleFont(_ font: UIFont, state: QSButtonState) {
        titleFontDict[state] = font
        
        if state == self.state {
            setTitleFont(font)
        }
    }
    
    /// 设置文字颜色
    public func qs_setTitleColor(_ color: UIColor, state: QSButtonState) {
        titleColorDict[state] = color
        
        if state == self.state {
            setTitleColor(color)
        }
    }
    
    /// 设置图片
    public func qs_setImage(_ image: UIImage?, state: QSButtonState) {
        guard let image = image else { return }
        imageDict[state] = image
        
        if state == self.state {
            setImage(image)
        }
    }
    
    /// 按钮点击事件
    public func qs_addTapAction(_ action: @escaping (QSButton) -> ()) {
        clickAction = action
    }
    
    // 点击手势
    @objc private func tapGesture() {
        if qs_eventEnabled {
            qs_eventEnabled = false
            if let block = clickAction {
                if state != .disabled {
                    block(self)
                }
            }
            self.perform(#selector(self.enableBtnEvent), with: nil, afterDelay: qs_eventInterval)
        }
    }
    
    /// 使能按钮点击事件
    @objc private func enableBtnEvent() {
        qs_eventEnabled = true
    }
    
    /// 设置背景颜色
    private func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    /// 设置文字
    private func setTitle(_ title: String) {
        titleLab.text = title
    }
    
    /// 设置文字字体大小
    private func setTitleFont(_ font: UIFont) {
        titleLab.font = font
    }
    
    /// 设置文字颜色
    private func setTitleColor(_ color: UIColor) {
        titleLab.textColor = color
    }
    
    /// 设置图片
    private func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    // MARK: - Property
    private var bgColorDict = [QSButtonState: UIColor]()
    private var titleDict = [QSButtonState: String]()
    private var titleFontDict = [QSButtonState: UIFont]()
    private var titleColorDict = [QSButtonState: UIColor]()
    private var imageDict = [QSButtonState: UIImage]()
    private var clickAction: ((QSButton) -> ())?
    
    // 按钮点击响应时间间隔
    public var qs_eventInterval: TimeInterval = 0.6
    // 点击事件是否有效
    private var qs_eventEnabled: Bool = true
    
    public var state: QSButtonState = .normal {
        didSet {
            if let bgColor = bgColorDict[state] {
                setBackgroundColor(bgColor)
            }
            
            if let title = titleDict[state] {
                setTitle(title)
            }
            
            if let titleFont = titleFontDict[state] {
                setTitleFont(titleFont)
            }
            
            if let titleColor = titleColorDict[state] {
                setTitleColor(titleColor)
            }
            
            if let image = imageDict[state] {
                setImage(image)
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            state = isSelected ? .selected : .normal
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            state = isEnabled ? .normal : .disabled
        }
    }
    
    // 内边距
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentView.snp.updateConstraints { make in
                make.left.greaterThanOrEqualTo(contentInset.left)
                make.top.greaterThanOrEqualTo(contentInset.top)
                make.right.lessThanOrEqualTo(contentInset.right)
                make.bottom.lessThanOrEqualTo(contentInset.bottom)
            }
        }
    }
    
    // MARK: - Widget
    private lazy var contentView: UIView = {
        let view = UIView.init()
        return view
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel.init()
            .qs_font(UIFont.systemFont(ofSize: 15.0))
            .qs_textColor(.black)
            .qs_textAlignment(.center)
        return lab
    }()

    private lazy var imageView: UIImageView = {
        let imgView = UIImageView.init()
        return imgView
    }()
}
