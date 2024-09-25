//
//  RegionCell.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/24/24.
//

import UIKit
import SnapKit

class RegionCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "RegionCell"
    
    var region: String? {
        didSet {
            guard let region = region else { return }
            regionLabel.text = region
        }
    }
    
    
    // MARK: - UI Components
    // 지역 라벨
    let regionLabel: UILabel = {
        let lb = UILabel()
        lb.text = " "
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        lb.setCharacterSpacing(-0.4)
        return lb
    }()
    
    // separator
    let cellSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)
        return view
    }()


    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        
        self.addSubviews(regionLabel, cellSeparator)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        regionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        cellSeparator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}
