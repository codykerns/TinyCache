//
//  TinyCache.swift
//  TinyCache
//
//  Created by Cody Kerns on 4/26/22.
//

import Foundation

/// A small in-memory cache for Codable objects.
public class TinyCache {
    private static let shared = TinyCache()

    private var cacheProvider: CacheProvidable = CacheProvider.MemoryProvider()

    private init() { }

    /// Use this method to configure a custom CacheProvider.
    /// - Parameter provider: An object that conforms to ``CacheProvidable``
    /// Clears the current provider's cache, then switches to the new provider.
    public static func configure(provider: CacheProvidable) {
        shared.cacheProvider.clear()
        shared.cacheProvider = provider
    }

    /// Use this method to set a cached value for a certain duration.
    /// - Parameters:
    ///   - key: The key used to access the cached value.
    ///   - value: A ``Codable`` value to be saved in the cache.
    ///   - expiration: A ``CacheDuration`` indicating how long the value should be cached.
    ///   Defaults to ``.medium``, or 30 minutes.
    public static func cache(_ key: String, value: Codable?, duration: CacheDuration = .medium) {
        let expiration = Date().add(minutes: duration.minutes)
        cache(key, value: value, expiration: expiration)
    }

    /// Use this method to set a cached value with a specific expiration date.
    /// - Parameters:
    ///   - key: The key used to access the cached value.
    ///   - value: A ``Codable`` value to be saved in the cache.
    ///   - expirationDate: A ``Date`` at which the value should be considered expired.
    public static func cache(_ key: String, value: Codable?, expiration: Date) {
        guard let value = value else {
            return
        }

        shared.cacheProvider.set(key: key, value: value, expiresAt: expiration)
    }

    /// Use this method to retrieve a value from the cache.
    /// - Parameters:
    ///   - type: The type of the value you are retrieving from the cache.
    ///   - key: The key used when setting the value in the cache.
    /// - Returns: An optional value from the cache. The value is `nil` if it
    /// doesn't exist in the cache.
    public static func value<T: Codable>(_ type: T.Type, key: String) -> T? {
        shared.cacheProvider.get(T.self, key: key)
    }

    /// Remove all values from the cache immediately, ignoring expiration date.
    public static func clear() {
        shared.cacheProvider.clear()
    }
}

public extension TinyCache {
    enum CacheDuration {
        /** Extra short cache, equivalent to 1 minute. */
        case extraShort

        /** Short cache, equivalent to 10 minutes. */
        case short

        /** Medium cache, equivalent to 30 minutes. */
        case medium

        /** Long cache, equivalent to 60 minutes. */
        case long

        /** A custom cache duration, in minutes. */
        case minutes(Int)

        /** The duration of the cache, in minutes. */
        var minutes: Int {
            switch self {
            case .extraShort: return 1
            case .short: return 10
            case .medium: return 30
            case .long: return 60
            case .minutes(let val): return val
            }
        }
    }
}
