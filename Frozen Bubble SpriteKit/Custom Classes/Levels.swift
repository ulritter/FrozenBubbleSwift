//
//  Level.swift
//  Frozen Bubble SpriteKit
//
//  Created by Uwe Ritter on 10.03.23.
//

import SpriteKit

class Levels {
    var levels = [[Int]]()
    
    init() {
        loadLevels()
    }
    
    func loadLevels() {
        if let path = Bundle.main.path(forResource: "levels", ofType: "txt") {
            let url = URL(filePath: path)
            var levelItem =  [Int]()
            let charSet = ["-","0","1","2","3","4","5","6","7"]
            do {
                let levelsRawText = try String(contentsOf: url, encoding: .utf8)
                let levels = levelsRawText.components(separatedBy: "\n\n")  as [String]
                for level in levels {
                    for char in level {
                        var charInt = C.B.emptyMarker
                        if charSet.contains(String(char)) {
                            if (char != "-")   {
                                charInt = char.wholeNumberValue!
                            }
                            levelItem.append(charInt)
                        }
                    }
                    self.levels.append(levelItem)
                    levelItem.removeAll()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        } else {
            print(C.S.noLevelsFoundMessage)
        }
    }
    
    func numberOfLevels() -> Int {
        return levels.count
    }
    
    func getLevel (level: Int) -> [Int] {
        if level < numberOfLevels() && numberOfLevels() > 0 {
            return levels[level]
        } else {
            return []
        }
    }
}
