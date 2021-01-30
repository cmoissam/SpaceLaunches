//
//  LaunchTableViewCell.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

class LaunchTableViewCell : UITableViewCell {
    
    static let Identifier = "LaunchTableViewCell"

    private let launchNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = AppFont.mediumTitle
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let launchImage: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .black
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    private let borderedView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: LaunchCellViewModel? {
        didSet {
            self.updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        borderedView.addSubview(launchImage)
        borderedView.addSubview(infosStackView)
        infosStackView.addArrangedSubview(launchNameLabel)
        addSubview(borderedView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderedView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: AppConstraint.smallPadding),
            borderedView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -AppConstraint.smallPadding),
            borderedView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: AppConstraint.smallPadding),
            borderedView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -AppConstraint.smallPadding)
        ])
        NSLayoutConstraint.activate([
            launchImage.centerYAnchor.constraint(equalTo: borderedView.centerYAnchor),
            launchImage.widthAnchor.constraint(equalTo: borderedView.widthAnchor, multiplier: 0.25),
            launchImage.heightAnchor.constraint(equalTo: launchImage.widthAnchor, multiplier: AppConstraint.imageRatio),
            launchImage.leadingAnchor.constraint(equalTo: borderedView.leadingAnchor, constant: AppConstraint.mediumPadding),
            launchImage.topAnchor.constraint(greaterThanOrEqualTo: borderedView.topAnchor, constant: AppConstraint.mediumPadding),
            launchImage.bottomAnchor.constraint(lessThanOrEqualTo: borderedView.bottomAnchor, constant: -AppConstraint.mediumPadding)
        ])
        
        NSLayoutConstraint.activate([
            infosStackView.leadingAnchor.constraint(equalTo: launchImage.trailingAnchor, constant: AppConstraint.mediumPadding),
            infosStackView.trailingAnchor.constraint(equalTo: borderedView.trailingAnchor, constant: -AppConstraint.largePadding),
            infosStackView.centerYAnchor.constraint(equalTo: borderedView.centerYAnchor),
            infosStackView.topAnchor.constraint(greaterThanOrEqualTo: borderedView.topAnchor, constant: AppConstraint.mediumPadding),
            infosStackView.bottomAnchor.constraint(lessThanOrEqualTo: borderedView.bottomAnchor, constant: -AppConstraint.mediumPadding)
        ])
    }

    func configure(
        viewModel: LaunchCellViewModel
    ) {
        self.viewModel = viewModel
    }
    
    private func updateUI() {
        guard let safeViewModel = self.viewModel else {
            debugPrint("cannot update UI with nil viewModel")
            return
        }
        launchNameLabel.text = safeViewModel.title
        launchImage.loadImage(safeViewModel.smallImageUrl)
    }
}

struct LaunchCellViewModel {
    let title: String
    let smallImageUrl: String?
    
    init(
        launch: Launch
    ) {
        title = launch.missionName
        smallImageUrl = launch.links.missionPatchSmall
    }
}
