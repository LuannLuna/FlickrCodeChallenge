//
//  ThumbViewModel.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import Foundation

struct ThumbViewModel: Identifiable {
    let id = UUID()
    private let thumb: Thumb

    init(thumb: Thumb) {
        self.thumb = thumb
    }

    var url: URL? {
        URL(string: thumb.media.m)
    }
}
