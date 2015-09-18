import Nuke
import UIKit
import XCPlayground
//: ## Nuke

//: Use shared image manager to create and resume `ImageTask` with `NSURL`. You can cancel the task at any time by calling its `cancel()` method.
let URL = NSURL(string: "http://farm8.staticflickr.com/7315/16455839655_7d6deb1ebf_z_d.jpg")!
let task = ImageManager.shared().taskWithURL(URL) {
    let image = $0.image
}
task.resume()

//: Create and customize `ImageRequest` and use it to create `ImageTask`. You can provide a target size and content mode that specify how to resize loaded image.
var request = ImageRequest(URL: NSURL(string: "http://farm4.staticflickr.com/3892/14940786229_5b2b48e96c_z_d.jpg")!)
request.targetSize = CGSize(width: 100.0, height: 100.0) // Set target size in pixels
request.contentMode = .AspectFill

ImageManager.shared().taskWithRequest(request) {
    (response) -> Void in
    switch response {
    case let .Success(image, _):
        let image = image
    case let .Failure(error):
        let error = error
    }
}.resume()

//: Initialize instance of `ImageManager` class with `ImageManagerConfiguration`. Configuration includes URL session manager (`URLSessionManager` class), memory cache (`ImageMemoryCaching` protocol) and image processor (`ImageProcessing` protocol).

// Provide your own NSURLSessionConfiguration
let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
let dataLoader: ImageDataLoader = ImageDataLoader(sessionConfiguration: sessionConfiguration)

let cache: ImageMemoryCaching = ImageMemoryCache()

let manager = ImageManager(configuration: ImageManagerConfiguration(dataLoader: dataLoader, cache: cache))

// Change shared manager
ImageManager.setShared(manager)

XCPSetExecutionShouldContinueIndefinitely()
