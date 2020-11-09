
import UIKit
import SpriteKit


class ChooseLevelController: UIViewController {
    
    var chooselevelView: ChooseLevelView!
    var audioController: AudioController!
    var masterView: SKView!
    var scene : SKScene!
    var gameViewController: MasterController!
    var gameSceneController: GameViewController!
    var choosecarController: ChooseCarController!
    var chosenLevel: String!
    var gameScene: GameView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.gameSceneController = gameViewController.gameSceneController
        self.choosecarController = gameViewController.chooseCarController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        chooselevelView = ChooseLevelView(givenController: self, size: size)
        self.gameScene = gameViewController.gameSceneController.gameView
    }
    
    func playAudio() {
        
    }
    
    func showOwnView() {
        chooselevelView.scaleMode = .aspectFit
        masterView.presentScene(chooselevelView)
        masterView.ignoresSiblingOrder = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func backButtonPressed() {
        choosecarController.showOwnView()
        choosecarController.choosecarView.niceButton.isHidden = true
    }
    
    func level1ButtonPressed() {
        self.chosenLevel = "Level_01"
        gameScene.chosenLevel = chosenLevel
        gameSceneController.showOwnView()
        gameSceneController.gameView.startLevelDelay()
    }
    
    func level2ButtonPressed() {
        self.chosenLevel = "Level_02"
        gameScene.chosenLevel = chosenLevel
        gameSceneController.showOwnView()
        gameSceneController.gameView.startLevelDelay()
    }
    
    func level3ButtonPressed(){
        self.chosenLevel = "Level_03"
        gameScene.chosenLevel = chosenLevel
        gameSceneController.showOwnView()
        gameSceneController.gameView.startLevelDelay()
    }
    
    func level4ButtonPressed(){
        self.chosenLevel = "Level_04"
        gameScene.chosenLevel = chosenLevel
        gameSceneController.showOwnView()
        gameSceneController.gameView.startLevelDelay()
    }
}
