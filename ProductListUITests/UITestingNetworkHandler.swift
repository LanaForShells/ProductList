import Foundation
class UITestingNetworkHandler {
    public static func register() {
        URLProtocol.registerClass(MockURLProtocol.self)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else { fatalError() }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    return (response, data)
                } catch {
                    fatalError(error.localizedDescription)
                }
            } else {
                fatalError("Json parse failed")
            }
        }
    }
}
