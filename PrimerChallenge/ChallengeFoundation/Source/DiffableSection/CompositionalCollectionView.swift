//
//  CompositionalCollectionView.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

public final class CompositionalCollectionView: UICollectionView {
    public init(frame: CGRect, sections: [DiffableSection]) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewCompositionalLayout {
            (section, environment) in
            return sections[section].layout(for: environment)
        })
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
