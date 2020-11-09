
import Foundation
//CoreGraphics to be able to use CGFloat
import CoreGraphics

struct GameConstants {
    
    struct PhysicsCategories{
        static let noCategory: UInt32 = 0
        static let allCategory: UInt32 =  UInt32.max
        //define bitmasks -> compare with OR to determine contacts
        static let playerCategory: UInt32 = 0x1
        static let groundCategory: UInt32 = 0x1 << 1
        // ...100
        static let finishCategory: UInt32 = 0x1 << 2
        static let collectableCategory: UInt32 = 0x1 << 3
        static let enemyCategory: UInt32 = 0x1 << 4
        static let frameCategory: UInt32 = 0x1 << 5
        
        static let rocketCategory: UInt32 = 0x1 << 7
        static let shieldCategory: UInt32 = 0x1 << 8
        static let checkPointCategory: UInt32 = 0x1 << 9
        
        // KI collision masks
        static let ki1Category: UInt32 = 0x1 << 10
        static let ki2Category: UInt32 = 0x1 << 11
        static let ki3Category: UInt32 = 0x1 << 12
        
        // jump markers
        static let jumpMarkerCategory: UInt32 = 0x1 << 13
    }
    
    struct PlayerName {
        static let playerName: String = "Your name ... hihi "
    }
    
    struct Resolutions {
        static let xMasterResolution: Int = 1334
        static let yMasterResolution: Int = 750
    }
    
    struct ZPositions {
        //far background
        static let farBGZ: CGFloat = 0
        //close background
        static let closeBGZ: CGFloat = 1
        // world
        static let worldZ: CGFloat = 2
        //objects
        static let objectZ: CGFloat = 3
        // ki
        static let kiZ: CGFloat = 5 // hurra, die welt geht unter... KIZ!!!
        //player
        static let playerZ: CGFloat = 7
        //Headsup-Display
        static let hudZ: CGFloat = 10
    }
    
    //StringConstants to avoid typos when working with Strings in the app
    struct StringConstants {
        static let groundTilesName = "Ground Tiles"
        static let worldBackgroundNames = ["White", "Titelbild", "Default", "MainMenu", "BathroomVillage", "SpookyRace", "KitchenParadise", "LivingVrooom"]
        // player names
        static let playerName = "Player"
        static let ki1Name = "KI1"
        static let ki2Name = "KI2"
        static let ki3Name = "KI3"
        
        // image names
        static let ki1ImageName = "schnecke-black_0"
        static let ki2ImageName = "cat-green_0"
        static let ki3ImageName = "dog-violet_0"
        static let playerImageName = "Idle_0"
        static let playerDogImageName = "dog_1"
        static let playerCatImageName = "cat_1"
        static let playerRatImageName = "rat_1"
        static let playerSchneckeImageName = "schnecke_1"
        static let playerSeppImageName = "sepp_1"
        static let playerPirateImageName = "pirate_1"
        static let playerDogBlueImageName = "dog-blue_1"
        static let playerCatPinkImageName = "cat-pink_1"
        static let playerRatNeonImageName = "rat-neon_1"
        static let playerDogVioletImageName = "dog-violet_1"
        static let playerCatGreenImageName = "cat-green_1"
        static let playerSchneckeBlackImageName = "schnecke-black_1"
        
        static let groundNodeName = "GroundNode"
        static let finishLineName = "FinishLine"
        static let checkpointName = "CheckPoint"
        static let jumpMarkerName = "JumpMarker"
        
        static let enemyName = "Enemy"
        static let rocketName = "Rocket"
        static let shieldName = "Shield"
        static let coinName = "Coin"
        static let coinImageName = "toiletpaper120"
        static let itemboxName = "Itembox"
        static let itemboxImageName = "Itembox"
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerDogIdleAtlas = "DogIdle"
        static let playerDogRunAtlas = "DogDrives"
        static let playerDogJumpAtlas = "DogDrives"
        static let playerDogDieAtlas = "DogDies"
        static let playerDogAtlas = "dog-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleDogPrefixKey = "dog-idle_"
        static let runDogPrefixKey = "dog_"
        static let jumpDogPrefixKey = "dog_"
        static let dieDogPrefixKey = "dog-dies_"
        static let dogPrefixKey = "dog_"
        
