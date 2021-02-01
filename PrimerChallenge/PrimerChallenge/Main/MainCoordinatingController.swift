//
//  MainCoordinatingController.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import SwiftUI
import SafariServices

final class MainCoordinatingController: UIViewController {

    private lazy var searchController: UIHostingController<UserSearchView> = {
        let controller = UIHostingController(rootView: UserSearchView(viewModel: UserSearchViewModel(), delegate: self))
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return controller
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        addChild(searchController)
        searchController.view.frame = view.bounds
        view.addSubview(searchController.view)
        searchController.didMove(toParent: self)
    }
}

extension MainCoordinatingController: UserSearchViewDelegate {
    func userSearchView(didSearchFor name: String) {
        let controller = UserDetailsViewController(delegate: self)
        navigationController?.show(controller, sender: nil)
    }

    func openDebugSettings() {
        #if DEBUG
        let debugSettingsView = UIHostingController(rootView: DebugSettingsView(viewModel: .init()))
        navigationController?.present(debugSettingsView, animated: true, completion: nil)
        #endif
    }
}

extension MainCoordinatingController: UserDetailsViewControllerDelegate {
    func userDetails(didSelect repository: String) {
        let safariController = SFSafariViewController(url: URL(string: repository)!)
        navigationController?.present(safariController, animated: true, completion: nil)
    }
}
