
import UIKit
import SpriteKit


class EnteringNameController: UIViewController {
    
    static let MAX_NAME_LENGTH = 15
    static let MIN_NAME_LENGTH = 3
    
    var enternameView: EnteringNameView!
    var audioController: AudioController!
    var masterView: SKView!
    var scene: SKScene!
    var gameViewController: MasterController!
    var mainmenuController: MainMenuController!
    
    //Needed to access CoreData database
    let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.mainmenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.enternameView = EnteringNameView(givenController: self, size: size)
    }
    
    //LoadingView -> EnteringNameView (if not already entered before)
    func showOwnView() {
        enternameView.scaleMode = .aspectFit
        masterView.presentScene(enternameView)
        masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //NiceButton -> saving player name, (min & max length)
    func niceButtonPressed(name: String) {
        if( name.count >= EnteringNameController.MIN_NAME_LENGTH && name.count <= EnteringNameController.MAX_NAME_LENGTH){
            let newPlayer = PlayerEntity(context: managedObjectContext)
            newPlayer.name = name
            appDelegate.saveContext()
            enternameView.usernameTextField.removeFromSuperview()
            let maxNameLength = enternameView.childNode(withName: "maxNameLength")
            maxNameLength?.removeFromParent()
            mainmenuController.gameSceneController.gameView.playerEntity = newPlayer
            
            mainmenuController.showOwnView()
        }
    }
}
