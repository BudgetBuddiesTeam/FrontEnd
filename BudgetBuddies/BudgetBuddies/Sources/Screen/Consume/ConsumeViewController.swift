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
  }

  // MARK: - Methods

  private func setConsumeView() {
    view.addSubview(consume)

    consume.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

}
