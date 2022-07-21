//
//  CryptoDetailViewController.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import UIKit

final class CryptoDetailViewController: BaseViewController {
    // MARK: - UI

    private lazy var cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "arrow.clockwise.circle.fill")
        return imageView
    }()

    private let nameLabelView: UILabel = {
        let nameLabelView = UILabel()
        nameLabelView.textColor = .black
        nameLabelView.font = .customBigSemi
        nameLabelView.translatesAutoresizingMaskIntoConstraints = false
        nameLabelView.textAlignment = .center
        nameLabelView.text = "Bitcoin"
        return nameLabelView
    }()

    private let priceLabelView: UILabel = {
        let priceLabelView = UILabel()
        priceLabelView.textAlignment = .right
        priceLabelView.font = .customBigSemi
        priceLabelView.textColor = .lightDark
        priceLabelView.translatesAutoresizingMaskIntoConstraints = false
        priceLabelView.text = "12345"

        return priceLabelView
    }()

    private let taglineLabelView: UILabel = {
        let taglineLabelView = UILabel()
        taglineLabelView.textAlignment = .center
        taglineLabelView.font = .customSmall
        taglineLabelView.textColor = .lightDark
        taglineLabelView.translatesAutoresizingMaskIntoConstraints = false
        taglineLabelView.text = "Comon! By me!"

        return taglineLabelView
    }()

//    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

//        presenter?.viewDidLoad()
    }

    override func addSubViews() {
        super.addSubViews()

        view.addSubview(cryptoImageView)
        view.addSubview(nameLabelView)
        view.addSubview(priceLabelView)
        view.addSubview(taglineLabelView)
    }

    // MARK: - Setting Constraints

    override func setupConstraints() {
        super.setupConstraints()

        let cryptoImageViewConstraints = getccryptoImageViewConstraints()
        let cryptoNameLabelViewConstraints = getcryptoNameLabelViewConstraints()
        let cryptoTokenLabelViewConstraints = getcryptoTaglineLabelViewConstraints()
        let cryptoPriceLabelViewConstraints = getcryptoPriceLabelViewConstraints()
        let layoutConstraint = cryptoImageViewConstraints
        + cryptoNameLabelViewConstraints
        + cryptoTokenLabelViewConstraints
        + cryptoPriceLabelViewConstraints
        NSLayoutConstraint.activate(layoutConstraint)
    }

    override func setupAccessibility() {
        super.setupAccessibility()
        view.accessibilityIdentifier = "ImageDetailViewController"
    }
}

private extension CryptoDetailViewController {
    // MARK: Private

    private func getccryptoImageViewConstraints() -> [NSLayoutConstraint] {
        let guide = self.view.safeAreaLayoutGuide
        return [
            cryptoImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            cryptoImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            cryptoImageView.heightAnchor.constraint(equalToConstant: 64),
            cryptoImageView.widthAnchor.constraint(equalTo: cryptoImageView.heightAnchor)
        ]
    }

    private func getcryptoNameLabelViewConstraints() -> [NSLayoutConstraint] {
        let guide = self.view.safeAreaLayoutGuide
        return [
            nameLabelView.bottomAnchor.constraint(equalTo: cryptoImageView.centerYAnchor, constant: -4),
            nameLabelView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            nameLabelView.leadingAnchor.constraint(greaterThanOrEqualTo: cryptoImageView.trailingAnchor),
            nameLabelView
                .trailingAnchor
                .constraint(lessThanOrEqualTo: priceLabelView.leadingAnchor)
        ]
    }

    private func getcryptoTaglineLabelViewConstraints() -> [NSLayoutConstraint] {
        let guide = self.view.safeAreaLayoutGuide
        return [
            taglineLabelView
                .trailingAnchor
                .constraint(lessThanOrEqualTo: priceLabelView.leadingAnchor),
            taglineLabelView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            taglineLabelView
                .topAnchor
                .constraint(equalTo: cryptoImageView.centerYAnchor),
            taglineLabelView.leadingAnchor.constraint(greaterThanOrEqualTo: cryptoImageView.trailingAnchor)
        ]
    }

    private func getcryptoPriceLabelViewConstraints() -> [NSLayoutConstraint] {
        let guide = self.view.safeAreaLayoutGuide
        return [
            priceLabelView
                .trailingAnchor
                .constraint(equalTo: guide.trailingAnchor, constant: -16),
            priceLabelView
                .centerYAnchor
                .constraint(equalTo: cryptoImageView.centerYAnchor),
            priceLabelView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8)
        ]
    }
}
