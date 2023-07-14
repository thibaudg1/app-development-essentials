import UIKit

/*:
# Welcome to Playgrounds
This is your *first* playground which is intended to demonstrate:
* The use of **Quick Look**
* Placing results **in-line** with the code
*/
let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
myLabel.backgroundColor = UIColor.red
myLabel.text = "Hello Swift"
myLabel.textAlignment = .center
myLabel.font = UIFont(name: "Georgia", size: 24)
myLabel

let image = UIImage(named: "waterfall")
