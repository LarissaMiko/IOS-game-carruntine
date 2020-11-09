
import SpriteKit
import CoreData
import GameplayKit

//enumeration to determine Game state
enum GameState {
    case ready, ongoing, paused, finished
}

class GameView: SKScene {
    
    //Static
   static var jumpProbability : Int = 90 // should not be below 90
   static var kiSafteJumpTimeIntervalInSec : Double = 2 // seconds
   static var kiSafteyJumpMinimumMovingDistance : CGFloat = 400 // pixel
   
   //Layers
   var worldLayer: Layer!
   var backgroundLayer : Layer!
   var overlayLayer: Layer!
   
   //Bool
   var gameStarted = false
   var isActive = false
   var touchEnabled = true
   var notTappedAlready = true
   var itemSelectedBool = false
   var loadLevelDelay = true
   //check if screen is touched
       var touch = false
       var brake = false
   
   //Nodes
   var test: SKLabelNode!
   var itemSelected: SKSpriteNode!
   var itemSelectedName: String!
   var backgroundImage: SKSpriteNode!
   var coindisplay: SKLabelNode!
   var playerPositionLabel: SKLabelNode!
   var tapToStartLabel: SKLabelNode!
   var itembox: SKSpriteNode!
   var itemframe: SKSpriteNode!
   var settingsButton: SKSpriteNode!
   var toiletPaper: SKSpriteNode!
   var cam : SKCameraNode!
   var spritesToRemove = [SKSpriteNode]()
   var lampeNodeKI: SKNode!
   var mapNode: SKNode!
   var tileMap: SKTileMapNode!
   
   //Names & Strings
   var chosenPlayer: String!
   var chosenLevel: String!
       
   //Scaling
   var currentSize: CGSize!
   var currentHeight: CGFloat!
   var currentWidth: CGFloat!
   var scaleFactor: CGFloat!
   var scaleRatioThreshold: CGFloat!
   
   //Game States:
   var savedGameState : GameState!
   var gameState = GameState.ready {
       willSet {
           switch newValue {
           case .ongoing:
               player.state = .running
               kiController.startPlayers()
           case .finished:
               player.state = .idle
           case .paused:
               player.state = .idle
           default:
               break
           }
       }
   }
   
   //Controller
   var audioController: AudioController!
   var gameSceneController : GameViewController!
   var settingsIngameController: SettingsInGameController!
   var chooseCarController: ChooseCarController!
   var kiController: KIController!
   
