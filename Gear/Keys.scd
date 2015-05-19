~grainIcollector = Array.newClear(128);
~grainIIcollector = Array.newClear(128);

MIDIdef.noteOn("keys", {arg vel, note, ch, id;
	// first synth
	if((id == d.radium)
		.and(s.numSynths <= 40)
		.and(note < 60),
		// [note + 12] - транспонирование
		{~grainIcollector[note + 12] = Synth("granulatorI", [\note, note + 12]);
	});
	// second synth
	if((id == d.radium)
		.and(s.numSynths <= 40)
		.and(note > 59),
		// [note - 12] - транспонирование
		{~grainIIcollector[note-12] = Synth("granulatorII", [\note, note-12])});
});

MIDIdef.noteOff("keysOff", {arg vel, note, ch, id;
	// first synth
	if((id == d.radium)
		.and(note < 60),
		{~grainIcollector[note + 12].release});
	// second synth
	if((id == d.radium)
		.and(note > 59),
		{~grainIIcollector[note-12].release});
});