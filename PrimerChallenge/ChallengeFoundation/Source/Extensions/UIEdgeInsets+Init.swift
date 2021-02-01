//
//  UIEdgeInsets+Init.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    public init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }

    public init(vertical: CGFloat) {
        self.init(top: vertical, left: 0, bottom: vertical, right: 0)
    }

    public init(horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }
}
