import Foundation
import Combine
import SwiftUI

class Network: ObservableObject {
    @Published var user: Datas? = nil
    
    func loadData() {
        guard let url = URL(string: "https://api.github.com/users/sanjar-as") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // TODO: Handle data task error
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                // TODO: Handle this
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let response = try decoder.decode(Datas.self, from: data)
                
                DispatchQueue.main.async {
                    self.user = response
                }
            } catch {
                // TODO: Handle decoding error
                print(error.localizedDescription)
            }
        }.resume()
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

