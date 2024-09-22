(* @author Brandon Lerit (bsl77) *)

open Bogue
open Warbackend

(* Board Pictures *)
let background = Widget.image "lib/assets/war/Together.png"

let blank_button_image =
  Style.Image (Image.create "lib/assets/tictactoe/transparent.png")

(* Card Pictures *)

(* Ratio is 1 : 1.45 for Height/Width *)

(* Player Cards *)
let back = Widget.image "lib/assets/war/back_of_card.png"
let ace = Widget.image "lib/assets/war/ace.png" (* 1 *)
let two = Widget.image "lib/assets/war/two.png"
let three = Widget.image "lib/assets/war/three.png"
let four = Widget.image "lib/assets/war/four.png"
let five = Widget.image "lib/assets/war/five.png"
let six = Widget.image "lib/assets/war/six.png"
let seven = Widget.image "lib/assets/war/seven.png"
let eight = Widget.image "lib/assets/war/eight.png"
let nine = Widget.image "lib/assets/war/nine.png"
let ten = Widget.image "lib/assets/war/ten.png"
let jack = Widget.image "lib/assets/war/jack.png" (* 11 *)
let queen = Widget.image "lib/assets/war/queen.png" (* 12 *)
let king = Widget.image "lib/assets/war/king.png" (* 13 *)

(* Computer Cards *)
(* Bogue does not allow the drawing of two of the same variables in the same board *)
let back1 = Widget.image "lib/assets/war/back_of_card.png"
let ace1 = Widget.image "lib/assets/war/ace.png" (* 1 *)
let two1 = Widget.image "lib/assets/war/two.png"
let three1 = Widget.image "lib/assets/war/three.png"
let four1 = Widget.image "lib/assets/war/four.png"
let five1 = Widget.image "lib/assets/war/five.png"
let six1 = Widget.image "lib/assets/war/six.png"
let seven1 = Widget.image "lib/assets/war/seven.png"
let eight1 = Widget.image "lib/assets/war/eight.png"
let nine1 = Widget.image "lib/assets/war/nine.png"
let ten1 = Widget.image "lib/assets/war/ten.png"
let jack1 = Widget.image "lib/assets/war/jack.png" (* 11 *)
let queen1 = Widget.image "lib/assets/war/queen.png" (* 12 *)
let king1 = Widget.image "lib/assets/war/king.png" (* 13 *)
let () = Random.self_init ()

(* Game Declarations *)
let played_yet = ref false
let layout = ref (Layout.empty ~w:1 ~h:1 ())
let end_game = ref false
let end_tie_game = ref false
let computer_deck = ref (create_deck 10)
let player_deck = ref (create_deck 10)

let get_player_image = function
  | 0 -> Layout.flat_of_w ~align:Draw.Center [ back ]
  | 1 -> Layout.flat_of_w ~align:Draw.Center [ ace ]
  | 2 -> Layout.flat_of_w ~align:Draw.Center [ two ]
  | 3 -> Layout.flat_of_w ~align:Draw.Center [ three ]
  | 4 -> Layout.flat_of_w ~align:Draw.Center [ four ]
  | 5 -> Layout.flat_of_w ~align:Draw.Center [ five ]
  | 6 -> Layout.flat_of_w ~align:Draw.Center [ six ]
  | 7 -> Layout.flat_of_w ~align:Draw.Center [ seven ]
  | 8 -> Layout.flat_of_w ~align:Draw.Center [ eight ]
  | 9 -> Layout.flat_of_w ~align:Draw.Center [ nine ]
  | 10 -> Layout.flat_of_w ~align:Draw.Center [ ten ]
  | 11 -> Layout.flat_of_w ~align:Draw.Center [ jack ]
  | 12 -> Layout.flat_of_w ~align:Draw.Center [ queen ]
  | _ -> Layout.flat_of_w ~align:Draw.Center [ king ]

