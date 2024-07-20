(** Generates a signal for a VGA (640x480) display. *)

open! Core
open Hardcaml

module Input : sig
  type 'a t =
    { clk : 'a
    ; reset : 'a
    }
  [@@deriving hardcaml]
end

module Output : sig
  type 'a t =
    { hsync : 'a
    ; vsync : 'a
    ; display_on : 'a
    ; hpos : 'a [@bits 10]
    ; vpos : 'a [@bits 10]
    }
  [@@deriving hardcaml]
end

val create : Signal.t Input.t -> Signal.t Output.t
