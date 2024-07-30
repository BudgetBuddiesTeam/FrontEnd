//
//  MonthPicker.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import SnapKit
import UIKit

class MonthPicker: UIView {
  // MARK: - Properties
  var calendarModel: YearMonth? {
    didSet {
      guard let calendarModel = calendarModel else { return }
      guard let year = calendarModel.year else { return }

      self.year = year
    }
  }

  var year: Int? {
    didSet {
      guard let year = year else { return }
      self.yearLabel.text = String(year)
    }
  }

  // MARK: - UI Components
  // 년도 라벪
  var yearLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    lb.setCharacterSpacing(-0.4)
    return lb
  }()

  // 년도 버튼
  lazy var prevButton: UIButton = {
    let btn = UIButton()
    btn.setImage(UIImage(named: "prevButtonImage"), for: .normal)
    btn.contentMode = .scaleAspectFill
    btn.addTarget(self, action: #selector(didTapPrevButton), for: .touchUpInside)
    return btn
  }()

  lazy var nextButton: UIButton = {
    let btn = UIButton()
    btn.setImage(UIImage(named: "nextButtonImage"), for: .normal)
    btn.contentMode = .scaleAspectFill
    btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    return btn
  }()

  // header StackView
  lazy var headerStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [prevButton, yearLabel, nextButton])
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 14
    return sv
  }()

  // collectionView
  lazy var monthCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    return cv
  }()

  // 확인 버튼
  lazy var selectButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("확인", for: .normal)
    btn.setTitleColor(BudgetBuddiesAsset.AppColor.white.color, for: .normal)
    btn.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    btn.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    btn.titleLabel?.setCharacterSpacing(-0.4)
    btn.layer.masksToBounds = true
    btn.layer.cornerRadius = 8
    return btn
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 15
    self.backgroundColor = BudgetBuddiesAsset.AppColor.white.color

    self.addSubviews(headerStackView, monthCollectionView, selectButton)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    yearLabel.snp.makeConstraints { make in
      make.height.equalTo(24)
      make.width.equalTo(41)
    }

    prevButton.snp.makeConstraints { make in
      make.height.width.equalTo(12)
    }

    nextButton.snp.makeConstraints { make in
      make.height.width.equalTo(12)
    }

    headerStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(15)
      make.height.equalTo(24)
      make.centerX.equalToSuperview()
    }

    monthCollectionView.snp.makeConstraints { make in
      make.top.equalTo(yearLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(152)

    }

    selectButton.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview().inset(12)
      make.height.equalTo(48)
    }
  }

  // MARK: - Selectors
  @objc
  private func didTapPrevButton() {
    guard let year = self.year else { return }
    self.year = year - 1
  }

  @objc
  private func didTapNextButton() {
    guard let year = self.year else { return }
    self.year = year + 1
  }
}
