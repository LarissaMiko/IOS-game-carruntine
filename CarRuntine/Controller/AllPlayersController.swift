
import UIKit
import SpriteKit


class AllPlayersController: UIViewController {
    
    var playersView: AllPlayersView!
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
        self.playersView = AllPlayersView(givenController: self, size: size)
    }
    
    //Plays audio for "AllPlayersView"
    func playAudio() {
        audioController.playPlayersMusic()
    }
    
    //Calls own view to be presented
    func showOwnView() {
        playersView.startCarsViaGameTimer()
        playersView.scaleMode = .aspectFit
        masterView.presentScene(playersView)
        masterView.ignoresSiblingOrder = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Back -> Main menu
    func backButtonPressed(){
        mainmenuController.showOwnView()
        playersView.stopGameTimer()
    }
}
