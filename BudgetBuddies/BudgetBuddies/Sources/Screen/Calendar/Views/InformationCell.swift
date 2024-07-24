//
//  InfomationCell.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/16/24.
//

import UIKit

protocol InformationCellDelegate: AnyObject {
    func didTapWebButton(in cell: InformationCell, urlString: String)
}

final class InformationCell: UITableViewCell {
    weak var delegate: InformationCellDelegate?
    
    // 임시 링크 (모델에 타이틀, 기간, 할인률, 링크 다 가지고 있을 거임)
    var urlString: String = ""
    
    enum InfoType {
        case discount
        case support
    }
    
    // MARK: - 배경
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10 //반경
        view.layer.shadowOffset = CGSize(width: 0, height: 0) //위치조정
        view.layer.masksToBounds = false //
        return view
    }()
    
    // MARK: - 로고 이미지뷰
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logoTempImage")
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    // MARK: - 타이틀, 기간, 퍼센트 스택뷰
    let infoTitleLabel: UILabel = {
        let lb = UILabel()
//        lb.text = "지그재그 썸머세일" // 나중에 받을 거
        lb.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.4
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return lb
    }()
    
    // 기간
    private let clockIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clockImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let dateLabel: UILabel = {
        let lb = UILabel()
//        lb.text = "08.17 ~ 08.20" // 나중에 받을 거
        lb.font = UIFont(name: "Pretendard-Regular", size: 12)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.3
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    
    private lazy var dateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [clockIconImageView, dateLabel])
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // upto
    private let percentIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "percentImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let percentLabel: UILabel = {
        let lb = UILabel()
//        lb.text = "~80%" // 나중에 받을 거
        lb.font = UIFont(name: "Pretendard-Regular", size: 12)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.3
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    
    private lazy var percentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [percentIconImageView, percentLabel])
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - 전체 스택뷰
    private lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(/*arrangedSubviews: [infoTitleLabel, dateStackView, percentStackView]*/)
        sv.axis = .vertical
        sv.spacing = 2
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - 댓글, 좋아요
    // 댓글
    private let commentsIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "commentImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let commentsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0" // 나중에 받을 거
        lb.font = UIFont(name: "Pretendard-Regular", size: 14)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.35
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    
    // 좋아요
    private let likesIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "likeImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let likesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0" // 나중에 받을 거
        lb.font = UIFont(name: "Pretendard-Regular", size: 14)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.35
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    
    // MARK: - 사이트 바로가기 버튼
    private lazy var webButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("사이트 바로가기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.8164488077, blue: 0.1144857034, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10

        let title = "사이트 바로가기"
        let font = UIFont(name: "Pretendard-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let attributes: [NSAttributedString.Key: Any] = [.font: font,.kern: -0.35]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        
        btn.addTarget(self, action: #selector(didTapWebButton), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - override init ⭐️
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(backView)
        self.backView.addSubview(logoImageView)
        self.backView.addSubview(verticalStackView)
        self.backView.addSubview(likesIconImageView)
        self.backView.addSubview(likesLabel)
        self.backView.addSubview(commentsLabel)
        self.backView.addSubview(commentsIconImageView)
        self.contentView.addSubview(webButton)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints(){
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(65)
            make.top.leading.equalToSuperview().inset(16)
        }
        
        infoTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        clockIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        
        percentIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(12)
            make.centerY.equalTo(logoImageView.snp.centerY)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(16)
            make.height.equalTo(21)
        }
        
        likesIconImageView.snp.makeConstraints { make in
            make.trailing.equalTo(likesLabel.snp.leading).offset(-2)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.width.equalTo(16)
        }
        
        commentsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(likesIconImageView.snp.leading).offset(-8)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(21)
            make.width.equalTo(9)
        }
        
        commentsIconImageView.snp.makeConstraints { make in
            make.trailing.equalTo(commentsLabel.snp.leading).offset(-4) // 원래는 2, 디자이너분께 물어보기
            make.top.equalToSuperview().inset(20)
            make.height.width.equalTo(15)
            
        }
        
        webButton.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(backView).inset(16)
            make.height.equalTo(39)
        }
    }
    
    // MARK: - Configure
    func configure(infoType: InfoType) {
        // 기존 arragedSubviews제거
        for view in verticalStackView.arrangedSubviews {
            verticalStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        // 다시 추가
        switch infoType {
        case .discount:
            verticalStackView.addArrangedSubview(infoTitleLabel)
            verticalStackView.addArrangedSubview(dateStackView)
            verticalStackView.addArrangedSubview(percentStackView)
            
        case .support:
            verticalStackView.addArrangedSubview(infoTitleLabel)
            verticalStackView.addArrangedSubview(dateStackView)
            
        }
    }
    
    // MARK: - Selectors
    @objc func didTapWebButton() {
        print(#function)
        delegate?.didTapWebButton(in: self, urlString: urlString)
    }
}

