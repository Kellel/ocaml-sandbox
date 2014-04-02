open Printf

let sock = new Socks.server_socket (Socks.socket_factory ());;

printf "Starting Server\n";;
sock#bind "127.0.0.1" 8001;;
sock#set_reuse;;
sock#listen 10;;

while true do
    let (client_sock, client_addr) = sock#accept in
    let client = new Socks.basic_socket client_sock in
    let str = "Hello\n" in 
    let sent = client#send str in
    let recv = client#recv 1024 in
    print_endline "Hello from 1";
    print_int sent;
    printf "Read (%d Bytes)-> %s" sent recv;
    client#close;
done;;

sock#close;;

