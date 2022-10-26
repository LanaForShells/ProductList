import SwiftUI

struct FavouritesView: View {
    private var favouriteList: [ProductDetailViewModel]
    
    init(favouriteList: [ProductDetailViewModel]) {
        self.favouriteList = favouriteList
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(favouriteList, id: \.self) { viewModel in
                        NavigationLink(
                            destination:
                                ProductDetailsView(viewModel: viewModel)
                                .onDisappear {
                                    
                                },
                            label: {
                                FavouriteItemView(viewModel: viewModel)
                            })
                    }
                }
            }
        }
    }
}

struct FavouriteItemView: View {
    var viewModel: ProductDetailViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            if let url = viewModel.detail.imageURL {
                ImageView(withURL: url)
                    .frame(width:100, height:100)
            }
            VStack(alignment: .leading) {
                if let title = viewModel.detail.title {
                    Text(title)
                        .bold()
                        .foregroundColor(.black)
                }
                HStack {
                    ForEach(viewModel.detail.price, id: \.?.message) {
                        priceView(priceDetail: $0) }
                }
            }
            Spacer()
            FavouriteButton(viewModel: viewModel, didTapButton: viewModel.didLikedItem)
        }.padding()
    }
    
    @ViewBuilder
    func priceView(priceDetail: ProductDetailPriceModel?) -> some View {
        VStack(alignment: .leading) {
            if let message = priceDetail?.message {
                Text(message)
                    .foregroundColor(.black)
            }
            if let value = priceDetail?.value {
                Text("$" + String(value))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0.5)
            )
    }
}
