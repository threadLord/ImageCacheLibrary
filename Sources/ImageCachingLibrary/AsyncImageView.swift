//
//  File.swift
//  
//
//  Created by Marko on 5.8.24..
//

import SwiftUI

@available(iOS 15, *)
public struct AsyncImageView<Content: View, Placeholder: View>: View {
    public let url: URL
    public let placeholder: () -> Placeholder
    public var imageClosure: (UIImage) -> Content
    
    public init(url: URL, placeholder: @escaping () -> Placeholder, image: UIImage? = nil, imageClosure: @escaping (UIImage) -> Content) {
        self.url = url
        self.placeholder = placeholder
        self.image = image
        self.imageClosure = imageClosure
    }

    @State private var image: UIImage?

    public var body: some View {
        if let image = image {
            imageClosure(image)
        } else {
            placeholder()
                .onAppear {
                    if let key = Utils.createKey(from: url) {
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
                   placeholder: { Image(systemName: "photo") }, imageClosure: {  image in
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    })
    .padding()
}
