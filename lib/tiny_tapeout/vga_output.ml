open! Core
open Hardcaml
open Signal

module I = struct
  type 'a t =
    { r : 'a [@bits 2]
    ; g : 'a [@bits 2]
    ; b : 'a [@bits 2]
    ; hsync : 'a
    ; vsync : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { uo_out : 'a [@bits 8] }
end

let create ({ r; g; b; hsync; vsync } : _ I.t) : _ O.t =
  let uo_out =
    hsync @: bit b 0 @: bit g 0 @: bit r 0 @: vsync @: bit b 1 @: bit g 1 @: bit r 1
  in
  { uo_out }
;;
