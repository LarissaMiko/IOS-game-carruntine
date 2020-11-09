
import SpriteKit

class ObjectHelper {
    
    static func handleChild(sprite: SKSpriteNode, with name: String) {
        switch name {
        case GameConstants.StringConstants.finishLineName,
             GameConstants.StringConstants.enemyName,
             GameConstants.StringConstants.rocketName,
             GameConstants.StringConstants.shieldName,
             GameConstants.StringConstants.coinName,
             GameConstants.StringConstants.checkpointName,
             GameConstants.StringConstants.jumpMarkerName,
             GameConstants.StringConstants.itemboxName:
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)

        default:
            break
        }
    }
}
