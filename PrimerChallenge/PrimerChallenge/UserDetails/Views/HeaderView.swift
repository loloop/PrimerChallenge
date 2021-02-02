//
//  HeaderView.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

private enum Metrics {
    static let horizontalPadding: CGFloat = 24
    static let verticalPadding: CGFloat = 16
}

final class HeaderView: UICollectionReusableView {

    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textMuted
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(label)
        label.constrainToAxis(.horizontal, of: self, insets: .init(all: Metrics.horizontalPadding))
        label.constrainToAxis(.vertical, of: self, insets: .init(all: Metrics.verticalPadding))
    }

    func setupHeader(with text: String) {
        label.text = text
    }
}
