//
//  AgeEditViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/5/24.
//

import SnapKit
import UIKit

final class AgeEditViewController: BaseViewController {

  // MARK: - Property
  var services = Services()
  var consumePeerInfoResponse: ConsumePeerInfoResponse? = nil

  var selectedGender: String?  // 선택된 성별 저장
  var selectedAgeRange: (Int, Int)?  // 선택된 연령대 저장

  // Delegate 프로퍼티 추가
  weak var delegate: AgeEditViewControllerDelegate?

  let titleLabel = {
    let label = UILabel()
    label.text = "성별과 연령대를\n선택해주세요"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    label.numberOfLines = 0
    return label
  }()

  let genderLabel = {
    let label = UILabel()
    label.text = "성별"
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()

  let textFieldStackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 16
    return sv
  }()

  // 성별 버튼
  lazy var femaleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("여성", for: .normal)
    button.setTitleColor(BudgetBuddiesAppAsset.AppColor.textBlack.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    button.layer.cornerRadius = 15

    button.setShadow(opacity: 1, Radius: 8, offSet: CGSize(width: 0, height: 1))
    button.addTarget(self, action: #selector(selectGender(_:)), for: .touchUpInside)
    button.tag = 0
    return button
  }()

  lazy var maleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("남성", for: .normal)
    button.setTitleColor(BudgetBuddiesAppAsset.AppColor.textBlack.color, for: .normal)
    button.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    button.layer.cornerRadius = 15

    button.setShadow(opacity: 1, Radius: 8, offSet: CGSize(width: 0, height: 1))
    button.addTarget(self, action: #selector(selectGender(_:)), for: .touchUpInside)
    button.tag = 1
    return button
  }()

  lazy var buttonStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [femaleButton, maleButton])
    sv.axis = .horizontal
    sv.distribution = .fillEqually
    sv.alignment = .center
    sv.spacing = 11
    return sv
  }()

  let ageLabel = {
    let label = UILabel()
    label.text = "연령"
    label.textColor = .black
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()

  // 연령대 버튼
  lazy var ageButtons: [UIButton] = {
    let titles = ["20-22세", "23-25세", "26-28세", "29세 이상"]
    return titles.enumerated().map { index, title in
      let button = UIButton(type: .system)
      button.backgroundColor = UIColor.white
      button.setTitle(title, for: .normal)
      button.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
      button.titleLabel?.textAlignment = .left
      button.setTitleColor(.black, for: .normal)
      button.layer.cornerRadius = 15
      button.setShadow(opacity: 1, Radius: 8, offSet: CGSize(width: 0, height: 1))
      button.addTarget(self, action: #selector(selectAge(_:)), for: .touchUpInside)
      button.tag = index
      return button
    }
  }()

  lazy var saveButton = {
    let button = UIButton(type: .custom)
    button.setTitle("저장하기", for: .normal)
    button.setCharacterSpacing(-0.45)
    button.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    button.layer.cornerRadius = 15
    return button
  }()

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    loadPeerInfo()
    setupNavigationBar()
  }

  // MARK: - Set up NavigationBar
  private func setupNavigationBar() {
    //    self.navigationController?.navigationBar.isHidden = true
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    self.navigationController?.setNavigationBarHidden(true, animated: true)  // 이 코드를 작성해야 뒤로 끌었다 취소했을 때 기본 네비바가 생성되지 않음
  }

  override func setUpViewProperty() {
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.background.color
  }

  override func setUp() {
    [titleLabel, genderLabel, buttonStackView, ageLabel, saveButton].forEach {
      view.addSubviews($0)
    }
    ageButtons.forEach { view.addSubview($0) }
  }

  override func setLayout() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }

    genderLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(16)
    }

    femaleButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }

    maleButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }

    buttonStackView.snp.makeConstraints { make in
      make.top.equalTo(genderLabel.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    ageLabel.snp.makeConstraints {
      $0.top.equalTo(buttonStackView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(16)
    }

    for (index, button) in ageButtons.enumerated() {
      button.snp.makeConstraints {
        if index == 0 {
          $0.top.equalTo(ageLabel.snp.bottom).offset(10)
        } else {
          $0.top.equalTo(ageButtons[index - 1].snp.bottom).offset(20)
        }
        $0.leading.trailing.equalTo(view).inset(16)
        $0.height.equalTo(50)
      }
    }

    saveButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
      $0.height.equalTo(60)
    }
  }

  @objc private func selectGender(_ sender: UIButton) {
    selectedGender = sender.tag == 0 ? "female" : "male"
    [femaleButton, maleButton].forEach { $0.setSelected($0 == sender) }
  }

  @objc private func selectAge(_ sender: UIButton) {
    switch sender.tag {
    case 0: selectedAgeRange = (20, 22)
    case 1: selectedAgeRange = (23, 25)
    case 2: selectedAgeRange = (26, 28)
    case 3: selectedAgeRange = (29, 99)  // 29세 이상으로 설정
    default: break
    }
    ageButtons.forEach { $0.setSelected($0 == sender) }
  }

  @objc private func saveButtonTapped() {
    guard let gender = selectedGender, let ageRange = selectedAgeRange else {
      print("성별 또는 연령대가 선택되지 않았습니다.")
      return
    }

    // 서버에 저장하는 로직 대신, delegate를 통해 데이터를 전달
    delegate?.didUpdateAgeAndGender(ageRange: ageRange, gender: gender)

    // 이전 화면으로 돌아가기
    navigationController?.popViewController(animated: true)
  }

  // MARK: - UI 업데이트
  func updateUIWithPeerInfo(peerInfo: ConsumePeerInfoResponse.ConsumePeerInfoResult) {
    // 성별 버튼 선택 업데이트
    if peerInfo.peerGender == "male" {
      selectGender(maleButton)
    } else {
      selectGender(femaleButton)
    }

    // 연령대 버튼 선택 업데이트
    let ageRange = (peerInfo.peerAgeStart, peerInfo.peerAgeEnd)
    switch ageRange {
    case (20, 22): selectAge(ageButtons[0])
    case (23, 25): selectAge(ageButtons[1])
    case (26, 28): selectAge(ageButtons[2])
    case (29, _): selectAge(ageButtons[3])
    default: break
    }
  }
}

extension UIButton {
  func setSelected(_ selected: Bool) {
    if selected {
      self.layer.borderColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color.cgColor
      self.layer.borderWidth = 2
      self.backgroundColor = UIColor.white
    } else {
      self.layer.borderWidth = 0
      self.setShadow(opacity: 1, Radius: 8, offSet: CGSize(width: 0, height: 1))
      self.backgroundColor = UIColor.white
    }
  }
}

// MARK: - 네트워킹

extension AgeEditViewController {

  func loadPeerInfo() {
    services.consumeGoalService.getPeerInfo(
      userId: 1, peerAgeStart: 25, peerAgeEnd: 25, peerGender: "male"
    ) { result in
      switch result {
      case .success(let response):
        self.consumePeerInfoResponse = response
        dump(response)

        // UI 업데이트
        if let peerInfo = response.result {
          self.updateUIWithPeerInfo(peerInfo: peerInfo)
        }

      case .failure(let error):
        print("Failed to load peer info: \(error)")
      }
    }
  }
}

protocol AgeEditViewControllerDelegate: AnyObject {
  func didUpdateAgeAndGender(ageRange: (Int, Int), gender: String)
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension AgeEditViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}
