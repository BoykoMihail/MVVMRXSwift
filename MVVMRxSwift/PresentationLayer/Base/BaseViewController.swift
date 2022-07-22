//
//  BaseViewController.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

private extension String {
    static let alertTitle = "Something went wrong"
    static let alertMessage = "Please try again later"
}

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

extension BaseViewController {
    // MARK: - Error Handling
    func handle(error: Error) {
        let alert = UIAlertController(title: .alertTitle, message: .alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
