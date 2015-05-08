~grainIcollector = Array.newClear(128);
~grainIIcollector = Array.newClear(128);

MIDIdef.noteOn("keys", {arg vel, note, ch, id;
	// first synth
	if((id == d.radium)
		.and(s.numSynths <= 40)
		.and(note < 60), {
		~grainIcollector[note] = Synth("granulatorI", [\note, note]);
	});
	// second synth
	if((id == d.radium)
		.and(s.numSynths <= 40)
		.and(note > 59),
		// [note - 24] - транспонирование, чтобы уровнять с гранулятор1, иначе
		// будет завышено.
		{~grainIIcollector[note-24] = Synth("granulatorII", [\note, note - 24])});
});

MIDIdef.noteOff("keysOff", {arg vel, note, ch, id;
	// first synth
	if((id == d.radium)
		.and(note < 60),
		{~grainIcollector[note].release});
	// second synth
	if((id == d.radium)
		.and(note > 59),
		{~grainIIcollector[note-24].release});
});