
import UIKit
import SpriteKit


class MultiplayerController: UIViewController {
    
    //Scene & Views
    var multiplayerView: MultiplayerView!
    var masterView: SKView!
    var scene : SKScene!
    
    //Controller
    var audioController: AudioController!
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
        self.multiplayerView = MultiplayerView(givenController: self, size: size)
    }
    
    //MainMenu -> MultiplayerView
    func showOwnView() {
        multiplayerView.scaleMode = .aspectFit
        masterView.presentScene(multiplayerView)
        masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //BackButton -> MainMenu
    func backButtonPressed() {
        mainmenuController.showOwnView()
    }
    
    //Needed when online function available
    func hostButtonPressed() {
        
    }
}
