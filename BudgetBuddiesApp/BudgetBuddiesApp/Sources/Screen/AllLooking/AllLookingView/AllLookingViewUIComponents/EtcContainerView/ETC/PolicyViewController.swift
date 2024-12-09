//
//  PolicyViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/19/24.
//

import SnapKit
import UIKit

final class PolicyViewController: UIViewController {

  // MARK: - UI Components
  private let termsTextView: UITextView = {
    let tv = UITextView()
    tv.isEditable = false
    tv.isScrollEnabled = true
    tv.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    tv.textColor = .darkGray
    tv.text = """
      [빈주머니즈] 이용약관

      1. 약관의 목적
      본 약관은 [빈주머니즈] (이하 “앱”)의 이용 조건 및 절차, 이용자와 앱 운영자 간의 권리 및 의무를 규정함을 목적으로 합니다.

      2. 이용자 정의
      “이용자”란 본 앱에 접속하여 본 약관에 따라 서비스를 이용하는 개인 또는 법인을 의미합니다.

      3. 서비스 제공
      앱은 다음과 같은 서비스를 제공합니다:
      [캘린더, 할인정보, 또래 소비 비교]
      앱은 서비스 개선 및 운영 상 필요에 따라 일부 서비스 내용을 변경하거나 중단할 수 있습니다.

      4. 사용자 책임 및 의무
      이용자는 앱을 합법적이고 도덕적으로 사용해야 하며, 다음 행위를 금지합니다:
      불법적인 콘텐츠 게시
      타인의 권리 침해
      서비스 안정성을 저해하는 행위
      이용자는 계정 정보의 비밀 유지 및 관리에 대한 책임이 있습니다.

      5. 개인정보 보호
      개인정보 보호와 관련된 사항은 개인정보처리방침에 따릅니다. (개인정보처리방침 별도 링크 제공)

      6. 이용 제한
      운영자는 이용자가 약관을 위반할 경우 서비스 이용을 제한하거나 계정을 삭제할 수 있습니다.

      7. 면책 조항
      운영자는 천재지변, 기술적 오류 등 불가항력으로 인해 발생한 서비스 중단에 대해 책임을 지지 않습니다.
      운영자는 이용자가 앱을 사용하는 과정에서 발생한 직접적 또는 간접적 손해에 대해 책임을 지지 않습니다.

      8. 약관의 개정
      본 약관은 법적 요구 사항이나 서비스 개선을 위해 수정될 수 있습니다. 변경 사항은 사전 공지 후 시행됩니다.
      """
    return tv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavi()
    setupUI()
    setConstraints()
  }

  // MARK: - Functions

  private func setNavi() {
    navigationItem.title = "이용약관 및 정책"

    // 뒤로가기 제스처 추가
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationController?.navigationBar.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(termsTextView)
  }

  private func setConstraints() {
    termsTextView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.bottom.equalToSuperview().offset(-16)
    }
  }

  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension PolicyViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
