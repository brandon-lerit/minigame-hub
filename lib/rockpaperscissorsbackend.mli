(* @author Philan Tran (pt337) *)
(**Type to represent all the possible choices in rock, paper, scissors.*)
type choices = Rock | Paper | Scissors

val gen_cammy_hand : choices option ref -> unit
(** [gen_cammy_hand] randomly generates a choices type and changes the camel's hand to this value.
The value of the input is changed to the randomly generated choices type. Returns nothing (unit).
Requires: [cammy_hand] is a choices option ref. *)

val eval_game : choices option -> choices option -> int
(** [eval_game] returns and int. Returns 1 if the user wins, 0 if the user ties, -1 if the user loses. 
    Requires: [cammy_hand] [user_hand] are type choices option ref. [user_hand] is the user's choice.*)

val eval_whole_game : int ref -> int ref -> string
(** [eval_whole_game] determines whether the user won overall and returns a message indicating to the user whether they won.
Returns a string indicating the number of games won out of the total number of games.
Requires: [games] [games_won] are type int ref. [games] is the number of games total. [games_won] is the number of games the user won.*)

val get_message : int -> int ref -> int ref -> string
(** [get_message] returns a string that is a message to be printed to the screen.
The contents of the message depends on whether the user won, tied, or lost.
[num_games] decrements by 1 if it was not a tie. [games_won] increments by 1 if the user wins.
Requires: [num] is type int. Specifies whether the user won their game. [num_games] [games_won] are type int ref.
[num_games] specifies how many games are left. [games_won] specifies how many games the user has won so far. *)
