(* @author Philan Tran (pt337) *)
open Bogue

val cammy_image : Rockpaperscissorsbackend.choices option -> Widget.t
(**[cammy_image]] matches the camel's choice (value of cammy_hand) to its image. Returns a widget.
    Requires: [cammy_hand] is type choices option.*)

val user_image : Rockpaperscissorsbackend.choices option -> Widget.t
(**[user_image] matches the user's choice (value of user_hand) to its image. Returns a widget.
    Requires: [user_hand] is type choices option.*)

val close_layout : 'a -> unit
(** [close_layout] is a function that closes the current window. Used to return to the home screen. Returns nothing (unit). *)

val end_game_layout : unit -> Layout.t
(**[end_game_layout]] creates a layout for when the game is over, uses reference variables to create the correct one.
    Returns a layout.*)

val draw_initial_board : Layout.t
(**[draw_initial_boad] is a layout for when the game starts. Asks the user how many games they want to play.*)

val draw_board : unit -> Layout.t
(**[draw_board] creates a layout that prompts the user to chose rock, paper, or scissors.
    Returns a layout.*)

val result_board : unit -> Layout.t
(**[result_board] creates a layout that shows the result of the individual game.
    Returns a layout.*)

val main : unit -> unit
(**[main] is a function that runs the game.*)