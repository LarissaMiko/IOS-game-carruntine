
import SpriteKit

class EdgeNode: SKSpriteNode {
    
    init(with size: CGSize){
        super.init(texture: nil, color: UIColor.clear, size: size)

        //upper edge of ground node
        let bodyInitialPoint = CGPoint(x: 0.0, y: 0.0)
        let bodyEndPoint = CGPoint(x: 0.0, y: size.height)

        let pB = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)

        pB.restitution = 0.0
        pB.affectedByGravity = false
        pB.isDynamic = false
        // define physicscategory for ground
        pB.categoryBitMask = GameConstants.PhysicsCategories.groundCategory
        // floor should collide with player
        pB.collisionBitMask = GameConstants.PhysicsCategories.playerCategory

        physicsBody = pB
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
