(** Transforms red/green/blue values, hsync, and vsync into the format used by
    the Tiny VGA pinout.

    https://tinytapeout.com/specs/pinouts/#vga-output *)

open! Core
open Hardcaml

module I : sig
  type 'a t =
    { r : 'a [@bits 2]
    ; g : 'a [@bits 2]
    ; b : 'a [@bits 2]
    ; hsync : 'a
    ; vsync : 'a
    }
end

module O : sig
  type 'a t = { uo_out : 'a [@bits 8] }
end

val create : Signal.t I.t -> Signal.t O.t
