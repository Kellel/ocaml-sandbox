open Printf;;
open Core.Std;;
open Async.Std;;

printf "Starting Server\n";;

let rec handler buffer r w =
    let st_time = Unix.time () in
    let rec clean buf current =
        match current with
        | 0 -> ()
        | _ ->
            ( buf.[current] = ' ';
              clean buf (current - 1) )
    in

    Reader.read r buffer
    >>= function
    | `Eof -> return ()
    | `Ok bytes_read ->
            printf "Read (%d Bytes): " bytes_read;
            Writer.write w buffer ~len:bytes_read;
            let now = Unix.time () in
            printf "%s -- in %.2f\n" (String.strip buffer) (now -. st_time); 
            clean buffer (String.length);
            Writer.flushed w
            >>= fun () ->
                handler buffer r w 

let run () = 
    let host_and_port = 
        Tcp.Server.create
          ~on_handler_error: `Raise
          (Tcp.on_port 8001)
          (fun _addr r w ->
              let buffer = String.create (16 * 1024) in
              handler buffer r w)
    in
    ignore (host_and_port : (Socket.Address.Inet.t, int) Tcp.Server.t Deferred.t)

let () =
    run ();
    never_returns (Scheduler.go ())
