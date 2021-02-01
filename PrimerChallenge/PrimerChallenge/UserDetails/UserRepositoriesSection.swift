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
    func userRepositoriesSection(didSelect item: String)
}

final class UserRepositoriesSection: BaseDiffableSection {

    private lazy var repositoryCellRegistration = UICollectionView.CellRegistration<RepositoryCell, String> { (cell, indexPath, model) in
        cell.setupCell(with: model)
    }

    private weak var delegate: UserRepositoriesSectionDelegate?

    init(delegate: UserRepositoriesSectionDelegate) {
        self.delegate = delegate
    }

    override func dequeueReusableCell(_ collectionView: UICollectionView, for indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? {
        guard let item = item as? String else { return nil }
        return collectionView.dequeueConfiguredReusableCell(using: repositoryCellRegistration, for: indexPath, item: item)
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
                                               heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    var currentItems: [String] = ["these", "are", "placeholder", "cells", "for", "testing", "https://github.com/CocoaHeadsConference/CocoaHeadsConference.github.io", "https://github.com/CocoaHeadsConference/CHConferenceApp"]
    override var items: [AnyHashable] { currentItems }

}

extension UserRepositoriesSection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let item = currentItems.element(at: indexPath.item),
            let delegate = delegate
        else { return }

        delegate.userRepositoriesSection(didSelect: item)

    }
}
