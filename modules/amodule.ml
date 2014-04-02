open Printf

let message = "Hello"
let bye_message = "Goodbye!"

let hello () = print_endline message

let bye () = print_endline bye_message

let handle_input input length = 
    let new_len = (min length (String.length input)) in
    printf "-> %s\n" (String.sub input 0 new_len)

let loops length =
    let num = ref 0 in
    let inc i = i := !i + 1 in
    try
        while true do
            let line = input_line stdin in
            handle_input line length;
            inc num
        done;
    with
        End_of_file -> 
            printf "Found %i lines.\n" !num
