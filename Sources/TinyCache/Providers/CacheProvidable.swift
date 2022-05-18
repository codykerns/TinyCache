//
//  CacheProvidable.swift
//  TinyCache
//
//  Created by Cody Kerns on 5/17/22.
//

import Foundation

public protocol CacheProvidable {

    func set(key: String, value: Codable, expiresAt: Date)
    func get<T: Codable>(_ type: T.Type, key: String) -> T?
    func clear()

}

public class CacheProvider {

}
