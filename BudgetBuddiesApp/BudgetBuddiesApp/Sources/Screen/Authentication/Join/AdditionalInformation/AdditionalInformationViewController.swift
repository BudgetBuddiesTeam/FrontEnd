//
//  AdditionalInformationViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/18/24.
//

import UIKit

class AdditionalInformationViewController: UIViewController {
    // MARK: - Properties
    let additionalInformationView = AdditionalInformationView()
    
    var isRegionPicked: Bool = false {
        didSet {
            additionalInformationView.continueButtonToggle(isRegionPicked, isMobileCarrierSelected, isInterestCategoriesSelected)
        }
    }
    
    var isMobileCarrierSelected: Bool = false {
        didSet {
            additionalInformationView.continueButtonToggle(isRegionPicked, isMobileCarrierSelected, isInterestCategoriesSelected)
        }
    }

    var isInterestCategoriesSelected: Bool = false {
        didSet {
            additionalInformationView.continueButtonToggle(isRegionPicked, isMobileCarrierSelected, isInterestCategoriesSelected)
        }
    }
    
    var isInterestCategoriesDictionary: [String: Bool] = [:] {
        didSet {
            let selected = self.isInterestCategoriesDictionary.values.contains { isSelected in
                if isSelected {
                    return true
                }
                
                return false
            }
            
            self.isInterestCategoriesSelected = selected
        }
    }
    
    // 임시로 선택한 장소를 담을 변수 + 뷰에 지역 이름 변경
    var selectedRegionFromPicker: String? {
        didSet {
            guard let region = selectedRegionFromPicker else { return }
            additionalInformationView.regionPickerView.changeTitleToSelectedRegion(region)
        }
    }

    // MARK: - Life Cycle
    override func loadView() {
        self.view = additionalInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupButtonActions()
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        addBackButton(selector: #selector(didTapBackButton))
    }
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        // 거주지역 선택 tapGesture
        additionalInformationView.regionPickerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegionPicker)))
        
        // 통신사 버튼 actions
        additionalInformationView.mobileCarrierButtonArray.forEach {
            $0.addTarget(self, action: #selector(didTapMobileCarrierButton), for: .touchUpInside)
        }
        
        // 관심 카테고리 actions
        additionalInformationView.interestCategoryButtonArray.forEach {
            $0.addTarget(self, action: #selector(didTapInterestCategoryButton), for: .touchUpInside)
        }
        
        // 건너뛰기 버튼
        additionalInformationView.skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        
        // 선택 후 계속하기 버튼
        additionalInformationView.continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapMobileCarrierButton(sender: ClearBackgroundRadioButton) {
        additionalInformationView.moblieCarrierRadioButtonToggle(sender)
        self.isMobileCarrierSelected = true
    }
    
    @objc
    private func didTapInterestCategoryButton(sender: ClearBackgroundCheckBoxButton) {
        sender.toggleButton()
        
        self.isInterestCategoriesDictionary[sender.interestCategory.rawValue] = sender.isButtonTapped
    }
    
    // 거주지역 바꾸는 selector
    @objc
    private func didTapRegionPicker() {
        print(#function)
        let regionPickerVC = RegionPickerViewController()
        regionPickerVC.delegate = self
        regionPickerVC.modalPresentationStyle = .overFullScreen
        self.present(regionPickerVC, animated: true, completion: nil)
    }
    
    // 건너뛰기 selector
    @objc
    private func didTapSkipButton() {
        nextViewController()
    }
    
    // 선택 후 계속하기 selector
    @objc
    private func didTapContinueButton() {
        nextViewController()
    }
    
    // MARK: - Functions
    private func nextViewController() {
        let registerCompleteVC = RegisterCompleteViewController()
        self.navigationController?.pushViewController(registerCompleteVC, animated: true)
    }
}

// MARK: - RegionPickerViewController Delegate
extension AdditionalInformationViewController: RegionPickerViewControllerDelegate {
    func didRegionSelected(_ region: String) {
        self.selectedRegionFromPicker = region
        self.isRegionPicked = true
    }
}
