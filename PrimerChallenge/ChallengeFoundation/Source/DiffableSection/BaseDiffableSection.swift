//
//  BaseDiffableSection.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

open class BaseDiffableSection: NSObject, DiffableSection {

    let id = UUID()
    var sectionIdentifier: AnyHashable { id }

    // MARK: - Required Methods

    func dequeueReusableCell(_ collectionView: UICollectionView, for indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? {
        fatalError("Base class methods should be overridden")
    }

    var items: [AnyHashable] {
        fatalError("Base class properties should be overridden")
    }

    func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        fatalError("Base class methods should be overridden")
    }

    // MARK: - Optional methods

    func dequeueReusableSupplementary(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView? { nil }

}
