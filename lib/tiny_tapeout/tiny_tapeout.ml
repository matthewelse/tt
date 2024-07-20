open! Core
open Hardcaml
open Signal

module Input = struct
  type 'a t =
    { ui_in : 'a [@bits 8]
    ; uio_in : 'a [@bits 8]
    ; ena : 'a
    ; clk : 'a
    ; rst_n : 'a
    }
  [@@deriving hardcaml]
end

module Output = struct
  type 'a t =
    { uo_out : 'a [@bits 8]
    ; uio_out : 'a [@bits 8]
    ; uio_oe : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

let create (i : _ Input.t) : _ Output.t =
  { uo_out = i.ui_in +: i.uio_in; uio_out = zero 8; uio_oe = zero 8 }
;;

module Circuit = Circuit.With_interface (Input) (Output)

let circuit = Circuit.create_exn ~name:"tt_um_matthewelse" create
