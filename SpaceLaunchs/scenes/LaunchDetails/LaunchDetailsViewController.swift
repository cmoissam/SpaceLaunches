//
//  LaunchDetailsViewController.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit
import AVKit
import WebKit

class LaunchDetailsViewController: UIViewController {
    
    // MARK :- Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.largeTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.mediumTitle
        label.text = Localizable.LaunchDetailsViewController.descriptionText
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.mediumText
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.largeTitle
        label.textAlignment = .left
        label.textColor = .orange
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.smallText
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private lazy var videoView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return scrollView
    }()
    
    private let interactor: LaunchDetailsUseCase
    
    // MARK: - Initializers
    
    init(
        interactor: LaunchDetailsUseCase
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.LaunchDetailsViewController.title
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.viewModel.addObserver(fireNow: true) { [weak self] in
            self?.updateView(viewModel: $0)
        }
    }
    
    // MARK: - Private Methodes
    
    private func setupViews() {
        stackView.addArrangedSubview(creationDateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descriptionTitle)
        stackView.addArrangedSubview(descriptionLabel)
        scrollView.addSubview(stackView)
        scrollView.addSubview(videoView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            videoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            videoView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: AppConstraint.imageRatio)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: AppConstraint.mediumPadding),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: AppConstraint.mediumPadding),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -AppConstraint.largePadding),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -AppConstraint.mediumPadding),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -AppConstraint.mediumPadding * 2)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func updateView(viewModel: LaunchDetailsViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        creationDateLabel.text = viewModel.creationDate
        guard let url = viewModel.videoLink else { return }
        videoView.load(URLRequest(url: url))
        
    }
}
