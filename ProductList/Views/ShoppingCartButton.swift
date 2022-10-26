import SwiftUI
struct ShoppingCartButton: View {
    private var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
        } label: {
            Image(systemName: "cart.badge.plus")
                .resizable()
                .frame(width: 30, height: 20)
        }
        .disabled(!(viewModel.detail.isAddToCartEnable ?? true))
    }
}
