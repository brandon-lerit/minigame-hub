(* @author Anneliese Ardizzone (ava34) *)

open OUnit2
open Final_project.Tictactoebackend

(* init_board *)
let test_init_board () =
  let test_board = init_board () in
  assert_equal Empty test_board.(0).(0);
  assert_equal Empty test_board.(0).(1);
  assert_equal Empty test_board.(0).(2);
  assert_equal Empty test_board.(1).(0);
  assert_equal Empty test_board.(1).(1);
  assert_equal Empty test_board.(1).(2);
  assert_equal Empty test_board.(2).(0);
  assert_equal Empty test_board.(2).(1);
  assert_equal Empty test_board.(2).(2)

(* random_empty_spot *)
let test_random_empty_spot () =
  let test_board = init_board () in
  let counter = ref 50 in
  while !counter > 0 do
    let row, col = random_empty_spot test_board in
    assert_equal true (row >= 0 && row <= 2);
    assert_equal true (col >= 0 && col <= 2);
    assert_equal Empty test_board.(row).(col);
    counter := !counter - 1
  done

(* computer_move_helper *)
let test_computer_move_helper () =
  (* Test one move *)
  let test_board = init_board () in
  computer_move_helper test_board;
  let empty_spots = ref 0 in
  for i = 0 to 2 do
    for j = 0 to 2 do
      if test_board.(i).(j) = Empty then incr empty_spots
    done
  done;
  assert_equal true (!empty_spots = 8);
  (* 8 empty spots because only one spot should be *)
  (* Test a second move *)
  computer_move_helper test_board;
  let empty_spots = ref 0 in
  for i = 0 to 2 do
    for j = 0 to 2 do
      if test_board.(i).(j) = Empty then incr empty_spots
    done
  done;
  assert_equal true (!empty_spots = 7)
(* 7 empty spots if it correctly picks a different place than the first one *)

(* player_move_helper *)
let test_player_move_helper () =
  let test_board = init_board () in
  (* move once *)
  player_move_helper test_board 0 0;
  assert_equal X test_board.(0).(0);
  assert_equal Empty test_board.(0).(1);
  assert_equal Empty test_board.(0).(2);
  assert_equal Empty test_board.(1).(0);
  assert_equal Empty test_board.(1).(1);
  assert_equal Empty test_board.(1).(2);
  assert_equal Empty test_board.(2).(0);
  assert_equal Empty test_board.(2).(1);
  assert_equal Empty test_board.(2).(2);

  (* move again *)
  player_move_helper test_board 0 1;
  assert_equal X test_board.(0).(0);
  (* make sure we updated the old board *)
  assert_equal X test_board.(0).(1);
  (* and added our new marker *)
  assert_equal Empty test_board.(0).(2);
  assert_equal Empty test_board.(1).(0);
  assert_equal Empty test_board.(1).(1);
  assert_equal Empty test_board.(1).(2);
  assert_equal Empty test_board.(2).(0);
  assert_equal Empty test_board.(2).(1);
  assert_equal Empty test_board.(2).(2)

let test_player_move_helper_spot_taken () =
  let test_board = init_board () in
  test_board.(0).(0) <- O;
  player_move_helper test_board 0 0;
  assert_equal O test_board.(0).(0);
  (* trying to move on a taken spot should do nothing *)
  assert_equal Empty test_board.(0).(1);
  assert_equal Empty test_board.(0).(2);
  assert_equal Empty test_board.(1).(0);
  assert_equal Empty test_board.(1).(1);
  assert_equal Empty test_board.(1).(2);
  assert_equal Empty test_board.(2).(0);
  assert_equal Empty test_board.(2).(1);
  assert_equal Empty test_board.(2).(2)

let test_player_move_helper_board_full () =
  let test_board = init_board () in
  for i = 0 to 2 do
    for j = 0 to 2 do
      test_board.(i).(j) <- O
    done
  done;
  player_move_helper test_board 0 0;
  (* trying to move on a full board should do nothing *)
  player_move_helper test_board 0 1;
  player_move_helper test_board 0 2;
  player_move_helper test_board 1 0;
  player_move_helper test_board 1 1;
  player_move_helper test_board 1 2;
  player_move_helper test_board 2 0;
  player_move_helper test_board 2 1;
  player_move_helper test_board 2 2;

  for i = 0 to 2 do
    for j = 0 to 2 do
      assert_equal O test_board.(i).(j)
    done
  done

