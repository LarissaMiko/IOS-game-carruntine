
import UIKit
import SpriteKit


class LevelOverlayController: UIViewController {
    
    //Scene & Views
    var leveloverlayView: LevelOverlayView!
    var masterView: SKView!
    var scene : SKScene!
    
    //Controller
    var gameViewController: MasterController!
    var settingsIngameController: SettingsInGameController!
    var gameSceneController: GameViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (gameViewController: MasterController) {
        self.settingsIngameController = gameViewController.settingsIngameController
        self.masterView = gameViewController.masterView
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.leveloverlayView = LevelOverlayView(givenController: self, size: size)
        
    }
    
    //GameScene needs overlay (HUD-Display)
    func showOwnView() {
        leveloverlayView.scaleMode = .aspectFit
        masterView.presentScene(leveloverlayView)
        masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //GameSceneSettingsIcon -> SettingsIngameView
    func settingsIconPressed() {
        settingsIngameController.showOwnView()
    }
}
