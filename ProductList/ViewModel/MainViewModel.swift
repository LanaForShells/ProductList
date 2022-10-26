import SwiftUI
import Foundation

class MainViewModel: ObservableObject {
    private let network: NetworkManager
    @Published var productList: [ProductDetailViewModel] = []
    @Published var favouriteList: [ProductDetailViewModel] = []
    
    init(urlSession: URLSession = URLSession.shared) {
        self.network = NetworkManager(.productList, urlSession: urlSession)
    }
    
    func requestData(completion: @escaping (Bool, Error?) -> Void) {
        network.request { response in
            switch response {
            case  let .success(data):
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let list = try decoder.decode(ProductsList.self, from: data)
                        DispatchQueue.main.async {
                            self.productList = list.products.map({ ProductDetailViewModel(detail: $0, didTapFavouriteButton: { viewModel in
                                self.didTapFavouriteButton(selectedVieModle: viewModel)
                                })
                            })
                            self.favouriteList = self.productList.filter({ $0.favourited })
                        }
                        completion(true, nil)
                    } catch  {
                        completion(false, error)
                    }
                }
            case let .failure(error):
                completion(false, error)
            }
        }
    }
    
    func didTapFavouriteButton(selectedVieModle: ProductDetailViewModel) {
        if selectedVieModle.favourited && favouriteList.filter({ $0.id == selectedVieModle.id }).count == 0 {
            favouriteList.append(selectedVieModle)
        } else if !selectedVieModle.favourited {
            favouriteList = favouriteList.filter { $0.favourited }
        }
    }
}
