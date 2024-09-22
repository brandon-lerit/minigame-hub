(* @author Gabrielle Loncke (gal98) *)
(* fourconnectfrontend.mli *)

open Bogue
module W = Widget
module L = Layout
module T = Trigger

(* Fourconnectbackend is the backend module for the game *)
open Fourconnectbackend

(* The last move made in the game *)
val last_move : int ref

(* The widget displaying whose turn it is *)
val player_turn_widget : Widget.t ref

(* Styles for the game pieces *)
val red : Style.t
val blue : Style.t

(* Function to map game cells to styles *)
val mstyle : cell -> Style.t

(* Function to create widgets for the game board *)
val create_widgets : board -> Widget.t array array

(* Styles for the game board *)
val dark : Style.t
val light : Style.t

(* The current layout of the game *)
val my_layout : Layout.t ref

(* The image displayed when a player wins *)
val win : Widget.t

(* The image for a blank button *)
val blank_button_image : Style.background

(* Function to close the current layout *)
val close_layout : unit -> unit

(* The home button widget *)
val home_button : Widget.t

(* The layout displayed when a player wins *)
val win_layout : Layout.t

(* Function to reset the game *)
val reset_game : unit -> unit

(* Button widgets for each column in the game *)
val make_button_one : Widget.t
val make_button_two : Widget.t
val make_button_three : Widget.t
val make_button_four : Widget.t
val make_button_five : Widget.t
val make_button_six : Widget.t

(* Function to create a layout for the buttons *)
val make_button_layout : unit -> Layout.t

(* Function to create the game layout *)
val make_layout : Widget.t array array -> Layout.t

(* Function to display the game board *)
val show_board : board -> unit

(* Function to play a turn of the game *)
val play1 : player -> unit

(* Function to start the game *)
val play : unit -> unit