        // CAT
        //test
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerCatIdleAtlas = "CatIdle"
        static let playerCatRunAtlas = "CatDrives"
        static let playerCatJumpAtlas = "CatDrives"
        static let playerCatDieAtlas = "CatDrives"
        static let playerCatAtlas = "cat-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleCatPrefixKey = "cat-idle_"
        static let runCatPrefixKey = "cat_"
        static let jumpCatPrefixKey = "cat_"
        static let dieCatPrefixKey = "cat_"
        static let catPrefixKey = "cat_"
        
        // RAT
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerRatIdleAtlas = "RatDrives"
        static let playerRatRunAtlas = "RatDrives"
        static let playerRatJumpAtlas = "RatDrives"
        static let playerRatDieAtlas = "RatDrives"
        static let playerRatAtlas = "rat-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleRatPrefixKey = "rat_"
        static let runRatPrefixKey = "rat_"
        static let jumpRatPrefixKey = "rat_"
        static let dieRatPrefixKey = "rat_"
        static let ratPrefixKey = "rat_"
        
        // SCHNECKE
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerSchneckeIdleAtlas = "SchneckeIdle"
        static let playerSchneckeRunAtlas = "SchneckeDrives"
        static let playerSchneckeJumpAtlas = "SchneckeDrives"
        static let playerSchneckeDieAtlas = "SchneckeDrives"
        static let playerSchneckeAtlas = "schnecke-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleSchneckePrefixKey = "schnecke-idle_"
        static let runSchneckePrefixKey = "schnecke_"
        static let jumpSchneckePrefixKey = "schnecke_"
        static let dieSchneckePrefixKey = "schnecke_"
        static let schneckePrefixKey = "schnecke_"
        
        // SEPP
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerSeppIdleAtlas = "SeppDrives"
        static let playerSeppRunAtlas = "SeppDrives"
        static let playerSeppJumpAtlas = "SeppDrives"
        static let playerSeppDieAtlas = "SeppDrives"
        static let playerSeppAtlas = "sepp-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleSeppPrefixKey = "sepp_"
        static let runSeppPrefixKey = "sepp_"
        static let jumpSeppPrefixKey = "sepp_"
        static let dieSeppPrefixKey = "sepp_"
        static let seppPrefixKey = "sepp_"
        
        // DOG blue
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerDogBlueIdleAtlas = "DogBlueDrives"
        static let playerDogBlueRunAtlas = "DogBlueDrives"
        static let playerDogBlueJumpAtlas = "DogBlueDrives"
        static let playerDogBlueDieAtlas = "DogBlueDrives"
        static let playerDogBlueAtlas = "dogBlue-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleDogBluePrefixKey = "dog-blue_"
        static let runDogBluePrefixKey = "dog-blue_"
        static let jumpDogBluePrefixKey = "dog-blue_"
        static let dieDogBluePrefixKey = "dog-blue_"
        static let dogBluePrefixKey = "dog-blue_"
        
        // CAT pink
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerCatPinkIdleAtlas = "CatPinkDrives"
        static let playerCatPinkRunAtlas = "CatPinkDrives"
        static let playerCatPinkJumpAtlas = "CatPinkDrives"
        static let playerCatPinkDieAtlas = "CatPinkDrives"
        static let playerCatPinkAtlas = "catPink-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleCatPinkPrefixKey = "cat-pink_"
        static let runCatPinkPrefixKey = "cat-pink_"
        static let jumpCatPinkPrefixKey = "cat-pink_"
        static let dieCatPinkPrefixKey = "cat-pink_"
        static let catPinkPrefixKey = "cat-pink_"
        
