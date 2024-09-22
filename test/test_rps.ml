(* @author Philan Tran (pt337) *)
open Final_project.Rockpaperscissorsbackend
open OUnit2

let cammy_hand = ref None
let game = ref 5
let num_games = ref 5
let games_won = ref 0

let test_gen_cammy_hand () =
  cammy_hand := None;
  gen_cammy_hand cammy_hand;
  assert (!cammy_hand <> None)

let test_eval_game_1 () =
  let game = eval_game (Some Rock) (Some Rock) in
  assert (game = 0)

let test_eval_game_2 () =
  let game = eval_game (Some Rock) (Some Paper) in
  assert (game = 1)

let test_eval_game_3 () =
  let game = eval_game (Some Rock) (Some Scissors) in
  assert (game = -1)

let test_eval_game_4 () =
  let game = eval_game (Some Paper) (Some Rock) in
  assert (game = -1)

let test_eval_game_5 () =
  let game = eval_game (Some Paper) (Some Paper) in
  assert (game = 0)

let test_eval_game_6 () =
  let game = eval_game (Some Paper) (Some Scissors) in
  assert (game = 1)

let test_eval_game_7 () =
  let game = eval_game (Some Scissors) (Some Rock) in
  assert (game = 1)

let test_eval_game_8 () =
  let game = eval_game (Some Scissors) (Some Paper) in
  assert (game = -1)

let test_eval_game_9 () =
  let game = eval_game (Some Scissors) (Some Scissors) in
  assert (game = 0)

let test_eval_whole_game_win_3 () =
  game := 3;
  games_won := 3;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy wants a rematch..."
    = result)

let test_eval_whole_game_win_3_2 () =
  game := 3;
  games_won := 2;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy wants a rematch..."
    = result)

let test_eval_whole_game_lose_3 () =
  game := 3;
  games_won := 1;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy beat you and just did a victory lap!"
    = result)

let test_eval_whole_game_lose_3_2 () =
  game := 3;
  games_won := 0;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy beat you and just did a victory lap!"
    = result)

let test_eval_whole_game_win_5 () =
  game := 5;
  games_won := 3;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy wants a rematch..."
    = result)

let test_eval_whole_game_win_5_2 () =
  game := 5;
  games_won := 4;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy wants a rematch..."
    = result)

let test_eval_whole_game_win_5_3 () =
  game := 5;
  games_won := 5;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy wants a rematch..."
    = result)

let test_eval_whole_game_lose_5 () =
  game := 5;
  games_won := 2;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy beat you and just did a victory lap!"
    = result)

let test_eval_whole_game_lose_5_2 () =
  game := 5;
  games_won := 1;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy beat you and just did a victory lap!"
    = result)

let test_eval_whole_game_lose_5_3 () =
  game := 5;
  games_won := 0;
  let result = eval_whole_game game games_won in
  assert (
    "You won " ^ string_of_int !games_won ^ "/" ^ string_of_int !game
    ^ " games!" ^ " Cammy beat you and just did a victory lap!"
    = result)

let test_get_message_tie () =
  num_games := 3;
  games_won := 2;
  let message = get_message 0 num_games games_won in
  assert (message = "You tied with Cammy!" && !num_games = 3 && !games_won = 2)

let test_get_message_win () =
  num_games := 3;
  games_won := 2;
  let message = get_message 1 num_games games_won in
  assert (message = "You beat Cammy!" && !num_games = 2 && !games_won = 3)

let test_get_message_lose () =
  num_games := 3;
  games_won := 2;
  let message = get_message (-1) num_games games_won in
  assert (
    message = "You got beat by a camel... yikes."
    && !num_games = 2 && !games_won = 2)

let tests =
  "test suite for rock paper scissors"
  >::: [
         ("test gen_cammy_hand" >:: fun _ -> test_gen_cammy_hand ());
         ( "test eval_game, cammy: rock, user: rock" >:: fun _ ->
           test_eval_game_1 () );
         ( "test eval_game, cammy: rock, user: paper" >:: fun _ ->
           test_eval_game_2 () );
         ( "test eval_game, cammy: rock, user: scissors" >:: fun _ ->
           test_eval_game_3 () );
         ( "test eval_game, cammy: paper, user: rock" >:: fun _ ->
           test_eval_game_4 () );
         ( "test eval_game, cammy: paper, user: paper" >:: fun _ ->
           test_eval_game_5 () );
         ( "test eval_game, cammy: paper, user: scissors" >:: fun _ ->
           test_eval_game_6 () );
         ( "test eval_game, cammy: scissors, user: rock" >:: fun _ ->
           test_eval_game_7 () );
         ( "test eval_game, cammy: scissors, user: paper" >:: fun _ ->
           test_eval_game_8 () );
         ( "test eval_game, cammy: scissors, user: scissors" >:: fun _ ->
           test_eval_game_9 () );
         ( "test eval_whole_game, user wins 3, game of 3" >:: fun _ ->
           test_eval_whole_game_win_3 () );
         ( "test eval_whole_game, user wins 1, game of 3" >:: fun _ ->
           test_eval_whole_game_lose_3 () );
         ( "test eval_whole_game, user wins 2, game of 3" >:: fun _ ->
           test_eval_whole_game_win_3_2 () );
         ( "test eval_whole_game, user wins 0, game of 3" >:: fun _ ->
           test_eval_whole_game_lose_3_2 () );
         ( "test eval_whole_game, user wins 3, game of 5" >:: fun _ ->
           test_eval_whole_game_win_5 () );
         ( "test eval_whole_game, user wins 4, game of 5" >:: fun _ ->
           test_eval_whole_game_win_5_2 () );
         ( "test eval_whole_game, user wins 5, game of 5" >:: fun _ ->
           test_eval_whole_game_win_5_3 () );
         ( "test eval_whole_game, user wins 2, game of 5" >:: fun _ ->
           test_eval_whole_game_lose_5 () );
         ( "test eval_whole_game, user wins 1, game of 5" >:: fun _ ->
           test_eval_whole_game_lose_5_2 () );
         ( "test eval_whole_game, user wins 0, game of 5" >:: fun _ ->
           test_eval_whole_game_lose_5_3 () );
         ("test get_message, game is a tie" >:: fun _ -> test_get_message_tie ());
         ("test get_message, user wins" >:: fun _ -> test_get_message_win ());
         ("test get_message, user loses" >:: fun _ -> test_get_message_lose ());
       ]

let _ = run_test_tt_main tests