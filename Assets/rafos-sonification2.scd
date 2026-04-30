(
// 1. Setup the server and labels
s.reboot;

~buoyLabels = [
    "FloatPosition_rafos1060",
    "FloatPosition_rafos1134",
    "FloatPosition_rafos1232",
    "FloatPosition_rafos1455",
    "FloatPosition_rafos1496"
];

s.waitForBoot({
    // 2. Define a simpler, louder sound
    SynthDef(\buoySound, {
        arg out=0, freq=440, amp=0, gate=1;
        var env = EnvGen.kr(Env.perc(0.05, 0.5), Impulse.kr(1)); // 1 beat per second
        var sig = SinOsc.ar(freq) * env * amp;
        Out.ar(out, sig ! 2); // Stereo output
    }).add;

    s.sync;

    // 3. Create the synth instances
    ~buoys = Array.newClear(~buoyLabels.size);
    ~buoyLabels.do({ |label, i|
        ~buoys[i] = Synth(\buoySound, [\freq, 200 + (i * 100), \amp, 0]);
    });

    // 4. The OSC Listener
    ~buoyLabels.do({ |label, i|
        OSCdef.new(label.asSymbol, { |msg|
            var distance = msg[1];
            var amp;

            // Debug print: Remove the '//' below to see data in the console
            // (label + "Distance:" + distance).postln;

            // Mapping: Full volume at 0 meters, silent at 500,000 meters (500km)
            amp = distance.linlin(0, 500000, 0.8, 0.0);

            ~buoys[i].set(\amp, amp);
        }, ('/' ++ label).asSymbol);
    });

    "--- SYSTEM READY ---".postln;
    "Use the code blocks below to test if you can't hear anything.".postln;
});
)

/* --- MANUAL TEST BLOCKS --- */

// TEST 1: Run this to force Buoy 0 to be audible.
// If you hear a beep, your SuperCollider audio is fine.
~buoys[0].set(\amp, 0.5);

// TEST 2: Run this to silence it again.
~buoys[0].set(\amp, 0);