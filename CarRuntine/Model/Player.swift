
import SpriteKit

enum PlayerState {
    case idle, running, respawning
}

class Player: SKSpriteNode {
    
    static let standardSpeed : Float = 480
    static let boostSpeed : Float = 1000
    static let honkSpeed : Float = 100
    
    var playerSpeed : Float = 480.0
    
    var shieldActive = false
    var shieldNode : SKSpriteNode!
    
    var runFrames = [SKTexture]()
    var idleFrames = [SKTexture]()
    var jumpFrames = [SKTexture]()
    var dieFrames = [SKTexture]()

    var respawnPosition = CGPoint()
    //Needed for speed adjustement on different devices
    var currentSize: CGSize?
    var currentWidth: CGFloat?
    var currentHeight: CGFloat?
    

    
    var speedAdjustment: CGFloat!
    
    var state = PlayerState.idle {
        //run animate each time when state is changed
        willSet{
            animate(for: newValue)
        }
    }
    
   
    //check if player is in the air
    var airborne = false
    func loadTextures(playername: String) {
        
        if playername == "Hund" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogIdleAtlas), withName: GameConstants.StringConstants.idleDogPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogRunAtlas), withName: GameConstants.StringConstants.runDogPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogJumpAtlas), withName: GameConstants.StringConstants.jumpDogPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogDieAtlas), withName: GameConstants.StringConstants.dieDogPrefixKey)
        }
        else if playername == "Katze" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatIdleAtlas), withName: GameConstants.StringConstants.idleCatPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatRunAtlas), withName: GameConstants.StringConstants.runCatPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatJumpAtlas), withName: GameConstants.StringConstants.jumpCatPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatDieAtlas), withName: GameConstants.StringConstants.dieCatPrefixKey)
        }
        else if playername == "Ratte" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatIdleAtlas), withName: GameConstants.StringConstants.idleRatPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatRunAtlas), withName: GameConstants.StringConstants.runRatPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatJumpAtlas), withName: GameConstants.StringConstants.jumpRatPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatDieAtlas), withName: GameConstants.StringConstants.dieRatPrefixKey)
        }
        else if playername == "Sepp" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSeppIdleAtlas), withName: GameConstants.StringConstants.idleSeppPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSeppRunAtlas), withName: GameConstants.StringConstants.runSeppPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSeppJumpAtlas), withName: GameConstants.StringConstants.jumpSeppPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSeppDieAtlas), withName: GameConstants.StringConstants.dieSeppPrefixKey)
        }
        else if playername == "Schnecke" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeIdleAtlas), withName: GameConstants.StringConstants.idleSchneckePrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeRunAtlas), withName: GameConstants.StringConstants.runSchneckePrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeJumpAtlas), withName: GameConstants.StringConstants.jumpSchneckePrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeDieAtlas), withName: GameConstants.StringConstants.dieSchneckePrefixKey)
        }
        else if playername == "HundBlau" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogBlueIdleAtlas), withName: GameConstants.StringConstants.idleDogBluePrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogBlueRunAtlas), withName: GameConstants.StringConstants.runDogBluePrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogBlueJumpAtlas), withName: GameConstants.StringConstants.jumpDogBluePrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDogBlueDieAtlas), withName: GameConstants.StringConstants.dieDogBluePrefixKey)
        }
        else if playername == "KatzePink" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatPinkIdleAtlas), withName: GameConstants.StringConstants.idleCatPinkPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatPinkRunAtlas), withName: GameConstants.StringConstants.runCatPinkPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatPinkJumpAtlas), withName: GameConstants.StringConstants.jumpCatPinkPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerCatPinkDieAtlas), withName: GameConstants.StringConstants.dieCatPinkPrefixKey)
        }
        else if playername == "Pirat" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerPirateIdleAtlas), withName: GameConstants.StringConstants.idlePiratePrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerPirateRunAtlas), withName: GameConstants.StringConstants.runPiratePrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerPirateJumpAtlas), withName: GameConstants.StringConstants.jumpPiratePrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerPirateDieAtlas), withName: GameConstants.StringConstants.diePiratePrefixKey)
        }
        else if playername == "RatteNeon" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatNeonIdleAtlas), withName: GameConstants.StringConstants.idleRatNeonPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatNeonRunAtlas), withName: GameConstants.StringConstants.runRatNeonPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatNeonJumpAtlas), withName: GameConstants.StringConstants.jumpRatNeonPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRatNeonDieAtlas), withName: GameConstants.StringConstants.dieRatNeonPrefixKey)
        }
        else if playername == "SchneckeBlack" {
            idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeBlackIdleAtlas), withName: GameConstants.StringConstants.idleSchneckeBlackPrefixKey)
            
            runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeBlackRunAtlas), withName: GameConstants.StringConstants.runSchneckeBlackPrefixKey)
            
            jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeBlackJumpAtlas), withName: GameConstants.StringConstants.jumpSchneckeBlackPrefixKey)
            
            dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerSchneckeBlackDieAtlas), withName: GameConstants.StringConstants.dieSchneckeBlackPrefixKey)
        }
        //do you see these changes???
    }
    
    func animate(for state: PlayerState){
        
        switch state {
        case .idle:
            removeAllActions()
            self.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.05, resize: true, restore: true)))
            
        case .running:
            removeAllActions()
            self.run(SKAction.repeatForever(SKAction.animate(with: runFrames, timePerFrame: 0.05, resize: true, restore: true)))
            
        case .respawning:
            self.run(SKAction.repeatForever(SKAction.animate(with: dieFrames, timePerFrame: 0.05, resize: true, restore: true)))
        }
    }
    
    func run(delta: Double){
        
        //Devices are categorized into aspect ratio of 4:3 (lowest), 16:9 (medium) and 19,5:9 (highest)
        
        self.currentWidth = self.currentSize?.width
        self.currentHeight = self.currentSize?.height
        let speedFactor = currentHeight!/currentWidth!
        
        speedAdjustment = 1
        //This speed on device scaling is hardcoded and can not be used if application is extended for playing online
        if (speedFactor < 0.45){
            //no iphone/ipad with this ratio at the moment but set with default value
            self.speedAdjustment = 1
        } else if (speedFactor >= 0.45 && speedFactor < 0.55){
            //currently iPhone X & 11 pro etc.
            self.speedAdjustment = 1.05
        } else if (speedFactor >= 0.55 && speedFactor < 0.65){
            //iPhone 8 (plus), SE etc.
            self.speedAdjustment = 1
        } else if (speedFactor >= 0.65 && speedFactor < 0.751){
            // Ipads
            self.speedAdjustment = 1.85
        } else if (speedFactor >= 0.751){
            //currently no device with this ratio
            self.speedAdjustment = 1
        } else {
            // error should not happen
        }
        
        self.position.x += CGFloat(playerSpeed) * CGFloat(delta) * self.speedAdjustment
    }
    
    func respawn(){
        let diesalto = SKAction.animate(with: self.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
               
        self.run(SKAction.group([diesalto, SKAction.move(to: self.respawnPosition, duration: 1)])){
           self.state = .running
        }
    }
}
