(* #load "unix.cma";; *)
open Unix

let socket_factory () =
    socket PF_INET SOCK_STREAM 0;;

class basic_socket sock = 
    object (self)
        val mutable sock = sock
        method send (str:string) =
            let len = String.length str in
            send sock str 0 len []
        method recv maxlen = 
            let str = String.create maxlen in
            let recvlen = recv sock str 0 maxlen [] in
            String.sub str 0 recvlen
        method close =
            close sock
        method shutdown = 
            shutdown sock SHUTDOWN_ALL
    end;;

class server_socket sock = 
    object (self)
        inherit basic_socket sock
        method set_reuse = 
            setsockopt sock SO_REUSEADDR true
        method bind addr port = 
            bind sock (ADDR_INET (inet_addr_of_string addr, port))
        method listen qlen = 
            listen sock qlen
        method accept =
            accept sock
    end;;

class client_socket sock = 
    object (self)
        inherit basic_socket sock
        method connect addr port =
            connect sock (ADDR_INET (addr, port))
    end;;
        
