
import UIKit
import SpriteKit
import Foundation


class EnteringNameView: SKScene, UITextFieldDelegate {
        
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Scaling
    var scaling: ScalingHelper!
    
    //Controller
    var audioController: AudioController!
    var enteringNameController: EnteringNameController!
    
    //Random
    let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usernameTextField:UITextField!
    var username: String!
    var layerNode: SKNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: EnteringNameController, size: CGSize){
        super.init(size: size)
        self.enteringNameController = givenController
        self.scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        
        guard let view = self.view else { return }
        let originX = (view.frame.size.width - view.frame.size.width/4)/2
        usernameTextField = UITextField(frame: CGRect.init(x: originX, y: view.frame.size.height/3, width: view.frame.size.width/4, height: 50))
        customize(textField: usernameTextField, placeholder: GameConstants.PlayerName.playerName)
        view.addSubview(usernameTextField)
        usernameTextField.addTarget(self, action:#selector(EnteringNameView.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    func customize(textField:UITextField, placeholder:String , isSecureTextEntry:Bool = false) {
        let paddingView = UIView(frame:CGRect(x:0,y: 0,width: 10,height: 50))
        textField.leftView = paddingView
        textField.textAlignment = NSTextAlignment.center
        textField.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 4.0
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = self
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let maxNameLength = self.childNode(withName: "maxNameLength")
        maxNameLength?.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func saveTextToVariable() {
        username = usernameTextField.text
    }
    
    func setAudioController (givenAudioController: AudioController){
        audioController = givenAudioController
    }
    
    func createLayers(){
        //Menu layer is added to scene as child
        menuLayer = Layer()
        menuLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(menuLayer)
        
        //Background is added to scene as child
        backgroundLayer = Layer()
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundLayer)
        
        //Set background image
        loadBackgroundImage()
        
        //Scale whole view for current device
        layerNode = scaling.load(layerFile: "EnteringName", menuLayer: menuLayer)
    }
    
    func loadBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[2])
        backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
        backgroundImage.anchorPoint = CGPoint.zero
        backgroundImage.position = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.addChild(backgroundImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "enterNameNiceButton" {
                self.view?.endEditing(true)
                enteringNameController.niceButtonPressed(name: usernameTextField.text!)
            }
        }
    }
}