(* Two functions for the same reason as before, bogue cannot have duplicate widgets*)
let get_computer_image = function
  | 0 -> Layout.flat_of_w ~align:Draw.Center [ back1 ]
  | 1 -> Layout.flat_of_w ~align:Draw.Center [ ace1 ]
  | 2 -> Layout.flat_of_w ~align:Draw.Center [ two1 ]
  | 3 -> Layout.flat_of_w ~align:Draw.Center [ three1 ]
  | 4 -> Layout.flat_of_w ~align:Draw.Center [ four1 ]
  | 5 -> Layout.flat_of_w ~align:Draw.Center [ five1 ]
  | 6 -> Layout.flat_of_w ~align:Draw.Center [ six1 ]
  | 7 -> Layout.flat_of_w ~align:Draw.Center [ seven1 ]
  | 8 -> Layout.flat_of_w ~align:Draw.Center [ eight1 ]
  | 9 -> Layout.flat_of_w ~align:Draw.Center [ nine1 ]
  | 10 -> Layout.flat_of_w ~align:Draw.Center [ ten1 ]
  | 11 -> Layout.flat_of_w ~align:Draw.Center [ jack1 ]
  | 12 -> Layout.flat_of_w ~align:Draw.Center [ queen1 ]
  | _ -> Layout.flat_of_w ~align:Draw.Center [ king1 ]

(* Game Boards *)
let draw_default_board () =
  let text =
    Layout.resident
      (Widget.text_display "Press The Button Below to Start A Round!")
  in
  let start_button =
    Layout.resident
      (Widget.button ~border_radius:10 "Start Round" ~action:(fun _ ->
           Layout.push_close !layout))
  in
  let end_game_button =
    Layout.resident
      (Widget.button ~border_radius:10 "End Game" ~action:(fun _ ->
           end_game := true;
           Layout.push_close !layout))
  in
  let player_card = get_player_image 0 in
  let player_card_amount = ref (string_of_int (get_deck_size player_deck)) in
  let player_card_message =
    Layout.resident (Widget.text_display !player_card_amount)
  in
  let computer_card = get_computer_image 0 in
  let computer_card_amount =
    ref (string_of_int (get_deck_size computer_deck))
  in
  let computer_card_message =
    Layout.resident (Widget.text_display !computer_card_amount)
  in
  Layout.set_size player_card (150, 218);
  Layout.set_size text (400, 20);
  Layout.set_size computer_card_message (50, 20);
  Layout.set_size player_card_message (50, 20);
  Layout.setx text 400;
  Layout.sety text 25;
  Layout.setx player_card 600;
  Layout.sety player_card 150;
  Layout.setx player_card_message 665;
  Layout.sety player_card_message 375;
  Layout.set_size computer_card (150, 218);
  Layout.setx computer_card 300;
  Layout.sety computer_card 150;
  Layout.setx computer_card_message 365;
  Layout.sety computer_card_message 375;
  Layout.setx start_button 485;
  Layout.sety start_button 450;
  Layout.setx end_game_button 491;
  Layout.sety end_game_button 500;
  let board =
    Layout.superpose ~name:"War"
      [
        Layout.resident background;
        text;
        player_card;
        computer_card;
        computer_card_message;
        player_card_message;
        start_button;
        end_game_button;
      ]
  in
  board

let draw_basic_board () =
  let next_button =
    Layout.resident
      (Widget.button ~border_radius:10 "Next Round" ~action:(fun _ ->
           play_round player_deck computer_deck;
           Layout.push_close !layout))
  in
  let player_card_amount = string_of_int (get_deck_size player_deck) in
  let player_card_message =
    Layout.resident (Widget.text_display player_card_amount)
  in
  let computer_card_amount =
    ref (string_of_int (get_deck_size computer_deck))
  in
  let computer_card_message =
    Layout.resident (Widget.text_display !computer_card_amount)
  in
  Layout.set_size computer_card_message (50, 20);
  Layout.set_size player_card_message (50, 20);
  Layout.setx player_card_message 665;
  Layout.sety player_card_message 375;
  Layout.setx computer_card_message 365;
  Layout.sety computer_card_message 375;
  Layout.setx next_button 485;
  Layout.sety next_button 450;
  let board =
    Layout.superpose ~name:"War"
      [
        Layout.resident background;
        next_button;
        player_card_message;
        computer_card_message;
      ]
  in
  board

