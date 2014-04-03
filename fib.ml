let rec fib_aux n a b =
  match n with
  | 0 -> a
  | _ -> fib_aux (n - 1) b (a+b)

let fib n = fib_aux n 0 1

let retrieve i = Array.get Sys.argv i

;;

let n = ref 20;;

match Array.length Sys.argv with
| 1 -> ()
| 2 -> n := int_of_string (retrieve 1)
| _ -> print_endline "Incorrect Usage!"; exit 1;;

print_int (fib !n);;
print_newline ();;

