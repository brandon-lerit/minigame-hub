(* @author Gabrielle Loncke (gal98), Philan Tran (pt337), Anneliese Ardizzone (ava34), & Brandon Lerit (bsl77) *)
open Bogue
open Final_project

let background_image = Widget.image "lib/assets/extra/home.png"
let play_RPS () = Rockpaperscissorsfrontend.main ()
let play_War () = Warfrontend.main ()
let play_TTT () = Tictactoefrontend.main ()

let blank_button_image =
  Style.Image (Image.create "lib/assets/tictactoe/transparent.png")

let b1 =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ -> play_RPS ())
    "Rock Paper Scissors"

let b2 =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ -> play_War ())
    "War          "

let b3 =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ -> play_TTT ())
    "Tic-Tac-Toe"

let b4 =
  Widget.button ~bg_on:blank_button_image ~bg_off:blank_button_image
    ~bg_over:(Some blank_button_image)
    ~action:(fun _ -> Fourconnectfrontend.play ())
    "Four Connect"

let r1 = Layout.flat_of_w ~align:Draw.Center [ b1; b2 ]
let r2 = Layout.flat_of_w ~align:Draw.Center [ b3; b4 ]
let buttons = Layout.tower ~align:Draw.Center [ r1; r2 ]

let () =
  Layout.set_size buttons (500, 300);
  Layout.setx buttons 250;
  Layout.sety buttons 50

let board =
  Layout.superpose ~name:"Camel UTOPia!"
    [ Layout.resident background_image; buttons ]
;;

Bogue.run (Bogue.of_layout board)