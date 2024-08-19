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

  let textFieldStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 16
    return sv
  }()

  let totalGoalTitleLabel = {
    let label = UILabel()
    label.text = "총 목표 금액"
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    return label
  }()

  let totalGoalLabel = {
    let label = UILabel()
    label.text = "500,000원"
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    return label
  }()

  lazy var finishButton = {
    let button = UIButton(type: .custom)
    button.setTitle("작성완료", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    return button
  }()

  override func viewWillAppear(_ animated: Bool) {
    setNavi()

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setConsts()
    setupTextFields()
  }

  private func setNavi() {
    navigationItem.title = "6월 소비목표"
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.shadowColor = nil

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

  private func setup() {
    view.backgroundColor = .white
    [
      textFieldStackView, totalGoalTitleLabel, totalGoalLabel, finishButton,
    ].forEach {
      view.addSubview($0)
    }
  }

  private func setConsts() {
    textFieldStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
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
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)  // 기존 -20에서 -10 추가 (탭바 가려짐 해결)
      $0.height.equalTo(60)
    }
  }

  // 모델에 기반하여 텍스트 필드를 생성하는 함수
  private func setupTextFields() {
    for category in goalCategories {
      let label = UILabel()
      label.text = category.name
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)

      let textField = UITextField()
      textField.layer.cornerRadius = 15
      textField.placeholder = category.placeholder
      textField.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
      textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
      textField.leftViewMode = .always

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
}

extension GoalEditViewController: UITextFieldDelegate {
  //화면 터치시 키보드 내림
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
