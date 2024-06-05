//
//  TodayNewsCountCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

import SnapKit
import Then

final class TodayNewsCountCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "TodayNewsCountCell"
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.font = .body
        $0.textColor = .label
    }
    
    private let selectedButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 15)
        $0.tintColor = .label
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        selectedButton.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with count: Int) {
        titleLabel.text = "\(count)개"
    }
    
    func setSelected(_ isSelected: Bool) {
        selectedButton.configuration?.image = isSelected ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle")
    }
    
}
