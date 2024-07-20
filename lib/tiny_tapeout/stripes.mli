open! Core
open Hardcaml

module I : sig
  type 'a t =
    { clk : 'a
    ; rst_n : 'a
    }
end

module O = Vga_output.I

val create : Signal.t I.t -> Signal.t O.t
