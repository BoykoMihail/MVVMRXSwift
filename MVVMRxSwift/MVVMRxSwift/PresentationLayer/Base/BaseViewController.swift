//
//  BaseViewController.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        setupAccessibility()
        setupBind()
        view.backgroundColor = .white
    }

    // MARK: - Setting Views

    internal func addSubViews() {}

    // MARK: - Setting Constraints

    internal func setupConstraints() {}

    // MARK: - Setting Accessibilities

    internal func setupAccessibility() {}

    // MARK: - Setting Bindings

    internal func setupBind() {}
}
