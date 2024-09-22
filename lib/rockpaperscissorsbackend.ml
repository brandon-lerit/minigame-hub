(* @author Philan Tran (pt337) *)
type choices = | Rock | Paper | Scissors
(**Randomly generates a choices type, assigns the camel this value.*)
let gen_cammy_hand cammy_hand =
  Random.self_init(); 
  let rand_num = Random.int 3 in
  match rand_num with
  | 0 -> cammy_hand := Some Rock
  | 1 -> cammy_hand := Some Paper
  | 2 -> cammy_hand := Some Scissors
  | _ -> cammy_hand := None

(* 1 if the user wins, 0 if the user ties, -1 if the user loses. *)
let eval_game cammy_hand user_hand =
  match cammy_hand with
  | Some Rock ->
    if (user_hand = Some Paper) then 1 else (
      if user_hand = Some Scissors then -1 else 0)
  | Some Paper ->
    if (user_hand = Some Scissors) then 1 else (
      if user_hand = Some Rock then -1 else 0)
  | Some Scissors -> 
    if (user_hand = Some Rock) then 1 else (
      if user_hand = Some Paper then -1 else 0)
  | None -> 0

let eval_whole_game game games_won =
  (* print_string (string_of_int(!game));
  print_string (string_of_int(!games_won)); *)
  if !games_won > (!game/2)
    then "You won " ^ string_of_int(!games_won) ^ "/" ^ string_of_int(!game) ^ " games!" ^ " Cammy wants a rematch..."
else "You won " ^ string_of_int(!games_won) ^ "/" ^ string_of_int(!game) ^ " games!" ^ " Cammy beat you and just did a victory lap!"

let get_message num num_games games_won =
  match num with
  | 0 -> "You tied with Cammy!"
  | 1 -> num_games := !num_games -1; games_won := !games_won + 1; "You beat Cammy!"
  | -1 -> num_games := !num_games -1; "You got beat by a camel... yikes."
  | _ -> "the code is broken."