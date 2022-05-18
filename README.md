![Swift](https://img.shields.io/badge/Swift-5.4-orange.svg)

# TinyCache

## Description

TinyCache is a Swift package for saving and retrieving Codable objects from an in-memory cache with expirations.

## Requirements

- Swift 5.4

## Usage

To save an object to the cache:

```swift
let key = "key"
let value = "value"

TinyCache.cache(key, value: value)
```

To retrieve it from the cache, pass the type of object and key:

```swift
if let value = TinyCache.value(String.self, "key") {
    // value is a String
}
```

If the type doesn't match what's in the cache, the returned value will be `nil`.

### Expirations

By default, TinyCache caches a value using `CacheDuration.medium` _(30 minutes)_. To customize the duration of each cached value until expiration, pass a duration:

```swift
let key = "key"
let value = "value"

TinyCache.cache(key, value: value, duration: .short) // 10 minutes
```

For a specific number of minutes:

```swift
let key = "key"
let value = "value"

TinyCache.cache(key, value: value, duration: .minutes(12)) // 12 minutes
```

For a specific expiration date:

```swift
let key = "key"
let value = "value"
let expiration = Date()

TinyCache.cache(key, value: value, expiration: expiration)
```

## Custom CacheProvider

For custom cache logic, create an object that conforms to `CacheProvidable` and implement:

```swift
func set(key: String, value: Codable, expiresAt: Date)
func get<T: Codable>(_ type: T.Type, key: String) -> T?
func clear()
```

To set your new provider, call `configure`:

```swift
TinyCache.configure(provider: MyCustomCacheProvider())
```

Calling `configure` immediately clears the current cache and sets your object as the default cache provider.

## License

[MIT License](http://opensource.org/licenses/MIT).
