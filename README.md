# GXBaseAPI

## GARPIX Networking Layer

### URLSession + Combine + Codable + Generics

1) Все чисто на URLSession, нету Alamoifire
2) Есть логгер для запросов
3) Логи ошибок Codable 
4) Обработка 204
5) Загрузка картинок


# 🔷 Требования

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ Xcode 12.0  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ Swift 5+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ iOS 14 

# 🔷 Установка

`GXBaseAPI` доступен через [Swift Package Manager](https://swift.org/package-manager).

Используя Xcode 12 и выше, нужно зайти в  `File -> Swift Packages -> Add Package Dependency` ввести адрес репозитория. 
Выбираем последнюю версию по тегу, ждем синхронизации, вуаля, можно использовать утилитки) 
При обновлении пакета, можно воспользоваться `File -> Swift Packages -> Update to Latest packages versions`

# 🔷 Documentation

1. Создайте класс/структуру, например `SomeAPIManager` и подпишите его под протокол `BaseAPIManagerProtocol`

``` swift
struct SomeAPIManager: BaseAPIManagerProtocol {
    let baseURL: String = *some base url*
    ....
}
```

2. Нам нужен enum с кейсами всех эндпоинтов. Реализовать можно вот так:
``` swift
extension SomeAPIManager {
    enum API {
        case getSome
        case getDetail(Int)  // - ассоциативные значения очень помогают
        case getSomeWithQuery(HTTPQuery)  // - если нужны query params, под капотом - [String: String]
    }
}
```


3. Далее настраиваем эндпоинты - path, headers, methods
``` swift
extension SomeAPIManager.API: GXBaseAPI.APICall {
    var path: String {
        switch self {
        case .getSome:
            return "/path/get/"
        case let .getDetail(id):
            return "/path/\(String(id))/"
        }
    }

    var method: GXBaseAPI.HTTPMethod {
        switch self {
        case .getSome, .getSomeDetail:
            return .GET
        case .someCase:
            return .PATCH
        }
    }

    var headers: GXBaseAPI.HTTPHeaders? {
        switch self {
        case .getSome:
            return [
                "Authorization": "",
            ]
        }
    }
}
```

4. И теперь создаем сами функции для запросов. С помощью функции fetch/upload
``` swift
struct SomeAPIManager: BaseAPIManagerProtocol {
    ...

    // пример POST, params - ваше body
    func loginUser(params: LoginRequest) -> AnyPublisher<ResponseModel<LoginResponse>, Error> {
        return fetch(endpoint: API.loginUser, params: params)
    }

    // пример GET + можно декодить ответ с сервера из snake_case в swiftCase
    // decoder: .snakeCaseConverting)
    func getUser() -> AnyPublisher<ResponseModel<UserInfoModel>, Error> {
        return fetch(endpoint: API.getUserInfo, decoder: .snakeCaseConverting)
    }

    // можно комбинировать
    func patchUserInfo(id: Int, params: UpdateUserInfoModel) -> AnyPublisher<ResponseModel<UserInfoModel>, Error> {
        return fetch(endpoint: API.updateUserInfo(id), params: params, decoder: .snakeCaseConverting)
    }

    // пример загрузки аватара на сервер
    func uploadAvatar(image: UIImage) -> AnyPublisher<ResponseModel<UserInfoModel>, Error> {
        let mediaImage = Media(withImage: image, forKey: "avatar", compressionQuality: 0.3)
        let formData = MultipartFormDataRequest()
        let dataBody = formData.createDataBody(withParameters: nil, media: [mediaImage!])
        return upload(endpoint: API.uploadAvatar, with: formData.boundary, and: dataBody, decoder: .snakeCaseConverting)
    }
}
```

5. Для подробного изучения смотрите папку Sources


🔷🔷🔷 https://garpix.com 🔷🔷🔷
