//
//  HomeViewViewModel.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import Foundation

final class HomeViewViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var thumbs: [ThumbViewModel] = []
    let client: FlickService

    init(client: FlickService) {
        self.client = client
    }

    func fetchThumbs() {
        let words = searchText.split(separator: " ").map(String.init)
        client.fetchThumbnail(words: words) { result in
            switch result {
                case let .success(response):
                    DispatchQueue.main.async { [weak self] in
                        self?.thumbs = response.map(ThumbViewModel.init)
                    }
                case let .failure(failure):
                    print(failure)
            }
        }
    }
}

#if DEBUG
extension HomeViewViewModel {
    convenience init(searchText: String = "", client: FlickService) {
        self.init(client: client)
        self.searchText = searchText
    }
}
#endif
