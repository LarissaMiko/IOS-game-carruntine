
import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    //Controller
    var gameViewController: MasterController!
    var settingsIngameController: SettingsInGameController!
    var chooseCarController: ChooseCarController!
    var kiController: KIController!
    var mainManuController: MainMenuController!
    var chooseLevelController: ChooseLevelController!
    var audioController: AudioController!
    
    //Bool
    var playerUsingRejoin = false
    var playerUsingBattery = false
    var playerLaunchingRocket = false
    var playerUsingHonk = false
    var playerUsingShield = false
    var newActivation = false
    var restart = false
    
    //Random
    var masterView: SKView!
    var scene : SKScene!
    var gameView: GameView!
    var currentSize: CGSize!
    var chosenPlayer : String!
    var size: CGSize!
    var shieldScaleFactor: Float!
    var rocketScaleFactor: Float!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.gameViewController = gameViewController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        self.settingsIngameController = gameViewController.settingsIngameController
        self.chooseCarController = gameViewController.chooseCarController
        self.kiController = gameViewController.kiController
        self.mainManuController = gameViewController.mainMenuController
        self.chooseLevelController = gameViewController.chooseLevelController
        super.init(nibName: nil, bundle: nil)
        self.size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.gameView = GameView(givenController: self, size: size)
        self.currentSize = masterView.bounds.size
        itemScalingHelper()
    }
    
    //GameScene uses same music as MainMenuView
    func playAudio() {
        audioController.playMenuMusic()
    }
    
    //ChooseLevelView -> GameScene
    func showOwnView() {
        gameView.scaleMode = .aspectFit
        masterView.presentScene(gameView)
        masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Checks desired car
    func setPlayer() {
        if chooseCarController.playername == "Hund"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerDogImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "Katze"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerCatImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "Ratte"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerRatImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "Sepp"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerSeppImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "Schnecke"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerSchneckeImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "HundBlau"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerDogBlueImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "KatzePink"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerCatPinkImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "Pirat"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerPirateImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "RatteNeon"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerRatNeonImageName)
            gameView.player.currentSize = self.currentSize
        }
        else if chooseCarController.playername == "SchneckeBlack"{
            gameView.player = Player(imageNamed: GameConstants.StringConstants.playerSchneckeBlackImageName)
            gameView.player.currentSize = self.currentSize
        }
    }
    
    //Sets background dependent of players level choice
    func setBackground() {
        if chooseLevelController.chosenLevel == "Level_01" {
            gameView.backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[4])
        }
        else if chooseLevelController.chosenLevel == "Level_02"{
            gameView.backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[5])
        }
        else if chooseLevelController.chosenLevel == "Level_03"{
            gameView.backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[6])
        }
        else if chooseLevelController.chosenLevel == "Level_04"{
            gameView.backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[7])
        }
    }
    
    //Loads specific level
    func loadLevel() {
        if chooseLevelController.chosenLevel == "Level_01" {
            gameView.load(level: "Level_01")
        }
        else if chooseLevelController.chosenLevel == "Level_02" {
            gameView.load(level: "Level_02")
        }
        else if chooseLevelController.chosenLevel == "Level_03" {
            gameView.load(level: "Level_03")
        }
        else if chooseLevelController.chosenLevel == "Level_04" {
            gameView.load(level: "Level_04")
        }
    }
    
    //GameSceneSettingsButton -> SettingsIngameView
    func settingsButtonPressed(){
        self.gameView.savedGameState = self.gameView.gameState    
        self.gameView.gameState = .paused
        settingsIngameController.showOwnView()
    }
    
    
    //ITEM handling:
    
    
    //BATTERY
    func useBattery(){
        audioController.playBatterySound()
        playerUsingBattery = true
        self.gameView.player.playerSpeed = Player.boostSpeed
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            if(self.playerUsingBattery){
                self.gameView.player.playerSpeed = Player.standardSpeed
                self.playerUsingBattery = false
            }
        }
        gameView.itemSelectedName = ""
        gameView.itemSelected.removeFromParent()
        gameView.itemSelectedBool = false
    }
    
    //SHIELD
    func useShield(){
        //Audio call at first for low latency audio feedback
        audioController.playShieldSound()
        
        if(!gameView.player.shieldActive){
            playerUsingShield = true
            gameView.player.shieldActive = true
            gameView.player.shieldNode = SKSpriteNode(imageNamed: "schutzschildLeer")
            gameView.player.shieldNode.name = GameConstants.StringConstants.shieldName
            PhysicsHelper.addPhysicsBody(to: gameView.player.shieldNode, with: gameView.player.shieldNode.name!)
            gameView.player.shieldNode.position = gameView.player.position
            gameView.player.shieldNode.zPosition = GameConstants.ZPositions.hudZ
            gameView.player.shieldNode.setScale(CGFloat(shieldScaleFactor))
            gameView.addChild(gameView.player.shieldNode)
        }
        
        gameView.itemSelectedName = ""
        gameView.itemSelected.removeFromParent()
        gameView.itemSelectedBool = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            if(self.playerUsingShield){
                
                self.gameView.player.shieldNode.removeFromParent()
                self.gameView.player.shieldActive = false
                self.playerUsingShield = false
            }
        }
    }
    
    //ROCKET
    func fireRocket() {
        
        audioController.playRocketSound()
        playerLaunchingRocket = true
        
        let rocketNode = SKSpriteNode(imageNamed: "item_small-rakete")
        rocketNode.name = GameConstants.StringConstants.rocketName
        rocketNode.position = gameView.player.position
        rocketNode.position.x += gameView.player.size.width
        rocketNode.userData = NSMutableDictionary()
        rocketNode.userData?.setObject("fromPlayer", forKey: true as NSCopying)
        rocketNode.zPosition = GameConstants.ZPositions.hudZ
        rocketNode.setScale(CGFloat(rocketScaleFactor))
        PhysicsHelper.addPhysicsBody(to: rocketNode, with: rocketNode.name!)
        gameView.addChild(rocketNode)
        
        let animationDuration: TimeInterval = 1
        var actionArray = [SKAction]()
                
        actionArray.append(SKAction.move(to: CGPoint(x: rocketNode.position.x + gameView.frame.size.width * 2, y: gameView.player.position.y), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        rocketNode.run(SKAction.sequence(actionArray))
        
        gameView.itemSelectedName = ""
        gameView.itemSelected.removeFromParent()
        gameView.itemSelectedBool = false
        playerLaunchingRocket = false
    }
    
    //HONK
    func useHonk(){
        audioController.playHonkSound()
        gameView.itemSelectedName = ""
        gameView.itemSelected.removeFromParent()
        gameView.itemSelectedBool = false
    }
    
    //DONT DELETE, CURRENTLY INACTIVE, ITEM under construction
    //    func useReJoin(){
    //        audioController.playHiyahSound()
    //        playerUsingRejoin = true
    //
    //
    //        gameView.shieldNode = SKSpriteNode(imageNamed: "item_stern")
    //       gameView.shieldNode.position = gameView.player.position
    //       gameView.shieldNode.zPosition = GameConstants.ZPositions.hudZ
    //        gameView.shieldNode.setScale(0.8)
    //       gameView.shieldActive = true
    //       gameView.addChild(gameView.shieldNode)
    //
    //
    //        self.gameView.playerSpeed = 1200
    //
    //        //Rejoining has to disable player contorl and to track for KIJump markers.
    //        //Similar to rocket in Mario Kart
    //        gameView.touchEnabled = false
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    //            self.gameView.playerSpeed = 500
    //            self.gameView.touchEnabled = true
    //           self.gameView.shieldNode.removeFromParent()
    //            self.playerUsingRejoin = false
    //        }
    //        gameView.itemSelectedName = ""
    //        gameView.itemSelected.removeFromParent()
    //    }
    
    
    //MainMenuButton -> stop -> MainMenu
    func mainmenuButtonPressed() {
        gameView.isActive = false
        mainManuController.showOwnView()
        self.gameView.gameState = .finished
        gameView.kiController = KIController(givenGameViewController: mainManuController.gameViewController)
        resetGameScene()
        self.gameView.gameStarted = false
        self.gameView.gameState = .ready
    }
    
    //RestartButton -> Reset and load new GameScene
    func restartButtonPressed() {
       
        restart = true
        gameView.gameState = .finished
        gameView.gameStarted = false
        resetGameScene()
        gameView.startLevelDelay()
        self.showOwnView()
        gameView.gameState = .ready
      
    }
    
    //Scales items according to screenSize (IPad, iPhone 11, iPhone 8)
    func itemScalingHelper () {
        shieldScaleFactor = Float(currentSize.height)/Float(GameConstants.Resolutions.yMasterResolution)
        rocketScaleFactor = Float(currentSize.height)/Float(GameConstants.Resolutions.yMasterResolution)
    }
    
    //RESET game scene
    func resetGameScene(){
        gameView.removeAllActions()
        gameView.removeAllChildren()
        
        if gameView.itemSelected == nil {
            //do nothing
        }
        else {
            gameView.itemSelected.removeFromParent()
        }
        
        if playerUsingShield {
            self.gameView.player.shieldNode.removeFromParent()
            self.gameView.player.shieldActive = false
            self.playerUsingShield = false
        }
        
      
        playerUsingBattery = false
        playerUsingHonk = false
        self.gameView.player.shieldActive = false
        
        gameView = GameView(givenController: self, size: size)
        
         
        gameView.loadLevelDelay = true
        gameView.notTappedAlready = true
            
    
        gameView.chosenPlayer = chosenPlayer
       
    }
}

