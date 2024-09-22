(* @author Brandon Lerit (bsl77) *)

open Final_project.Warbackend
open OUnit

(* Test deck creation *)
let test_create_deck () =
  let array = create_deck 10 in
  assert (Array.length array = 10)

let test_create_deck_one () =
  let array = create_deck 1 in
  assert (Array.length array = 1)

(* Test get deck size *)
let test_get_deck_size () = assert (3 = get_deck_size (ref [| 1; 2; 3 |]))
let test_get_deck_size_one () = assert (1 = get_deck_size (ref [| 1 |]))

(* Test first card creation *)
let test_first_card () = assert (1 = get_first_card (ref [| 1; 5; 12 |]))
let test_first_card_one () = assert (13 = get_first_card (ref [| 13 |]))

(* Test get smaller deck size *)
let test_small_deck_fst () =
  let arr1 = ref [| 1; 2; 3; 4 |] in
  let arr2 = ref [| 1; 2; 3; 5; 8; 9 |] in
  assert (4 = get_min_deck_size arr1 arr2)

let test_small_deck_snd () =
  let arr1 = ref [| 1; 2; 3; 4 |] in
  let arr2 = ref [| 1; 2 |] in
  assert (2 = get_min_deck_size arr1 arr2)

let test_small_deck_eq () =
  let arr1 = ref [| 1; 2 |] in
  let arr2 = ref [| 1; 2 |] in
  assert (2 = get_min_deck_size arr1 arr2)

let test_small_deck_0_fst () =
  let arr1 = ref [||] in
  let arr2 = ref [| 1; 2 |] in
  assert (0 = get_min_deck_size arr1 arr2)

let test_small_deck_0_snd () =
  let arr1 = ref [| 1; 2 |] in
  let arr2 = ref [||] in
  assert (0 = get_min_deck_size arr1 arr2)

let test_small_deck_0_eq () =
  let arr1 = ref [||] in
  let arr2 = ref [||] in
  assert (0 = get_min_deck_size arr1 arr2)

(* Test win message *)
let test_player_round () =
  let arr1 = ref [| 8; 7 |] in
  let arr2 = ref [| 7; 1 |] in
  assert ("You Win!" = get_win_message arr1 arr2)

let test_computer_round () =
  let arr1 = ref [| 1; 7 |] in
  let arr2 = ref [| 7; 1 |] in
  assert ("Humphrey Wins!" = get_win_message arr1 arr2)

let test_tie_round () =
  let arr1 = ref [| 1; 7 |] in
  let arr2 = ref [| 1 |] in
  assert ("There's a Tie." = get_win_message arr1 arr2)

(* Check first cards equal *)
let test_check_cards_true () =
  let arr1 = [| 1; 7 |] in
  let arr2 = [| 1 |] in
  assert (true = check_first_cards arr1 arr2)

let test_check_cards_false () =
  let arr1 = [| 1; 7 |] in
  let arr2 = [| 7 |] in
  assert (false = check_first_cards arr1 arr2)

(* Tests for playing a round *)
let test_play_round_player () =
  let arr1 = ref [| 13; 1; 5; 6 |] in
  let arr2 = ref [| 12; 4 |] in
  play_round arr1 arr2;
  assert (!arr1 = [| 1; 5; 6; 13; 12 |] && !arr2 = [| 4 |])

let test_play_round_computer () =
  let arr1 = ref [| 5; 1; 5; 6 |] in
  let arr2 = ref [| 12; 4 |] in
  play_round arr1 arr2;
  assert (!arr1 = [| 1; 5; 6 |] && !arr2 = [| 4; 12; 5 |])

let test_play_round_player_tie () =
  let arr1 = ref [| 13; 7; 5; 6 |] in
  let arr2 = ref [| 13; 4 |] in
  play_round arr1 arr2;
  assert (!arr1 = [| 5; 6; 13; 13; 7; 4 |] && !arr2 = [||])

let test_play_round_computer_tie () =
  let arr1 = ref [| 6; 1; 5; 6 |] in
  let arr2 = ref [| 6; 4 |] in
  play_round arr1 arr2;
  assert (!arr1 = [| 5; 6 |] && !arr2 = [| 6; 6; 4; 1 |])

let test_play_round_tie_tie () =
  let arr1 = ref [| 8; 1; 5; 6 |] in
  let arr2 = ref [| 8; 1 |] in
  play_round arr1 arr2;
  assert (!arr1 = [| 5; 6 |] && !arr2 = [||])

