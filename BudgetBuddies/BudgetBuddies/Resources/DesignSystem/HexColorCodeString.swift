//
//  HexColorCodeString.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/23/24.
//

import Foundation

/// 헥스컬러코드 스트링
///
/// Assets에 있는 항목들을 우선적으로 사용하고, 안되면 해당 파일에 있는 항목들을 사용해주세요.
enum HexColorCodeString {

  /// 화면 반배경, 버튼
  static let coreYellow = "FFD01D"

  /// 아이콘 내 밝은 파랑색, 원형 그래프 일부
  static let coreBlue = "00A1F1"

  /// 본문 내 모든 흑백 텍스트
  static let textBlack = "111111"

  /// 아이콘, 뒤로가기 버튼, 각종 캡션 텍스트
  static let subGray = "767676"

  /// 캘린더(정보) 내 '지원정보' 띠 바탕색
  static let calendarBlue = "E6F7FF"

  /// 아이콘내에서 진한 파란색
  static let subBlue = "0076B0"

  /// 흰색 무채색 바탕을 제외한 기본 바탕색
  static let background = "F9F9F9"

  /// 텍스트 입력 박스, 원형 게이지
  static let textBox = "F5F5F5"

  /// 캐릭터 로고(주머니)에서 얼굴을 이루는 테두리
  static let logoLine = "FFB803"

  /// 캐릭터 로고(주머니)에서 끈 stroke, 그래프 등 오렌지 컬러의 중심축
  static let logoLine2 = "FFA903"

  /// 텍스트 박스 내 예시 글자
  static let textExample = "B7B7B7"

  /// 지원 / 할인정보 우측 상단의 하트 pressed 컬러
  static let heart = "FF4D00"

  /// 텍스트 박스 , 원형 게이지 회색 stroke, 각종 구분선
  static let circleStroke = "E5E5E5"

  /// 표정 캐릭터(주머니 x)의 얼굴 바탕 컬러
  static let face = "FFECA5"

  /// 회색 버튼
  static let grayButton = "F3F1F1"

  /// 캘린더 내 할인정보 띠 바탕 컬러
  static let calendarYellow = "FFF7CD"

  /// 하단 바 non selected 아이콘 컬러
  static let barGray = "C8C8C8"
}
