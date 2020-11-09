
import GameplayKit
import Foundation

//Du hast Probleme oder Klagen? Nicht verzagen - Domi fragen! :)
class KIController {
    
    var isEnabled = true
    
    // KI players
    let ki1: KI!
    let ki2: KI!
    let ki3: KI!
    
    var kis = [KI]()
    var kiNames = [String]()
    
    var gameViewController: MasterController!
    var shieldScaleFactor: Float!
    var rocketScaleFactor: Float!
    var currentSize: CGSize!
    var masterView: SKView!
    
    init(givenGameViewController: MasterController){
        self.ki1 = KI(imageNamed: GameConstants.StringConstants.ki1ImageName)
        self.ki2 = KI(imageNamed: GameConstants.StringConstants.ki2ImageName)
        self.ki3 = KI(imageNamed: GameConstants.StringConstants.ki3ImageName)        
        self.ki1.name = "KI1"
        self.ki2.name = "KI2"
        self.ki3.name = "KI3"
        
        self.kis.append(ki1)
        self.kis.append(ki2)
        self.kis.append(ki3)
        
        self.kiNames.append(GameConstants.StringConstants.ki1Name)
        self.kiNames.append(GameConstants.StringConstants.ki2Name)
        self.kiNames.append(GameConstants.StringConstants.ki3Name)
        
        self.gameViewController = givenGameViewController
        
        self.ki1.currentSize = gameViewController.masterView.bounds.size
        self.ki2.currentSize = gameViewController.masterView.bounds.size
        self.ki3.currentSize = gameViewController.masterView.bounds.size
        
        self.masterView = gameViewController.masterView
        self.currentSize = masterView.bounds.size
        itemScalingHelper()
    }
    
    func setupKI(){
        let frame = gameViewController.gameSceneController.gameView.frame
        
        var xOffset = -50
        for (index, ki) in kis.enumerated() {
            ki.scale(to: frame.size, width: false, multiplier: 0.2)
            ki.name = kiNames[index]
            PhysicsHelper.addPhysicsBody(to: ki, with: kiNames[index])
            
            ki.position = CGPoint(x: frame.midX/3.0 + CGFloat(xOffset), y: frame.midY)
            ki.lastSafetyJumpPosition = frame.midX/3.0
            ki.zPosition = GameConstants.ZPositions.kiZ
            ki.state = .idle
            
            gameViewController.gameSceneController.gameView.addChild(ki)
            xOffset += 50
        }
    }
    
    func startPlayers(){
        for ki in self.kis {
            ki.state = .running
        }
    }
    
    func handleUpdate(delta: Double){
        for ki in self.kis {
            if ki.state == .running {
                ki.run(delta: delta)
            }
            
            if ki.shieldActive {
                ki.shieldNode.position = ki.position
            }
        }
    }
    
    func handleItem(item: String, index: Int){
        if item == "item_rakete"{
            fireRocket(index: index)
        }
        else if item == "item_batterie"{
            useBattery(index: index)
        }
        else if item == "item_schild"{
            useShield(index: index)
        }
        else if item == "item_hupe"{
            useHonk(index: index)
        }
    }
    
    //Scales items according to screenSize (IPad, iPhone 11, iPhone 8)
    func itemScalingHelper () {
        
        shieldScaleFactor = Float(currentSize.height)/Float(GameConstants.Resolutions.yMasterResolution)
        rocketScaleFactor = Float(currentSize.height)/Float(GameConstants.Resolutions.yMasterResolution)
        
    }
    
    func fireRocket(index: Int) {
        
        let  gameScene: GameView! = self.gameViewController.gameSceneController.gameView
        
        let random = Int.random(in: 0..<10)
        if random > 1{
            let rocketNode = SKSpriteNode(imageNamed: "item_small-rakete")
            rocketNode.name = GameConstants.StringConstants.rocketName
            rocketNode.position = kis[index-1].position
            rocketNode.position.x += kis[index-1].size.width
            rocketNode.zPosition = GameConstants.ZPositions.hudZ
            rocketNode.setScale(CGFloat(rocketScaleFactor))
            PhysicsHelper.addPhysicsBody(to: rocketNode, with: rocketNode.name!)
            
            gameScene.addChild(rocketNode)
            
            let animationDuration: TimeInterval = 1
            
            var actionArray = [SKAction]()
            
            actionArray.append(SKAction.move(to: CGPoint(x: kis[index-1].position.x + gameScene.frame.size.width * 2, y: kis[index-1].position.y), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            
            rocketNode.run(SKAction.sequence(actionArray))
        }
    }
    
    func useShield(index: Int){
        
        let  gameScene: GameView! = self.gameViewController.gameSceneController.gameView
        
        if(!kis[index-1].shieldActive){
            
            kis[index-1].shieldNode = SKSpriteNode(imageNamed: "schutzschildLeer")
            kis[index-1].shieldNode.name = GameConstants.StringConstants.shieldName
            PhysicsHelper.addPhysicsBody(to: kis[index-1].shieldNode, with: kis[index-1].shieldNode.name!)
            kis[index-1].shieldNode.position = kis[index-1].position
            kis[index-1].shieldNode.zPosition = GameConstants.ZPositions.hudZ
            kis[index-1].shieldNode.setScale(CGFloat(shieldScaleFactor))
            kis[index-1].shieldActive = true
            
            gameScene.addChild(kis[index-1].shieldNode)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.kis[index-1].shieldNode.removeFromParent()
            self.kis[index-1].shieldActive = false
        }
    }
    
    func useBattery(index: Int){
        
        kis[index-1].playerSpeed = Player.boostSpeed
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.kis[index-1].playerSpeed = Player.standardSpeed
        }
    }
    
    // KI uses honk
    func useHonk(index: Int){
        
        let filteredKis = kis.filter{(ki) -> Bool in
            return ki != kis[index-1]
        }
        
        let random = Int.random(in: 0..<10)
        if random > 5{
            gameViewController.audioController.playHonkSoundKI()
            for ki in filteredKis{
                if(!ki.shieldActive){
                    ki.playerSpeed = Player.honkSpeed
                }
            }
            if(!gameViewController.gameSceneController.gameView.player.shieldActive){
                self.gameViewController.gameSceneController.gameView.player.playerSpeed = Player.honkSpeed
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                for ki in filteredKis{
                    ki.playerSpeed = Player.standardSpeed
                }
                self.gameViewController.gameSceneController.gameView.player.playerSpeed = Player.standardSpeed
            }
        }
    }
    
    //  Player honks
    func getHonked(){
        for ki in kis{
            if(!ki.shieldActive){
                ki.playerSpeed = Player.honkSpeed
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            for ki in self.kis{
                ki.playerSpeed = Player.standardSpeed
            }
        }
    }
}
