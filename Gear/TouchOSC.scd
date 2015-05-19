thisProcess.openUDPPort(23231);
~touchOSCFunction = OSCdef("TouchOSC", {arg msg, time, addr, recvPort;
	t.tempo = msg[1] / 60;
	("Tempo:" + msg[1].round(0.01)).postln;
}, '/tempo');