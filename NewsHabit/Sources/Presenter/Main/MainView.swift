//
//  MainView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import Combine
import UIKit

class MainView: UIView {
    
    private var viewModel: MainViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let todayNewsLabel = UILabel().then {
        $0.text = "오늘의 뉴스"
        $0.textColor = .label
        $0.font = .titleFont
        $0.isUserInteractionEnabled = true
    }
    
    let monthlyRecordLabel = UILabel().then {
        $0.text = "이번 달 기록"
        $0.textColor = .label
        $0.font = .titleFont
        $0.isUserInteractionEnabled = true
    }
    
    let separator = UIView().then {
        $0.backgroundColor = .newsHabitLightGray
    }
    
    let indicator = UIView().then {
        $0.backgroundColor = .label
    }
    
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let todayNewsView = TodayNewsView()
    
    let monthlyRecordView = UIView().then {
        $0.backgroundColor = .systemYellow.withAlphaComponent(0.1)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupGestureRecognizer()
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        backgroundColor = .background
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupHierarchy() {
        addSubview(todayNewsLabel)
        addSubview(monthlyRecordLabel)
        addSubview(separator)
        addSubview(indicator)
        addSubview(scrollView)
        scrollView.addSubview(todayNewsView)
        scrollView.addSubview(monthlyRecordView)
    }
    
    private func setupLayout() {
        todayNewsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        monthlyRecordLabel.snp.makeConstraints {
            $0.top.equalTo(todayNewsLabel.snp.top)
            $0.leading.equalTo(todayNewsLabel.snp.trailing).offset(15)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(todayNewsLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        indicator.snp.makeConstraints {
            $0.width.equalTo(monthlyRecordLabel.snp.width)
            $0.height.equalTo(3)
            $0.centerY.equalTo(separator.snp.centerY)
            $0.centerX.equalTo(todayNewsLabel.snp.centerX)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        todayNewsView.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        monthlyRecordView.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalTo(todayNewsView.snp.trailing)
            $0.width.equalTo(scrollView.snp.width)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setupGestureRecognizer() {
        // 탭 제스처 인식기 설정
        addTapGestureRecognizer(to: todayNewsLabel, action: #selector(handleTodayNewsTap))
        addTapGestureRecognizer(to: monthlyRecordLabel, action: #selector(handleMonthlyRecordTap))

        // 스와이프 제스처 인식기 설정
        addSwipeGestureRecognizer(to: self, action: #selector(handleTodayNewsTap), direction: .right)
        addSwipeGestureRecognizer(to: self, action: #selector(handleMonthlyRecordTap), direction: .left)
    }
    
    private func setupViewModel() {
        let todayNewsViewModel = TodayNewsViewModel()
        todayNewsView.bindViewModel(todayNewsViewModel)
        todayNewsViewModel.input.send(.getTodayNews)
    }
    
}

// MARK: - Bind ViewModel

extension MainView {
    
    func bindViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        viewModel.$selectedMenu
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedMenu in
                self?.updateMenuPosition(for: selectedMenu)
            }
            .store(in: &cancellables)
    }
    
    private func updateMenuPosition(for menu: MainOption) {
        let indicatorPosition = menu == .todayNews ? todayNewsLabel : monthlyRecordLabel
        let viewOffset = menu == .todayNews ? CGPoint(x: 0, y: 0) : CGPoint(x: scrollView.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.2) {
            self.indicator.snp.remakeConstraints {
                $0.width.equalTo(indicatorPosition.snp.width)
                $0.height.equalTo(3)
                $0.centerY.equalTo(self.separator.snp.centerY)
                $0.centerX.equalTo(indicatorPosition.snp.centerX)
            }
            self.scrollView.setContentOffset(viewOffset, animated: true)
            self.layoutIfNeeded()
        }
    }
    
}

// MARK: - Setup Gesture Recognizers

extension MainView {
    
    private func addTapGestureRecognizer(to view: UIView, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addSwipeGestureRecognizer(to view: UIView, action: Selector, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: action)
        swipeGestureRecognizer.direction = direction
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
}

// MARK: - Action Handlers

extension MainView {
    
    @objc private func handleTodayNewsTap() {
        viewModel?.selectedMenu = .todayNews
    }
    
    @objc private func handleMonthlyRecordTap() {
        viewModel?.selectedMenu = .monthlyRecord
    }
    
}
