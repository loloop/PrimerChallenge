//
//  UserDetailsViewController.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

final class UserDetailsViewController: UIViewController {

    let sections = [
        UserRepositoriesSection()
    ]

    private lazy var collectionView: UICollectionView = {
        let collection = CompositionalCollectionView(frame: view.bounds, sections: sections)
        collection.backgroundColor = .systemBackground
        return collection
    }()

    private lazy var dataSource = DiffableDataSource(sections: sections, on: collectionView)

    init() {
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
