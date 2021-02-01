//
//  DiffableSection.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

public protocol DiffableSection: AnyObject {
    var sectionIdentifier: AnyHashable { get }
    func dequeueReusableCell(_ collectionView: UICollectionView, for indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell?
    func dequeueReusableSupplementary(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView?
    func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
    var items: [AnyHashable] { get }
}
