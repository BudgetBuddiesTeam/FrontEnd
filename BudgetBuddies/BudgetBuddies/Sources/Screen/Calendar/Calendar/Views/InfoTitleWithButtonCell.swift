//
//  InfoTitleWithButtonCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/26/24.
//

import UIKit

protocol InfoTitleWithButtonCellDelegate: AnyObject {
    func didTapShowDetailViewButton(in cell: InfoTitleWithButtonCell, infoType: InfoTitleWithButtonCell.InfoType)
}

class InfoTitleWithButtonCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "InfoTitleWithButtonCell"
    
    weak var delegate: InfoTitleWithButtonCellDelegate?
    
    enum InfoType {
        case discount
        case support
    }
    
    // 최근 타입을 저장하기 위한 변수
    var currentInfoType: InfoType?
    
    // MARK: - UI Components
    // 세미볼드체 타이틀
    var infoTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
        lb.setCharacterSpacing(-0.55)
        lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
        return lb
    }()
    
    // 전체보기 텍스트
    var showDetailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "전체보기"
        lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
        lb.setCharacterSpacing(-0.35)
        lb.textColor = BudgetBuddiesAsset.AppColor.subGray.color
        return lb
    }()
    
    // 전체보기 chevron
    var chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
        return iv
    }()
    
    // 전체보기 스택뷰
    lazy var showDetailStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [showDetailLabel, chevronImageView])
        sv.axis = .horizontal
        sv.spacing = 2
        sv.alignment = .center
        sv.distribution = .fill
        
        // 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowDetailStackView))
        sv.addGestureRecognizer(tapGesture)
        sv.isUserInteractionEnabled = true
        return sv
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(infoType: InfoType) {
        self.currentInfoType = infoType
        
        switch infoType {
        case .discount:
            infoTitleLabel.text = "할인정보"
        case .support:
            infoTitleLabel.text = "지원정보"
        }
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.addSubviews(infoTitleLabel, showDetailStackView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints()
    private func setupConstraints() {
        infoTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(6)
        }
        
        showDetailLabel.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.width.equalTo(48)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        showDetailStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 + 5)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    // MARK: - Selectors
    @objc
    func didTapShowDetailStackView() {
        guard let infoType = currentInfoType else { return }
        delegate?.didTapShowDetailViewButton(in: self, infoType: infoType)
        print("\(infoType)")
    }
}
