// Uncomment if you want to use Ableton Live (you need LiveOsc)
// thisProcess.openUDPPort(9001);
// ~live = NetAddr("localhost", 9000);
//
// ~liveTempo = OSCdef("tempo", { arg msg, time, addr, recvPort;
// 	t.tempo = msg[1] / 60;
// 	("Live tempo: " + msg[1]).postln;
// }, '/live/tempo');
//
// ~live.sendMsg("/live/play");
//
// ~livePlay = OSCdef("play", { arg msg, time, addr, recvPort;
// 	if(msg[1] == 2, {
// 		~r1.reset; ~r2.reset; ~r3.reset; ~r4.reset; ~r5.reset; ~stepCounter.reset;
// 		"Live is playing".postln;
// 	});
// }, '/live/play');


// MIDI Clock
/*~midiClock = MIDIClockOut(d.virtualANames[\deviceName], d.virtualANames[\portName], t);
~midiClock.start;*/

t.tempo = 45/60;
