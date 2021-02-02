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
    static let padding: CGFloat = 5
    static let cornerRadius: CGFloat = 15
    static let imageSize: CGFloat = 184
}

final class RepositoryCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = Metrics.cornerRadius
        return image
    }()

    private lazy var imageConstraints: [NSLayoutConstraint] = [
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.padding),
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.padding),
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.padding),
        imageView.widthAnchor.constraint(equalToConstant: Metrics.imageSize),
        imageView.heightAnchor.constraint(equalToConstant: Metrics.imageSize),
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
        label.numberOfLines = 0
        label.textColor = .textMuted
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Metrics.padding
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()

    private lazy var stackConstraints: [NSLayoutConstraint] = [
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.padding),
        stack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Metrics.padding),
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.padding),
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.padding),
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
    }
}
