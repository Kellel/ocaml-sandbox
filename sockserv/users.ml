
class user_type (sock_obj : basic_socket) =
    object (self)
        val mutable sock = sock_obj
        method fileno () =
            sock.sock.fileno () ;;
