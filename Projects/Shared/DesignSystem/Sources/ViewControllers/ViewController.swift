//
//  ViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import SnapKit

open class ViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Nested Types
    
    private enum NavigationBarStyle {
        case normal
        case large
        
        var height: CGFloat {
            switch self {
            case .normal: return 44
            case .large: return 88
            }
        }
    }
    
    // MARK: - Components
    
    let navigationBar = UIView()
    public let contentView = View()
    
    public private(set) var titleLabel: UILabel?
    public private(set) var subTitleLabel: UILabel?
    public private(set) var backButton: UIButton?
    public private(set) var rightButton: UIButton?
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Public Setup Methods
    
    public func setupNormalNavigationBar(title: String) {
        setupLayout(style: .normal)
        setupBackButton()
        setupNormalTitle(with: title)
    }
    
    public func setupNormalNavigationBar(rightTitle: String, isBackButtonHidden: Bool = false) {
        setupLayout(style: .normal)
        if !isBackButtonHidden {
            setupBackButton()
        }
        setupRightTextButton(with: rightTitle)
    }
    
    public func setupNormalNavigationBar(rightIcon: UIImage) {
        setupLayout(style: .normal)
        setupBackButton()
        setupRightIconButton(with: rightIcon)
    }
    
    public func setupLargeNavigationBar(title: String, subTitle: String? = nil) {
        setupLayout(style: .large)
        setupLargeTitle(with: title)
        if let subTitle = subTitle {
            setupSubTitle(with: subTitle)
        }
    }
    
    public func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    public func setTitleColor(_ color: UIColor) {
        titleLabel?.textColor = color
        subTitleLabel?.textColor = color
    }
    
    // MARK: - Private Setup Methods
    
    private func setupViewController() {
        view.backgroundColor = Colors.background
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupLayout(style: NavigationBarStyle) {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(style.height)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupBackButton() {
        let button = UIButton()
        button.setImage(Images.chevronLeft, for: .normal)
        button.tintColor = Colors.gray09
        
        navigationBar.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton = button
    }
    
    private func setupNormalTitle(with title: String) {
        let label = createLabel(text: title, font: Fonts.heading3, color: Colors.gray09)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel = label
    }
    
    private func setupRightTextButton(with title: String) {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.body1
        config.attributedTitle = attributedTitle
        setupRightButton(with: config)
    }
    
    private func setupRightIconButton(with icon: UIImage) {
        var config = UIButton.Configuration.plain()
        config.image = icon
        setupRightButton(with: config)
    }
    
    private func setupRightButton(with config: UIButton.Configuration) {
        let button = UIButton()
        button.configuration = config
        button.tintColor = Colors.gray09
        
        navigationBar.addSubview(button)
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        rightButton = button
    }
    
    private func setupLargeTitle(with title: String) {
        let label = createLabel(text: title, font: Fonts.heading1, color: Colors.gray09)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        titleLabel = label
    }
    
    private func setupSubTitle(with title: String) {
        let label = createLabel(text: title, font: Fonts.title3, color: Colors.gray04)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(3)
        }
        subTitleLabel = label
    }
    
    // MARK: - Helper Methods
    
    private func createLabel(text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    // MARK: - Action Methods
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