let test_play_round_computer_0 () =
  let arr1 = ref [| 8; 1; 5; 6 |] in
  let arr2 = ref [||] in
  play_round arr1 arr2;
  assert (!arr1 = [| 8; 1; 5; 6 |] && !arr2 = [||])

let test_play_round_player_0 () =
  let arr1 = ref [||] in
  let arr2 = ref [| 1; 13; 2; 1 |] in
  play_round arr1 arr2;
  assert (!arr1 = [||] && !arr2 = [| 1; 13; 2; 1 |])

(* Test final win message *)
let test_final_player () =
  let arr1 = ref [| 8; 1; 5; 6 |] in
  let arr2 = ref [| 8; 1 |] in
  assert (get_final_win_message arr1 arr2 = "You Win The Game! :)")

let test_final_computer () =
  let arr1 = ref [| 5; 6 |] in
  let arr2 = ref [| 8; 1; 13; 12 |] in
  assert (get_final_win_message arr1 arr2 = "Humphrey Wins The Game! ;(")

let test_final_tie () =
  let arr1 = ref [| 8; 12 |] in
  let arr2 = ref [| 8; 1 |] in
  assert (get_final_win_message arr1 arr2 = "The Game is a Tie! :|")

let test_final_player_0 () =
  let arr1 = ref [| 8; 1; 5; 6 |] in
  let arr2 = ref [||] in
  assert (get_final_win_message arr1 arr2 = "You Win The Game! :)")

let test_final_computer_0 () =
  let arr1 = ref [||] in
  let arr2 = ref [| 8; 1 |] in
  assert (get_final_win_message arr1 arr2 = "Humphrey Wins The Game! ;(")

let test_final_tie_0 () =
  let arr1 = ref [||] in
  let arr2 = ref [||] in
  assert (get_final_win_message arr1 arr2 = "The Game is a Tie! :|")

let tests =
  "Test suite for war"
  >::: [
         ("test create deck (deck size)" >:: fun _ -> test_create_deck ());
         ("test create deck one" >:: fun _ -> test_create_deck_one ());
         ("test get deck size typical" >:: fun _ -> test_get_deck_size ());
         ("test get deck size one" >:: fun _ -> test_get_deck_size_one ());
         ("test get first card typical" >:: fun _ -> test_first_card ());
         ("test get first card one" >:: fun _ -> test_first_card_one ());
         ( "test get min deck size first smaller" >:: fun _ ->
           test_small_deck_fst () );
         ( "test get min deck size second smaller" >:: fun _ ->
           test_small_deck_snd () );
         ("test get min deck size equal" >:: fun _ -> test_small_deck_eq ());
         ("test get min deck size first 0" >:: fun _ -> test_small_deck_0_fst ());
         ( "test get min deck size second 0" >:: fun _ ->
           test_small_deck_0_snd () );
         ("test get min deck size both 0" >:: fun _ -> test_small_deck_0_eq ());
         ("test round player win" >:: fun _ -> test_player_round ());
         ("test round computer win" >:: fun _ -> test_computer_round ());
         ("test round tie" >:: fun _ -> test_tie_round ());
         ("test check first cards true" >:: fun _ -> test_check_cards_true ());
         ("test check first cards false" >:: fun _ -> test_check_cards_false ());
         ("test round played player win" >:: fun _ -> test_play_round_player ());
         ( "test round played computer win" >:: fun _ ->
           test_play_round_computer () );
         ( "test round played player win after tie" >:: fun _ ->
           test_play_round_player_tie () );
         ( "test round played computer win after tie" >:: fun _ ->
           test_play_round_computer_tie () );
         ("test round played two ties" >:: fun _ -> test_play_round_tie_tie ());
         ( "test round player deck empty" >:: fun _ ->
           test_play_round_player_0 () );
         ( "test round computer deck empty" >:: fun _ ->
           test_play_round_computer_0 () );
         ("test final message player" >:: fun _ -> test_final_player ());
         ("test final message computer" >:: fun _ -> test_final_computer ());
         ("test final message tie" >:: fun _ -> test_final_tie ());
         ( "test final message player (computer 0)" >:: fun _ ->
           test_final_player_0 () );
         ( "test final message computer (player 0)" >:: fun _ ->
           test_final_computer_0 () );
         ("test final message tie (both 0)" >:: fun _ -> test_final_tie_0 ());
       ]

let _ = run_test_tt_main tests