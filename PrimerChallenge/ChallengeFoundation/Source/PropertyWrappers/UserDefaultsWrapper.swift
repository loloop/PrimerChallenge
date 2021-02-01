//
//  UserDefaultsWrapper.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T> {
    private var userDefaults: UserDefaults
    private var key: String
    private var defaultValue: T

    public init(userDefaults: UserDefaults = .standard, key: String, defaultValue: T) {
        self.userDefaults = userDefaults
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
