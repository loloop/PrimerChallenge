//
//  UserRepositoriesSection.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

final class UserRepositoriesSection: BaseDiffableSection {

    private lazy var repositoryCellRegistration = UICollectionView.CellRegistration<RepositoryCell, String> { (cell, indexPath, model) in
        cell.setupCell(with: model)
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

    override var items: [AnyHashable] {
        ["these", "are", "placeholder", "cells", "for", "testing"]
    }


}
