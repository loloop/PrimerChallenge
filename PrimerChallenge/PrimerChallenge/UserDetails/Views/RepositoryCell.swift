//
//  RepositoryCell.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import ChallengeFoundation

private enum Metrics {
    static let padding: CGFloat = 16
    static let cornerRadius: CGFloat = 15
    static let regularImageSize: CGFloat = 184
    static let compactImageSize: CGFloat = 104
    static let stackSpacing: CGFloat = padding/2
}

final class RepositoryCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = Metrics.cornerRadius
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private lazy var imageConstraints: [NSLayoutConstraint] = [
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.padding),
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.padding),
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
    ]

    private lazy var regularImageConstraints: [NSLayoutConstraint] = [
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: Metrics.regularImageSize),
    ]

    private lazy var compactImageConstraints: [NSLayoutConstraint] = [
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: Metrics.compactImageSize),
    ]

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .textPrimary
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .textMuted
        return label
    }()

    private lazy var tapIndicator: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .link
        label.text = "Tap to open"
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, subtitle, tapIndicator])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Metrics.stackSpacing
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()

    private lazy var stackConstraints: [NSLayoutConstraint] = [
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.padding),
        stack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Metrics.padding),
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.padding)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(stack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(stackConstraints)
        let currentTraits = UIApplication.shared.currentKeyWindow?.traitCollection
        activateConstraints(for: currentTraits)
    }

    private func activateConstraints(for traitCollection: UITraitCollection?) {
        guard let traitCollection = traitCollection else { return }

        if traitCollection.horizontalSizeClass == .regular {
            NSLayoutConstraint.deactivate(compactImageConstraints)
            NSLayoutConstraint.activate(regularImageConstraints)
        } else {
            NSLayoutConstraint.deactivate(regularImageConstraints)
            NSLayoutConstraint.activate(compactImageConstraints)
        }

        setNeedsLayout()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        activateConstraints(for: traitCollection)
    }

    private func resetCell() {
        title.text = ""
        subtitle.text = ""
        imageView.image = nil
    }

    func setupCell(titleText: String, subtitleText: String, imageURL: URL) {
        resetCell()
        title.text = titleText
        subtitle.text = subtitleText
        imageView.loadImage(from: imageURL)
    }


}
