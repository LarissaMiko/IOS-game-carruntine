
import UIKit
import SpriteKit


class SettingsInGameController: UIViewController {
    
    //Controller
    var audioController: AudioController!
    var gameViewController: MasterController!
    var mainmenuController: MainMenuController!
    var leveloverlayController: LevelOverlayController!
    var gameSceneController: GameViewController!
    
    //Views & scene
    var settingsIngameView: SettingsInGameView!
    var masterView: SKView!
    var scene : SKScene!
    
    //Random
    var muted: Bool!
    var finishMessage: SKLabelNode!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.mainmenuController = gameViewController.mainMenuController
        self.leveloverlayController = gameViewController.levelOverlayController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.settingsIngameView = SettingsInGameView(givenController: self, size: size)
        self.gameViewController = gameViewController
        self.muted = false
        
    }
    
    //GameSceneSettingsButton -> SettingsIngameView
    func showOwnView() {
        settingsIngameView.scaleMode = .aspectFit
        gameViewController.masterView.presentScene(settingsIngameView)
        gameViewController.masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //CloseIconPressed -> GameScene -> implements a "continue then press" label for requesting
    //input from user/player
    func closeIconPressed() {
        gameSceneController.showOwnView()
        finishMessage = SKLabelNode()
        finishMessage.name = "finishMessage"
        finishMessage.position = CGPoint(x: gameSceneController.gameView.currentWidth*gameSceneController.gameView.scaleRatioThreshold/2, y: 750 / 2)
        finishMessage.fontSize = 100
        finishMessage.zPosition = 7
        finishMessage.fontColor = .purple
        finishMessage.fontName = "Zubilo Black W01 Regular"
        finishMessage.text = "READY? Press me!"
        gameSceneController.gameView.mapNode.addChild(finishMessage)
    }
    
    //Enables or disables sound in whole game
    func soundButtonPressed() {
        if !muted {
            muted = true
            audioController.muteAll()
            settingsIngameView.soundOnButton.isHidden = true
            settingsIngameView.soundOffButton.isHidden = false
        } else {
            muted = false
            audioController.activateAll()
            settingsIngameView.soundOnButton.isHidden = false
            settingsIngameView.soundOffButton.isHidden = true
        }
    }
    
    //Go back to menu
    func menuButtonPressed() {
        
        
        self.mainmenuController.showOwnView()
        self.gameSceneController.gameView.gameState = .finished
        self.gameSceneController.resetGameScene()
      
        self.gameSceneController.gameView.gameStarted = false
        self.gameSceneController.gameView.gameState = .ready
    }
    
    //Restart current game
    func restartButtonPressed() {
        
        
        self.gameSceneController.gameView.gameState = .finished
        self.gameSceneController.gameView.gameStarted = false
        self.gameSceneController.resetGameScene()
        self.gameSceneController.gameView.startLevelDelay()
        self.gameSceneController.showOwnView()
        self.gameSceneController.gameView.gameState = .ready
    }
}
