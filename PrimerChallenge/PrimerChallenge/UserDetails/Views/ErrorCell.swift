//
//  ErrorCell.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

private enum Metrics {
    static let padding: CGFloat = 10
}

final class ErrorCell: UICollectionViewCell {

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .textPrimary
        label.text = "An error has occurred"
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        contentView.addSubview(stack)
        stack.center(on: contentView)
        stack.constrainToAxis(.horizontal, of: contentView, insets: UIEdgeInsets(vertical: Metrics.padding))
    }

    func setupCell(with errorMessage: String) {
        subtitle.text = errorMessage
    }

}
