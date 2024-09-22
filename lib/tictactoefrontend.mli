(* @author Anneliese Ardizzone (ava34) *)

open Bogue
open Tictactoebackend

(* Function for the computer's move.
   Preconditions: Takes a board
   Postconditions: Calls computer_move_helper with the board, calls graphics functions, returns nothing (unit) *)
val computer_move : board -> unit

(* Function for the player's move
   Preconditions: Takes a board, an int representing row (between 0 and 2 inclusive), and an int representing column (between 0 and 2 inclusive)
   Postconditions: Calls player_move_helper with the board, row, and col, calls graphics functions, returns nothing (unit) *)
val player_move : spot_on_board array array -> int -> int -> 'a -> unit

(* Function to create buttons representing the tic-tac-toe board. Helper function for draw_board.
   Preconditions: Takes a board
   Postconditions: Creates buttons using values from the board, returns a Layout.t of the buttons *)
val make_board_buttons : board -> Layout.t

(* Function to draw the tic-tac-toe board
   Preconditions: Takes a board
   Postconditions: Calls make_board_buttons, then creates and returns a Layout of all elements that need to be displayed. *)
val draw_board : board -> Layout.t

(* Main function to manage the main game loop by calling functions for game logic and graphics functions.
   Preconditions: Takes no inputs (unit)
   Postconditions: Returns nothing (unit) *)
val main : unit -> unit