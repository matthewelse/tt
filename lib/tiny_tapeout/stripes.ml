open! Core
open Hardcaml
open Signal

module I = struct
  type 'a t =
    { clk : 'a
    ; rst_n : 'a
    }
end

module O = Vga_output.I

let create ({ clk; rst_n } : _ I.t) : _ Vga_output.I.t =
  (* Direct translation of https://github.com/TinyTapeout/vga-playground/blob/main/src/examples/stripes/project.v *)
  let%tydi { hsync; vsync; display_on; hpos; vpos } =
    Hvsync_generator.create { clk; reset = ~:rst_n }
  in
  let counter =
    let counter_width = 10 in
    reg_fb ~width:counter_width (Reg_spec.create ~clock:vsync ()) ~f:(fun x ->
      mux2 ~:rst_n (zero counter_width) (x +:. 1))
  in
  let moving_x = hpos +: counter in
  let r = mux2 display_on (bit moving_x 5 @: bit vpos 2) (zero 2) in
  let g = mux2 display_on (bit moving_x 6 @: bit vpos 2) (zero 2) in
  let b = mux2 display_on (bit moving_x 7 @: bit vpos 5) (zero 2) in
  { r; g; b; hsync; vsync }
;;
