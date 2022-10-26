import SwiftUI
import CoreData

struct ContentView: View {
    @State var isLoaded: Bool = false
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if isLoaded {
                TabView {
                    productListView
                    favouriteView
                }
            } else {
                ProgressView()
            }
        }.onAppear {
            viewModel.requestData { success, error in
                isLoaded.toggle()
            }
        }
    }
    
    var productListView: some View {
        getTabItem(title: "Product List", image: "list.bullet.rectangle.fill", view: ProductListView(productList: viewModel.productList))
    }
    
    var favouriteView: some View {
        getTabItem(title: "Favourites", image: "heart.fill", view: FavouritesView(favouriteList: viewModel.favouriteList))
    }
    
    @ViewBuilder
    func getTabItem(title: String, image: String, view: some View) -> some View {
        view
            .tabItem {
                Image(systemName: image)
                Text(title)
            }
    }
    
}
