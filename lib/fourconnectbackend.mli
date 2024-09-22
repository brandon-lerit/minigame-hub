(* @author Gabrielle Loncke (gal98) *)
(* The type of players. *)
type player = Player1 | Player2

(* The type of cells on the game board. A cell can be empty or filled by a player. *)
type cell = Empty | Filled of player

(*The type of the game board. The game board is a list of lists of cells. *)
type board = cell list list

(* The current player. This is a mutable reference that is updated after each move. *)
val current_player : player ref

(* The game board. This is a mutable reference that is updated after each move. *)
val game_board : board ref

(* [print_board board] prints the game board to the standard output. *)
val print_board : board -> unit

(* [make_move column] drops a piece of the current player in the specified column. *)
val make_move : int -> unit

(*[check_win board] checks if there is a winning line on the game board. *)
val check_win : board -> bool