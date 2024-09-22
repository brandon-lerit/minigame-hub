(* @author Gabrielle Loncke (gal98) *)
type player = Player1 | Player2
type cell = Empty | Filled of player
type board = cell list list

let current_player = ref Player2
let game_board = ref (List.init 6 (fun _ -> List.init 6 (fun _ -> Empty)))

let print_board board =
  List.iter
    (fun row ->
      List.iter
        (fun cell ->
          match cell with
          | Empty -> print_string "E "
          | Filled Player1 -> print_string "red "
          | Filled Player2 -> print_string "blue ")
        row;
      print_newline ())
    board

let make_move column =
  let rec drop_piece row =
    if row >= 6 then failwith "Column is full"
    else if List.nth (List.nth !game_board row) column = Empty then
      let new_row =
        List.mapi
          (fun i cell -> if i = column then Filled !current_player else cell)
          (List.nth !game_board row)
      in
      game_board :=
        List.mapi (fun i r -> if i = row then new_row else r) !game_board
    else drop_piece (row + 1)
  in
  drop_piece 0;
  current_player :=
    match !current_player with Player1 -> Player2 | Player2 -> Player1

let check_win board =
  let directions = [ (0, 1); (1, 0); (1, 1); (1, -1) ] in
  let in_bounds (x, y) =
    x >= 0 && y >= 0 && x < List.length board && y < List.length (List.hd board)
  in
  let rec check_dir (x, y) (dx, dy) count player =
    if (not (in_bounds (x, y))) || count = 4 then count = 4
    else
      match List.nth (List.nth board x) y with
      | Empty -> check_dir (x + dx, y + dy) (dx, dy) 0 None
      | Filled p when Some p = player ->
          check_dir (x + dx, y + dy) (dx, dy) (count + 1) (Some p)
      | Filled p -> check_dir (x + dx, y + dy) (dx, dy) 1 (Some p)
  in
  let rec check_all x y dirs =
    match dirs with
    | [] -> false
    | (dx, dy) :: ds -> check_dir (x, y) (dx, dy) 0 None || check_all x y ds
  in
  let rec check_cell x y =
    if y >= List.length (List.hd board) then check_cell (x + 1) 0
    else if x >= List.length board then false
    else check_all x y directions || check_cell x (y + 1)
  in
  check_cell 0 0