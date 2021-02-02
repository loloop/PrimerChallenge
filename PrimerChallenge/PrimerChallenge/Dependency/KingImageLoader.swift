//
//  KingImageLoader.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import Kingfisher
import UIKit
import ChallengeFoundation

final class KingImageLoader: RemoteImageLoader {
    func loadRemoteImage(in imageView: UIImageView, from url: URL?) {
        guard let url = url else { return }

        imageView.kf.setImage(with: url)
    }
}
