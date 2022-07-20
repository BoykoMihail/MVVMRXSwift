//
//  СryptocurrenciesController.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

private extension String {
    static let tableViewCellIdentifier = "ImageCell"
}

final class СryptocurrenciesController: BaseViewController, IСryptocurrenciesController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(СryptocurrenciesCell.self, forCellReuseIdentifier: .tableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

//    var viewModel: IGalleryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = presenter?.title
        
//        Task {
//            await presenter?.viewDidLoad()
//        }
        Task {
            let count = try await CurrenciesService().fetchPhotos(page: 1).data
            count?.forEach({ ddd in
                debugPrint("BBoyko = ", ddd)
//            https://assets.coincap.io/assets/icons/leo@2x.png
            })
        }
    }
    // MARK: - Setting Views

    override func addSubViews() {
        super.addSubViews()
        view.addSubview(tableView)
        updateData()
    }

    // MARK: - Setting Constraints

    override func setupConstraints() {
        super.setupConstraints()

        if let view = view {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    }

    override func setupAccessibility() {
        super.setupAccessibility()
        view.accessibilityIdentifier = "GalleryController"
        tableView.accessibilityIdentifier = "GalleryController_tableView"
    }

    func updateData() {
        tableView.reloadData()
    }
}

extension СryptocurrenciesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didTapCell(indexPath: indexPath.row)
    }
}

extension СryptocurrenciesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
//        guard let presenter = presenter else {
//            return .zero
//        }
//
//        return presenter.getCellHeight(index: indexPath.row,
//                                       viewWidth: view.bounds.width)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
//        guard let presenter = presenter else {
//            return .zero
//        }
//
//        return presenter.countOfPhotos
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView
//            .dequeueReusableCell(withIdentifier: .tableViewCellIdentifier,
//                                 for: indexPath) as? СryptocurrenciesCell else {
//            return UITableViewCell()
//        }
        let cell = UITableViewCell()
//        let viewModel = presenter.getCellViewModelFor(index: indexPath.row)
//        cell.configure(with: viewModel)
        cell.backgroundColor = .cyan
        cell.accessibilityIdentifier = String.tableViewCellIdentifier + "_\(indexPath.row)"

        return cell
//        guard let cell = tableView
//            .dequeueReusableCell(withIdentifier: .tableViewCellIdentifier,
//                                 for: indexPath) as? СryptocurrenciesCell,
//              let presenter = presenter else {
//            return UITableViewCell()
//        }
//
//        let viewModel = presenter.getCellViewModelFor(index: indexPath.row)
//        cell.configure(with: viewModel)
//
//        cell.accessibilityIdentifier = String.tableViewCellIdentifier + "_\(indexPath.row)"
//
//        return cell
    }
}
