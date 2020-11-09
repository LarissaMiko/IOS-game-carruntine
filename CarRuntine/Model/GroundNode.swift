
import SpriteKit

class GroundNode: SKSpriteNode {
    
    var isBodyActivated: Bool = false {
        //observer of isBodyActivated
        //nil if player is under platform
        //activatedBody if player on platform
        didSet {
            physicsBody = isBodyActivated ? activatedBody : nil
        }
    }
    
    private var activatedBody: SKPhysicsBody?
    
    init(with size: CGSize){
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        //upper edge of ground node
        let bodyInitialPoint = CGPoint(x: 0.0, y: size.height)
        let bodyEndPoint = CGPoint(x: size.width, y: size.height)
        
        activatedBody = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)
        activatedBody!.restitution = 0.0
        activatedBody!.friction = 0.0
        activatedBody!.isDynamic = false
        activatedBody!.affectedByGravity = false
        activatedBody!.allowsRotation = false
        activatedBody!.isResting = true
        activatedBody!.velocity = CGVector.zero
        // define pysicscategory for ground
        activatedBody!.categoryBitMask = GameConstants.PhysicsCategories.groundCategory
        // floor should collide with player
        activatedBody!.collisionBitMask = GameConstants.PhysicsCategories.playerCategory
        
        physicsBody = isBodyActivated ? activatedBody : nil
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
