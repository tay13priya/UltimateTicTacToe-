//
//  UltimateTicTacToeModel.swift
//  UltimateTicTacToe
//
//  Created by Parekh, Priya Zara on 11/8/24.
//
import SwiftUI

class UltimateTicTacToeViewModel: ObservableObject {
    @Published var boards: [[SmallBoard]] = Array(repeating: Array(repeating: SmallBoard(), count: 3), count: 3)
    @Published var currentPlayer: Mark = .x
    @Published var currentBoard: (Int, Int)? = (0, 0)  // Start with the top-left board
    @Published var message: String = "Player X's Turn"

    func makeMove(boardIndex: (Int, Int), cellIndex: (Int, Int)) {
        let (boardRow, boardCol) = boardIndex
        let (row, col) = cellIndex
        let index = row * 3 + col
        
        print("makeMove called with boardIndex: \(boardIndex), cellIndex: \(cellIndex)")
        print("Current state before move: \(boards[boardRow][boardCol].cells)")

        if boards[boardRow][boardCol].cells[index] == .empty {
            boards[boardRow][boardCol].cells[index] = currentPlayer
            print("Updated state after move: \(boards[boardRow][boardCol].cells)")
            if boards[boardRow][boardCol].checkWin(for: currentPlayer) {
                message = "Player \(currentPlayer.display) Wins!"
            } else if boards.flatMap({ $0 }).allSatisfy({ $0.cells.allSatisfy({ $0 != .empty }) }) {
                message = "It's a Draw!"
            } else {
                currentPlayer = currentPlayer == .x ? .o : .x
                message = "Player \(currentPlayer.display)'s Turn"
                currentBoard = cellIndex
                print("Next currentBoard: \(String(describing: currentBoard))")
            }
        } else {
            print("Cell already occupied")
        }
    }

    func resetGame() {
        boards = Array(repeating: Array(repeating: SmallBoard(), count: 3), count: 3)
        currentPlayer = .x
        currentBoard = (0, 0)  // Reset to the top-left board
        message = "Player X's Turn"
    }
}
