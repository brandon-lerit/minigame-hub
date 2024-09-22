(* @author Anneliese Ardizzone (ava34) *)

(* Type to represent items in the tic-tac-toe board.
   X represents the player's spots, O represent's the computer's spots, and Empty represents a spot taken
   by neither player. *)
type spot_on_board = X | O | Empty

(* Type to rerpesent the tic-tac-toe board as a mutable 2D array. Each spot on the board is of type spot_on_board. *)
type board = spot_on_board array array

(* Function to convert spot_on_board type to string.
   Preconditions: The spot_on_board is X, O, or Empty
   Postconditions: X returns "X", O returns "O", and Empty returns "-". *)
val string_of_spot : spot_on_board -> string

(* Function to initialize and returns an empty tic-tac-toe board.
   Preconditions: No inputted values (unit)
   Postconditions: returns a 3 by 3 Array matrix filled with Empty spot_on_board objects *)
val init_board : unit -> board

(* Function to get a random empty spot on the board (for Cammy's move)
   Preconditions: Takes a board of size 3 by 3, board has at least one Empty spot
   Postconditions: Returns an int (from 0 to 2 inclusive) representing a random row and an int
        (from 0 to 2 inclusive) representing a random column in the board where the board is Empty at that spot *)
val random_empty_spot : board -> int * int

(* Function to print the tic-tac-toe board to the console (for debugging).
    Precondition: Takes a board filled with spot_on_board objects
    Postcondition: Prints the board to the console by utilizing string_of_spot, returns nothing (unit) *)
val print_board : board -> unit

(* Function to check if the tic-tac-toe board is full.
    Precondition: Takes a board containing spot_on_board objects
    Postcondition: Returns a boolean corresponding to whether the board is full (ex. if there are Empty spots in the board, then it is not full) *)
val board_full : board -> bool

(* Functions to check if a player (represented by a spot_on_board X or O) has won by placing three markers along any of the board's rows.
    Preconditions: The spot_on_board is expected to be either X or O, and board is of size 3 by 3.
    Postconditions: Returns a boolean corresponding to whether there is a valid win state for the given spot_on_board value along
        at least one of the board's rows *)
val check_row_win : board -> spot_on_board -> bool

(* Functions to check if a player (represented by a spot_on_board X or O) has won by placing three markers along any of the board's columns.
    Preconditions: The spot_on_board is expected to be either X or O, and board is of size 3 by 3.
    Postconditions: Returns a boolean corresponding to whether there is a valid win state for the given spot_on_board value along
        at least one of the board's columns *)
val check_column_win : board -> spot_on_board -> bool

(* Functions to check if a player (represented by a spot_on_board X or O) has won by placing three markers along any of the board's rows.
    Preconditions: The spot_on_board is expected to be either X or O, and board is of size 3 by 3.
    Postconditions: Returns a boolean corresponding to whether there is a valid win state for the given spot_on_board value along
        at least one of the board's diagonal*)
val check_diagonal_win : board -> spot_on_board -> bool

(* Functions to check if a player (represented by a spot_on_board X or O) has won.
    Preconditions: The spot_on_board is expected to be either X or O, board is of size 3 by 3.
    Postconditions: returns a boolean corresponding to whether there is a valid win state for the given spot_on_board value
        anywhere on the board *)
val check_win : board -> spot_on_board -> bool

(* Function for the computer's move
   Preconditions: Takes a board with at least 1 Empty spot
   Postconditions: Uses random_empty_spot to pick a random empty spot on the board, changes its value to O, and returns nothing (unit) *)
val computer_move_helper : spot_on_board array array -> unit

(* Function for the player's move
    Preconditions: Takes a board, an int corresponding to row (from 0 to 2 inclusive), and an int corresponding
        to column (from 0 to 2 inclusive)
    Postconditions: If the spot on the board at the given row and column is Empty, changes its value to X, and returns nothing (unit) *)
val player_move_helper : spot_on_board array array -> int -> int -> unit