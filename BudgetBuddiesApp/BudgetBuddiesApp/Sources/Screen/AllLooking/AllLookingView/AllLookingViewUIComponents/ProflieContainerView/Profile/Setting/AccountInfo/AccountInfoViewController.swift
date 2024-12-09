//
//  AccountInfoViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/2/24.
//

import SnapKit
import UIKit

class AccountInfoViewController: BaseViewController {

  /// View
  private let accountPhoneNumerView: AccountInfoView = {
    let view = AccountInfoView()
    view.infoTitleLabel.text = "전화번호"
    view.infoLabel.text = "010-1234-5678"
    return view
  }()

  /// ViewController
  private let phoneNumberChangeViewController = PhoneNumberChangeViewController()

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavi()
    setTapGesture()
  }

  private func setNavi() {
    self.navigationItem.title = "계정정보"
    // 뒤로가기 제스처 추가
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationController?.navigationBar.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  override func setUp() {
    view.backgroundColor = .white
    view.addSubview(accountPhoneNumerView)
  }

  override func setLayout() {
    // 그림자 설정
    accountPhoneNumerView.setShadow(opacity: 1, Radius: 12, offSet: CGSize(width: 0, height: 1))

    accountPhoneNumerView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(130)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(81)
    }
  }

  private func setTapGesture() {
    // 전화번호 탭
    let accountPhoneNumerViewTapped = UITapGestureRecognizer(
      target: self, action: #selector(accountPhoneNumerViewTapped))
    accountPhoneNumerView.addGestureRecognizer(accountPhoneNumerViewTapped)
  }

  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }

  @objc private func accountPhoneNumerViewTapped() {
    navigationController?.pushViewController(phoneNumberChangeViewController, animated: true)
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension AccountInfoViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
