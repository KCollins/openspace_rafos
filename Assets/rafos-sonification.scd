(
// To run this example, click this line and press CTRL + ENTER on the keyboard
// When finished, press CTRL + . on you keyboard simultaneously to stop the sonification



/*****************************************************************************************
 * DEBUGGING VERSION: 5 Buoys Sonification
 ****************************************************************************************/

s.quit;
o = Server.default.options;

// 0: Stereo (Binaurual), 1: VisC Dome, 2: Hayden
~setup = 0;

if((~setup == 0), {~numSpeakerChannels = 2; "Mode: Stereo/Binaural".postln;});
if((~setup == 1), {~numSpeakerChannels = 8; "Mode: VisC Dome".postln;});
if((~setup == 2), {~numSpeakerChannels = 32; "Mode: Hayden".postln;});

o.numOutputBusChannels = ~numSpeakerChannels;

// Setup the buoy names
// Update these to match the Identifiers in your OpenSpace Asset files
~buoyLabels = [
    'FloatPosition_rafos1060',
    'FloatPosition_rafos1134',
    'FloatPosition_rafos1232',
    'FloatPosition_rafos1455',
    'FloatPosition_rafos1496'
];
~numBuoys = ~buoyLabels.size;

s.reboot;

s.waitForBoot{
	var loadSynths = {
		"1. Loading SynthDefs...".postln;
		SynthDef(\synth, {
			arg out=0, gate=1, mamp=5, amp=0, baseAmp=1, freq=400, phase=0, mute=1;
			var sig, env, t_gate;

			t_gate = gate * LFPulse.kr(0.2, phase);
			env = EnvGen.kr(Env.perc(0.01, 1/0.5), t_gate, doneAction: 0);

			sig = BrownNoise.ar(1);
			sig = (BPF.ar(sig, freq*2, 0.004) * 50);
			sig = mamp * sig;

			sig = mute.lag(5) * (baseAmp * amp) * sig * env;

			Out.ar(out, sig);
		}).add;

		~order = 2;
		~numChannels = ((~order + 1)**2).asInteger;

		SynthDef.new(\binauralDecoder, { | bus, out = 0 |
			Out.ar(out, VSTPlugin.ar(In.ar(bus, ~numChannels), 2));
		}).add;
		SynthDef.new(\stereoEncoder, { | bus = 0 |
			ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, 2), ~numChannels));
		}).add;
		SynthDef.new(\ambiThrow, { | from, to |
			Out.ar(to, In.ar(from, ~numChannels));
		}).add;
		"   - Synths Loaded.".postln;
	};

	var initiateAmbisonic = {
		"2. Initiating Ambisonic Bus...".postln;
		~ambiMasterBus = Bus.audio(s, ~numChannels);
		~ambiMasterGroup = Group.new;

		~decoder = VSTPluginController(Synth(\binauralDecoder, [\bus, ~ambiMasterBus, \out, 0], target: ~ambiMasterGroup, addAction: \addToTail)).open("BinauralDecoder");

		"   - Ambisonic System Ready.".postln;
	};

	var initiateSynths = {
		"3. Creating Synths for 5 Buoys...".postln;
		~ambiBus = Array.newClear(~numBuoys);
		~ambiGroup = Array.newClear(~numBuoys);
		~encoder = Array.newClear(~numBuoys);
		~sounds = Array.newClear(~numBuoys);
		~lastDistances = Array.fill(~numBuoys, { 0 }); // For debugging

		~buoyLabels.do({ |label, i|
			~ambiBus[i] = Bus.audio(s, ~numChannels);
			~ambiGroup[i] = Group.before(~ambiMasterGroup);

			~sounds[i] = Synth.new(\synth, [
				\out, ~ambiBus[i],
				\freq, 200 + (i * 80),
				\phase, (i * 0.15) % 1.0,
				\baseAmp, 0.3,
				\mute, 1
			], ~ambiGroup[i], addAction: \addToHead);

			~encoder[i] = VSTPluginController(Synth(\stereoEncoder, [\bus, ~ambiBus[i]], target: ~ambiGroup[i], addAction: \addToTail));
			~encoder[i].open("StereoEncoder");

			Synth(\ambiThrow, [\from, ~ambiBus[i], \to, ~ambiMasterBus], target: ~ambiGroup[i], addAction: \addToTail);
			("   - Initialized: " ++ label).postln;
		});
	};

	var oscDef = {
		"4. Setting up OSC Listeners...".postln;
		~modeElSign = 1;
		~modeElPhase = 0.5;
		~distanceLimit = 10;
		~ambientAmp = 0.1;

		~buoyLabels.do({ |label, i|
			OSCdef.new(label, { arg msg;
				var distance, azimuth, elevation, amp;

				// Standard OpenSpace telemetry: [path, distance, azimuth, elevation]
				distance = msg[1]/10000;
				azimuth = (msg[2]/(2*pi))+0.5;
				elevation = ~modeElSign*(msg[3]/(2*pi))+~modeElPhase;

				if((distance < ~distanceLimit),
					{ amp = LinLin.kr(distance, 0, ~distanceLimit, 0, 1); },
					{ amp = ~ambientAmp; }
				);

				~sounds[i].set(\amp, amp);
				~encoder[i].do(_.set(6, azimuth));
				~encoder[i].do(_.set(7, elevation));

				// Store distance for the heartbeat logger
				~lastDistances[i] = distance;
			}, label);
		});
		"   - OSC Listeners Active.".postln;
	};

	// A debug loop that prints data every 2 seconds so you know if data is flowing
	var startDebugger = {
		Tdef(\telemetryCheck, {
			loop {
				"--- Telemetry Heartbeat ---".postln;
				~buoyLabels.do({ |label, i|
					(label.asString ++ " Dist: " ++ ~lastDistances[i].round(0.01)).postln;
				});
				2.0.wait;
			}
		}).play;
	};

	~startRoutine = Routine({
		0.5.wait;
		loadSynths.value;
		0.3.wait;
		initiateAmbisonic.value;
		0.3.wait;
		initiateSynths.value;
		0.2.wait;
		oscDef.value;
		0.2.wait;
		startDebugger.value;
		" ".postln;
		"---------- Sonification is ready ----------".postln;
		"Check below for live buoy distance data...".postln;
	}).play(AppClock);
}
)