(* @author Brandon Lerit (bsl77) *)

(* Function to Create Deck *)
let create_deck n =
  let rec create_deck_helper acc remaining =
    if remaining = 0 then acc
    else
      let random_card = Random.int 13 + 1 in
      create_deck_helper (Array.append [| random_card |] acc) (remaining - 1)
  in
  create_deck_helper [||] n

let get_deck_size deck = Array.length !deck

(*GAME LOGIC*)
let get_first_card deck = Array.get !deck 0

let get_min_deck_size player_deck computer_deck =
  let player_size = Array.length !player_deck in
  let computer_size = Array.length !computer_deck in
  if player_size > computer_size then computer_size else player_size

let get_win_message player_deck computer_deck =
  let player_card = Array.get !player_deck 0 in
  let computer_card = Array.get !computer_deck 0 in
  if player_card > computer_card then "You Win!"
  else if computer_card > player_card then "Humphrey Wins!"
  else "There's a Tie."

let check_first_cards deck1 deck2 = Array.get deck1 0 = Array.get deck2 0

let play_round player_deck computer_deck =
  if Array.length !player_deck = 0 || Array.length !computer_deck = 0 then ()
  else
    let player_card = Array.get !player_deck 0 in
    let computer_card = Array.get !computer_deck 0 in
    let remaining_player_deck =
      Array.sub !player_deck 1 (Array.length !player_deck - 1)
    in
    let remaining_computer_deck =
      Array.sub !computer_deck 1 (Array.length !computer_deck - 1)
    in
    if player_card > computer_card then (
      player_deck :=
        Array.append remaining_player_deck [| player_card; computer_card |];
      computer_deck := remaining_computer_deck)
    else if computer_card > player_card then (
      computer_deck :=
        Array.append remaining_computer_deck [| computer_card; player_card |];
      player_deck := remaining_player_deck)
    else (
      if Array.length !player_deck = 0 || Array.length !computer_deck = 0 then
        ();
      let tie_player_card = Array.get remaining_player_deck 0 in
      let tie_computer_card = Array.get remaining_computer_deck 0 in
      let tie_remaining_player_deck =
        Array.sub remaining_player_deck 1
          (Array.length remaining_player_deck - 1)
      in
      let tie_remaining_computer_deck =
        Array.sub remaining_computer_deck 1
          (Array.length remaining_computer_deck - 1)
      in
      if tie_player_card > tie_computer_card then (
        player_deck :=
          Array.append tie_remaining_player_deck
            [| player_card; computer_card; tie_player_card; tie_computer_card |];
        computer_deck := tie_remaining_computer_deck)
      else if tie_computer_card > tie_player_card then (
        computer_deck :=
          Array.append tie_remaining_computer_deck
            [| computer_card; player_card; tie_computer_card; tie_player_card |];
        player_deck := tie_remaining_player_deck)
      else (
        player_deck := tie_remaining_player_deck;
        computer_deck := tie_remaining_computer_deck))

let get_final_win_message player_deck computer_deck =
  let player_length = Array.length !player_deck in
  let computer_length = Array.length !computer_deck in
  if player_length > computer_length then "You Win The Game! :)"
  else if computer_length > player_length then "Humphrey Wins The Game! ;("
  else "The Game is a Tie! :|"