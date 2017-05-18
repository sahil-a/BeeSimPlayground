import UIKit

class Bee {
    weak var beeView: BeeView!
    var xVelocity: CGFloat = 0
    var yVelocity: CGFloat = 0
    var xAcceleration: CGFloat = 0
    var yAcceleration: CGFloat = 0
}

class BeeView: UIView {
    var bee: Bee
    let beeImage = #imageLiteral(resourceName: "Bee.png")
    let fps: Double = 60
    
    init(bee: Bee) {
        self.bee = bee
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let timer = Timer.scheduledTimer(withTimeInterval: 1/fps, repeats: true, block: update)
        bee.beeView = self
        let imageView = UIImageView(frame: bounds)
        imageView.image = beeImage
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
        super.init(coder: aDecoder)
    }
    
    func update(timer: Timer) {
        layer.position.x += bee.xVelocity
        layer.position.y += bee.yVelocity
        bee.xVelocity += bee.xAcceleration
        bee.yVelocity += bee.yAcceleration
        layer.position.y
    }
}

let numberOfBees = 5
let speed = 1

let simulationView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
simulationView.backgroundColor = UIColor.red

let firstBee = BeeView(bee: Bee())
firstBee.layer.position = CGPoint(x: 400, y: 400)
firstBee.bee.yVelocity = 15

simulationView.addSubview(firstBee)


simulationView
