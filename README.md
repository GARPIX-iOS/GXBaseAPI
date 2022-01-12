# GXBaseAPI

## IN TEST NOW!!! USE IT ON YOUR OWN RISK!!!

Test project for GARPIX Networking Layer

How to use

```swift
import Foundation
import GXBaseAPI
import Combine

class HomeAPIManager: BaseAPIManagerProtocol {
    var baseURL: String = Constants.cocktailBaseURL
    
    
    func getAlcoDrinks(endpoint: APICall) -> AnyPublisher<AlcoDrinkList, Error> {
        return fetch(endpoint: endpoint)
    }
    
    func getCategories(endpoint: APICall) -> AnyPublisher<AlcoCategories, Error> {
        return fetch(endpoint: endpoint)
    }
    
}
```

Configure your API Request by APICAll protocol
``` swift
extension HomeInteracor.UseCases: APICall {
    var path: String {
        switch self {
        case .getAlcoDrinks:
            return "filter.php?a=Alcoholic"
        case .getAlcoCategories:
            return "list.php?c=list"
        }
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var headers: HTTPHeaders? {
        nil
    }

}

```

Now you can handle this request by Combine

``` swift

        HomeAPIManager().getAlcoDrinks(endpoint: HomeInteracor.UseCases.*your endpoint*)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .mapError { error -> Error in
                debugPrint(error.localizedDescription)
                handler(.failure(error.localizedDescription))
                return error
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("result", result)
                handler(.success(result))
            })
            .store(in: &bag)
```