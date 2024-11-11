# NetworkSDK

NetworkSDK, iOS uygulamaları için geliştirilmiş modern ve güçlü bir networking framework'üdür.

## Özellikler

- Async/await desteği
- Güçlü caching mekanizması
- Retry stratejileri
- Request/Response logging
- Error handling
- Builder pattern ile kolay request oluşturma

## Kurulum

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/ahmetekti/NetworkSDK.git", from: "1.0.0")
]
```

### Gereksinimler

- iOS 13.0+
- Swift 5.5+
- Xcode 13.0+

## Kullanım

```swift
// NetworkSDK'yı configure etme
let configuration = NetworkConfiguration(
    baseURL: URL(string: "https://api.example.com")!,
    defaultHeaders: ["Content-Type": "application/json"]
)

NetworkManager.configure(with: configuration)

// Request örneği
let endpoint = RequestBuilder(endpoint: "/users")
    .setMethod(.get)
    .addHeader(key: "Authorization", value: "Bearer token")
    .build()

Task {
    do {
        let users: [User] = try await NetworkManager.shared.request(
            endpoint: endpoint,
            responseType: [User].self,
            cachePolicy: .useCache(maxAge: 300)
        )
        print(users)
    } catch {
        print("Error: \(error)")
    }
}
```
