import SwiftUI

class ProductDetailViewModel: ObservableObject {
    let detail: ProductDetailModel
    let didTapFavouriteButton: (ProductDetailViewModel) -> Void
    @Published var favourited: Bool
    
    init(detail: ProductDetailModel, favourited: Bool = false, didTapFavouriteButton: @escaping (ProductDetailViewModel) -> Void) {
        self.detail = detail
        self.favourited = favourited
        self.didTapFavouriteButton = didTapFavouriteButton
    }
    
    func didLikedItem() {
        didTapFavouriteButton(self)
    }
}

extension ProductDetailViewModel: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: ProductDetailViewModel, rhs: ProductDetailViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