let draw_result_board () =
  let board = draw_basic_board () in
  let message = get_win_message player_deck computer_deck in
  let text = Layout.resident (Widget.text_display message) in
  let player_card = get_first_card player_deck in
  let computer_card = get_first_card computer_deck in
  let player_card_img = get_player_image player_card in
  let computer_card_img = get_computer_image computer_card in
  Layout.set_size player_card_img (150, 218);
  Layout.set_size computer_card_img (150, 218);
  Layout.setx text 450;
  Layout.sety text 25;
  Layout.setx player_card_img 600;
  Layout.sety player_card_img 150;
  Layout.setx computer_card_img 300;
  Layout.sety computer_card_img 150;
  let board =
    Layout.superpose ~name:"War"
      [ board; text; player_card_img; computer_card_img ]
  in
  board

let draw_tie_board () =
  let board = draw_basic_board () in
  let subbed_player_deck =
    ref (Array.sub !player_deck 1 (Array.length !player_deck - 1))
  in
  let subbed_computer_deck =
    ref (Array.sub !computer_deck 1 (Array.length !computer_deck - 1))
  in
  let message = get_win_message subbed_player_deck subbed_computer_deck in
  let text =
    Layout.resident
      (Widget.text_display ("The first round was a tie, This time: " ^ message))
  in
  let player_card = Array.get !player_deck 1 in
  let computer_card = Array.get !computer_deck 1 in
  let player_card_img = get_player_image player_card in
  let player_card_img2 = get_player_image 0 in
  let computer_card_img = get_computer_image computer_card in
  let computer_card_img2 = get_computer_image 0 in
  Layout.set_size player_card_img (150, 218);
  Layout.set_size computer_card_img (150, 218);
  Layout.set_size player_card_img2 (150, 218);
  Layout.set_size computer_card_img2 (150, 218);
  Layout.setx text 450;
  Layout.sety text 25;
  Layout.setx player_card_img 600;
  Layout.sety player_card_img 150;
  Layout.setx player_card_img2 620;
  Layout.sety player_card_img2 150;
  Layout.setx computer_card_img 300;
  Layout.sety computer_card_img 150;
  Layout.setx computer_card_img2 320;
  Layout.sety computer_card_img2 150;
  let board =
    Layout.superpose ~name:"War"
      [
        board;
        text;
        player_card_img2;
        computer_card_img2;
        player_card_img;
        computer_card_img;
      ]
  in
  board

let draw_end_board () =
  let message = get_final_win_message player_deck computer_deck in
  let text = Layout.resident (Widget.text_display message) in
  let return_button =
    Layout.resident
      (Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
         ~bg_over:(Some blank_button_image)
         ~action:(fun _ -> Layout.push_close !layout)
         ~label:
           (Label.create ~size:14
              ~fg:Draw.(opaque (find_color "black"))
              "<= Click HERE to return to Camel UTOPia!")
         " ")
  in
  Layout.setx text 450;
  Layout.sety text 150;
  let board =
    Layout.superpose ~name:"War"
      [ Layout.resident background; text; return_button ]
  in
  board

let main () =
  let rec game_loop min_deck_size =
    if min_deck_size > 0 && !end_game = false then (
      if !played_yet = false then (
        layout := draw_default_board ();
        played_yet := true)
      else if check_first_cards !player_deck !computer_deck then
        if get_min_deck_size player_deck computer_deck = 1 then (
          layout := draw_end_board ();
          end_game := true;
          end_tie_game := true)
        else (
          layout := draw_tie_board ();
          played_yet := false)
      else (
        layout := draw_result_board ();
        played_yet := false);
      Bogue.run (Bogue.of_layout !layout);
      game_loop (get_min_deck_size player_deck computer_deck))
    else (
      layout := draw_end_board ();
      if !end_tie_game = false then Bogue.run (Bogue.of_layout !layout))
  in
  game_loop (get_min_deck_size player_deck computer_deck);
  layout := Layout.empty ~w:1 ~h:1 ();
  played_yet := false;
  computer_deck := create_deck 10;
  player_deck := create_deck 10;
  end_game := false