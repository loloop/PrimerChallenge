//
//  UserRepositoriesSection.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

protocol UserRepositoriesSectionDelegate: AnyObject {
    func userRepositoriesSection(didSelect item: URL)
    func updateSnapshot()
}

final class UserRepositoriesSection: BaseDiffableSection {

    enum State: Equatable {
        case loading
        case error(NetworkError)
        case partiallyLoaded
        case fullyLoaded

        static func == (lhs: UserRepositoriesSection.State, rhs: UserRepositoriesSection.State) -> Bool {
            switch (lhs, rhs) {
            case (.error(_), .error(_)):
                return true
            case (.loading, .loading):
                return true
            case (.partiallyLoaded, .partiallyLoaded):
                return true
            case (.fullyLoaded, .fullyLoaded):
                return true
            default:
                return false
            }
        }
    }

    private lazy var repositoryCellRegistration = UICollectionView.CellRegistration<RepositoryCell, GitHubRepository> { (cell, indexPath, model) in
        cell.setupCell(titleText: model.name, subtitleText: model.owner.login, imageURL: model.owner.avatarUrl)
    }

    private lazy var loadingCellRegistration = UICollectionView.CellRegistration<LoadingCell, LoadingHashable> { (cell, _, _) in
        cell.activityIndicator.startAnimating()
    }

    private lazy var errorCellRegistration = UICollectionView.CellRegistration<ErrorCell, RepositoryErrorHashable> {
        (cell, indexPath, model) in
        cell.setupCell(with: model.error.message)
    }

    private weak var delegate: UserRepositoriesSectionDelegate?
    private let service: GitHubService
    private var currentPage: Int = 1
    private let currentUser: String
    private var state: State = .loading

    init(user: String,
         delegate: UserRepositoriesSectionDelegate,
         service: GitHubService = .init()) {
        self.currentUser = user
        self.delegate = delegate
        self.service = service
        super.init()
        loadRepositories()
    }

    func loadRepositories() {
        service.repositories(for: currentUser, page: currentPage) { [weak self] (result, lastPage) in
            switch result {
            case .success(let repositories):
                self?.currentItems.append(contentsOf: repositories)
                if !lastPage {
                    self?.currentPage += 1
                }
                self?.state = lastPage ? .fullyLoaded : .partiallyLoaded
            case .failure(let error):
                self?.state = .error(error)
            }

            self?.delegate?.updateSnapshot()
        }
    }

    override func dequeueReusableCell(_ collectionView: UICollectionView, for indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? {

        switch item {
        case let item as GitHubRepository:
            return collectionView.dequeueConfiguredReusableCell(using: repositoryCellRegistration, for: indexPath, item: item)

        case let item as LoadingHashable:
            return collectionView.dequeueConfiguredReusableCell(using: loadingCellRegistration, for: indexPath, item: item)

        case let item as RepositoryErrorHashable:
            return collectionView.dequeueConfiguredReusableCell(using: errorCellRegistration, for: indexPath, item: item)

        default:
            return nil
        }
    }

    override func dequeueReusableSupplementary(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView? {
        nil
    }

    override func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let isRegularSizeClass = environment.traitCollection.horizontalSizeClass == .regular
        let size = NSCollectionLayoutSize(widthDimension: isRegularSizeClass ? .fractionalWidth(0.5) : .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: isRegularSizeClass ? .estimated(216) : .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    var currentItems: [GitHubRepository] = []

    override var items: [AnyHashable] {
        switch state {
        case .fullyLoaded:
            return currentItems
        case .partiallyLoaded:
            var array: [AnyHashable] = []
            array.append(contentsOf: currentItems)
            array.append(LoadingHashable())
            return array
        case .loading:
            return [LoadingHashable()]
        case .error(let error):
            return [RepositoryErrorHashable(error: error)]
        }
    }

}

extension UserRepositoriesSection: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard state == .partiallyLoaded,
              indexPath.item == currentItems.count - 10 else { return }

        loadRepositories()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let item = currentItems.element(at: indexPath.item),
            let delegate = delegate
        else { return }

        delegate.userRepositoriesSection(didSelect: item.htmlUrl)
    }
}
