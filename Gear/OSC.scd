/*thisProcess.openUDPPort(9001);
~live = NetAddr("127.0.0.1", 9000);

~liveTempo = OSCdef("tempo", { arg msg, time, addr, recvPort;
	t.tempo = msg[1] / 60;
	},
	'/live/tempo');

~live.sendMsg("/live/tempo");*/

// ~livePlay = OSCdef("play", { arg msg, time, addr, recvPort;
// 	if(msg[1] == 2, {~r1.reset; ~r2.reset; ~r3.reset; ~r4.reset; ~r5.reset; ~stepCounter.reset;
// 	});
// 	},
// '/live/play');