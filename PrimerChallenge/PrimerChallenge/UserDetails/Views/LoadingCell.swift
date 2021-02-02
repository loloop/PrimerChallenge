//
//  LoadingCell.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

final class LoadingCell: UICollectionViewCell {

    lazy var activityIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupView() {
        contentView.addSubview(activityIndicator)
        activityIndicator.constrainToEdges(of: contentView)
    }

}
