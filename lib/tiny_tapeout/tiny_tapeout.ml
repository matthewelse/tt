open! Core
open Hardcaml
open Signal

module I = struct
  type 'a t =
    { ui_in : 'a [@bits 8]
    ; uio_in : 'a [@bits 8]
    ; ena : 'a
    ; clk : 'a
    ; rst_n : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { uo_out : 'a [@bits 8]
    ; uio_out : 'a [@bits 8]
    ; uio_oe : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

include Circuit.With_interface (I) (O)

let stripes ({ ui_in = _; uio_in = _; ena = _; clk; rst_n } : _ I.t) : _ O.t =
  let%tydi { uo_out } = Stripes.create { clk; rst_n } |> Vga_output.create in
  { uo_out; uio_out = zero 8; uio_oe = zero 8 }
;;

let circuit = create_exn ~name:"tt_um_matthewelse" stripes
