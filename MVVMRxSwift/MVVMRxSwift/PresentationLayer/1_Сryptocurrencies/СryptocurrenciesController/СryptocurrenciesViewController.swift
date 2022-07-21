//
//  СryptocurrenciesViewController.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import RxSwift
import SwiftUI
import UIKit

private extension String {
    static let tableViewCellIdentifier = "ImageCell"
}

final class СryptocurrenciesViewController: BaseViewController, IСryptocurrenciesController {
    // MARK: Dependency

    var viewModel: IСryptocurrenciesViewModel?

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK: UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(СryptocurrenciesCell.self, forCellReuseIdentifier: .tableViewCellIdentifier)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView(frame: .zero)

        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

    private lazy var viewSpinner: UIView = {
            let view = UIView(frame: CGRect(
                                x: 0,
                                y: 0,
                                width: view.frame.size.width,
                                height: 100)
            )
            let spinner = UIActivityIndicatorView()
            spinner.center = view.center
            view.addSubview(spinner)
            spinner.startAnimating()
            return view
        }()

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
    }

    // MARK: - Setting Views

    override func addSubViews() {
        super.addSubViews()
        view.addSubview(tableView)
    }

    // MARK: - Setting Constraints

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    // MARK: - Setting Accessibilities

    override func setupAccessibility() {
        super.setupAccessibility()
        view.accessibilityIdentifier = "GalleryController"
        tableView.accessibilityIdentifier = "GalleryController_tableView"
    }

    // MARK: - Setting Bindings

    override func setupBind() {
        super.setupBind()
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)

        viewModel?
            .cryptocurrenciesCellViewModels
            .bind(to: tableView.rx.items) { tableView, index, element in
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: .tableViewCellIdentifier,
                                         for: indexPath) as? СryptocurrenciesCell else {
                    return UITableViewCell()
                }
                cell.configure(with: element)
                return cell
            }
            .disposed(by: disposeBag)

        bindTableViewForSelection()
        bindTableViewForPagination()
    }

    // MARK: - Private

    @objc
    private func refreshControlTriggered() {
        viewModel?.refreshControlAction.onNext(())
    }

    private func bindTableViewForSelection() {
        Observable
            .zip(tableView.rx.itemSelected,
                 tableView.rx.modelSelected(СryptocurrenciesCellViewModel.self))
            .bind { [weak self] indexPath, model in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                self?.viewModel?.didSelectCell(model: model)
                let viewModel = LineChartViewModel(service: CurrenciesService(),
                                                   token: model.token,
                                                   name: model.name,
                                                   dragGesture: true)
                let vc = UIHostingController(rootView: ContactPickerView(lineChartViewModel: viewModel))

                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

    private func bindTableViewForPagination() {
        tableView.rx
            .didScroll
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                let offSetY = self.tableView.contentOffset.y
                let contentHeight = self.tableView.contentSize.height

                if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                    self.viewModel?.fetchMoreDatas.onNext(())
                }
            }
            .disposed(by: disposeBag)

        viewModel?.isLoadingSpinnerAvaliable
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isAvaliable in
                guard let isAvaliable = isAvaliable.element,
                      let self = self else { return }
                self.tableView.tableFooterView = isAvaliable ? self.viewSpinner : UIView(frame: .zero)
            }
            .disposed(by: disposeBag)

        viewModel?.refreshControlCompelted
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
}
