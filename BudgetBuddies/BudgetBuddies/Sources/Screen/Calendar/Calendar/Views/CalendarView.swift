//
//  CalendarView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import SnapKit
import UIKit

class CalendarView: UIView {
  // MARK: - Properties
  var calendarHeight: Int = 510

  // 할인정보 테이블 뷰 height
  var discountTableViewHeight: Int = 168 + 168 {
    didSet {
      reSetupDiscountTableViewHeight()
    }
  }

  // 지원정보 테이블 뷰 height
  var supportTableViewHeight: Int = 168 + 168 {
    didSet {
      reSetupSupportTableViewHeight()
    }
  }

  var yearMonth: YearMonth? {
    didSet {
      mainCalendarView.yearMonth = self.yearMonth
      guard let yearMonth = self.yearMonth else { return }
      calendarHeight = yearMonth.isSixWeeksLong() ? 590 : 510
      reSetupMainCalendarHeightConstraints()
    }
  }

  // MARK: - UI Components
  // 스크롤뷰
  var scrollView = UIScrollView()
  lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [
      bannerView,
      mainCalendarView,
      infoColorView,
      discountInfoTitleWithButtonView,
      discountInfoTableView,
      supportInfoTitleWithButtonView,
      supportInfoTableView,
    ])
    sv.axis = .vertical
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 0
    return sv
  }()

  // 콘텐트 뷰에 들어갈 컴포넌트들
  var bannerView = BannerView()  // 상단 배너
  var mainCalendarView = MainCalendarView()  // 메인 캘린더
  var infoColorView = InfoColorView()  // 할인정보, 지원정보 색 표시
  var discountInfoTitleWithButtonView = InfoTitleWithButtonView(infoType: .discount)  // 할인정보 타이틀 + 전체보기 버튼

  var discountInfoTableView: UITableView = {  // 할인정보 테이블 뷰
    let tv = UITableView()
    tv.separatorStyle = .none
    tv.backgroundColor = .clear
    return tv
  }()

  var supportInfoTitleWithButtonView = InfoTitleWithButtonView(infoType: .support)  // 지원정보 타이틀 + 전체보기 버튼

  var supportInfoTableView: UITableView = {  // 지원정보 테이블 뷰
    let tv = UITableView()
    tv.separatorStyle = .none
    tv.backgroundColor = .clear
    return tv
  }()

  // MARK: - Init ⭐️
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    // 스크롤 뷰
    self.addSubviews(scrollView)
    scrollView.addSubviews(stackView)

    setupConstraints()
  }
  // MARK: - Re set up CalendarViewHeight
  private func reSetupMainCalendarHeightConstraints() {
    mainCalendarView.snp.removeConstraints()
    mainCalendarView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(calendarHeight)
    }

    // 애니메이션이 좀 이상해서 고쳐야 함
    //        UIView.animate(withDuration: 0.3) {
    //            self.layer.layoutIfNeeded()
    //        }
  }

  // MARK: - Re set up discountTableViewHeight
  private func reSetupDiscountTableViewHeight() {
    discountInfoTableView.snp.removeConstraints()
    discountInfoTableView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(discountTableViewHeight)
    }
  }

  // MARK: - Re set up supportTableViewHeight
  private func reSetupSupportTableViewHeight() {
    supportInfoTableView.snp.removeConstraints()
    supportInfoTableView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(supportTableViewHeight)
    }
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    // 스크롤 뷰
    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }

    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalTo(scrollView)
    }

    // 콘텐트 뷰에 들어갈 컴포넌트
    bannerView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(127)
    }

    mainCalendarView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(calendarHeight)
    }

    infoColorView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(29)
    }

    discountInfoTitleWithButtonView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(64)
    }

    discountInfoTableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(discountTableViewHeight)
    }

    supportInfoTitleWithButtonView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(64)
    }

    supportInfoTableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(supportTableViewHeight)
    }
  }
}