   //Random
   var lastKiSafetyJumpCheckTimestamp : TimeInterval = 0
   var possibleItems = ["item_rakete", "item_hupe" ,"item_batterie", "item_schild"]
   var playerEntity : PlayerEntity?
   let appDelegate = UIApplication.shared.delegate as! AppDelegate;
   var coins = 0
   var player: Player!
   var playerInFinishLinePosition = 0
   var lastTime: TimeInterval = 0
   var delta: TimeInterval = 0
   let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: GameViewController, size: CGSize){
        self.savedGameState = .ready
        gameSceneController = givenController
        super.init(size: gameSceneController.masterView.bounds.size)
        self.kiController = givenController.kiController
        self.audioController = givenController.audioController
        self.currentSize = gameSceneController.masterView.bounds.size
        self.currentHeight = currentSize.height
        self.currentWidth = currentSize.width
        let cgsize = CGSize(width: 1334, height: 750)
        self.scaleFactor = currentHeight/cgsize.height
        self.scaleRatioThreshold = 750/currentHeight
      
    }
    
    //Called in chooseLevelController to prevent the game from running to early
    func startLevelDelay(){
        if(self.loadLevelDelay){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.notTappedAlready = false
                self.loadLevelDelay = false
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        gameSceneController.playAudio()
        if (!gameStarted){
            
            self.gameStarted = true
            
            physicsWorld.contactDelegate = self
            
            // normally the gravity value of dy is -9.8 which represents the gravity on earth
            physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
            
            physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: frame.minX, y: frame.minY), to: CGPoint(x: CGFloat.init(integerLiteral: Int.max), y: frame.minY))
            physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.frameCategory
            physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
            
            addPlayer()
            kiController = KIController(givenGameViewController: self.gameSceneController.gameViewController)
            kiController.setupKI()
            
            createLayers()
        }
        isActive = true
    }
    
    func setAudioController (givenAudioController: AudioController){
        audioController = givenAudioController
    }
    
    func createLayers() {
        //Whole world layer
        worldLayer = Layer()
        worldLayer.zPosition = GameConstants.ZPositions.worldZ
        worldLayer.physicsBody?.restitution = 0.0
        worldLayer.physicsBody?.isDynamic = false
        // add worldLayer as child to Scene
        addChild(worldLayer)
        //add speed (velocity) that worldlayer should move with
        //layer should move left since player is moving right
        worldLayer.layerVelocity = CGPoint(x: -350.0, y: 0.0)
        
        //Repeating background layer
        backgroundLayer = RepeatingLayer()
        //Game actions and hud layer
        overlayLayer = Layer()
        overlayLayer.zPosition = GameConstants.ZPositions.hudZ
        addChild(overlayLayer)
        
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundLayer)
        
        for i in 0...2 {
            gameSceneController.setBackground()
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 2.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: -backgroundImage.size.width + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundLayer.addChild(backgroundImage)
        }
        
        backgroundLayer.layerVelocity = CGPoint(x: -100.0 , y: 0.0)
        
        gameSceneController.loadLevel()
    }
    
    func load(level: String) {
        if let levelNode = SKNode.unarchiveFromFile(file: level) {
            mapNode = levelNode
            mapNode.physicsBody?.restitution = 0.0
            mapNode.physicsBody?.isDynamic = false
            worldLayer.addChild(mapNode)
            loadTileMap()
        }
    }
    
    func load(headsup: String){
        if let levelNode = SKNode.unarchiveFromFile(file: headsup) {
            levelNode.zPosition = GameConstants.ZPositions.hudZ
            mapNode = levelNode
            mapNode.position = CGPoint(x: 0, y: 0)
            
            //Needed for scaling
            mapNode.yScale = scaleFactor
            mapNode.xScale = scaleFactor
            mapNode.zPosition = 50
            overlayLayer.addChild(mapNode)
            
            //Toiletpaper label
            coindisplay = SKLabelNode()
            coindisplay.text = "\(coins)"
            coindisplay.fontName = "Zubilo Black W01 Regular"
            coindisplay.fontSize = 85
            coindisplay.fontColor = .blue
            coindisplay.position = CGPoint(x: 0.13*currentWidth*scaleRatioThreshold, y: 0.87*750)
            coindisplay.zPosition = GameConstants.ZPositions.hudZ
            mapNode.addChild(coindisplay)
            
            //Current position label
            playerPositionLabel = SKLabelNode()
            playerPositionLabel.text = "1st"
            playerPositionLabel.fontSize = 70
            playerPositionLabel.fontColor = .white
            playerPositionLabel.fontName = "Zubilo Black W01 Regular"
            playerPositionLabel.position = CGPoint(x: 0.5*currentWidth*scaleRatioThreshold, y: 0.90*750)
            playerPositionLabel.zPosition = GameConstants.ZPositions.hudZ + 1
            mapNode.addChild(playerPositionLabel)
            
            //Start label
            tapToStartLabel = SKLabelNode()
            tapToStartLabel.text = "Tap to start game!"
            tapToStartLabel.fontSize = 70
            tapToStartLabel.fontColor = .white
            tapToStartLabel.fontName = "Zubilo Black W01 Regular"
            tapToStartLabel.position = CGPoint(x: 0.5*currentWidth*scaleRatioThreshold, y: 750/2)
            tapToStartLabel.zPosition = GameConstants.ZPositions.hudZ + 1
            mapNode.addChild(tapToStartLabel)
            
            //Itembox
            itemframe = SKSpriteNode(imageNamed: "item_frame")
            itemframe.setScale(1.05)
            itemframe.position = CGPoint(x: 0.04*currentWidth*scaleRatioThreshold, y: 0.08*750)
            itemframe.zPosition = GameConstants.ZPositions.hudZ + 1
            mapNode.addChild(itemframe)
            
            //InGameSettingsView button
            settingsButton = SKSpriteNode(imageNamed: "Zahnrad")
            settingsButton.name = "SettingsButton"
            settingsButton.position = CGPoint(x: 0.95*currentWidth*scaleRatioThreshold, y: 0.90*750)
            settingsButton.zPosition = GameConstants.ZPositions.hudZ + 1
            
            //Toiletpaper icon
            toiletPaper = SKSpriteNode(imageNamed: "toiletpaper120")
            toiletPaper.setScale(0.85)
            toiletPaper.position = CGPoint(x:0.05*currentWidth*scaleRatioThreshold, y: 0.9*750)
            toiletPaper.zPosition = GameConstants.ZPositions.hudZ + 1
            mapNode.addChild(toiletPaper)
        }
    }
    
    func loadTileMap() {
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode {
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
            PhysicsHelper.addPhysicsBody(to: tileMap, and: GameConstants.StringConstants.groundTag)
            PhysicsHelper.addPhysicsBody(to: tileMap, and: GameConstants.StringConstants.sideEdgeTag)
            for child in groundTiles.children {
                if let sprite = child as? SKSpriteNode, sprite.name != nil {
                    ObjectHelper.handleChild(sprite: sprite, with: sprite.name!)
                }
            }
        }
        load(headsup: "LevelOverlay")
    }
    
    func addPlayer(){
        gameSceneController.setPlayer()
        
        //Player has 20% of the size of the game
        player.currentSize = self.currentSize
        player.currentWidth = self.currentWidth
        player.currentHeight = self.currentHeight
        player.scale(to: frame.size, width: false, multiplier: 0.2)
        player.name = GameConstants.StringConstants.playerName
        PhysicsHelper.addPhysicsBody(to: player, with: player.name!)
        player.position = CGPoint(x: frame.midX/3.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        player.loadTextures(playername: gameSceneController.chosenPlayer)
        player.state = .idle
        
        //Camera
        cam = SKCameraNode()
        cam.position.x = player.position.x + (frame.midX*2)/3
        cam.position.y = player.position.y
        
        addChild(player)
        addChild(cam)
        
        self.camera = cam
        
        addPlayerActions()
    }
    
    func addPlayerActions() {
        let up = SKAction.moveBy(x: 0.0, y: frame.size.height/4, duration: 0.4)
        up.timingMode = .easeOut
        
        player.createUserData(entry: up, forKey: GameConstants.StringConstants.jumpUpActionKey)
        
        let move = SKAction.moveBy(x: 0.0, y: player.size.height, duration: 0.4)
        let jump = SKAction.animate(with: player.jumpFrames, timePerFrame: 0.4/Double(player.jumpFrames.count))
        
        let group = SKAction.group([move,jump])
        
        player.createUserData(entry: group, forKey: GameConstants.StringConstants.brakeDescendActionKey)
    }
    
    func jump() {
        player.airborne = true
        player.turnGravity(on: false)
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
            //double jump
            if self.touch {
                self.player.run(self.player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
                    self.player.turnGravity(on: true)
                }
            }
        }
    }
    
    func brakeDescend(){
        brake = true
        player.physicsBody?.velocity.dy = 0.0
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction)
    }
    
    func handleCollectable(sprite: SKSpriteNode, isPlayer : Bool, index: Int) {
        switch sprite.name! {
        //collected coin
        case GameConstants.StringConstants.coinName:
            collectCoin(sprite: sprite, isPlayer: isPlayer)
        case GameConstants.StringConstants.itemboxName:
            if isPlayer {
                if itemSelectedBool {
                    itemSelected.removeFromParent()
                }
            }
            handleItem(isPlayer: isPlayer, index: index)
        default:
            break
        }
    }
    
    func collectCoin(sprite: SKSpriteNode, isPlayer : Bool) {
        if isPlayer {
            coins += 1
            coindisplay.text = "\(coins)"
            spritesToRemove.append(sprite)
        }
    }
    
    func handleItem(isPlayer: Bool, index: Int) {
        
        //make random number between 0 and 3 and use as index
        let randomNumber = Int.random(in: 0..<possibleItems.count)
        
        possibleItems.shuffle()
        
        // Player gets item
        if isPlayer {
            itemSelected = SKSpriteNode(imageNamed: possibleItems[randomNumber])
            itemSelectedName = possibleItems[randomNumber]
            
            if itemSelectedBool {
                itemSelected.removeFromParent()
            }
            itemSelected.position = CGPoint(x: itemframe.position.x, y: itemframe.position.y)
            itemSelected.zPosition = GameConstants.ZPositions.hudZ
            mapNode.addChild(itemSelected)
            itemSelectedBool = true
        }
        // KI gets item
        else{
            kiController.handleItem(item: possibleItems[0] ,index: index)
        }
    }
    
    func goalAchieved() {
        playerPositionLabel.fontSize = 80
        playerPositionLabel.fontColor = .purple
        
        let finishMessage = SKLabelNode()
        finishMessage.position = CGPoint(x: 0.5*currentWidth*scaleRatioThreshold, y: 750 / 2)
        finishMessage.fontSize = 75
        finishMessage.zPosition = 6
        finishMessage.fontColor = .purple
        finishMessage.fontName = "Zubilo Black W01 Regular"
        
        switch playerInFinishLinePosition {
        case 1:
            finishMessage.text = "NICE! YOU WON!"
        case 2:
            finishMessage.text = "GOOD GAME!"
        case 3:
            finishMessage.text = "AT LEAST NOT LAST!"
        case 4:
            finishMessage.text = "ÜFF, YOU LOST!"
        default:
            // Invalid game position - please review code
            finishMessage.text = "GAME OVER" // show generic message to user
        }
        
        mapNode.addChild(finishMessage)
        
        let menubutton = SKSpriteNode(imageNamed: "button_home")
        menubutton.position = CGPoint(x: 0.4*currentWidth*scaleRatioThreshold, y: 0.3*750)
        menubutton.name = "button_home"
        mapNode.addChild(menubutton)
        
        let restartbutton = SKSpriteNode(imageNamed: "button_restarticon")
        restartbutton.position = CGPoint(x: 0.6*currentWidth*scaleRatioThreshold, y: 0.3*750)
        restartbutton.name = "button_restart"
        mapNode.addChild(restartbutton)
    }
    
    func fireItem(){
        if itemSelectedName == "item_rakete"{
            gameSceneController.fireRocket()
        }
        else if itemSelectedName == "item_batterie"{
            gameSceneController.useBattery()
        }
        else if itemSelectedName == "item_schild"{
            gameSceneController.useShield()
        }
        else if itemSelectedName == "item_hupe"{
            gameSceneController.useHonk()
            kiController.getHonked()
        }
    }
    
    //override touch functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "SettingsButton" {
                if gameSceneController.settingsIngameController.finishMessage != nil {
                    gameSceneController.settingsIngameController.finishMessage.removeFromParent()
                }
                
                if gameState != .ready {
                    gameSceneController.settingsButtonPressed()
                    return
                }
            }
            else if nodeArray.first?.name == "finishMessage" {
                gameSceneController.settingsIngameController.finishMessage.removeFromParent()
                self.gameState = .ongoing
            }
            else if nodeArray.first?.name == "button_home" {
                gameSceneController.mainmenuButtonPressed()
                return
            }
            else if nodeArray.first?.name == "button_restart" {
                gameSceneController.restartButtonPressed()
                return
            }
        }
        
        //switch dependend on gameState
        switch gameState {
        case .ready:
            //Dispatch queue delay to prevent race from starting too early
            if(!self.notTappedAlready) {
                self.gameState = .ongoing
                self.player.state = .running
                self.kiController.startPlayers()
                self.mapNode.addChild(self.settingsButton)
                self.tapToStartLabel.removeFromParent()
            }
            
        case .ongoing:
            self.touch = true
            
            guard let touch = touches.first else {
                return
            }
            
            let location = touch.location(in: nil)
            
            //right screen --> jump  || left screen --> fire item
            if location.x < CGFloat(currentWidth/2){
                fireItem()
            } else {
                if !player.airborne{
                    jump()
                }
                else if !brake {
                    brakeDescend()
                }
            }
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = false
        player.turnGravity(on: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = false
        player.turnGravity(on: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastTime > 0 {
            delta = currentTime - lastTime
        } else {
            delta = 0
        }
        
        lastTime = currentTime
        
        // check if game is running
        if gameState == .ongoing {
            
            // check playerState
            if player.state == .running{
                player.run(delta: delta)
                overlayLayer.position.x = player.position.x - (frame.midX/3.0)
                cam.position.x = player.position.x + (frame.midX*2)/3
                worldLayer.update(player.position)
                backgroundLayer.update(player.position)
                
                // update position label of player
                // we asume that the player is leading (1st place)
                var placementOfPlayer = 1
                for ki in kiController.kis {
                    // everytime a ki is in front of the player we fall back one place
                    if((ki.position.x + ki.size.width) > (player.position.x + player.size.width)) {
                        placementOfPlayer += 1
                    }
                }
                updatePlayerPlacementView(placementOfPlayer: placementOfPlayer)
                
                // check if KI did not move for some time -> jumps
                checkKiSafetyJump(currentTime: currentTime)
            }
            if player.state == .respawning{
                // update position label of player
                // we asume that the player is leading (1st place)
                var placementOfPlayer = 1
                for ki in kiController.kis {
                    // everytime a ki is in front of the player we fall back one place
                    if((ki.position.x + ki.size.width) > (player.position.x + player.size.width)) {
                        placementOfPlayer += 1
                    }
                }
                updatePlayerPlacementView(placementOfPlayer: placementOfPlayer)
                
                overlayLayer.position.x = player.position.x - (frame.midX/3.0)
                cam.position.x = player.position.x + (frame.midX*2)/3
                worldLayer.update(player.position)
                backgroundLayer.update(player.position)
            }
            
            if(player.shieldActive){
                player.shieldNode.position.x = player.position.x
                player.shieldNode.position.y = player.position.y
            }
            //check state of KIs
            kiController.handleUpdate(delta: delta)
        }
        
        possibleItems.shuffle()
        _ = Int.random(in: 0..<possibleItems.count) // produce more random value calls
    }
    
    func checkKiSafetyJump(currentTime : TimeInterval) {
        if currentTime - lastKiSafetyJumpCheckTimestamp > GameView.kiSafteJumpTimeIntervalInSec {
            lastKiSafetyJumpCheckTimestamp = currentTime
            
            for ki in kiController.kis {
                if abs(ki.position.x - ki.lastSafetyJumpPosition) < GameView.kiSafteyJumpMinimumMovingDistance && ki.state == .running {
                    ki.jump(force: true)
                }
                ki.lastSafetyJumpPosition = ki.position.x
            }
        }
    }
    
    func updatePlayerPlacementView(placementOfPlayer: Int) {
        var positionLabelContent = ""
        
        switch placementOfPlayer {
        case 1:
            positionLabelContent = "1st"
        case 2:
            positionLabelContent = "2nd"
        case 3:
            positionLabelContent = "3rd"
        case 4:
            positionLabelContent = "4th"
        default:
            break
        }
        playerPositionLabel.text = positionLabelContent
    }
    
    // check where player is and acitvate/deactivate physicsBodys correspondingly
    override func didSimulatePhysics() {
        for node in tileMap[GameConstants.StringConstants.groundNodeName] {
            if let groundNode = node as? GroundNode {
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                var playerY = player.position.y - player.size.height/3
                
                for ki in kiController.kis{
                    if ki.position.y - ki.size.height/3 > playerY {
                        playerY = ki.position.y - ki.size.height/3
                    }
                }
                groundNode.isBodyActivated = playerY > groundY
            }
        }
        for nodes in spritesToRemove {
            nodes.removeFromParent()
        }
    }
}

extension GameView: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        //player touches ground -> airborne = false
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = false
            brake = false
            
        //player reaches finishline
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            playerEntity = CoreDataService.getPlayer()
            playerEntity?.coins += Int32(coins)
            CoreDataService.saveContext()
            gameState = .finished
            settingsButton.removeFromParent()
            playerInFinishLinePosition += 1
            playerPositionLabel.text = String(playerInFinishLinePosition)
            updatePlayerPlacementView(placementOfPlayer: playerInFinishLinePosition)
            goalAchieved()
            
        //player touches enemy and dies - poor alfred
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            player.state = .respawning
            player.respawn()
            
        //stupid alfred falls off the platform
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.frameCategory:
            player.state = .respawning
            player.respawn()
            
        // player collects something
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.collectableCategory:
            //Save collectable Sprite in variable
            let collectable = contact.bodyA.node?.name == player.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            handleCollectable(sprite: collectable, isPlayer: true, index: 0)
            
        // update respawn-position when player passes checkPoint
        case GameConstants.PhysicsCategories.playerCategory |
            GameConstants.PhysicsCategories.checkPointCategory:
            player.respawnPosition = CGPoint(x: player.position.x + 50, y: player.position.y + 80)
            
        case GameConstants.PhysicsCategories.rocketCategory | GameConstants.PhysicsCategories.playerCategory:
            
            let rocketNode = contact.bodyA.node?.name == GameConstants.StringConstants.rocketName ? contact.bodyA.node as! SKSpriteNode :
            contact.bodyB.node as! SKSpriteNode
            
            // we assume that the rocket is from the KI
            var isRocketFromKI = true
            
            if let rocketUserDataCount = rocketNode.userData?.allKeys.count {
                // only rockets from player do have a user data dictionary entry
                if rocketUserDataCount > 0 {
                    isRocketFromKI = false
                }
            }
            
            if player.state == .running && isRocketFromKI {
                if player.shieldActive {
                    player.shieldNode.removeFromParent()
                    player.shieldActive = false
                } else {
                    audioController.playHitSound()
                    player.state = .respawning
                    player.respawn()
                }
            }
            
            /**
             KI physics mgmt
             */
            
        // Finish line contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.finishCategory:
            playerInFinishLinePosition += 1
            kiController.ki1.state = .idle
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.finishCategory:
            playerInFinishLinePosition += 1
            kiController.ki2.state = .idle
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.finishCategory:
            playerInFinishLinePosition += 1
            kiController.ki3.state = .idle
            
        // Frame contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.frameCategory:
            kiController.ki1.state = .respawning
            kiController.ki1.respawn()
            
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.frameCategory:
            kiController.ki2.state = .respawning
            kiController.ki2.respawn()
            
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.frameCategory:
            kiController.ki3.state = .respawning
            kiController.ki3.respawn()
            
        // Collectable contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.collectableCategory:
            
            let collectable = contact.bodyA.node?.name == kiController.ki1.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            handleCollectable(sprite: collectable, isPlayer: false, index: 1)
            
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.collectableCategory:
            let collectable = contact.bodyA.node?.name == kiController.ki2.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            handleCollectable(sprite: collectable, isPlayer: false, index: 2)
            
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.collectableCategory:
            let collectable = contact.bodyA.node?.name == kiController.ki3.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            handleCollectable(sprite: collectable, isPlayer: false, index: 3)
            
        // item contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.rocketCategory:
            if kiController.ki1.state == .running {
                if kiController.ki1.shieldActive {
                    kiController.ki1.shieldNode.removeFromParent()
                    kiController.ki1.shieldActive = false
                } else {
                    kiController.ki1.state = .respawning
                    kiController.ki1.respawn()
                    audioController.playHitSound()
                }
            }
            
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.rocketCategory:
            if kiController.ki2.state == .running {
                if kiController.ki2.shieldActive {
                    kiController.ki2.shieldNode.removeFromParent()
                    kiController.ki2.shieldActive = false
                } else {
                    audioController.playHitSound()
                    kiController.ki2.state = .respawning
                    kiController.ki2.respawn()
                }
            }
            
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.rocketCategory:
            if kiController.ki3.state == .running {
                if kiController.ki3.shieldActive {
                    kiController.ki3.shieldNode.removeFromParent()
                    kiController.ki3.shieldActive = false
                } else {
                    audioController.playHitSound()
                    kiController.ki3.state = .respawning
                    kiController.ki3.respawn()
                }
            }
            
        // checkpoint contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.checkPointCategory:
            kiController.ki1.respawnPosition = CGPoint(x: kiController.ki1.position.x + 50, y: kiController.ki1.position.y + 80)
            
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.checkPointCategory:
            kiController.ki2.respawnPosition = CGPoint(x: kiController.ki2.position.x + 50, y: kiController.ki2.position.y + 80)
            
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.checkPointCategory:
            kiController.ki3.respawnPosition = CGPoint(x: kiController.ki3.position.x + 50, y: kiController.ki3.position.y + 80)
            
        // jump marker contact
        case GameConstants.PhysicsCategories.ki1Category | GameConstants.PhysicsCategories.jumpMarkerCategory:
            
            let marker = contact.bodyA.node?.name == kiController.ki1.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            
            let isStep = (marker.userData?.value(forKey: GameConstants.StringConstants.stepJumpKey) != nil)
            if kiController.ki1.state != .respawning {
                kiController.ki1.jump(force: isStep)
            }
            
        case GameConstants.PhysicsCategories.ki2Category | GameConstants.PhysicsCategories.jumpMarkerCategory:
            
            let marker = contact.bodyA.node?.name == kiController.ki2.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            
            let isStep = (marker.userData?.value(forKey: GameConstants.StringConstants.stepJumpKey) != nil)
            if kiController.ki2.state != .respawning {
                kiController.ki2.jump(force: isStep)
            }
            
        case GameConstants.PhysicsCategories.ki3Category | GameConstants.PhysicsCategories.jumpMarkerCategory:
            let marker = contact.bodyA.node?.name == kiController.ki3.name ? contact.bodyB.node as! SKSpriteNode :
                contact.bodyA.node as! SKSpriteNode
            
            let isStep = (marker.userData?.value(forKey: GameConstants.StringConstants.stepJumpKey) != nil)
            if kiController.ki3.state != .respawning {
                kiController.ki3.jump(force: isStep)
            }
            
        default:
            break // do nothing
        }
    }
}

