//
//  MainCoordinatingController.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import SwiftUI

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
        navigationController?.show(UIViewController(), sender: nil)
    }
}
