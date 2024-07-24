//
//  WebViewController.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/17/24.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    // MARK: - Properties
    let webView = WKWebView()
    
    var urlString: String = ""

    // MARK: - Life Cycle ⭐️
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupNavigationBar()
    }
    
    // MARK: - Set up NavigationBar
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(didTapbarButtonItem))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
    }
    
    // MARK: - Set up UI
    func setupWebView() {
        self.view.backgroundColor = .systemBackground
//        self.webView.scrollView.delegate = self
        
        // webView 불러오기
        guard let url = URL(string: self.urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.webView.load(URLRequest(url: url))
        
        self.view.addSubview(webView)
        
        setupWebViewConstraints()
    }
    
    // MARK: - Set up Constraints
    func setupWebViewConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    @objc func didTapbarButtonItem() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
}

//extension WebViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        if offsetY > 50 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
//}
