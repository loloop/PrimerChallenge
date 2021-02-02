//
//  UIView+Constraints.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    public func constrainToEdges(of view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
        ])
    }

    public func center(on view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    public func constrainToAxis(_ axis: Axis.Set, of view: UIView, insets: UIEdgeInsets = .zero) {
        if axis == [.vertical, .horizontal] {
            constrainToEdges(of: view, insets: insets)
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            ])
        case .vertical:
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            ])
        default:
            break
        }
    }
}
