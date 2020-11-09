
import SpriteKit

//define operatorfunctions for CGPoints
//multiply CGPoint with scalar
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
//add two CGPoints
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
// += for two CGPoints
public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

class Layer: SKNode {
    
    var layerVelocity = CGPoint.zero
    
    //local update
    func update(_ positionPlayer: CGPoint) {
        //use updateNodesGlobal on every childnode of Layernode
        for child in children{
            updateNodesGlobal(positionPlayer, childNode: child)
        }
    }
    func updateNodesGlobal(_ positionPlayer: CGPoint, childNode: SKNode) {
        //delta => create smooth game independent of framerate
        //let offset = layerVelocity * CGFloat(delta)
        //update position of childnode
        //childNode.position += offset
        //update other childnodes
        updateNodes(positionPlayer, childNode: childNode)
    }
    
    func updateNodes(_ positionPlayer: CGPoint, childNode: SKNode) {
        //overwritten in subclasses
    }
}