        // PIRATE
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerPirateIdleAtlas = "PirateDrives"
        static let playerPirateRunAtlas = "PirateDrives"
        static let playerPirateJumpAtlas = "PirateDrives"
        static let playerPirateDieAtlas = "PirateDrives"
        static let playerPirateAtlas = "pirate-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idlePiratePrefixKey = "pirate_"
        static let runPiratePrefixKey = "pirate_"
        static let jumpPiratePrefixKey = "pirate_"
        static let diePiratePrefixKey = "pirate_"
        static let piratePrefixKey = "pirate_"
        
        // RAT neon
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerRatNeonIdleAtlas = "RatNeonDrives"
        static let playerRatNeonRunAtlas = "RatNeonDrives"
        static let playerRatNeonJumpAtlas = "RatNeonDrives"
        static let playerRatNeonDieAtlas = "RatNeonDrives"
        static let playerRatNeonAtlas = "ratNeon-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleRatNeonPrefixKey = "rat-neon_"
        static let runRatNeonPrefixKey = "rat-neon_"
        static let jumpRatNeonPrefixKey = "rat-neon_"
        static let dieRatNeonPrefixKey = "rat-neon_"
        static let ratNeonPrefixKey = "rat-neon_"
        
        // SCHNECKE black
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerSchneckeBlackIdleAtlas = "SchneckeBlackDrives"
        static let playerSchneckeBlackRunAtlas = "SchneckeBlackDrives"
        static let playerSchneckeBlackJumpAtlas = "SchneckeBlackDrives"
        static let playerSchneckeBlackDieAtlas = "SchneckeBlackDrives"
        static let playerSchneckeBlackAtlas = "schneckeBlack-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleSchneckeBlackPrefixKey = "schnecke-black_"
        static let runSchneckeBlackPrefixKey = "schnecke-black_"
        static let jumpSchneckeBlackPrefixKey = "schnecke-black_"
        static let dieSchneckeBlackPrefixKey = "schnecke-black_"
        static let schneckeBlackPrefixKey = "schnecke-black_"
        
        // DOG violet
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerDogVioletIdleAtlas = "DogVioletDrives"
        static let playerDogVioletRunAtlas = "DogVioletDrives"
        static let playerDogVioletJumpAtlas = "DogVioletDrives"
        static let playerDogVioletDieAtlas = "DogVioletDrives"
        static let playerDogVioletAtlas = "dogViolet-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleDogVioletPrefixKey = "dog-violet_"
        static let runDogVioletPrefixKey = "dog-violet_"
        static let jumpDogVioletPrefixKey = "dog-violet_"
        static let dieDogVioletPrefixKey = "dog-violet_"
        static let dogVioletPrefixKey = "dog-violet_"
        
        // CAT green
        
        // names must match with Assets.xcassets -> Player Sprites -> Atlas definition
        static let playerCatGreenIdleAtlas = "CatGreenDrives"
        static let playerCatGreenRunAtlas = "CatGreenDrives"
        static let playerCatGreenJumpAtlas = "CatGreenDrives"
        static let playerCatGreenDieAtlas = "CatGreenDrives"
        static let playerCatGreenAtlas = "catGreen-drive-atlas"
        
        // names must match with atlas file names without index number
        static let idleCatGreenPrefixKey = "cat-green_"
        static let runCatGreenPrefixKey = "cat-green_"
        static let jumpCatGreenPrefixKey = "cat-green_"
        static let dieCatGreenPrefixKey = "cat-green_"
        static let catGreenPrefixKey = "cat-green_"
        
        static let jumpUpActionKey = "JumpUp"
        static let brakeDescendActionKey = "BrakeDescend"
        
        static let stepJumpKey = "stepjump"
        
        static let toiletPaperMagicKey = "ToiletPaperMagic"
        
        static let groundTag = "ground"
        static let sideEdgeTag = "sideEdgeLeft"
    }
}
