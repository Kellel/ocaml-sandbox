let retrieve i = Array.get Sys.argv i;;

let line_len = ref 30;;

for i = 1 to (Array.length Sys.argv) - 1 do
    let current = retrieve i in
    match current with
    | "-a" -> print_endline "Oh hello there!"
    | "-h" -> print_endline "I hope this helps.";
              exit 1
    | "-l" -> 
            line_len := int_of_string (retrieve (i+1)); 
            print_endline (retrieve (i+1))
    | _    -> ()
done;;
Amodule.hello();;
Amodule.loops !line_len;;
Amodule.bye();;
