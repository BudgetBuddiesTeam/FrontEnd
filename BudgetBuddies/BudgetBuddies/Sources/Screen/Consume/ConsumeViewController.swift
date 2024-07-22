//
//  ConsumeViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit

class ConsumeViewController: UIViewController {
  // MARK: - Properties

  private var consume = Consume()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    setConsumeView()
    setNavigation()
  }

  // MARK: - Methods

  private func setConsumeView() {
    view.addSubview(consume)

    consume.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func setNavigation() {
    navigationItem.title = "소비 추가하기"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "소비기록", image: UIImage(systemName: "list.clipboard"), target: self, action: #selector(rightBarButtonItemButtonTapped))
    navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
  }
  
  @objc
  private func rightBarButtonItemButtonTapped() {
    debugPrint("소비기록 버튼 탭")
  }
}
