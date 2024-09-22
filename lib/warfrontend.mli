(* @author Brandon Lerit (bsl77) *)

open Bogue

(* Function to get a card image based on an int input
   Preconditions: Takes an integer and returns a picture widget of a card
   Postconditions: Returns a Layout of a picture widget *)
val get_player_image : int -> Layout.t

(* Function to get a card image based on an int input
   Preconditions: Takes an integer and returns a picture widget of a card
   Postconditions: Returns a Layout of a picture widget *)
val get_computer_image : int -> Layout.t

(* Function to draw the board before a game starts
   Preconditions: None
   Postconditions: Returns a Layout of a board before starting a round *)
val draw_default_board : unit -> Layout.t

(* Function to draw a default board (no cards/specialized buttons)
   Preconditions: None
   Postconditions: Returns a Layout of a board with common components of other boards*)
val draw_basic_board : unit -> Layout.t

(* Function to get a board after a round
   Preconditions: None
   Postconditions: Returns a Layout of the board after one normal round *)
val draw_result_board : unit -> Layout.t

(* Function to get a board after a round when the first round is a tie
   Preconditions: None
   Postconditions: Returns a Layout of the board when a tie occurs in a round *)
val draw_tie_board : unit -> Layout.t

(* Function to get a board after a game terminates
   Preconditions: None
   Postconditions: Returns a Layout of the board after the game ends *)
val draw_end_board : unit -> Layout.t

(* Function to run the game loop and boards
   Preconditions: None
   Postconditions: Starts the game *)
val main : unit -> unit