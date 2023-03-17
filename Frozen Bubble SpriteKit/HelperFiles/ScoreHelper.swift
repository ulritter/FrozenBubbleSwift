//
//  ScoreLine.swift
//  Frozen Bubble SpriteKit
//
//  Created by Uwe Ritter on 14.03.23.
//  Copyright © 2023 Uwe Ritter IT Beratung. All rights reserved.
//

import SpriteKit

class ScoreHelper {
    
    static func updateScoreTable (for levelKey: Int, with numberOfShots: Int,  taking numberOfSeconds: CGFloat) {

        var newScore = ScoreEntry()
        var scorePosition:Int = -1
        var levelScores = PrefsHelper.getScores(for: levelKey)

        newScore.numberOfShots = numberOfShots
        newScore.numberOfSeconds = numberOfSeconds.rounded(toPlaces: 1)
        levelScores.append(newScore)
         
        levelScores.sort {
            $0.numberOfShots == $1.numberOfShots ? $0.numberOfSeconds < $1.numberOfSeconds : $0.numberOfShots < $1.numberOfShots
        }
        scorePosition = levelScores.firstIndex(where: {$0.numberOfShots == numberOfShots && $0.numberOfSeconds == numberOfSeconds.rounded(toPlaces: 1)}) ?? -1
        
        if levelScores.count > C.B.maxScoreEntries {
            levelScores.removeLast()
        }
        
        if scorePosition >= C.B.maxScoreEntries {
            scorePosition = -1
        }
        PrefsHelper.setScores(for: levelKey, with: levelScores)
        PrefsHelper.setLastLevelScoreInfo(to: "\(levelKey)-\(scorePosition)")
    }
}

extension CGFloat {
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
