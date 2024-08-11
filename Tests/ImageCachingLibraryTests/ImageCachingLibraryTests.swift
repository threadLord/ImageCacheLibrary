import XCTest
import SwiftUI
@testable import ImageCachingLibrary

final class ImageCachingLibraryTests: XCTestCase {
    func testExample() throws {
       
        let _ = AsyncImageView(url: URL(string: "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg")!,
                                       placeholder: {Image(systemName: "photo")}, imageClosure: {image in
        Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        })
    }
}
