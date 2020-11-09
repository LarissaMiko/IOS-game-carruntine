
import UIKit
import SpriteKit


class GameGuideController: UIViewController {
    
    var highscoresView: GameGuideView!
    var audioController: AudioController!
    var masterView: SKView!
    var scene : SKScene!
    var gameViewController: MasterController!
    var mainmenuController: MainMenuController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.mainmenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.highscoresView = GameGuideView(givenController: self, size: size)
    }
    
    //MainMenuView -> GameGuideView
    func showOwnView() {
        highscoresView.scaleMode = .aspectFit
        masterView.presentScene(highscoresView)
        masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    //BackButton -> MainMenuView
    func backButtonPressed() {
        mainmenuController.showOwnView()
    }
}
