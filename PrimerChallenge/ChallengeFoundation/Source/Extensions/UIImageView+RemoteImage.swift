//
//  UIImageView+RemoteImage.swift.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import UIKit

public protocol RemoteImageLoader: AnyObject {
    func loadRemoteImage(in imageView: UIImageView, from url: URL?)
}

public extension UIImageView {
    static var imageLoader: RemoteImageLoader?

    func loadImage(from url: URL?) {
        assert(UIImageView.imageLoader != nil, "ImageLoader should be set when app loads")
        guard let url = url,
              let loader = UIImageView.imageLoader else { return }
        loader.loadRemoteImage(in: self, from: url)
    }
}
