//
//  AgeEditViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/5/24.
//

import SnapKit
import UIKit

final class AgeEditViewController: UIViewController {

  let titleLabel = {
    let label = UILabel()
    label.text = "성별과 연령대를\n선택해주세요"
    label.textColor = .black
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.numberOfLines = 0
    return label
  }()

  let genderLabel = {
    let label = UILabel()
    label.text = "성별"
    label.textColor = .black
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
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
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 15
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowRadius = 10  //반경
    button.addTarget(self, action: #selector(selectGender(_:)), for: .touchUpInside)
    button.tag = 0
    return button
  }()

  lazy var maleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("남성", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 15
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowRadius = 10  //반경
    button.addTarget(self, action: #selector(selectGender(_:)), for: .touchUpInside)
    button.tag = 1
    return button
  }()

  let ageLabel = {
    let label = UILabel()
    label.text = "연령"
    label.textColor = .black
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()

  // 연령대 버튼
  lazy var ageButtons: [UIButton] = {
    let titles = ["20-22세", "23-25세", "26-28세", "29세 이상"]
    return titles.enumerated().map { index, title in
      let button = UIButton(type: .system)
      button.setTitle(title, for: .normal)
      button.titleLabel?.textAlignment = .left
      button.setTitleColor(.black, for: .normal)
      button.layer.cornerRadius = 15
      button.layer.borderColor = UIColor.lightGray.cgColor
      button.layer.borderWidth = 1
      button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
      button.layer.shadowOpacity = 1
      button.layer.shadowRadius = 10  //반경
      button.addTarget(self, action: #selector(selectAge(_:)), for: .touchUpInside)
      button.tag = index
      return button
    }
  }()

  lazy var saveButton = {
    let button = UIButton(type: .custom)
    button.setTitle("저장하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    button.layer.cornerRadius = 15
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setConsts()
  }

  private func setup() {
    [titleLabel, genderLabel, femaleButton, maleButton, ageLabel, saveButton].forEach {
      view.addSubviews($0)
    }
    ageButtons.forEach { view.addSubview($0) }
  }

  private func setConsts() {
    //        textFieldStackView.snp.makeConstraints {
    //            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
    //            $0.leading.trailing.equalTo(view).inset(16)
    //        }

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
      $0.top.equalTo(genderLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(16)
      $0.width.equalTo(160)
      $0.height.equalTo(50)
    }

    maleButton.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(10)
      $0.trailing.equalToSuperview().offset(-16)
      $0.width.equalTo(160)
      $0.height.equalTo(50)
    }

    ageLabel.snp.makeConstraints {
      $0.top.equalTo(femaleButton.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(16)
    }

    for (index, button) in ageButtons.enumerated() {
      button.snp.makeConstraints {
        if index == 0 {
          $0.top.equalTo(ageLabel.snp.bottom).offset(20)
        } else {
          $0.top.equalTo(ageButtons[index - 1].snp.bottom).offset(20)
        }
        $0.leading.trailing.equalTo(view).inset(16)
        $0.height.equalTo(50)
      }
    }

    saveButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      $0.height.equalTo(60)
    }
  }

  @objc private func selectGender(_ sender: UIButton) {
    [femaleButton, maleButton].forEach { $0.setSelected($0 == sender) }
  }

  @objc private func selectAge(_ sender: UIButton) {
    ageButtons.forEach { $0.setSelected($0 == sender) }
  }
}

extension UIButton {
  func setSelected(_ selected: Bool) {
    if selected {
      self.layer.borderColor = BudgetBuddiesAsset.AppColor.coreYellow.color.cgColor
      self.layer.borderWidth = 2
      self.backgroundColor = UIColor.white
    } else {
      self.layer.borderColor = UIColor.lightGray.cgColor
      self.layer.borderWidth = 1
      self.backgroundColor = UIColor.clear
    }
  }
}
