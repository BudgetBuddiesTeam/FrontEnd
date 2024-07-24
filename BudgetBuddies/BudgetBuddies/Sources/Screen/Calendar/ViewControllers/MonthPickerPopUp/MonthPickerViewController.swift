//
//  MonthPickerViewController.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/21/24.
//

import UIKit

protocol MonthPickerViewDelegate: AnyObject {
  func didViewClosed(selectedMonth: Int)
}

final class MonthPickerViewController: DimmedViewController {
  weak var delegate: MonthPickerViewDelegate?

  var selectedIndexPath: IndexPath? {
    didSet {
      guard let selectedIndexPath = selectedIndexPath else { return }
      print("\(selectedIndexPath.row + 1)월 선택")
    }
  }

  var currentSelectedMonth: Int?

  // MARK: - Properties
  private let backView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 15
    return view
  }()

  private let yearLabel: UILabel = {
    let lb = UILabel()
    lb.text = "2024"
    lb.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    lb.textAlignment = .center
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.4
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    return lb
  }()

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    return cv
  }()

  // MARK: - init
  override init() {
    super.init()
    setupUI()
    setupCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    close()
  }
  // MARK: - Set up CollectionView
  private func setupCollectionView() {
    //        collectionView.backgroundColor = .gray

    collectionView.delegate = self
    collectionView.dataSource = self

    // 셀 등록
    collectionView.register(MonthPickerCell.self, forCellWithReuseIdentifier: "MonthPickerCell")

    self.backView.addSubview(collectionView)

    collectionView.snp.makeConstraints { make in
      make.top.equalTo(yearLabel.snp.bottom).offset(16)
      make.leading.bottom.trailing.equalToSuperview().inset(16)
    }
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.view.addSubview(backView)
    self.backView.addSubview(yearLabel)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(30)
      make.height.equalTo(224)
      make.center.equalToSuperview()
    }

    yearLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview().inset(16)
      make.height.equalTo(24)
    }

  }

  // MARK: - Selectors
  private func close() {
    // 캘린더뷰컨에 전달
    guard let selectedIndexPath = selectedIndexPath else { return }
    delegate?.didViewClosed(selectedMonth: selectedIndexPath.row + 1)
    dismiss(animated: true)
    print("dismiss Done")
  }
}

// MARK: - UICollectionView DataSource
extension MonthPickerViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return 12
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "MonthPickerCell", for: indexPath)
      as! MonthPickerCell
    cell.monthLabel.text = "\(indexPath.row + 1)월"
    return cell
  }
}
// MARK: - UICollectionView Delegate
extension MonthPickerViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let selectedColor = #colorLiteral(red: 1, green: 0.8164488077, blue: 0.1144857034, alpha: 1)
    let unSelectedLabelColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)

    if let selectedIndexPath = selectedIndexPath {
      let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? MonthPickerCell
      previousCell?.backView.backgroundColor = .clear
      previousCell?.monthLabel.textColor = unSelectedLabelColor
    }

    let cell = collectionView.cellForItem(at: indexPath) as! MonthPickerCell
    cell.backView.backgroundColor = selectedColor
    cell.monthLabel.textColor = .white

    selectedIndexPath = indexPath
  }

}

// MARK: - UICollectionView Delegate Flow Layout
extension MonthPickerViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 8
  }

  // minimumLineSpacingForSectionAt
  // vertical => 아이템 간 간격
  // horizontal => 위 아래 간격
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 8
  }

  // 컬렉션 아이템(셀) 사이즈 정하기
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    //        let width = (view.frame.width - 1 - 1) / 3 // 3개의 컬랙션 뷰가 한 줄에 있을 거니까 2개의 빈칸 빼고, 가로를 3으로 나누기
    let width = (self.backView.frame.width - 16 - 16 - 8 - 8) / 3
    return CGSize(width: width, height: 32)
  }
}
