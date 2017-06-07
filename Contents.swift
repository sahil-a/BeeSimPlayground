import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class Bee {
    weak var beeView: BeeView!
    var xVelocity: CGFloat = 0
    var yVelocity: CGFloat = 0
    var xAcceleration: CGFloat = 0
    var yAcceleration: CGFloat = 0
    var returning: Bool = false
}

func random(_ range: ClosedRange<Float>) -> CGFloat {
    return (CGFloat(arc4random_uniform(UInt32((range.upperBound - range.lowerBound) * 10000))) / 10000) + CGFloat(range.lowerBound)
}

class BeeView: UIView {
    var bee: Bee
    let beeImage = #imageLiteral(resourceName: "Bee.png")
    let fps: Double = 120
    
    init(bee: Bee) {
        self.bee = bee
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        Timer.scheduledTimer(withTimeInterval: 1/fps, repeats: true, block: update)
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
        layer.position.x += bee.xVelocity / 10
        layer.position.y += bee.yVelocity / 10
        bee.xVelocity += bee.xAcceleration / 10
        bee.yVelocity += bee.yAcceleration / 10
        let angle = rotationAngleForVelocity(x: bee.xVelocity, y: bee.yVelocity)
        layer.setAffineTransform(CGAffineTransform(rotationAngle:angle))
        if !superview!.frame.contains(frame) {
            bee.xAcceleration = ((layer.position.x > 200) ? -1 : 1) * 0.5
            bee.yAcceleration = ((layer.position.y > 200) ? -1 : 1) * 0.5
            bee.returning = true
        } else if bee.returning {
            bee.returning = false
            bee.yAcceleration = random(-1...1)
            bee.xAcceleration = random(-1...1)
        }
    }
    
    func rotationAngleForVelocity(x: CGFloat, y: CGFloat) -> CGFloat {
        var angle: CGFloat = 0
        if x == 0 && y != 0 {
            angle = ((y > 0) ? 1 : -1) * CGFloat.pi / 2
        } else if y == 0 && x != 0 {
            if x > 0 {
                angle = CGFloat.pi
            }
        } else {
            angle = atan(y / x)
        }
        if x > 0 {
            angle += CGFloat.pi
        }
        return angle - (CGFloat.pi / 2)
    }
}

let numberOfBees = 5
let speed = 1

let simulationView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
simulationView.backgroundColor = UIColor.red



for _ in 1...10 {
    let bee = BeeView(bee: Bee())
    bee.layer.position = CGPoint(x: random(10...380), y: random(10...380))
    bee.bee.xVelocity = random(-10...10)
    bee.bee.yVelocity = random(-10...10)
    bee.bee.yAcceleration = random(-1...1)
    bee.bee.xAcceleration = random(-1...1)
    simulationView.addSubview(bee)
}


PlaygroundPage.current.liveView = simulationView
