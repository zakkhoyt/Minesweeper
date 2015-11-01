

The user starts on ZHOptionsTableViewController where they set a few game options.
When start is pressed a game instance (ZHBoard) is created and then passed to the next view controller.

The game's logic consists of ZHBoard and ZHCell.
ZHBoard contains
    * a dictionary of ZHCells
    * processes the plays on background queues
    * executes callback blocks on certain events
    * keeps tally of moves, mine count, cheat count, etc...
ZHCell is a model for a board cell.
    * isBomb
    * adjacentBombCount
    * isPlayed

I've provided two implementations of rendering view controllers.
* One for UIKit using a UICollectionView
* One using SpriteKit, a scene, and some nodes.
Each view controller is passed an instance of ZHBoard and implments ZHBoard's callback blocks to provide visual feedback. This decouples the game from the rendering.

What have I done to profile the app?
    * I fired up Instruments and ran both an Allocatoins analysis and a Time Profile analysis.
    * This was run for both UIKit and SpriteKit impelmentations.
    * I found that all large allocations and time was spent on system calls, especially for large boards using UIKit.
    * The game engine code seems to be efficient.
    * My spritekit code could be improved quite a bit to add the nodes only once and manipulate only what's changed rather than redrawing the whole board each time.

What could be improved about this code?
    * ZHSpriteKitGameViewController and ZHUIKitGameViewController contain duplicate code which manages the buttons and labels. These could be abstracted to a base UIViewController subclass.
    * ZHBoard could to more in on background queues. For example generateCells. This would need to be moved to another public method with a callback block which would need to be called after init.

What could be added to fill the app out a bit?
    * Keeping a history of your game play. Perhaps using gamecenter or a cloudkit implementation.
    * Easy, Med, Hard, Hero mine count suggestions (as buttons)
    * Various other cheats.
    * First move is a freebie (guaranteed not to be a mine)
    * Some particle emitters and sound effects. This is easy with spritekit and a bit more involved with UIKit.

Source code is available on github: https://github.com/zakkhoyt/Minesweeper

