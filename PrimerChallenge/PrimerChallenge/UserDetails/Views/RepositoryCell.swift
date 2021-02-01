//
//  RepositoryCell.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

final class RepositoryCell: UICollectionViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupConstraints() {
        contentView.addSubview(label)
        label.constrainToEdges(of: contentView)
    }

    func setupCell(with text: String) {
        label.text = text
    }
}
