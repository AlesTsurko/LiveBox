~grainIcollector = Array.newClear(128);
~grainIIcollector = Array.newClear(128);

MIDIdef.noteOn("keys", {arg vel, note, ch, id;
	// first synth
	if((id == d.virtualA).and(ch == 0).and(s.numSynths <= 40), {
		~grainIcollector[note] = Synth("granulatorI", [\note, note]);
	});
	// second synth
	if((id == d.virtualB).and(ch == 0).and(s.numSynths <= 40),
		{~grainIIcollector[note] = Synth("granulatorII", [\note, note])});
});

MIDIdef.noteOff("keysOff", {arg vel, note, ch, id;
	// first synth
	if((id == d.virtualA).and(ch == 0),
		{~grainIcollector[note].release});
	// second synth
	if((id == d.virtualB).and(ch == 0),
		{~grainIIcollector[note].release});
});