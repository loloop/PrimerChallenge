//
//  DiffableDataSource.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

final public class DiffableDataSource: NSObject {

    public var currentSnapshot: NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable> = .init()
    public var dataSource: UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>?
    public var sections: [DiffableSection]

    public init(sections: [DiffableSection], on collection: UICollectionView) {
        self.sections = sections
        super.init()
        bindDataSource(to: collection)
    }

    func bindDataSource(to collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>(collectionView: collectionView) {
            [weak self] (collectionView, indexPath, hashableItem) in
            guard let self = self else { return nil }
            return self.sections[indexPath.section].dequeueReusableCell(collectionView, for: indexPath, item: hashableItem)
        }
        collectionView.delegate = self

        dataSource?.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) in
            guard let self = self else { return nil }
            return self.sections[indexPath.section].dequeueReusableSupplementary(collectionView, for: indexPath)
        }
    }

    public func updateSnapshot() {
        guard let source = dataSource else { return }

        var newSnapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>()

        newSnapshot.appendSections(sections.map{ $0.sectionIdentifier })

        sections.forEach { section in
            newSnapshot.appendItems(section.items, toSection: section.sectionIdentifier)
        }

        currentSnapshot = newSnapshot

        DispatchQueue.main.async {
            source.apply(newSnapshot)
        }
    }

}

extension DiffableDataSource: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let section = sections[indexPath.section] as? UICollectionViewDelegate else { return }
        section.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = sections[indexPath.section] as? UICollectionViewDelegate else { return }
        section.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
