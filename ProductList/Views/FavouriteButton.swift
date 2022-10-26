import SwiftUI

struct FavouriteButton: View {
    private var viewModel: ProductDetailViewModel
    private var didTapButton: () -> Void
    
    init(viewModel: ProductDetailViewModel, didTapButton: @escaping () -> Void) {
        self.viewModel = viewModel
        self.didTapButton = didTapButton
    }
    
    var body: some View {
        Button {
            viewModel.favourited.toggle()
            didTapButton()
        } label: {
            Image(systemName: viewModel.favourited ? "heart.fill": "heart")
                .foregroundColor(.red)
        }
    }
}

