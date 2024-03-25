//
//  FlickApp.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import SwiftUI

@main
struct FlickApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = HomeViewViewModel(client: FlickService(client: URLSession.shared))
            return HomeView(viewModel: viewModel)
        }
    }
}
