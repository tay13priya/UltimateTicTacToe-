import SwiftUI

enum Mark: String {
    case x = "X"
    case o = "O"
    case empty = ""

    var display: String {
        self.rawValue
    }
}

struct SmallBoard {
    var cells: [Mark] = Array(repeating: .empty, count: 9)
    
    func checkWin(for mark: Mark) -> Bool {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        return winningCombinations.contains { combo in
            combo.allSatisfy { cells[$0] == mark }
        }
    }
}