(* check_row_win --> called after each move, so there will never be a situation with two complete rows at once *)
let test_check_row_win_O () =
  (* row 0 *)
  let test_row_win_board_O_0 = init_board () in
  test_row_win_board_O_0.(0) <- Array.make 3 O;
  assert_equal true (check_row_win test_row_win_board_O_0 O);
  assert_equal false (check_row_win test_row_win_board_O_0 X);

  (* row 1 *)
  let test_row_win_board_O_1 = init_board () in
  test_row_win_board_O_1.(1) <- Array.make 3 O;
  assert_equal true (check_row_win test_row_win_board_O_1 O);
  assert_equal false (check_row_win test_row_win_board_O_1 X);

  (* row 2 *)
  let test_row_win_board_O_2 = init_board () in
  test_row_win_board_O_2.(2) <- Array.make 3 O;
  assert_equal true (check_row_win test_row_win_board_O_2 O);
  assert_equal false (check_row_win test_row_win_board_O_2 X);

  (* no rows *)
  let test_row_win_board_none = init_board () in
  assert_equal false (check_row_win test_row_win_board_none O);
  assert_equal false (check_row_win test_row_win_board_none X)

let test_check_row_win_X () =
  (* row 0 *)
  let test_row_win_board_X_0 = init_board () in
  test_row_win_board_X_0.(0) <- Array.make 3 X;
  assert_equal true (check_row_win test_row_win_board_X_0 X);
  assert_equal false (check_row_win test_row_win_board_X_0 O);

  (* row 1 *)
  let test_row_win_board_X_1 = init_board () in
  test_row_win_board_X_1.(1) <- Array.make 3 X;
  assert_equal true (check_row_win test_row_win_board_X_1 X);
  assert_equal false (check_row_win test_row_win_board_X_1 O);

  (* row 2 *)
  let test_row_win_board_X_2 = init_board () in
  test_row_win_board_X_2.(2) <- Array.make 3 X;
  assert_equal true (check_row_win test_row_win_board_X_2 X);
  assert_equal false (check_row_win test_row_win_board_X_2 O);

  (* no rows *)
  let test_row_win_board_none = init_board () in
  assert_equal false (check_row_win test_row_win_board_none X);
  assert_equal false (check_row_win test_row_win_board_none O)

(* check_column_win --> again, called after each move, so there will never be a situation with two complete rows at once*)
let test_check_column_win_O () =
  (* col 0 *)
  let test_col_win_board_O_0 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_O_0.(i).(0) <- O
  done;
  assert_equal true (check_column_win test_col_win_board_O_0 O);
  assert_equal false (check_column_win test_col_win_board_O_0 X);

  (* col 1 *)
  let test_col_win_board_O_1 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_O_1.(i).(1) <- O
  done;
  assert_equal true (check_column_win test_col_win_board_O_1 O);
  assert_equal false (check_column_win test_col_win_board_O_1 X);

  (* col 2 *)
  let test_col_win_board_O_2 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_O_2.(i).(2) <- O
  done;
  assert_equal true (check_column_win test_col_win_board_O_2 O);
  assert_equal false (check_column_win test_col_win_board_O_2 X);

  (* no cols *)
  let test_col_win_board_none = init_board () in
  assert_equal false (check_column_win test_col_win_board_none O);
  assert_equal false (check_column_win test_col_win_board_none X)

let test_check_column_win_X () =
  (* col 0 *)
  let test_col_win_board_X_0 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_X_0.(i).(0) <- X
  done;
  assert_equal true (check_column_win test_col_win_board_X_0 X);
  assert_equal false (check_column_win test_col_win_board_X_0 O);

  (* col 1 *)
  let test_col_win_board_X_1 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_X_1.(i).(1) <- X
  done;
  assert_equal true (check_column_win test_col_win_board_X_1 X);
  assert_equal false (check_column_win test_col_win_board_X_1 O);

  (* col 2 *)
  let test_col_win_board_X_2 = init_board () in
  for i = 0 to 2 do
    test_col_win_board_X_2.(i).(2) <- X
  done;
  assert_equal true (check_column_win test_col_win_board_X_2 X);
  assert_equal false (check_column_win test_col_win_board_X_2 O);

  (* no cols *)
  let test_col_win_board_none = init_board () in
  assert_equal false (check_column_win test_col_win_board_none X);
  assert_equal false (check_column_win test_col_win_board_none O)

