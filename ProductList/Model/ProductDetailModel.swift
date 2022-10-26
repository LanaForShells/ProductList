import AnyCodable
import SwiftUI

struct ProductDetailModel: Decodable {

    let citrusId: String?
    let title: String?
    let id: String?
    let imageURL: String?
    let price: [ProductDetailPriceModel?]
    let brand: String?
    let badges: [String?]
    let ratingCount: Double?
    let messages: ProductDetailMessageModel?
    let isAddToCartEnable: Bool?
    let addToCartButtonText: String?
    let isInTrolley: Bool?
    let isInWishlist: Bool?
    let purchaseTypes: [PurchaseTypeModel?]
    let isFindMeEnable: Bool?
    let saleUnitPrice: Double?
    let totalReviewCount: Int?
    let isDeliveryOnly: Bool?
}

struct PurchaseTypeModel: Decodable {
    let purchaseType: String?
    let displayName: String?
    let unitPrice: Double?
    let minQtyLimit: Int?
    let maxQtyLimit: Int?
    let cartQty: Int?
}

struct ProductDetailPriceModel: Decodable {
    let message: String?
    let value: Double?
    let isOfferPrice: Bool?
    
    var priceString: String {
        var priceString = ""
        if let value = value {
            priceString = "$" + String(value)
        }
        if let message = message {
            priceString += " (" + message + ")"
        }
        return priceString
    }
}

struct ProductDetailMessageModel: Decodable {
    let secondaryMessage: String?
    let sash: AnyCodable
}

struct ProductsList: Decodable {
    let products: [ProductDetailModel]
}
