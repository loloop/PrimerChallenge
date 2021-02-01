//
//  UserDetailsViewController.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

protocol UserDetailsViewControllerDelegate: AnyObject {
    func userDetails(didSelect repository: URL)
}

final class UserDetailsViewController: UIViewController {

    lazy var sections = [
        UserRepositoriesSection(user: username, delegate: self)
    ]

    private lazy var collectionView: UICollectionView = {
        let collection = CompositionalCollectionView(frame: view.bounds, sections: sections)
        collection.backgroundColor = .systemBackground
        return collection
    }()

    private lazy var dataSource = DiffableDataSource(sections: sections, on: collectionView)

    private weak var delegate: UserDetailsViewControllerDelegate?
    private let username: String

    init(username: String, delegate: UserDetailsViewControllerDelegate) {
        self.username = username
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.addSubview(collectionView)
        collectionView.constrainToEdges(of: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        dataSource.updateSnapshot()
    }

    func configureTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Repositories"
    }
}

extension UserDetailsViewController: UserRepositoriesSectionDelegate {
    func userRepositoriesSection(didSelect item: URL) {
        delegate?.userDetails(didSelect: item)
    }

    func updateSnapshot() {
        dataSource.updateSnapshot()
    }
}
