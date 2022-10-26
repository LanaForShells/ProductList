import Foundation

enum APIs: String {
    case productList = "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"
    
    var url: URL? {
        switch self {
        case .productList:
            return URL(string: self.rawValue)
        }
    }
}

final class NetworkManager {
    // MARK: -
    private let endPoint: APIs
    private let queue: DispatchQueue
    private let session: URLSession
    
    // MARK: -
    
    init(_ endPoint: APIs, urlSession: URLSession = .shared, queue: DispatchQueue = .global(qos: .background)) {
        self.endPoint = endPoint
        self.queue = queue
        self.session = urlSession
    }
    
    func request(completion: ((Result<Data?, Error>) -> Void)?) {
        guard let url = endPoint.url else {
            print("invaild url")
            return
        }
        session.dataTask(with: url) { data, response, error in
            self.queue.async {
                if let error = error {
                    completion?(.failure(error))
                    return
                }
                completion?(.success(data))
            }
        }.resume()
    }
    
}
