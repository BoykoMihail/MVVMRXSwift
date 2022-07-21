//
//  СryptocurrenciesCell.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

final class СryptocurrenciesCell: UITableViewCell {
    // MARK: Init

    private let cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let cryptoNameLabelView: UILabel = {
        let nameLabelView = UILabel()
        nameLabelView.textColor = .black
        nameLabelView.font = .customMedium
        nameLabelView.translatesAutoresizingMaskIntoConstraints = false
        nameLabelView.textAlignment = .right
        return nameLabelView
    }()

    private let cryptoPriceLabelView: UILabel = {
        let priceLabelView = UILabel()
        priceLabelView.textAlignment = .left
        priceLabelView.font = .customBigSemi
        priceLabelView.textColor = .lightDark
        priceLabelView.translatesAutoresizingMaskIntoConstraints = false
        return priceLabelView
    }()

    private let cryptoTokenLabelView: UILabel = {
        let cryptoTokenLabelView = UILabel()
        cryptoTokenLabelView.textAlignment = .right
        cryptoTokenLabelView.textColor = .lightGray
        cryptoTokenLabelView.font = .customSmall
        cryptoTokenLabelView.translatesAutoresizingMaskIntoConstraints = false
        return cryptoTokenLabelView
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: UITableViewCell

    override func prepareForReuse() {
        cryptoImageView.image = nil
        cryptoNameLabelView.text = nil
        cryptoPriceLabelView.text = nil
        cryptoTokenLabelView.text = nil
        super.prepareForReuse()
    }

    // MARK: Configure

    func configure(with viewModel: СryptocurrenciesCellViewModel) {
        cryptoImageView.image = viewModel.image
        cryptoNameLabelView.text = viewModel.name
        cryptoPriceLabelView.text = viewModel.price
        cryptoTokenLabelView.text = viewModel.token
    }
}

extension СryptocurrenciesCell {
    // MARK: Private

    private func setupViews() {
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(cryptoNameLabelView)
        contentView.addSubview(cryptoPriceLabelView)
        contentView.addSubview(cryptoTokenLabelView)
    }

    private func setupConstraints() {
        let cryptoImageViewConstraints = getccryptoImageViewConstraints()
        let cryptoNameLabelViewConstraints = getcryptoNameLabelViewConstraints()
        let cryptoTokenLabelViewConstraints = getcryptoTokenLabelViewConstraints()
        let cryptoPriceLabelViewConstraints = getcryptoPriceLabelViewConstraints()
        let layoutConstraint = cryptoImageViewConstraints
        + cryptoNameLabelViewConstraints
        + cryptoTokenLabelViewConstraints
        + cryptoPriceLabelViewConstraints
        NSLayoutConstraint.activate(layoutConstraint)
    }

    private func getccryptoImageViewConstraints() -> [NSLayoutConstraint] {
        [
            cryptoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cryptoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cryptoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cryptoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cryptoImageView.widthAnchor.constraint(equalTo: cryptoImageView.heightAnchor)
        ]
    }

    private func getcryptoNameLabelViewConstraints() -> [NSLayoutConstraint] {
        [
            cryptoNameLabelView
                .leadingAnchor
                .constraint(equalTo: cryptoImageView.trailingAnchor,
                            constant: 8),
            cryptoNameLabelView.topAnchor.constraint(greaterThanOrEqualTo: cryptoImageView.topAnchor),
            cryptoNameLabelView
                .bottomAnchor
                .constraint(equalTo: cryptoImageView.centerYAnchor,
                            constant: -2),
            cryptoNameLabelView
                .trailingAnchor
                .constraint(lessThanOrEqualTo: cryptoPriceLabelView.trailingAnchor)
        ]
    }

    private func getcryptoTokenLabelViewConstraints() -> [NSLayoutConstraint] {
        [
            cryptoTokenLabelView
                .leadingAnchor
                .constraint(equalTo: cryptoImageView.trailingAnchor,
                            constant: 8),
            cryptoTokenLabelView
                .topAnchor
                .constraint(equalTo: cryptoImageView.centerYAnchor,
                            constant: 2),
            cryptoTokenLabelView
                .bottomAnchor
                .constraint(lessThanOrEqualTo: cryptoImageView.bottomAnchor),
            cryptoTokenLabelView
                .trailingAnchor
                .constraint(lessThanOrEqualTo: cryptoPriceLabelView.trailingAnchor)
        ]
    }

    private func getcryptoPriceLabelViewConstraints() -> [NSLayoutConstraint] {
        [
            cryptoPriceLabelView
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cryptoPriceLabelView
                .centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor),
            cryptoPriceLabelView
                .heightAnchor
                .constraint(equalToConstant: 16)
        ]
    }
}
