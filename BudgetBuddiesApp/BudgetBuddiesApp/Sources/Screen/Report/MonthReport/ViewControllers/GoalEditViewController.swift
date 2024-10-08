//
//  GoalEditViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/2/24.
//

import SnapKit
import UIKit

struct GoalCategory {
  let name: String
  let placeholder: String
  var amount: Int?
}

final class GoalEditViewController: UIViewController {

  var goalCategories: [GoalCategory] = [
    GoalCategory(name: "식비", placeholder: "ex) 200,000"),
    GoalCategory(name: "쇼핑", placeholder: "ex) 200,000"),
    GoalCategory(name: "문화생활", placeholder: "ex) 200,000"),
    GoalCategory(name: "패션", placeholder: "ex) 200,000"),
  ]

  // MARK: - UI Components
  let textFieldStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 16
    return sv
  }()

  let totalGoalTitleLabel = {
    let label = UILabel()
    label.text = "총 목표 금액"
    label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
    return label
  }()

  let totalGoalLabel = {
    let label = UILabel()
    label.text = "500,000원"
    label.setCharacterSpacing(-0.55)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    return label
  }()

  lazy var finishButton = {
    let button = UIButton(type: .custom)
    button.setTitle("작성완료", for: .normal)
    button.setCharacterSpacing(-0.45)
    button.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    return button
  }()

  // MARK: - Life Cycle
  override func viewWillAppear(_ animated: Bool) {
    setNavi()

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setConsts()
    setupTextFields()
  }

  // MARK: - Set Navi
  private func setNavi() {
    // 뒤로가기 제스처
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationController?.navigationBar.isHidden = false

    navigationItem.title = "6월 소비목표"

    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    self.addBackButton(selector: #selector(didTapBarButtonItem))
  }

  private func setup() {
    view.backgroundColor = .white
    [
      textFieldStackView, totalGoalTitleLabel, totalGoalLabel, finishButton,
    ].forEach {
      view.addSubview($0)
    }
  }

  // MARK: - Set Const
  private func setConsts() {
    textFieldStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      $0.leading.trailing.equalTo(view).inset(16)
    }

    totalGoalTitleLabel.snp.makeConstraints {
      $0.top.equalTo(textFieldStackView.snp.bottom).offset(50)
      $0.leading.equalToSuperview().offset(20)
    }

    totalGoalLabel.snp.makeConstraints {
      $0.top.equalTo(totalGoalTitleLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }

    finishButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)  // 기존 -20에서 -10 추가 (탭바 가려짐 해결)
      $0.height.equalTo(60)
    }
  }

  // 모델에 기반하여 텍스트 필드를 생성하는 함수
  private func setupTextFields() {
    for category in goalCategories {
      let label = UILabel()
      label.text = category.name
      label.setCharacterSpacing(-0.35)
      label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
      label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)

      let textField = UITextField()
      textField.layer.cornerRadius = 15
      textField.placeholder = category.placeholder
      textField.setCharacterSpacing(-0.35)
      textField.backgroundColor = BudgetBuddiesAppAsset.AppColor.textBox.color
      textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
      textField.leftViewMode = .always
      textField.setComfortableTextField()
      textField.keyboardType = .numberPad
      textField.textAlignment = .left
      textField.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)  // 폰트 설정

      let stack = UIStackView(arrangedSubviews: [label, textField])
      stack.axis = .vertical
      stack.spacing = 8

      textFieldStackView.addArrangedSubview(stack)

      textField.snp.makeConstraints {
        $0.height.equalTo(50)
      }

      stack.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
      }
    }
  }

  // MARK: - Selectors
  @objc
  private func didTapBarButtonItem() {
    self.navigationController?.popViewController(animated: true)
  }
}

extension GoalEditViewController: UITextFieldDelegate {
  //화면 터치시 키보드 내림
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension GoalEditViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
