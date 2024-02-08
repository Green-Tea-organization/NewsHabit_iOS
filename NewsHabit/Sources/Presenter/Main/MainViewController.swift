//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

class MainViewController: BaseNavigationBarController<MainView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MainView
        else { fatalError("error: MainViewController viewDidLoad") }
        contentView.bindViewModel(MainViewModel())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarLargeTitleText("\(Settings.nickname)님의 뉴빗")
        setNavigationBarSubTitleText("👀 42일 째 모두 읽으셨어요!")
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.title)
        setBackgroundColor(UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)) // 📌
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitleTextColor(.white)
    }
    
}
