//
//  AlertManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/3/24.
//

import UIKit

class AlertManager {

  /// 화면에 알림을 표시합니다.
  ///
  /// 이 메서드는 'UIViewController'에서 알림을 표시하며,
  /// 'needsCancelButton'값에 따라 취소 버튼의 추가 여부를 결정합니다.
  /// 취소 버튼이 필요한 경우 'needsCancelButton'을 'true'
  /// 취소 버튼이 필요 없는 경우 'needsCancelButton'을 'false'로 설정합니다.
  /// 확인 버튼은 기본으로 추가되어 있습니다.
  ///
  /// - Parameters:
  ///   - vc: 알림을 표시할 대상 'UIViewController' 인스턴스입니다.
  ///   - title: 알림의 제목을 나타내는 문자열입니다.
  ///   - message: 알림의 내용이나 메세지를 나타내는 문자열입니다. 메세지가 필요 없는 경우 'nil'을 사용할 수 있습니다.
  ///   - needsCancelButton: 'true'일 경우 취소 버튼이 추가되고, 'false'일 경우 추가되지 않습니다.
    ///   
  public static func showAlert(
    on vc: UIViewController, title: String, message: String?, needsCancelButton: Bool
  ) {
    // 나중에 api통신을 위해 UI작업은 main큐에서
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

      // 취소 버튼이 필요하면 추가
      if needsCancelButton {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
      }

      // 뷰컨에 알림 표시
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      vc.present(alert, animated: true, completion: nil)
    }
  }
}
