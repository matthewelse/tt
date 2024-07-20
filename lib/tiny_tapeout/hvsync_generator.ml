open! Core
open Hardcaml
open Signal

module Input = struct
  type 'a t =
    { clk : 'a
    ; reset : 'a
    }
  [@@deriving hardcaml]
end

module Output = struct
  type 'a t =
    { hsync : 'a
    ; vsync : 'a
    ; display_on : 'a
    ; hpos : 'a [@bits 10]
    ; vpos : 'a [@bits 10]
    }
  [@@deriving compare, hardcaml]
end

module Vertical = struct
  let visible_height = 480
  let bottom_porch = 10
  let top_porch = 33
  let sync_pulse = 2
  let total_height = visible_height + bottom_porch + top_porch + sync_pulse
end

module Horizontal = struct
  let visible_width = 640
  let back_porch = 48
  let front_porch = 16
  let sync_pulse = 96
  let total_width = visible_width + back_porch + front_porch + sync_pulse
end

let hsync (i : _ Input.t) =
  let reg_spec = Reg_spec.create ~clear:i.reset ~clock:i.clk () in
  let hpos =
    reg_fb reg_spec ~width:10 ~f:(fun hpos ->
      mux2 (hpos ==:. Horizontal.total_width - 1) (zero 10) (hpos +:. 1))
  in
  let hsync =
    (* reg
       reg_spec *)
    hpos
    >=:. Horizontal.visible_width + Horizontal.front_porch
    &&: (hpos
         <=:. Horizontal.visible_width
              + Horizontal.front_porch
              + Horizontal.sync_pulse
              - 1)
  in
  hpos, hsync
;;

let create (i : _ Input.t) : _ Output.t =
  let reg_spec = Reg_spec.create ~clear:i.reset ~clock:i.clk () in
  let hpos, hsync = hsync i in
  let vpos =
    reg_fb reg_spec ~width:10 ~f:(fun vpos ->
      let next_vpos = mux2 (vpos ==:. Vertical.total_height - 1) (zero 10) (vpos +:. 1) in
      mux2 (hpos ==:. Horizontal.total_width - 1) next_vpos vpos)
  in
  let vsync =
    (* reg
       reg_spec *)
    vpos
    >=:. Vertical.visible_height + Vertical.bottom_porch
    &&: (vpos
         <=:. Vertical.visible_height + Vertical.bottom_porch + Vertical.sync_pulse - 1)
  in
  let display_on =
    hpos <:. Horizontal.visible_width &&: (vpos <:. Vertical.visible_height)
  in
  { hsync; vsync; display_on; hpos; vpos }
;;

let%expect_test _ =
  let module Simulator = Cyclesim.With_interface (Input) (Output) in
  let sim = Simulator.create create in
  let inputs : _ Input.t = Cyclesim.inputs sim in
  let output = Cyclesim.outputs sim in
  inputs.reset := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.reset := Bits.gnd;
  for _i = 0 to 10 do
    let visible_pixels = ref 0 in
    for y = 0 to 525 - 1 do
      for x = 0 to 800 - 1 do
        let expected_display_on = x < 640 && y < 480 in
        let expected_hsync = x >= 640 + 16 && x < 640 + 16 + 96 in
        let expected_vsync = y >= 480 + 10 && y < 480 + 10 + 2 in
        let expected : Bits.t Output.t =
          { vpos = Bits.of_int ~width:10 y
          ; hpos = Bits.of_int ~width:10 x
          ; hsync = Bits.of_bool expected_hsync
          ; vsync = Bits.of_bool expected_vsync
          ; display_on = Bits.of_bool expected_display_on
          }
        in
        if expected_display_on then incr visible_pixels;
        let real_output = Output.map ~f:Ref.( ! ) output in
        if not ([%compare.equal: Bits.t Output.t] expected real_output)
        then
          raise_s
            [%message
              "Expected output did not equal the real output"
                (x : int)
                (y : int)
                (expected : Bits.t Output.t)
                (real_output : Bits.t Output.t)];
        Cyclesim.cycle sim
      done
    done;
    let expected_visible_pixels = 640 * 480 in
    let visible_pixels = !visible_pixels in
    print_s [%message "" (expected_visible_pixels : int) (visible_pixels : int)];
    [%expect {| ((expected_visible_pixels 307200) (visible_pixels 307200)) |}]
  done
;;
