(* @author Anneliese Ardizzone (ava34) *)

(* ~~~ Functions for game logic ~~~ *)
type spot_on_board = X | O | Empty (* type for each item in the board *)

type board =
  spot_on_board array array (* type for the game board --> mutable 2d array *)

let string_of_spot = function X -> " X " | O -> " O " | Empty -> "  -  "

(* make an empty board *)
let init_board () = Array.make_matrix 3 3 Empty

let rec random_empty_spot board =
  (* helper for computer_move, gets a random empty spot on the board *)
  let row = Random.int 3 in
  let col = Random.int 3 in
  if board.(row).(col) = Empty then (row, col) else random_empty_spot board

(* debug function to print board to console *)
let print_board board =
  Array.iter
    (fun row ->
      Array.iter
        (fun cell ->
          match cell with
          | X -> print_string " X "
          | O -> print_string " O "
          | Empty -> print_string " - ")
        row;
      print_endline "")
    board

(* Check if the board is full (i.e. no Empty spots) *)
let board_full board =
  Array.for_all (Array.for_all (fun cell -> cell <> Empty)) board

(* Functions to check if [player] (X or O) has won *)
let check_row_win board player =
  Array.exists (fun row -> Array.for_all (fun cell -> cell = player) row) board

let check_column_win board player =
  let num_cols = Array.length board.(0) in
  let rec check_col col =
    if col >= num_cols then false
    else if Array.for_all (fun row -> row.(col) = player) board then true
    else check_col (col + 1)
  in
  check_col 0

let check_diagonal_win board player =
  let num_rows = Array.length board in
  let num_cols = Array.length board.(0) in

  (* check the first diagonal *)
  let one_diag_win = ref true in
  for i = 0 to min (num_rows - 1) (num_cols - 1) do
    if board.(i).(i) <> player then one_diag_win := false
  done;

  (* check the other diagonal *)
  let other_diag_win = ref true in
  for i = 0 to min (num_rows - 1) (num_cols - 1) do
    if board.(i).(num_cols - 1 - i) <> player then other_diag_win := false
  done;
  !one_diag_win || !other_diag_win

let check_win board player =
  check_row_win board player
  || check_column_win board player
  || check_diagonal_win board player

let computer_move_helper board =
  (* function for computer moves*)
  let row, col = random_empty_spot board in
  board.(row).(col) <- O

let player_move_helper board row col =
  (* function for player moves *)
  if board.(row).(col) = Empty then board.(row).(col) <- X