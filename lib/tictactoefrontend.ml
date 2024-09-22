(* @author Anneliese Ardizzone (ava34) *)

open Bogue
open Tictactoebackend

(* Name assets *)
let bg = Widget.image "lib/assets/tictactoe/bg.png"
let win = Widget.image "lib/assets/tictactoe/win.png"
let lose = Widget.image "lib/assets/tictactoe/lose.png"
let tie = Widget.image "lib/assets/tictactoe/tie.png"
let my_layout = ref (Layout.empty ~w:1 ~h:1 ())

(* Mutable global layout --> this is what is displayed in the window *)

let computer_move board =
  computer_move_helper board;
  Layout.push_close !my_layout

let player_move board row col (* function for player moves*) _ =
  player_move_helper board row col;
  if not (board_full board) then computer_move board
  else
    (* This branch runs if the player took the last spot on the board (so the computer move doesn't get stuck) *)
    Layout.push_close !my_layout

(* Functions for drawing *)
let blank_button_image =
  Style.Image (Image.create "lib/assets/tictactoe/transparent.png")

let make_board_buttons current_board =
  (* Helper for draw_board that just makes the buttons *)
  (* Widgets to represent each place on the board *)
  let b1 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 0 0)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(0).(0)))
      " "
  in
  let b2 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 0 1)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(0).(1)))
      " "
  in
  let b3 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 0 2)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(0).(2)))
      " "
  in
  let b4 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 1 0)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(1).(0)))
      " "
  in
  let b5 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 1 1)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(1).(1)))
      " "
  in
  let b6 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 1 2)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(1).(2)))
      " "
  in
  let b7 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 2 0)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(2).(0)))
      " "
  in
  let b8 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 2 1)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(2).(1)))
      " "
  in
  let b9 =
    Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
      ~bg_over:(Some blank_button_image)
      ~action:(player_move current_board 2 2)
      ~label:
        (Label.create ~size:28
           ~fg:Draw.(opaque (find_color "sienna"))
           (string_of_spot current_board.(2).(2)))
      " "
  in

  (* Create rows *)
  let r1 = Layout.flat_of_w ~align:Draw.Center [ b1; b2; b3 ] in
  let r2 = Layout.flat_of_w ~align:Draw.Center [ b4; b5; b6 ] in
  let r3 = Layout.flat_of_w ~align:Draw.Center [ b7; b8; b9 ] in
  let buttons = Layout.tower [ r1; r2; r3 ] in
  buttons

let draw_board current_board =
  (* Create a layout representing the game board*)
  let buttons = make_board_buttons current_board in
  Layout.set_size buttons (600, 600);
  Layout.setx buttons 200;
  (* Layout.sety buttons 50; *)
  let board =
    Layout.superpose ~name:"Tic-Tac-Toe" [ Layout.resident bg; buttons ]
  in
  board

let close_layout (* function for closing layout, used for home button below *) _
    =
  Layout.push_close !my_layout

let home_button =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image) ~action:close_layout
    ~label:
      (Label.create ~size:14
         ~fg:Draw.(opaque (find_color "white"))
         "<= Click HERE to return to Camel UTOPia!")
    " "

(* Layouts to display in event of win/loss/tie*)
let win_layout =
  let house =
    Layout.superpose ~name:"Tic-Tac-Toe"
      [ Layout.resident win; Layout.resident home_button ]
  in
  Layout.set_size house (800, 600);
  house

let lose_layout =
  let house =
    Layout.superpose ~name:"Tic-Tac-Toe"
      [ Layout.resident lose; Layout.resident home_button ]
  in
  Layout.set_size house (800, 600);
  house

let tie_layout =
  let house =
    Layout.superpose ~name:"Tic-Tac-Toe"
      [ Layout.resident tie; Layout.resident home_button ]
  in
  Layout.set_size house (800, 600);
  house

(* Function to manage the game flow *)
let main () =
  let board = init_board () in
  let rec game_loop () =
    let my_board = draw_board board in
    my_layout := my_board;
    Bogue.run (Bogue.of_layout !my_layout);
    (* Layout.push_close my_board; *)
    print_board board;

    (* if player wins *)
    if check_win board X then (
      my_layout := win_layout;
      Bogue.run (Bogue.of_layout !my_layout) (* if Cammy wins *))
    else if check_win board O then (
      my_layout := lose_layout;
      Bogue.run (Bogue.of_layout !my_layout) (* if it's a draw *))
    else if board_full board then (
      my_layout := tie_layout;
      Bogue.run (Bogue.of_layout !my_layout) (* if the game hasn't ended *))
    else game_loop ()
  in
  game_loop ()