# ImageLoader
ImageLoader with SpinnerMagazine and ImageCache for UIKit.

![](./demoAllSpinners.gif)
![](./demoMulticolorSpinner.gif)
![](./demoSpinner.gif)
![](./demoActivityIndicatorMedium.gif)
![](./demoActivityIndicatorLarge.gif)

### Usage

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstImageView: ImageLoader!
    @IBOutlet weak var secondImageView: ImageLoader!
    @IBOutlet weak var thirdImageView: ImageLoader!
    @IBOutlet weak var fourthImageView: ImageLoader!
    @IBOutlet weak var fifthImageView: ImageLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // With default spinner
        firstImageView.loadImage(from: "https://", isSpin: true)
        
        // With selected spinner
        secondImageView.loadImage(
            from: "https://", 
            isSpin: true, 
            spinType: .activityIndicatorMedium
        )
        
        // With selected spinner and completion
        thirdImageView.loadImage(
            from: "https://", 
            isSpin: true, 
            spinSize: 20, 
            spinType: .multicolorSpinner
        ) {
            // ...
        }
        
        // Without spinner
        fourthImageView.loadImage(from: "https://")
        
        // Without spinner and with completion
        fifthImageView.loadImage(from: "https://") {
            // ...
        }
    }
}
```

## Requirements
- [Swift 5](https://developer.apple.com/swift/)
