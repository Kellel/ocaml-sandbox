open Printf;;
open Core.Std;;

let sock = new Socks.server_socket (Socks.socket_factory ());;

printf "Starting Server\n";;
sock#bind "127.0.0.1" 8001;;
sock#set_reuse;;
sock#listen 10;;

let client_func client = 
    let echo () = 
        let recv = String.strip (client#recv 1024) in
        if String.length recv < 1 then raise (Failure "Connection closed by client");
        let sent = client#send (recv ^ "\n") in
        printf "ECHO: %s - (%d Bytes)\n" recv sent 
    in

    (* sock#send !message; *)
    try
        client#send "Hello\n";
        while true do
            echo (); 
        done;
    with exn -> 
        client#send "Goodbye\n";
        client#close;
        print_endline "Closing Connection";;

while true do
    let (client_sock, client_addr) = sock#accept in
    let client = new Socks.basic_socket client_sock in
    try ignore (Thread.create client_func client)
    with exn -> client#close; raise exn;
done;;
