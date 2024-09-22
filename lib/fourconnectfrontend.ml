(* @author Gabrielle Loncke (gal98) *)
open Bogue
module W = Widget
module L = Layout
module T = Trigger
open Fourconnectbackend

let last_move = ref 0
let w = 100
let h = 100
let player_turn_widget = ref (Widget.label "Player 1's turn")

let red =
  Style.(
    of_bg (opaque_bg Draw.red)
    |> with_border (mk_border ~radius:(w / 2) (mk_line ())))

let blue =
  Style.(
    of_bg (opaque_bg Draw.blue)
    |> with_border (mk_border ~radius:(w / 2) (mk_line ())))

let mstyle = function
  | Empty -> Style.empty
  | Filled Player1 -> red
  | Filled Player2 -> blue

let create_widgets board =
  let create_row row =
    List.map (fun cell -> W.box ~w ~h ~style:(mstyle cell) ()) row
  in
  List.map create_row board |> Array.of_list |> Array.map Array.of_list

let dark = Style.(of_bg (opaque_bg Draw.(find_color "saddlebrown")))
let light = Style.(of_bg (opaque_bg Draw.(find_color "bisque")))
let my_layout = ref (Layout.empty ~w:1 ~h:1 ())
let win = Widget.image "lib/assets/tictactoe/win.png"

let blank_button_image =
  Style.Image (Image.create "lib/assets/tictactoe/transparent.png")

let close_layout (* function for closing layout, used for home button below *) _
    =
  Layout.push_close !my_layout

let home_button =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image) ~action:close_layout
    ~label:
      (Label.create ~size:14
         ~fg:Draw.(opaque (find_color "white"))
         "<= Click HERE to return to Connect Four!")
    " "

let win_layout =
  let house =
    Layout.superpose ~name:"Four Connect"
      [ Layout.resident win; Layout.resident home_button ]
  in
  Layout.set_size house (800, 600);
  house

let reset_game () =
  current_player := Player1;
  game_board := List.init 6 (fun _ -> List.init 7 (fun _ -> Empty))

let make_button_one =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 0;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 1 !")
    " "

let make_button_two =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 1;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 2 !")
    " "

let make_button_three =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 2;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 3 !")
    " "

let make_button_four =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 3;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 4 !")
    " "

let make_button_five =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 4;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 5 !")
    " "

let make_button_six =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ ->
      last_move := 5;
      player_turn_widget :=
        Widget.label
          (match !current_player with
          | Player1 -> "Player 2's turn"
          | Player2 -> "Player 1's turn"))
    ~label:
      (Label.create ~size:14 ~fg:Draw.(opaque (find_color "red")) "Column 6 !")
    " "

let make_button_layout () =
  let buttons =
    [
      make_button_one;
      make_button_two;
      make_button_three;
      make_button_four;
      make_button_five;
      make_button_six;
    ]
  in
  L.flat ~name:"buttons" (List.map L.resident buttons)

let make_layout ws =
  let button_layout = make_button_layout () in
  let turn_layout = L.resident !player_turn_widget in
  let ws_with_buttons =
    ws
    |> Array.mapi (fun i row ->
           row
           |> Array.mapi (fun j box ->
                  let background =
                    if (i + j) mod 2 = 0 then L.style_bg light
                    else L.style_bg dark
                  in
                  L.resident ~background box))
    |> Array.to_list
    |> List.map (fun row -> L.flat ~margins:0 (Array.to_list row))
  in
  L.tower ~margins:0 (turn_layout :: button_layout :: ws_with_buttons)

let show_board n =
  let ws = create_widgets n in
  let layout = make_layout ws in
  Bogue.(run (of_layout layout))

let rec play1 player =
  make_move !last_move;
  show_board !game_board;
  if check_win !game_board then (
    match player with
    | Player1 ->
        my_layout := win_layout;
        Bogue.run (Bogue.of_layout !my_layout);
        reset_game ()
    | Player2 ->
        my_layout := win_layout;
        Bogue.run (Bogue.of_layout !my_layout);
        reset_game ())
  else play1 (if player = Player1 then Player2 else Player1)

let play () =
  let thick_grey_line =
    Style.mk_line ~color:Draw.(opaque grey) ~width:3 ~style:Solid ()
  in
  let image =
    W.image ~w:1024 ~h:768 "lib/assets/connectfour/connect_four.png"
  in
  let image = L.flat ~name:"image" [ L.resident image ] in
  let title =
    W.label ~size:32 ~fg:Draw.(opaque (find_color "black")) "CONNECT FOUR"
    |> L.resident
  in
  let instructions =
    W.label ~size:16
      ~fg:Draw.(opaque (find_color "black"))
      "Instructions: Click on a column to place your piece. Get four in a row \
       to win! "
    |> L.resident
  in
  let instructions1 =
    W.label ~size:16
      ~fg:Draw.(opaque (find_color "black"))
      " AFTER A PLAYER CHOOSES A COLUMN PLEASE CLOSE THE WINDOW TO SEE YOUR \
       PLACEMENT!Happy Gaming! "
    |> L.resident
  in
  let note =
    W.label ~size:16
      ~fg:Draw.(opaque (find_color "black"))
      "Player 2 gets a boost try beating them player 1!"
    |> L.resident
  in
  let style = Style.(create ~border:(mk_border thick_grey_line) ()) in
  let fg = Draw.(opaque white) in
  let make_btn x y text action =
    let l = W.label ~fg text in
    let r =
      L.tower ~name:"game button" ~margins:0
        [ L.resident ~w:100 ~h:40 ~background:(L.style_bg style) l ]
    in
    L.setx r x;
    L.sety r y;
    let open Menu in
    { label = Layout r; content = Action action }
  in
  let start_btn = make_btn 320 640 "Start" (fun () -> play1 Player1) in
  let quit_btn = make_btn 475 640 "Quit" (fun () -> exit 0) in
  let entries = [ start_btn; quit_btn ] in
  let _ = Menu.create ~dst:image (Menu.Custom entries) in
  let layout =
    L.superpose [ image; title; instructions; instructions1; note ]
  in
  L.setx instructions 10;
  L.sety instructions 100;
  L.setx instructions1 7;
  L.sety instructions1 120;
  L.setx title 35;
  L.sety title 250;
  L.setx note 650;
  L.sety note 500;
  L.rotate ~duration:1000 ~angle:360. title;
  let board = Bogue.of_layout layout in
  Bogue.run board