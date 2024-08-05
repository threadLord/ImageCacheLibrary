//
//  File.swift
//  
//
//  Created by Marko on 5.8.24..
//

import UIKit
import SwiftUI

@available(iOS 15, *)
public class AsyncImageViewUIKit: UIImageView {
    
    public func loadImage(url: String, key: String , placeholder: String) {
        self.image = UIImage(named: placeholder)
        guard let url = URL(string: url) else {
            return
        }

        ImageCache.shared.loadImage(url: url, key: key) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

struct AsyncImageViewUIKitRepresentable: UIViewRepresentable {
    @Binding public var url: String
    @Binding public var key: String
    @Binding public var placeholder: String
    
    public func makeUIView(context: Context) -> AsyncImageViewUIKit {
        AsyncImageViewUIKit()
    }

    public func updateUIView(_ uiView: AsyncImageViewUIKit, context: Context) {
        uiView.loadImage(url: url, key: key, placeholder: placeholder)
    }
}

#Preview {
    AsyncImageViewUIKitRepresentable(url: .constant("https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg"), key: .constant("17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg"), placeholder: .constant("photo"))
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
}
