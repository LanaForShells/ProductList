import XCTest
@testable import ProductList

class ProductListTests: XCTestCase {
    var urlSession: URLSession!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        guard let data = loadData() else {
            XCTFail("Data load failed")
            return
        }
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), data)
        }
    }
    
    func testGetData() throws {
        let expectation = XCTestExpectation(description: "response")
        let network = NetworkManager(.productList, urlSession: urlSession)
        network.request { result in
            switch result {
            case let .success(data):
                if let data = data {
                    do {
                        let list = try JSONDecoder().decode(ProductsList.self, from: data)
                        XCTAssertEqual(list.products.count,3)
                        expectation.fulfill()
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 20)
    }
    
    func testDidTapFavouriteButton() {
        let sut = MainViewModel()
        if let data = loadData() {
            do {
                let list = try JSONDecoder().decode(ProductsList.self, from: data)
                sut.productList = list.products.map({ ProductDetailViewModel(detail: $0, didTapFavouriteButton: { _ in })
                })
                sut.favouriteList = sut.productList.filter({ $0.favourited })
                XCTAssertEqual(sut.favouriteList.count, 0)
                if let first = sut.productList.first {
                    first.favourited = true
                    sut.didTapFavouriteButton(selectedVieModle: first)
                    XCTAssertEqual(sut.favouriteList.count, 1)
                } else {
                    XCTFail("Data prase failed")
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
}


func loadData() -> Data? {
    if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
