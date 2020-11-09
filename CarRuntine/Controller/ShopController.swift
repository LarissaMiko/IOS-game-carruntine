
import UIKit
import SpriteKit


class ShopController: UIViewController {
    
    //Views & scene
    var shopView: ShopView!
    var masterView: SKView!
    var scene : SKScene!
    
    //Controller
    var gameViewController: MasterController!
    var mainmenuController: MainMenuController!
    var audioController: AudioController!
    
    //Random
    var playerEntity: PlayerEntity!
    var frameSize : CGSize!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.mainmenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.shopView = ShopView(givenController: self, size: size)
        self.frameSize = gameViewController.masterView.frame.size
    }
    
    //MainMenuView -> ShopView -> checks bought cars to be active or not
    func showOwnView() {
        shopView.scaleMode = .aspectFit
        masterView.presentScene(shopView)
        masterView.ignoresSiblingOrder = true
        
        playerEntity = CoreDataService.getPlayer()!
        shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
        
        if(playerEntity.car1){
            shopView.menuLayerNode.childNode(withName: "car1")?.alpha = 0.5
            shopView.menuLayerNode.childNode(withName: "car1Enabled")!.isHidden = false
        } else {
            shopView.menuLayerNode.childNode(withName: "car1Enabled")!.isHidden = true
            shopView.menuLayerNode.childNode(withName: "car1")?.alpha = 1.0
        }
        
        if(playerEntity.car2){
            shopView.menuLayerNode.childNode(withName: "car2")?.alpha = 0.5
            shopView.menuLayerNode.childNode(withName: "car2Enabled")!.isHidden = false
        } else {
            shopView.menuLayerNode.childNode(withName: "car2Enabled")!.isHidden = true
            shopView.menuLayerNode.childNode(withName: "car2")?.alpha = 1.0
        }
        
        if(playerEntity.car3){
            shopView.menuLayerNode.childNode(withName: "car3")?.alpha = 0.5
            shopView.menuLayerNode.childNode(withName: "car3Enabled")!.isHidden = false
        } else {
            shopView.menuLayerNode.childNode(withName: "car3Enabled")!.isHidden = true
            shopView.menuLayerNode.childNode(withName: "car3")?.alpha = 1.0
        }
        
        if(playerEntity.car4){
            shopView.menuLayerNode.childNode(withName: "car4")?.alpha = 0.5
            shopView.menuLayerNode.childNode(withName: "car4Enabled")!.isHidden = false
        } else {
            shopView.menuLayerNode.childNode(withName: "car4Enabled")!.isHidden = true
            shopView.menuLayerNode.childNode(withName: "car4")?.alpha = 1.0
        }
        
        if(playerEntity.car5){
            shopView.menuLayerNode.childNode(withName: "car5")?.alpha = 0.5
            shopView.menuLayerNode.childNode(withName: "car5Enabled")!.isHidden = false
        } else {
            shopView.menuLayerNode.childNode(withName: "car5Enabled")!.isHidden = true
            shopView.menuLayerNode.childNode(withName: "car5")?.alpha = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //BackButton -> MainMenuView
    func backButtonPressed() {
        mainmenuController.showOwnView()
    }
    
    //Handling buying cars (checks if enough money etc.)
    
    func car1Pressed(node: SKNode) {
        if(!playerEntity.car1){
            if (playerEntity.coins >= 100) {
                playerEntity.car1 = true
                node.alpha = 0.5
                playerEntity.coins -= 100
                shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
                shopView.menuLayerNode.childNode(withName: "car1Enabled")!.isHidden = false
                CoreDataService.saveContext()
            } else {
                shopView.needMoneyLabel.alpha = 1.0
            }
        }
    }
    
    func car2Pressed(node: SKNode) {
        if(!playerEntity.car2){
            if (playerEntity.coins >= 500) {
                playerEntity.car2 = true
                node.alpha = 0.5
                playerEntity.coins -= 500
                shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
                shopView.menuLayerNode.childNode(withName: "car2Enabled")!.isHidden = false
                CoreDataService.saveContext()
            } else {
                shopView.needMoneyLabel.alpha = 1.0
            }
        }
    }
    
    func car3Pressed(node: SKNode) {
        if(!playerEntity.car3){
            if (playerEntity.coins >= 1000) {
                playerEntity.car3 = true
                node.alpha = 0.5
                playerEntity.coins -= 1000
                shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
                shopView.menuLayerNode.childNode(withName: "car3Enabled")!.isHidden = false
                CoreDataService.saveContext()
            } else {
                shopView.needMoneyLabel.alpha = 1.0
            }
        }
    }
    
    func car4Pressed(node: SKNode) {
        if(!playerEntity.car4){
            if (playerEntity.coins >= 2500) {
                playerEntity.car4 = true
                node.alpha = 0.5
                playerEntity.coins -= 2500
                shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
                shopView.menuLayerNode.childNode(withName: "car4Enabled")!.isHidden = false
                CoreDataService.saveContext()
            } else {
                shopView.needMoneyLabel.alpha = 1.0
            }
        }
    }
    
    func car5Pressed(node: SKNode) {
        if(!playerEntity.car5){
            if (playerEntity.coins >= 5000) {
                playerEntity.car5 = true
                node.alpha = 0.5
                playerEntity.coins -= 5000
                shopView.mainMenuToiletCounterLabel!.text = String(playerEntity.coins)
                shopView.menuLayerNode.childNode(withName: "car5Enabled")!.isHidden = false
                CoreDataService.saveContext()
            } else {
                shopView.needMoneyLabel.alpha = 1.0
            }
        }
    }
}
