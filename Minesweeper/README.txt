

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

I've provided two implementations of rendering the game. One for UIKit using a UICollectionView, and one using SpriteKit.
Each view controller has an instance of ZHBoard and implments ZHBoard's callback blocks to provide visual feedback. This decouples the game from the viewcontrllers.

What could be improved about this code?
    * ZHSpriteKitGameViewController and ZHUIKitGameViewController contain duplicate code which manages the buttons and labels. These could be abstracted to a base UIViewController subclass.
    * ZHBoard could to more in on background queues. For example generateCells. This would need to be moved to another public method with a callback block which would need to be called after init.



