
import UIKit
import SpriteKit
import CoreData


class LoadingController: UIViewController {
    
    var loadingView: LoadingView!
    var audioController: AudioController!
    var masterView: SKView!
    var scene : SKScene!
    var gameViewController: MasterController!
    var enteringNameController: EnteringNameController!
    var mainMenuController: MainMenuController!
    var enteredNameBefore: Bool!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.enteringNameController = gameViewController.enteringNameController
        self.mainMenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.loadingView = LoadingView(givenController: self, size: size)
    }
    
    //Attack mode!
    func playAudio() {
        audioController.playLoadingMusic()
    }
    
    //CompanyLogoView -> LoadingView
    func showOwnView() {
        loadingView.scaleMode = .aspectFit
        masterView.presentScene(loadingView)
        masterView.ignoresSiblingOrder = true
        nextView()
    }
    
    //LoadingView -> MainMenuView
    func nextView() {
        //Set time to 3 - default time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            let playerEntity = CoreDataService.getPlayer()
            
            if(playerEntity == nil) {
                self.enteringNameController.showOwnView()
            } else {
                self.mainMenuController.gameSceneController.gameView.playerEntity = playerEntity!
                self.mainMenuController.showOwnView()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
