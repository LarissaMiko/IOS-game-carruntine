
import SpriteKit

class PhysicsHelper {
    
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String) {
        
        var namesWithDynamicBodies = [String]()
        namesWithDynamicBodies.append(GameConstants.StringConstants.playerName)
        namesWithDynamicBodies.append(GameConstants.StringConstants.ki1Name)
        namesWithDynamicBodies.append(GameConstants.StringConstants.ki2Name)
        namesWithDynamicBodies.append(GameConstants.StringConstants.ki3Name)
        
        //check what kind of spriteNode 
        switch name {
        case GameConstants.StringConstants.playerName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            
            // player does not bounce from other objects, just lands on them
            sprite.physicsBody!.restitution = 0.0
            
            // player should not rotate - just stands like a man - like a reeeeeal Alfred - hehe muhahaha - programming on sunday evening is fun fun fun
            sprite.physicsBody!.allowsRotation = false
            // define PhysicsCategory
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.playerCategory
            // player should collide with ground or finish line
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory |
                GameConstants.PhysicsCategories.finishCategory
            // test contact with any PhysicsCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
        
        // KI1
        case GameConstants.StringConstants.ki1Name:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            sprite.physicsBody!.restitution = 0.0
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.ki1Category
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory |
                GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
        
        // KI2
        case GameConstants.StringConstants.ki2Name:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            sprite.physicsBody!.restitution = 0.0
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.ki2Category
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory |
                GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
         
        // KI3
        case GameConstants.StringConstants.ki3Name:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            sprite.physicsBody!.restitution = 0.0
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.ki3Category
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory |
                GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
       
        case GameConstants.StringConstants.finishLineName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.isDynamic = false
            sprite.physicsBody!.affectedByGravity = false
        
        case GameConstants.StringConstants.checkpointName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask =
                GameConstants.PhysicsCategories.checkPointCategory
            sprite.physicsBody!.isDynamic = false
            sprite.physicsBody!.affectedByGravity = false
            
        case GameConstants.StringConstants.jumpMarkerName:
              sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
              sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.jumpMarkerCategory
              sprite.physicsBody!.isDynamic = false
              sprite.physicsBody!.affectedByGravity = false
          
        case GameConstants.StringConstants.enemyName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.enemyCategory
        
        case GameConstants.StringConstants.rocketName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.rocketCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.shieldCategory | GameConstants.PhysicsCategories.playerCategory
        
        case GameConstants.StringConstants.shieldName:
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
            sprite.physicsBody!.categoryBitMask =
            GameConstants.PhysicsCategories.shieldCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.rocketCategory
            
        case GameConstants.StringConstants.coinName:
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
            sprite.physicsBody!.categoryBitMask =
                GameConstants.PhysicsCategories.collectableCategory
        
        case GameConstants.StringConstants.itemboxName:
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.collectableCategory
                        
        default:
            // for all other unknown sprites
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
        
        if !namesWithDynamicBodies.contains(name) {
            //check contact with player
            if(name != GameConstants.StringConstants.rocketName && name != GameConstants.StringConstants.shieldName){
                 sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
            }
            //no dynamic physicsBody e.g finishLine doesn't move when touched by player
            sprite.physicsBody!.isDynamic = false
        }
    }
    
    static func addPhysicsBody(to tileMap: SKTileMapNode, and tileInfo: String){
        let tileSize = tileMap.tileSize
        //check rows and columns of tilemap step by step
        //rows first since platforms are horizontal
        for row in 0..<tileMap.numberOfRows {
            var tiles = [Int]()
            for col in 0..<tileMap.numberOfColumns {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                if (isUsedTile ?? false) {
                    tiles.append(1)
                } else {
                    tiles.append(0)
                }
            }
            if tiles.contains(1) {
                var platform = [Int]()
                for (index, tile) in tiles.enumerated() {
                    if tile == 1 && index < (tileMap.numberOfColumns - 1) {
                        platform.append(index)
                    } else if !platform.isEmpty {
                        let x = CGFloat(platform[0]) * tileSize.width
                        let y = CGFloat(row) * tileSize.height
                        let tileNode : SKSpriteNode
                        switch tileInfo {
                        case GameConstants.StringConstants.groundTag:
                            tileNode = GroundNode(with: CGSize(width: tileSize.width  * CGFloat(platform.count), height: tileSize.height))
                        case GameConstants.StringConstants.sideEdgeTag:
                            tileNode = EdgeNode(with: CGSize(width: tileSize.width  * CGFloat(platform.count), height: tileSize.height))
                        default:
                            tileNode = GroundNode(with: CGSize(width: tileSize.width  * CGFloat(platform.count), height: tileSize.height))
                        }
                        
                        tileNode.position  = CGPoint(x: x, y: y)
                        tileMap.addChild(tileNode)
                        platform.removeAll()
                    }
                }
            }
    }
}
}


