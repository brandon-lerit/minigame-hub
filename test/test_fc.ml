(* @author Gabrielle Loncke (gal98) *)
open OUnit
open Final_project.Fourconnectbackend

(*Test Cases For Four Connect Game*)
let test_check_win_with_win () =
  game_board :=
    [
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
    ];
  assert (check_win !game_board)

let test_check_win_without_win () =
  game_board :=
    [
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Empty;
        Empty;
        Empty;
        Empty;
      ];
      [
        Empty;
        Empty;
        Filled Final_project.Fourconnectbackend.Player1;
        Filled Final_project.Fourconnectbackend.Player2;
        Empty;
        Empty;
        Empty;
      ];
    ];
  assert (not (check_win !game_board))

let test_check_win_horizontal () =
  game_board :=
    [
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [ Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
      [
        Filled Player1;
        Filled Player1;
        Filled Player1;
        Filled Player1;
        Empty;
        Empty;
        Empty;
      ];
    ];
  assert (check_win !game_board)

let test_check_win_empty_board () =
  game_board := List.init 6 (fun _ -> List.init 7 (fun _ -> Empty));
  assert (not (check_win !game_board))

let test_make_move _ =
  for column = 0 to 5 do
    (* Reset the game board and current player for each column *)
    game_board := List.init 6 (fun _ -> List.init 6 (fun _ -> Empty));
    current_player := Player1;

    make_move column;
    assert_equal (List.nth (List.nth !game_board 0) column) (Filled Player1);

    current_player := Player2;
    make_move column;
    assert_equal (List.nth (List.nth !game_board 1) column) (Filled Player2)
  done

let suite =
  "Connect Four tests"
  >::: [
         "test_check_win_with_win" >:: test_check_win_with_win;
         "test_check_win_without_win" >:: test_check_win_without_win;
         "test_check_win_horizontal" >:: test_check_win_horizontal;
         "test_check_win_empty_board" >:: test_check_win_empty_board;
         "test_make_move" >:: test_make_move;
       ]

let () = ignore (run_test_tt_main suite)