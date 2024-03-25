//
//  Service.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import Foundation

enum Constants: String {
    case url = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    case tags
}

enum ServiceErros: Error {
    case url
    case notFound
    case decode(Error)
    case apiError(Error)
}

final class FlickService {

    let client: URLSession

    init(client: URLSession) {
        self.client = client
    }

    func fetchThumbnail(words: [String], completion: @escaping (Result<[Thumb], ServiceErros>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.url.rawValue) else {
            completion(.failure(.url)); return
        }
        let queryItem = URLQueryItem(name: Constants.tags.rawValue, value: words.map(\.description).joined(separator: ","))
        urlComponents.queryItems?.append(queryItem)

        guard let url = urlComponents.url else {
            completion(.failure(.url)); return
        }

        client.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(.apiError(error))); return
            }

            guard let data = data else {
                completion(.failure(.notFound)); return
            }

            do {
                let feed = try JSONDecoder().decode(FlickrResponse.self, from: data)
                completion(.success(feed.items))
            } catch {
                completion(.failure(.decode(error)))
            }
        }.resume()
    }
}
