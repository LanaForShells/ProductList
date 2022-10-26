import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer()
            VStack(alignment: .leading) {
                ImageView(withURL: viewModel.detail.imageURL ?? "")
                    .frame(width: 300, height: 300)
                if let title = viewModel.detail.title {
                    Text(title)
                }
                ratingView
                HStack(alignment: .top) {
                    priceView(prices: viewModel.detail.purchaseTypes)
                    Spacer()
                    ShoppingCartButton(viewModel: viewModel)
                }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.detail.title ?? "")
        .toolbar {
            FavouriteButton(viewModel: viewModel) {  }
        }
        .onDisappear {
            viewModel.didTapFavouriteButton(viewModel)
        }
    }
    
    var ratingView: some View {
        HStack {
            if let rating = viewModel.detail.ratingCount {
                Image(systemName: "star.fill")
                Text(String(format: "%.2f", rating))
            } else {
                Text("No rating yet")
            }
        }
    }
    
    @ViewBuilder
    func priceView(prices: [PurchaseTypeModel?]) -> some View {
        VStack(alignment: .leading) {
            ForEach(prices, id: \.?.purchaseType) { price in
                if let name = price?.displayName, let price = price?.unitPrice {
                    Text(String(format: "$%.2f", price) + " / " + name)
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 0.5)
                            )
                }
            }
            
        }
    }
}
