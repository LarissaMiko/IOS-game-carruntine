
import SpriteKit

class RepeatingLayer: Layer {
    
    override func updateNodes(_ positionPlayer: CGPoint, childNode: SKNode) {
        if let node = childNode as? SKSpriteNode{
            //check if SpriteNode is out of screen
            if node.name == "0" && node.position.x < positionPlayer.x - node.size.width * 2 {
                node.position = CGPoint(x: node.position.x + node.size.width * 3, y: node.position.y)
            }
            
            if node.name == "1" && node.position.x < positionPlayer.x - node.size.width * 2 {
                node.position = CGPoint(x: node.position.x + node.size.width * 3, y: node.position.y)
            }
            
            if node.name == "2" && node.position.x < positionPlayer.x - node.size.width * 2 {
                node.position = CGPoint(x: node.position.x + node.size.width * 3, y: node.position.y)
            }
            
        }
    }
    
}
