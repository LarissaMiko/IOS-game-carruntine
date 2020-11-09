
import UIKit
import SpriteKit


class DevelopersController: UIViewController {
    
    var developedbyView: DevelopersView!
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
        self.developedbyView = DevelopersView(givenController: self, size: size)
    }
    
    //MainMenuView -> DevelopersView
    func showOwnView() {
        developedbyView.scaleMode = .aspectFit
        masterView.presentScene(developedbyView)
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
