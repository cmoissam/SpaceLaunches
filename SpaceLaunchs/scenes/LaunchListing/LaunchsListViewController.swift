//
//  LaunchsListViewController.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

class LaunchsListViewController: UIViewController {
    
    // MARK :- Properties
    private let launchsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let interactor: LaunchsListUseCase
    private let coordinator: AppRoutingLogic

    // MARK: - Initializers
    
    init(
        interactor: LaunchsListUseCase,
        coordinator: AppRoutingLogic
    ) {
        self.interactor = interactor
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.LaunchsListViewController.title
        setUpRefreshButton()
        setupViews()
        setupConstraints()
        launchsTableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.Identifier)
        
        interactor.viewModel.status.addObserver(fireNow: true) { [weak self] in
            self?.refreshUI(status: $0)
        }
        interactor.fetchData()
    }

    // MARK: - Private Methodes
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            launchsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            launchsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            launchsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            launchsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            noDataLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            noDataLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -AppConstraint.largePadding * 2),
        ])
    }
    
    private func setupViews() {
        launchsTableView.delegate = self
        launchsTableView.dataSource = self
        launchsTableView.estimatedRowHeight = AppConstraint.estimatedRowHeight
        launchsTableView.separatorStyle = .none
        view.addSubview(launchsTableView)
        view.addSubview(noDataLabel)
        view.backgroundColor = .white
    }

    private func refreshUI(status: LaunchsListViewModel.DisplayContext) {
        switch status {
        case .success:
            launchsTableView.isHidden = false
            launchsTableView.reloadData()
        case .noData:
            noDataLabel.text = Localizable.LaunchsListViewController.noData
            launchsTableView.isHidden = true
        case .loading:
            launchsTableView.isHidden = true
        case .updated:
            launchsTableView.reloadData()
        }
    }
}

// MARK: - NavBar
extension LaunchsListViewController {
    private func setUpRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }

    @objc
    func refreshTapped() {
        interactor.fetchData()
    }
}

// MARK: - TableView delegates
extension LaunchsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showLaunchDetailsViewController(
            launch: interactor.viewModel.launchs[indexPath.row]
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LaunchsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.viewModel.launchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LaunchTableViewCell.Identifier,
            for: indexPath
        ) as? LaunchTableViewCell else {
            fatalError("Cannot get cell for identifier: \(LaunchTableViewCell.Identifier)")
        }
        cell.configure(viewModel: LaunchCellViewModel(
            launch: interactor.viewModel.launchs[indexPath.row]
        ))
        return cell
    }
}
