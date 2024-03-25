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
            HomeView(viewModel: HomeViewViewModel())
        }
    }
}
