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
    public var sectionIdentifier: AnyHashable { id }

    // MARK: - Required Methods

    open func dequeueReusableCell(_ collectionView: UICollectionView, for indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? {
        fatalError("Base class methods should be overridden")
    }

    open var items: [AnyHashable] {
        fatalError("Base class properties should be overridden")
    }

    open func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        fatalError("Base class methods should be overridden")
    }

    // MARK: - Optional methods

    open func dequeueReusableSupplementary(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView? { nil }

}
