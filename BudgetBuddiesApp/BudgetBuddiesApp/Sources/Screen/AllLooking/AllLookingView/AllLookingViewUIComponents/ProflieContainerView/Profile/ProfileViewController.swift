//
//  ProfileViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/25/24.
//

import UIKit
import SnapKit
import Combine
import Moya

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    /// View
    private let profileView = ProfileView()
    
    /// ViewController
    private let profileEditViewController = ProfileEditViewController()
    private let accountInfoViewController = AccountInfoViewController()
    private let addtionInfoViewController = AddtionInfoViewController()
    private let notificationInfoViewController = NotificationInfoViewController()
    
    
    /// Combine
    private var cancellable = Set<AnyCancellable>()

    /// Network
    private let provider = MoyaProvider<UserRouter>()
    
    /// Variable
    private let userId = 1
    @Published private var userName = String()
    
    // MARK: - View Life Cycle

    override func loadView() {
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchUserData(userId: self.userId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setNavigationSetting()
        observeUserNameProperty()
        setTapGesture()
    }
    
    private func setNavigationSetting() {
      navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.title = "마이페이지"
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        self.addBackButton(selector: #selector(didTapBarButton))
    }
    @objc
    private func didTapBarButton() {
      self.navigationController?.popViewController(animated: true)
    }
    
    private func observeUserNameProperty() {
      self.$userName
        .sink { [weak self] newValue in
            self?.profileView.profileTopView.nameLabel.text = newValue
        }
        .store(in: &cancellable)
    }
    
    private func setTapGesture() {
        /// 프로필 상단 뷰 탭
        let profileTopViewTapped = UITapGestureRecognizer(
            target: self, action: #selector(profileTopViewTapped))
        profileView.profileTopView.addGestureRecognizer(profileTopViewTapped)
        
        /// 사용자 설정의 계정 정보 탭
        let accountInfoViewTapped = UITapGestureRecognizer(target: self, action: #selector(accountInfoViewTapped))
        profileView.settingContainerView.accountInfoContainer.addGestureRecognizer(accountInfoViewTapped)
        
        /// 사용자 설정의 추가 정보 탭
        let addtionInfoViewTapped = UITapGestureRecognizer(target: self, action: #selector(addtionInfoViewTapped))
        profileView.settingContainerView.addtionInfoContainer.addGestureRecognizer(addtionInfoViewTapped)
        
        /// 사용자 설정의 알림 설정 탭
        let notificationViewTapped = UITapGestureRecognizer(target: self, action: #selector(notificationViewTapped))
        profileView.settingContainerView.notificationContainer.addGestureRecognizer(notificationViewTapped)
        
        /// 기타의 버전정보 탭
        /// 기타의 캐시 파일 삭제 탭
        /// 기타의 로그아웃 탭
        /// 기타의 회원 탈퇴 탭
    }
}

extension ProfileViewController {
    @objc private func profileTopViewTapped() {
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    
    @objc private func accountInfoViewTapped() {
        navigationController?.pushViewController(accountInfoViewController, animated: true)
    }
    
    @objc private func addtionInfoViewTapped() {
        navigationController?.pushViewController(addtionInfoViewController, animated: true)
    }
    
    @objc private func notificationViewTapped() {
        navigationController?.pushViewController(notificationInfoViewController, animated: true)
    }
    
    
}

extension ProfileViewController {
  public func fetchUserData(userId: Int) {
    provider.request(.find(userId: userId)) { result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            ApiResponseResponseUserDto.self, from: response.data)
          self.userName = decodedData.result.name
        } catch {
          self.userName = "다시 시도하세요"
        }
      case .failure:
        let fetchUserFailureAlertController = UIAlertController(
          title: "알림", message: "사용자 정보를 가져오지 못했습니다", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.userName = "다시 시도하세요"
        }
        fetchUserFailureAlertController.addAction(confirmedButtonAction)
        self.present(fetchUserFailureAlertController, animated: true)
      }
    }
  }
}
