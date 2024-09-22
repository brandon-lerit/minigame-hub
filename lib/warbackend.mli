(* @author Brandon Lerit (bsl77) *)

(* Function to create an int array of specified size.
   Preconditions: Inputed size [n] is greater than or equal to 0
   Postconditions: Every element in the array is an integer between 1-13 *)
val create_deck : int -> int array

(* Function to return the size of an array ref.
   Preconditions: Input is an array ref of any type
   Postconditions: Returns the size of the array ref as an int *)
val get_deck_size : 'a array ref -> int

(* Function to return the first element of an array ref.
   Preconditions: Input is an array ref of any type
   Postconditions: Returns an element of type 'a *)
val get_first_card : 'a array ref -> 'a

(* Function to return the smaller length of two array inputs.
   Preconditions: Input is two array refs of any type
   Postconditions: Returns the smaller size of the array ref as an int *)
val get_min_deck_size : 'a array ref -> 'b array ref -> int

(* Function to return the win message of one round in the game
    (based on the first element).
   Preconditions: Input is two array refs of any type.
   Postconditions: Returns the proper message for whether the first or second
   array has a higher first element*)
val get_win_message : 'a array ref -> 'a array ref -> string

(* Function to return a bool based on if the first elements of an array are the same.
   Preconditions: Input is two arrays of any type
   Postconditions: Returns the bool corresponding to the function *)
val check_first_cards : 'a array -> 'a array -> bool

(* Function to modify the tow inputed array refs based on war rounds.
   Whichever player has a higher first element gets both first elements appended
   to it. In the case of a tie, one more round is played with the same rules.
   If two ties occur, no elements get appended.
      Preconditions: Input is two array refs of any type
      Postconditions: Returns a unit and modifies the inputed arrays. *)
val play_round : 'a array ref -> 'a array ref -> unit

(* Function to return the win message for the entire game (based on array size).
   If array size is the same its the tie message, and then for the first the player
   wins and the second the computer wins.
   Preconditions: Input is two array refs of any type
   Postconditions: Returns message based on the function as a string *)
val get_final_win_message : 'a array ref -> 'a array ref -> string