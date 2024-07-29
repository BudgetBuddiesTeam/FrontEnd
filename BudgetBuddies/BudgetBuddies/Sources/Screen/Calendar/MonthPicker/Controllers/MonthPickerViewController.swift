//
//  MonthPickerViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit
import SnapKit

final class MonthPickerViewController: DimmedViewController {
    // MARK: - Properties
    private let monthPicker = MonthPicker()
    
    var calendarModel: YearMonth? {
        didSet {
            setupData()
        }
    }
    
    // MARK: - init
    override init() {
        super.init()
        
        setupUI()
        setupButtons()
        setupTapGestures()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.view.addSubview(monthPicker)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        monthPicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(283)
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Set up CollectionView
    private func setupCollectionView() {
        monthPicker.monthCollectionView.register(MonthCell.self, forCellWithReuseIdentifier: MonthCell.identifier)
        
        monthPicker.monthCollectionView.delegate = self
        monthPicker.monthCollectionView.dataSource = self
    }
    
    // MARK: - Set up Data
    private func setupData() {
        monthPicker.calendarModel = calendarModel
    }
    
    // MARK: - Set up Buttons
    private func setupButtons() {
        monthPicker.selectButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
    }
    
    // MARK: - Set up Tap Gestures
    private func setupTapGestures() {
      self.view.isUserInteractionEnabled = true
      let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
      view.addGestureRecognizer(viewTapGesture)

      // 뒷 배경만을 눌렀을 경우에 dismiss가 되도록
      // bottomSheet에 temp gesture 설정
      // 다른 방법이 있다면 추후에 수정할 예정
      monthPicker.isUserInteractionEnabled = true
      let tempTapGesture = UITapGestureRecognizer(target: self, action: nil)
      monthPicker.addGestureRecognizer(tempTapGesture)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapSelectButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionView DataSource
extension MonthPickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let monthCell = monthPicker.monthCollectionView.dequeueReusableCell(withReuseIdentifier: MonthCell.identifier, for: indexPath) as! MonthCell
        monthCell.monthLabel.text = "\(indexPath.row + 1)월"
        monthCell.monthLabel.setCharacterSpacing(-0.4)
        
        if let month = calendarModel?.month {
            if indexPath.row + 1 == month {
                monthCell.backView.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
                monthCell.monthLabel.textColor = BudgetBuddiesAsset.AppColor.white.color
            } else {
                monthCell.backView.backgroundColor = .clear
                monthCell.monthLabel.textColor = BudgetBuddiesAsset.AppColor.subGray.color
            }
        }
        
        return monthCell
    }
}

// MARK: - UICollectionView Delegate Flow Layout
extension MonthPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // minimumLineSpacingForSectionAt
    // vertical => 아이템 간 간격
    // horizontal => 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // 컬렉션 아이템(셀) 사이즈 정하기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (monthPicker.frame.width - 16 - 16 - 8 - 8) / 3
        return CGSize(width: width, height: 32)
    }
}
