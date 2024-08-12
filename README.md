**ImageCacheLibrary**

*ImageCacheLibrary* is a Swift package that provides an asynchronous image view (**AsyncImageView**) for SwiftUI. It allows you to load images from URLs and cache them efficiently.


**Installation**
You can add ImageCacheLibrary to your project using Swift Package Manager. In Xcode, go to *File > Swift Packages > Add Package Dependency* and enter the repository URL:

https://github.com/threadLord/ImageCacheLibrary.git


**Usage**

1. Import the module:

``` Swift

import ImageCacheLibrary

``` 


2. Create an AsyncImageView with a placeholder view and an image closure:

``` Swift
@available(iOS 15, *)
struct ContentView: View {
    let imageUrl = URL(string: "https://example.com/image.jpg")!
    
    var body: some View {
        AsyncImageView(url: imageUrl, placeholder: {
            // Placeholder view (e.g., a loading spinner)
            ProgressView()
        }) { image in
            // Closure to display the loaded image
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}
```


3. Make sure to set up your image cache using ImageCache.shared. You can customize the cache and other settings

 Example usage of ImageCache

``` Swift

ImageCache.shared.change(cache: DiskCache<Data>()) 

```

 Load an image from a URL

``` Swift

ImageCache.shared.loadImage(url: imageUrl) { loadedImage in
    // Handle the loaded image
    if let image = loadedImage {
        // Do something with the image
    } else {
        // Handle the failure (e.g., show an error message)
    }
}

```

4. Delete Cache with urls:
 - deleteCache(with urls: [String]):
 - This function is responsible for deleting cached images associated with specific URLs.
 - It takes an array of URLs as input (urls: [String]).
 - For each URL in the array, it generates a cache key (using the Utils.createKeyFrom(urlString: String) method) and removes the corresponding cached data from disk.
 - The operation is performed asynchronously on the cacheQueue.
 - If the cache key for a URL doesn’t exist, no action is taken.

Example usage:

``` Swift

let urlsToDelete = ["https://example.com/image1.jpg", "https://example.com/image2.jpg"]
ImageCache.shared.deleteCache(with: urlsToDelete)

```

5. Delete all cache:
 - deleteAllCache() -> Bool:
 - This method clears the entire cache, deleting all cached images.
 - It returns a boolean value (true if successful, false otherwise).


Example usage:

``` Swift

let cacheCleared = ImageCache.shared.deleteAllCache()
if cacheCleared {
    print("Cache cleared successfully!")
} else {
    print("Cache deletion failed.")
}

```
