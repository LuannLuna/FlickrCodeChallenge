//
//  HomeViewViewModel.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import Foundation

final class HomeViewViewModel: ObservableObject {
    var searchText = ""

    let client: FlickService

    init(client: FlickService) {
        self.client = client
    }
}
