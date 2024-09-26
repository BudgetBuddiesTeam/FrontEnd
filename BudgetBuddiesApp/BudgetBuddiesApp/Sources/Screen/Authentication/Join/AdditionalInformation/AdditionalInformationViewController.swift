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
        additionalInformationView.interestedCategoryButtonArray.forEach {
            $0.addTarget(self, action: #selector(didTapInterestedCategoryButton), for: .touchUpInside)
        }
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapMobileCarrierButton(sender: ClearBackgroundRadioButton) {
        additionalInformationView.moblieCarrierRadioButtonToggle(sender)
        
        
    }
    
    @objc
    private func didTapInterestedCategoryButton(sender: ClearBackgroundCheckBoxButton) {
        sender.toggleButton()
        print("\(sender.interestedCategory) \(sender.isButtonTapped)")
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
}

// MARK: - RegionPickerViewController Delegate
extension AdditionalInformationViewController: RegionPickerViewControllerDelegate {
    func didRegionSelected(_ region: String) {
        self.selectedRegionFromPicker = region
    }
}
