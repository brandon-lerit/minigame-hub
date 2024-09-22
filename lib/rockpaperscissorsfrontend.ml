(* @author Philan Tran (pt337) *)
open Bogue
open Rockpaperscissorsbackend

let bg = Widget.image "lib/assets/rockpaperscissors/bg.png"

(* let initial_bg = Widget.image "lib/assets/rockpaperscissors/InitBG.png" *)
let lose_bg = Widget.image "lib/assets/rockpaperscissors/CammyWin.png"
let win_bg = Widget.image "lib/assets/rockpaperscissors/CammyLose.png"

(**Player's rock, papers, scissors.*)
let scissors =
  Widget.image "lib/assets/rockpaperscissors/Icons/Player-Scissors.png"

let paper = Widget.image "lib/assets/rockpaperscissors/Icons/Player-Paper.png"
let rock = Widget.image "lib/assets/rockpaperscissors/Icons/Player-Rock.png"

(* *Camel's rock, paper, scissors.
   let cam_scissors = Widget.image "lib/assets/rockpaperscissors/Icons/Camel-Scissors.png"
   let cam_paper = Widget.image "lib/assets/rockpaperscissors/Icons/Camel-Paper.png"
   let cam_rock = Widget.image "lib/assets/rockpaperscissors/Icons/Camel-Rock.png" *)

(**Camels*)
let camel =
  Widget.image "lib/assets/rockpaperscissors/Camels/Holding-Nothing.png"

let camel_s =
  Widget.image "lib/assets/rockpaperscissors/Camels/Holding-Scissors.png"

let camel_p =
  Widget.image "lib/assets/rockpaperscissors/Camels/Holding-Paper.png"

let camel_r =
  Widget.image "lib/assets/rockpaperscissors/Camels/Holding-Rock.png"

let blank_button_image =
  Style.Image (Image.create "lib/assets/rockpaperscissors/transparent.png")

(**Stores the current choice the user or cammy has selected*)
let cammy_hand = ref None

let user_hand = ref (Some Paper)
let game = ref 5
let num_games = ref 5
let games_won = ref 0
let start_game = ref true
let played_yet = ref false
let my_layout = ref (Layout.empty ~w:1 ~h:1 ())

(**Widget's for all the player's choices*)
let rock_button =
  Widget.button "Rock" ~action:(fun _ ->
      user_hand := Some Rock;
      Layout.push_close !my_layout)

let rock_row =
  Layout.tower [ Layout.resident rock_button; Layout.resident rock ]

let paper_button =
  Widget.button "Paper" ~action:(fun _ ->
      user_hand := Some Paper;
      Layout.push_close !my_layout)

let paper_row =
  Layout.tower [ Layout.resident paper_button; Layout.resident paper ]

let scissors_button =
  Widget.button "Scissors" ~action:(fun _ ->
      user_hand := Some Scissors;
      Layout.push_close !my_layout)

let scissors_row =
  Layout.tower [ Layout.resident scissors_button; Layout.resident scissors ]

let user_buttons = Layout.tower [ rock_row; paper_row; scissors_row ]

(**Matches the camel's choice to its image.*)
let cammy_image cammy_hand =
  match cammy_hand with
  | Some Rock -> camel_r
  | Some Paper -> camel_p
  | Some Scissors -> camel_s
  | None -> camel

(**Matches the user's choice to its image.*)
let user_image user_hand =
  match user_hand with
  | Some Rock -> rock
  | Some Paper -> paper
  | Some Scissors -> scissors
  | None -> paper

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

let end_game_layout () =
  let end_message =
    Layout.resident (Widget.text_display (eval_whole_game game games_won))
  in
  Layout.sety end_message 300;
  Layout.setx end_message 300;
  if !games_won > !game / 2 then
    Layout.superpose
      [ Layout.resident win_bg; Layout.resident home_button; end_message ]
  else
    Layout.superpose
      [ Layout.resident lose_bg; Layout.resident home_button; end_message ]

let draw_initial_board =
  let text =
    Layout.resident (Widget.text_display "How many games do you want to play?")
  in
  let best_of_3 =
    Layout.resident
      (Widget.button "Best of 3" ~action:(fun _ ->
           num_games := 3;
           start_game := false;
           game := 3;
           Layout.push_close !my_layout))
  in
  let best_of_5 =
    Layout.resident
      (Widget.button "Best of 5" ~action:(fun _ ->
           num_games := 5;
           start_game := false;
           game := 5;
           Layout.push_close !my_layout))
  in
  Layout.setx best_of_3 250;
  Layout.setx best_of_5 500;
  Layout.sety best_of_3 300;
  Layout.sety best_of_5 300;
  Layout.setx text 300;
  Layout.superpose [ Layout.resident bg; best_of_3; best_of_5; text ]

(**Draws the board while game is in play.*)
let draw_board () =
  let game_message =
    string_of_int !num_games ^ " games left. " ^ "You've won "
    ^ string_of_int !games_won ^ " games so far."
  in
  let message = Widget.text_display game_message in
  Layout.setx user_buttons 650;
  Layout.sety user_buttons 75;
  Layout.superpose [ Layout.resident bg; user_buttons; Layout.resident message ]

(**Draws board after each game to show the player if they beat Cammy.*)
let result_board () =
  let close_button =
    Layout.resident
      (Widget.button "Next game" ~action:(fun _ -> Layout.push_close !my_layout))
  in
  gen_cammy_hand cammy_hand;
  let game_status = eval_game !cammy_hand !user_hand in
  let message_widget =
    Layout.resident
      (Widget.text_display (get_message game_status num_games games_won))
  in
  let game_message =
    string_of_int !num_games ^ " games left. " ^ "You've won "
    ^ string_of_int !games_won ^ " games so far."
  in
  let message = Layout.resident (Widget.text_display game_message) in
  let curr_bg = cammy_image !cammy_hand in
  let user_choice = Layout.resident (user_image !user_hand) in
  Layout.setx close_button 370;
  Layout.sety close_button 500;
  Layout.setx message_widget 350;
  Layout.sety message_widget 150;
  Layout.setx user_choice 550;
  Layout.sety user_choice 180;
  Layout.superpose
    [
      Layout.resident bg;
      Layout.resident curr_bg;
      message;
      user_choice;
      message_widget;
      close_button;
    ]

let main () =
  let rec game_loop games_left =
    if games_left > 0 then (
      if !start_game = true then (
        my_layout := draw_initial_board;
        start_game := false)
      else if !played_yet = false then (
        my_layout := draw_board ();
        played_yet := true)
      else (
        my_layout := result_board ();
        played_yet := false);
      Bogue.run (Bogue.of_layout !my_layout);
      game_loop !num_games)
    else if games_left = 0 then (
      my_layout := end_game_layout ();
      Bogue.run (Bogue.of_layout !my_layout))
  in
  game_loop !num_games;
  start_game := true;
  game := 0;
  num_games := 5;
  games_won := 0;
  start_game := true;
  played_yet := false;
  my_layout := Layout.empty ~w:1 ~h:1 ();
  cammy_hand := None;
  user_hand := None
FooterCornell University
