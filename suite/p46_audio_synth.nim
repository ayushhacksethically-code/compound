import std/osproc
#  Project 46: Audio Waveform Synthesizer
import math

proc generate_sine_wave(freq: float, duration: float) {.discardable.} =
  echo "Generating PCM audio sine wave frequency: " & $freq & " Hz"
  for i in 0 .. 3:
    var sample = sin(2.0 * PI * freq * (float(i) / 44100.0))
    echo "  Sample #" & $i & ": " & $sample

generate_sine_wave(440.0, 1.0)
