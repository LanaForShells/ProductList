import QGrid
import SwiftUI

struct ProductListView: View {
    private var productList: [ProductDetailViewModel]
    
    init(productList: [ProductDetailViewModel]) {
        self.productList = productList
    }

    var body: some View {
        NavigationView {
            QGrid(productList, columns: 2) { viewModel in
                NavigationLink(
                    destination: ProductDetailsView(viewModel: viewModel),
                    label: {
                        ProductItemView(viewModel: viewModel)
                    })
            }
        }
    }
}

struct ProductItemView: View {
    @ObservedObject var viewModel: ProductDetailViewModel

    var body: some View {
        VStack() {
            if let url = viewModel.detail.imageURL {
                ImageView(withURL: url)
                    .frame(width: 150, height: 150)
            }
            if let title = viewModel.detail.title {
                Text(title)
                    .bold()
                    .foregroundColor(.black)
            }
            VStack {
                ForEach(viewModel.detail.price, id: \.?.message) {
                    priceView(priceDetail: $0) }
                HStack {
                    ShoppingCartButton(viewModel: viewModel)
                    Spacer()
                    FavouriteButton(viewModel: viewModel, didTapButton: viewModel.didLikedItem)
                }.padding(.horizontal)
            }
            
        }.padding()
    }
    
    @ViewBuilder
    func priceView(priceDetail: ProductDetailPriceModel?) -> some View {
        VStack(alignment: .leading) {
            if let priceString = priceDetail?.priceString {
                Text(priceString)
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}
