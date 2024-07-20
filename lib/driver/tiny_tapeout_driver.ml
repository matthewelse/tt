open! Core

let preamble =
  {|/*
 * Copyright (c) 2024 Matthew Else
 * SPDX-Licence-Identifier: Apache-2.0
 */
|}
;;

let command =
  Command.basic
    ~summary:"Generate RTL for the tiny tapeout program."
    [%map_open.Command
      let () = return () in
      fun () ->
        print_endline preamble;
        Hardcaml.Rtl.print Verilog Tiny_tapeout.circuit]
;;
