//
//  File.swift
//  
//
//  Created by Marko on 5.8.24..
//

import SwiftUI

@available(iOS 15, *)
public struct AsyncImageView: View {
    public let url: URL
    public let placeholder: Image
    
    public init(url: URL, placeholder: Image, image: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.image = image
    }
    

    @State private var image: UIImage?

    public var body: some View {
        if let image = image {
            Image(uiImage: image)
        } else {
            placeholder
                .onAppear {
                    if let key = url.absoluteString.components(separatedBy:"/").last {
                        ImageCache.shared.loadImage(url: url, key: key) { loadedImage in
                            self.image = loadedImage
                        }
                    }
                }
        }
    }
}

#Preview {
    AsyncImageView(url: URL(string: "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg")!,
                   placeholder: Image(systemName: "photo"))
    .padding()
}