(* check_diagonal_win *)
let test_check_diag_win_LR_X () =
  let test_diag_win_board = init_board () in
  for i = 0 to 2 do
    test_diag_win_board.(i).(i) <- X
  done;
  assert_equal true (check_diagonal_win test_diag_win_board X);
  assert_equal false (check_diagonal_win test_diag_win_board O)

let test_check_diag_win_LR_O () =
  let test_diag_win_board = init_board () in
  for i = 0 to 2 do
    test_diag_win_board.(i).(i) <- O
  done;
  assert_equal true (check_diagonal_win test_diag_win_board O);
  assert_equal false (check_diagonal_win test_diag_win_board X)

let test_check_diag_win_LR_no_winner () =
  let test_diag_win_board = init_board () in
  assert_equal false (check_diagonal_win test_diag_win_board X);
  assert_equal false (check_diagonal_win test_diag_win_board O);
  test_diag_win_board.(0).(0) <- O;
  test_diag_win_board.(1).(1) <- X;
  test_diag_win_board.(2).(2) <- O;
  assert_equal false (check_diagonal_win test_diag_win_board O);
  assert_equal false (check_diagonal_win test_diag_win_board X)

let test_check_diag_win_RL_X () =
  let test_diag_win_board = init_board () in
  for i = 0 to 2 do
    test_diag_win_board.(i).(2 - i) <- X
  done;
  assert_equal true (check_diagonal_win test_diag_win_board X);
  assert_equal false (check_diagonal_win test_diag_win_board O)

let test_check_diag_win_RL_O () =
  let test_diag_win_board = init_board () in
  for i = 0 to 2 do
    test_diag_win_board.(i).(2 - i) <- O
  done;
  assert_equal true (check_diagonal_win test_diag_win_board O);
  assert_equal false (check_diagonal_win test_diag_win_board X)

let test_check_diag_win_RL_no_winner () =
  let test_diag_win_board = init_board () in
  assert_equal false (check_diagonal_win test_diag_win_board X);
  assert_equal false (check_diagonal_win test_diag_win_board O);
  test_diag_win_board.(0).(2) <- X;
  test_diag_win_board.(1).(1) <- O;
  test_diag_win_board.(2).(0) <- X;
  assert_equal false (check_diagonal_win test_diag_win_board O);
  assert_equal false (check_diagonal_win test_diag_win_board X)

(* check_win *)
let test_check_win () =
  let test_win_board = init_board () in
  assert_equal false (check_win test_win_board X);
  assert_equal false (check_win test_win_board O);
  for i = 0 to 2 do
    for j = 0 to 2 do
      test_win_board.(i).(j) <- X
    done
  done;
  assert_equal true (check_win test_win_board X);
  assert_equal false (check_win test_win_board O)

let tests =
  "test suite for Tic-Tac-Toe"
  >::: [
         ("test_init_board" >:: fun _ -> test_init_board ());
         ("test_random_empty_spot" >:: fun _ -> test_random_empty_spot ());
         ("test_computer_move_helper" >:: fun _ -> test_computer_move_helper ());
         ("test_player_move_helper" >:: fun _ -> test_player_move_helper ());
         ( "test_player_move_helper_spot_taken" >:: fun _ ->
           test_player_move_helper_spot_taken () );
         ( "test_player_move_helper_board_full" >:: fun _ ->
           test_player_move_helper_board_full () );
         ("test_check_row_win_O" >:: fun _ -> test_check_row_win_O ());
         ("test_check_row_win_X" >:: fun _ -> test_check_row_win_X ());
         ("test_check_column_win_O" >:: fun _ -> test_check_column_win_O ());
         ("test_check_column_win_X" >:: fun _ -> test_check_column_win_X ());
         ("test_check_diag_win_LR_X" >:: fun _ -> test_check_diag_win_LR_X ());
         ("test_check_diag_win_LR_O" >:: fun _ -> test_check_diag_win_LR_O ());
         ( "test_check_diag_win_LR_no_winner" >:: fun _ ->
           test_check_diag_win_LR_no_winner () );
         ("test_check_diag_win_RL_X" >:: fun _ -> test_check_diag_win_RL_X ());
         ("test_check_diag_win_RL_O" >:: fun _ -> test_check_diag_win_RL_O ());
         ( "test_check_diag_win_RL_no_winner" >:: fun _ ->
           test_check_diag_win_RL_no_winner () );
         ("test_check_win" >:: fun _ -> test_check_win ());
       ]

let _ = run_test_tt_main tests