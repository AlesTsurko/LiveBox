~arm1 = 0;
~lpswtch = Array.fill(128, 0);
~lprecbutnum = Array.fill(128, 0);
~seqNoteDurs = [1/4, 1/8, 1/16, 1/32, 1/64] * 4;
~seqNoteDurCurrent = ~seqNoteDurs[2];

~recOn1 = Task({
	inf.do({
		d.launchPadSOut.noteOn(0, 107, 15);
		0.85.wait;
		d.launchPadSOut.noteOn(0, 107, 16);
		0.15.wait;
	});
});

MIDIdef.noteOn("LPRecMode", {arg vel, note, ch, id;

	if((id == d.launchPadS).and(note == 107).and(~mode == ~user1), {
		switch(~arm1,
			0, {if(~recOn1.isPlaying == false, {~recOn1.play});
				~arm1 = 1},
			1, {d.launchPadSOut.noteOn(0, 107, 16);
				if(~recOn1.isPlaying, {~recOn1.stop});
				~arm1 = 0});
	});

	if((id == d.launchPadS).and(note == 107).and(~mode == ~user2), {
		switch(~arm2,
			0, {if(~recOn2.isPlaying == false, {~recOn2.play});
				~arm2 = 1},
			1, {d.launchPadSOut.noteOn(0, 107, 16);
				if(~recOn2.isPlaying, {~recOn2.stop});
				~arm2 = 0});
	});
});

~octRandUp = "off";
~octRandDown = "off";
~direction1 = 1;
~direction2 = 1;
~mode = 0;

MIDIdef.cc("LPControl", {arg val, num, ch, id;
	if((id == d.launchPadS).and(num == 109).and(~arm1 == 0), {~user1 = num; ~mode = ~user1;
		d.launchPadSOut.control(0, 0, 2);
		~layout = "drum-rack";
		~seq = "off";
		~steps = "off";
		if(~recOn2.isPlaying, {~recOn2.stop});
		(102..106).do({arg i; d.launchPadSOut.noteOn(0, i, 29)});
		~seqNoteDurs.do({arg i, n;
			if(i == ~seqNoteDurCurrent, {d.launchPadSOut.noteOn(0, 102 + n, 63)});
		});
		d.launchPadSOut.noteOn(0, 107, 16);
		(52..67).do({arg note; d.launchPadSOut.noteOn(0, note, 17)});
		(84..99).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(36..51).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(68..83).do({arg note; d.launchPadSOut.noteOn(0, note, 1)});
		~lpswtch.do({arg item, i;
			if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 48)})});

		if(~octRandUp == "off", {d.launchPadSOut.control(0, 104, 19); ~contbox.set(\roct2, 1)});
		if(~octRandUp == "on", {d.launchPadSOut.control(0, 104, 63)});
		if(~octRandDown == "off", {d.launchPadSOut.control(0, 105, 19); ~contbox.set(\roct2, 1)});
		if(~octRandDown == "on", {d.launchPadSOut.control(0, 105, 63)});

		if(~direction1 == 1, {
			d.launchPadSOut.control(0, 106, 19);
			d.launchPadSOut.control(0, 107, 63);
			~contbox.set(\direction1, ~direction1)});

		if(~direction1 == -1, {
			d.launchPadSOut.control(0, 106, 63);
			d.launchPadSOut.control(0, 107, 19);
			~contbox.set(\direction1, ~direction1)});

	});

	if((id == d.launchPadS).and(num == 109).and(~arm1 == 1), {~user1 = num; ~mode = ~user1;
		d.launchPadSOut.control(0, 0, 2);
		~layout = "drum-rack";
		~seq = "off";
		~steps = "off";
		if(~recOn1.isPlaying == false, {~recOn1.play});
		(102..106).do({arg i; d.launchPadSOut.noteOn(0, i, 29)});
		~seqNoteDurs.do({arg i, n;
			if(i == ~seqNoteDurCurrent, {d.launchPadSOut.noteOn(0, 102 + n, 63)});
		});
		(52..67).do({arg note; d.launchPadSOut.noteOn(0, note, 17)});
		(84..99).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(36..51).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(68..83).do({arg note; d.launchPadSOut.noteOn(0, note, 1)});
		~lprecbutnum.do({arg item, i;
			if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 15)});
		});
		~lpswtch.do({arg item, i;
			if((item == 1).and(~lprecbutnum[i] != 1), {d.launchPadSOut.noteOn(0, i + 36, 48)});
		});

		if(~octRandUp == "off", {d.launchPadSOut.control(0, 104, 19); ~contbox.set(\roct2, 1)});
		if(~octRandUp == "on", {d.launchPadSOut.control(0, 104, 63)});
		if(~octRandDown == "off", {d.launchPadSOut.control(0, 105, 19); ~contbox.set(\roct2, 1)});
		if(~octRandDown == "on", {d.launchPadSOut.control(0, 105, 63)});

		if(~direction1 == 1, {
			d.launchPadSOut.control(0, 106, 19);
			d.launchPadSOut.control(0, 107, 63);
			~contbox.set(\direction1, ~direction1)});

		if(~direction1 == -1, {
			d.launchPadSOut.control(0, 106, 63);
			d.launchPadSOut.control(0, 107, 19);
			~contbox.set(\direction1, ~direction1)});


	});

	if((id == d.launchPadS).and(num == 110).(~arm2 == 0), {~user2 = num; ~mode = ~user2;
		d.launchPadSOut.control(0, 0, 2);
		~layout = "drum-rack";
		~seq = "off";
		~steps = "off";
		(100..102).do({arg i; d.launchPadSOut.noteOn(0, i, 30)});
		(102..106).do({arg i; d.launchPadSOut.noteOn(0, i, 29)});
		~seqNoteDurs.do({arg i, n;
			if(i == ~seqNoteDurCurrent, {d.launchPadSOut.noteOn(0, 102 + n, 63)});
		});
		if(~recOn1.isPlaying, {~recOn1.stop});
		d.launchPadSOut.noteOn(0, 107, 16);
		(52..67).do({arg note; d.launchPadSOut.noteOn(0, note, 17)});
		(84..99).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(36..51).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(68..83).do({arg note; d.launchPadSOut.noteOn(0, note, 1)});
		~lpswtch2.do({arg item, i;
			if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 48)});
		});

		if(~octRandUp == "off", {d.launchPadSOut.control(0, 104, 19); ~contbox.set(\roct2, 1)});
		if(~octRandUp == "on", {d.launchPadSOut.control(0, 104, 63)});
		if(~octRandDown == "off", {d.launchPadSOut.control(0, 105, 19); ~contbox.set(\roct2, 1)});
		if(~octRandDown == "on", {d.launchPadSOut.control(0, 105, 63)});

		if(~direction2 == 1, {
			d.launchPadSOut.control(0, 106, 19);
			d.launchPadSOut.control(0, 107, 63);
			~contbox.set(\direction2, ~direction2)});

		if(~direction2 == -1, {
			d.launchPadSOut.control(0, 106, 63);
			d.launchPadSOut.control(0, 107, 19);
			~contbox.set(\direction2, ~direction2)});

	});

	if((id == d.launchPadS).and(num == 110).and(~arm2 == 1), {~user2 = num; ~mode = ~user2;
		d.launchPadSOut.control(0, 0, 2);
		~layout = "drum-rack";
		~seq = "off";
		~steps = "off";
		(100..102).do({arg i; d.launchPadSOut.noteOn(0, i, 30)});
		(102..106).do({arg i; d.launchPadSOut.noteOn(0, i, 29)});
		~seqNoteDurs.do({arg i, n;
			if(i == ~seqNoteDurCurrent, {d.launchPadSOut.noteOn(0, 102 + n, 63)});
		});
		if(~recOn2.isPlaying == false, {~recOn2.play});
		(52..67).do({arg note; d.launchPadSOut.noteOn(0, note, 17)});
		(84..99).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(36..51).do({arg note; d.launchPadSOut.noteOn(0, note, 16)});
		(68..83).do({arg note; d.launchPadSOut.noteOn(0, note, 1)});
		~lprecbutnum2.do({arg item, i;
			if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 15)});
		});
		~lpswtch2.do({arg item, i;
			if((item == 1).and(~lprecbutnum2[i] != 1), {d.launchPadSOut.noteOn(0, i + 36, 48)});
		});

		if(~octRandUp == "off", {d.launchPadSOut.control(0, 104, 19); ~contbox.set(\roct2, 1)});
		if(~octRandUp == "on", {d.launchPadSOut.control(0, 104, 63)});
		if(~octRandDown == "off", {d.launchPadSOut.control(0, 105, 19); ~contbox.set(\roct2, 1)});
		if(~octRandDown == "on", {d.launchPadSOut.control(0, 105, 63)});

		if(~direction2 == 1, {
			d.launchPadSOut.control(0, 106, 19);
			d.launchPadSOut.control(0, 107, 63);
			~contbox.set(\direction2, ~direction2)});

		if(~direction2 == -1, {
			d.launchPadSOut.control(0, 106, 63);
			d.launchPadSOut.control(0, 107, 19);
			~contbox.set(\direction2, ~direction2)});

	});

	if((id == d.launchPadS).and(num == 104).and(
		(~mode == ~user1).or(~mode == ~user2)
		).and(val == 127),
		{
			switch(~octRandUp,
				"on", {~octRandUp = "off";
					d.launchPadSOut.control(0, 104, 19);
					~contbox.set(\roct2, 1);
				},
				"off", {~octRandUp = "on"; d.launchPadSOut.control(0, 104, 63)});

	});

	if((id == d.launchPadS).and(num == 105).and(
		(~mode == ~user1).or(~mode == ~user2)
		).and(val == 127),
		{
			switch(~octRandDown,
				"on", {~octRandDown = "off";
					d.launchPadSOut.control(0, 105, 19);
					~contbox.set(\roct2, 1);
				},
				"off", {~octRandDown = "on"; d.launchPadSOut.control(0, 105, 63)});

	});

	if((id == d.launchPadS).and(num == 106).and(~mode == ~user1).and(val == 127), {
		~direction1 = -1;
		d.launchPadSOut.control(0, 106, 63);
		d.launchPadSOut.control(0, 107, 19);
		~contbox.set(\direction1, ~direction1);
	});

	if((id == d.launchPadS).and(num == 106).and(~mode == ~user2).and(val == 127), {
		~direction2 = -1;
		d.launchPadSOut.control(0, 106, 63);
		d.launchPadSOut.control(0, 107, 19);
		~contbox.set(\direction2, ~direction2);
	});

	if((id == d.launchPadS).and(num == 107).and(~mode == ~user1).and(val == 127), {
		~direction1 = 1;
		d.launchPadSOut.control(0, 106, 19);
		d.launchPadSOut.control(0, 107, 63);
		~contbox.set(\direction1, ~direction1);
	});

	if((id == d.launchPadS).and(num == 107).and(~mode == ~user2).and(val == 127), {
		~direction2 = 1;
		d.launchPadSOut.control(0, 106, 19);
		d.launchPadSOut.control(0, 107, 63);
		~contbox.set(\direction2, ~direction2);
	});

	if((id == d.launchPadS).and((num == 108).or(num == 111)),
		{~mode = num; ~seq = "off"; ~steps = "off"});

	if((~direction1 == -1).and([106, 107, 109, 110].includes(num)).and(val == 127).and(
		(~mode == ~user1).or(~mode == ~user2)), {"GranulatorI reversed".postln});
	if((~direction2 == -1).and([106, 107, 109, 110].includes(num)).and(val == 127).and(
		(~mode == ~user1).or(~mode == ~user2)), {"GranulatorII reversed".postln});
	if((~octRandUp == "on").and(~octRandDown == "off").and([104, 105, 109, 110].includes(num)).and(val == 127).and(
		(~mode == ~user1).or(~mode == ~user2)),
		{"Octaves randomized to UP".postln});
	if((~octRandUp == "off").and(~octRandDown == "on").and([104, 105, 109, 110].includes(num)).and(val == 127).and(
		(~mode == ~user1).or(~mode == ~user2)),
		{"Octaves randomized to DOWN".postln});
	if((~octRandUp == "on").and(~octRandDown == "on").and([104, 105, 109, 110].includes(num)).and(val == 127).and(
		(~mode == ~user1).or(~mode == ~user2)),
		{"Octaves randomized to BOTH SIDES".postln});

});

// ---------------------------------------------------------------------------- SYNTH 1

MIDIdef.noteOn("LPNoteOnUser1", {arg vel, note, ch, id;

	if((id == d.launchPadS).and(~mode == ~user1).and(~arm1 == 1).and(
		~lprecbutnum.includes(1) == false).and(note >= 36).and(note <= 99).and(
			(~lpswtch.count({arg n; n == 1}) < 4).or(~lpswtch[note - 36] == 1)),

		{
			~recFileName = ~recfolder +/+ ("Recording-" ++ thisThread.seconds.asString).replace(".", "-") ++ ".wav";
			~predisk = Buffer.alloc(s, 65536, 1);
			~predisk.write(~recFileName, "wav", "int16", 0, 0, true);
			~recorder = Synth.tail(nil, "recorder", ["bufnum", ~predisk]);
			~pitcher = Synth("pitchtector");
			d.launchPadSOut.noteOn(0, note, 15);
			~lprecbutnum[note - 36] = 1;
	});

	if((id == d.launchPadS).and(~mode == ~user1).and(~arm1 == 0), {
		~lprecbutnum.do({arg item, i;
			if(item == 1, {
				Routine.run{
					~samples1[i + 1] = Buffer.read(s, ~recFileName);
					~lpswtch[i] = 1;
					c.pitcher.get({arg v; ~pitches1[i + 1] = v});
					s.wait;
					d.launchPadSOut.noteOn(0, i + 36, 48);

					~lpswtch.do({arg item, i;
						var sw = 0;
						if((item == 1).and(~buttsCatLPs1.includes(i + 1) == false), {
							~buttsCatLPs1.do({arg cont, n;
								switch(sw,
									0, {if(cont == 0, {~buttsCatLPs1[n] = i + 1; sw = 1})},
									1, {~buttsCatLPs1[n].postln})});
							sw = 0});
					});
					~sampleNumber1 = ~buttsCatLPs1.as(Array);
					~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};

					~lprecbutnum[i] = 0;
					~recorder.free;
					~pitcher.free;
					~predisk.close;
					~predisk.free;
					~recFileName.free;
				};
			});
		});

		if(~lpswtch.count({arg n; n == 1}) < 4, {

			if((note >= 36).and(note <= 51), {

				switch(~lpswtch[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch[note - 36] = 1;

						~lpswtch.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs1.includes(i + 1) == false), {
								~buttsCatLPs1.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs1[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs1[n].postln})});
								sw = 0});
						});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 16); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});
			});

			if((note >= 52).and(note <= 67), {
				switch(~lpswtch[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch[note - 36] = 1;
						~lpswtch.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs1.includes(i + 1) == false), {
								~buttsCatLPs1.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs1[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs1[n].postln});
								});
								sw = 0});
						});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 17); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});
			});

			if((note >= 68).and(note <= 83), {
				switch(~lpswtch[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch[note - 36] = 1;
						~lpswtch.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs1.includes(i + 1) == false), {
								~buttsCatLPs1.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs1[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs1[n].postln})});
								sw = 0});
						});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 1); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});
			});

			if((note >= 84).and(note <= 99), {
				switch(~lpswtch[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch[note - 36] = 1;
						~lpswtch.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs1.includes(i + 1) == false), {
								~buttsCatLPs1.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs1[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs1[n].postln})});
								sw = 0});
						});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 16); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});
			});
			},

			{
				if((note >= 36).and(note <= 51).and(~lpswtch[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 16); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});

				if((note >= 52).and(note <= 67).and(~lpswtch[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 17); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});

				if((note >= 68).and(note <= 83).and(~lpswtch[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 1); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});

				if((note >= 84).and(note <= 99).and(~lpswtch[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 16); ~lpswtch[note - 36] = 0;
						~buttsCatLPs1.do({arg item, i; if(~lpswtch[item-1] == 0, {~buttsCatLPs1[i] = 0})});
						~sampleNumber1 = ~buttsCatLPs1.as(Array);
						~sampleNumber1.do{| item, i | if( item == 0) {~sampleNumber1.do{| a | if(a != 0) {~sampleNumber1[i] = a}}}};
				});
		});
	});

	~contbox.set(\b1, ~samples1[~sampleNumber1[0]].bufnum);
	~contbox.set(\b2, ~samples1[~sampleNumber1[1]].bufnum);
	~contbox.set(\b3, ~samples1[~sampleNumber1[2]].bufnum);
	~contbox.set(\b4, ~samples1[~sampleNumber1[3]].bufnum);

	~contbox.set(\p1, ~pitches1[~sampleNumber1[0]]);
	~contbox.set(\p2, ~pitches1[~sampleNumber1[1]]);
	~contbox.set(\p3, ~pitches1[~sampleNumber1[2]]);
	~contbox.set(\p4, ~pitches1[~sampleNumber1[3]]);

	if(~unpitched.includes(~sampleNumber1[0]), {~contbox.set(\st1, 0)}, {~contbox.set(\st1, 1)});
	if(~unpitched.includes(~sampleNumber1[1]), {~contbox.set(\st2, 0)}, {~contbox.set(\st2, 1)});
	if(~unpitched.includes(~sampleNumber1[2]), {~contbox.set(\st3, 0)}, {~contbox.set(\st3, 1)});
	if(~unpitched.includes(~sampleNumber1[3]), {~contbox.set(\st4, 0)}, {~contbox.set(\st4, 1)});

	// ~buttsCatLPs1.postln;
	// ~sampleNumber1.postln;
});

~arm2 = 0;
~lpswtch2 = Array.fill(128, 0);
~lprecbutnum2 = Array.fill(128, 0);

~recOn2 = Task({
	inf.do({
		if(~layout == "drum-rack", {d.launchPadSOut.noteOn(0, 107, 15)});
		if(~layout == "x/y", {d.launchPadSOut.noteOn(0, 120, 15)});
		0.85.wait;
		if(~layout == "drum-rack", {d.launchPadSOut.noteOn(0, 107, 16)});
		if(~layout == "x/y", {d.launchPadSOut.noteOn(0, 120, 16)});
		0.15.wait;
	});
});

// ---------------------------------------------------------------------------- SYNTH 2

MIDIdef.noteOn("LPNoteOnUser2", {arg vel, note, ch, id;

	if((id == d.launchPadS).and(~mode == ~user2).and(~arm2 == 0).and(~seq == "off").and(~steps == "off"), {
		~lprecbutnum2.do({arg item, i;
			if(item == 1, {
				Routine.run{
					~samples2[i + 1] = Buffer.read(s, ~recFileName2);
					~lpswtch2[i] = 1;
					c.pitcher2.get({arg v; ~pitches2[i + 1] = v});
					s.wait;
					d.launchPadSOut.noteOn(0, i + 36, 48);

					~lpswtch2.do({arg item, i;
						var sw = 0;
						if((item == 1).and(~buttsCatLPs2.includes(i + 1) == false), {
							~buttsCatLPs2.do({arg cont, n;
								switch(sw,
									0, {if(cont == 0, {~buttsCatLPs2[n] = i + 1; sw = 1})},
									1, {~buttsCatLPs2[n].postln})});
							sw = 0});
					});
					~sampleNumber2 = ~buttsCatLPs2.as(Array);
					~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};


					~lprecbutnum2[i] = 0;
					~recorder2.free;
					~pitcher2.free;
					~predisk2.close;
					~predisk2.free;
					~recFileName2.free;
				};
			});
		});

		if(~lpswtch2.count({arg n; n == 1}) < 4, {

			if((note >= 36).and(note <= 51), {

				switch(~lpswtch2[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch2[note - 36] = 1;

						~lpswtch2.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs2.includes(i + 1) == false), {
								~buttsCatLPs2.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs2[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs2[n].postln})});
								sw = 0});
						});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 16); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});
			});

			if((note >= 52).and(note <= 67), {
				switch(~lpswtch2[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch2[note - 36] = 1;
						~lpswtch2.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs2.includes(i + 1) == false), {
								~buttsCatLPs2.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs2[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs2[n].postln});
								});
								sw = 0});
						});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 17); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});
			});

			if((note >= 68).and(note <= 83), {
				switch(~lpswtch2[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch2[note - 36] = 1;
						~lpswtch2.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs2.includes(i + 1) == false), {
								~buttsCatLPs2.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs2[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs2[n].postln})});
								sw = 0});
						});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 1); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});
			});

			if((note >= 84).and(note <= 99), {
				switch(~lpswtch2[note - 36],
					0, {d.launchPadSOut.noteOn(0, note, 48); ~lpswtch2[note - 36] = 1;
						~lpswtch2.do({arg item, i;
							var sw = 0;
							if((item == 1).and(~buttsCatLPs2.includes(i + 1) == false), {
								~buttsCatLPs2.do({arg cont, n;
									switch(sw,
										0, {if(cont == 0, {~buttsCatLPs2[n] = i + 1; sw = 1})},
										1, {~buttsCatLPs2[n].postln})});
								sw = 0});
						});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
					},
					1, {d.launchPadSOut.noteOn(0, note, 16); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});
			});
			},

			{
				if((note >= 36).and(note <= 51).and(~lpswtch2[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 16); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});

				if((note >= 52).and(note <= 67).and(~lpswtch2[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 17); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});

				if((note >= 68).and(note <= 83).and(~lpswtch2[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 1); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});

				if((note >= 84).and(note <= 99).and(~lpswtch2[note - 36] == 1),
					{d.launchPadSOut.noteOn(0, note, 16); ~lpswtch2[note - 36] = 0;
						~buttsCatLPs2.do({arg item, i; if(~lpswtch2[item-1] == 0, {~buttsCatLPs2[i] = 0})});
						~sampleNumber2 = ~buttsCatLPs2.as(Array);
						~sampleNumber2.do{| item, i | if( item == 0) {~sampleNumber2.do{| a | if(a != 0) {~sampleNumber2[i] = a}}}};
				});
		});
	});

	if((id == d.launchPadS).and(~mode == ~user2).and(~arm2 == 1).and(~seq == "off").and(~steps == "off").and(
		~lprecbutnum2.includes(1) == false).and(note >= 36).and(note <= 99).and(
			(~lpswtch2.count({arg n; n == 1}) < 4).or(~lpswtch2[note - 36] == 1)),

		{
			~recFileName2 = ~recfolder +/+ ("Recording-" ++ thisThread.seconds.asString).replace(".", "-") ++ ".wav";
			~predisk2 = Buffer.alloc(s, 65536, 1);
			~predisk2.write(~recFileName2, "wav", "int16", 0, 0, true);
			~recorder2 = Synth.tail(nil, "recorder", ["bufnum", ~predisk2]);
			~pitcher2 = Synth("pitchtector2");
			d.launchPadSOut.noteOn(0, note, 15);
			~lprecbutnum2[note - 36] = 1;
	});

	~contbox.set(\b5, ~samples2[~sampleNumber2[0]].bufnum);
	~contbox.set(\b6, ~samples2[~sampleNumber2[1]].bufnum);
	~contbox.set(\b7, ~samples2[~sampleNumber2[2]].bufnum);
	~contbox.set(\b8, ~samples2[~sampleNumber2[3]].bufnum);

	~contbox.set(\p5, ~pitches2[~sampleNumber2[0]]);
	~contbox.set(\p6, ~pitches2[~sampleNumber2[1]]);
	~contbox.set(\p7, ~pitches2[~sampleNumber2[2]]);
	~contbox.set(\p8, ~pitches2[~sampleNumber2[3]]);

	if(~unpitched.includes(~sampleNumber2[0]), {~contbox.set(\st5, 0)}, {~contbox.set(\st5, 1)});
	if(~unpitched.includes(~sampleNumber2[1]), {~contbox.set(\st6, 0)}, {~contbox.set(\st6, 1)});
	if(~unpitched.includes(~sampleNumber2[2]), {~contbox.set(\st7, 0)}, {~contbox.set(\st7, 1)});
	if(~unpitched.includes(~sampleNumber2[3]), {~contbox.set(\st8, 0)}, {~contbox.set(\st8, 1)});
	// ~buttsCatLPs2.postln;
	// ~sampleNumber2.postln;

});

// ------------------------------------------------------------------------- SEQUENCER

~seq = "off";
~steps = "off";
~stepsNum = 120;
~seqSize = 64;
~layout = "drum-rack";
~modebtns = Array.newClear(8).seriesFill(8, 16).collect({arg n; n + (0..7)}).flat;
~sequence = Array.fill(127, 0);
~seqRoutInternal = Array.newClear(127);
~seqRoutInternalFiltered = ~seqRoutInternal.as(Array);
~sequenceToSynth = Array.newClear(127);
~seqCursor = (0..127);
~seqCursorFiltered = ~seqCursor.as(Array);
~routineStep = 0;
~ledDelay = 0;

~seqLedFeedback = {
	~sequenceToSynth = ~sequence.as(Array);
	~modebtns.do({arg i, n;
		if(~sequenceToSynth.size > (i - n), {~sequenceToSynth.removeAt(i - n)});
	});

	~seqRoutInternalFiltered = ~seqRoutInternal.as(Array);
	~modebtns.do({arg i, n;
		if(~seqRoutInternalFiltered.size > (i - n), {~seqRoutInternalFiltered.removeAt(i - n)});
	});

	~seqCursorFiltered = ~seqRoutInternal.as(Array);
	~seqCursorFiltered.do({arg i, n;
		if(i.isNumber, {~seqCursorFiltered[n] = nil},
			{~seqCursorFiltered[n] = n});
	});

	~modebtns.do({arg i, n;
		if(~seqCursorFiltered.size > (i - n), {~seqCursorFiltered.removeAt(i - n)});
	});
};

~seqLedFeedback.value;

~r1 = Routine.run({
	loop{
		~sequenceToSynth.lace(~seqSize).rotate(~routineStep).do({arg i, n;
			if(i == 1, {~contbox.set(\trigger, 1000.rand)});
			~routineStepExchange = n + 1;
			if((~octRandUp == "on").and(~octRandDown == "off"),
				{~contbox.set(\roct2, [1, 2, 4].choose)});
			if((~octRandDown == "on").and(~octRandUp == "off"),
				{~contbox.set(\roct2, [0.25, 0.5, 1].choose)});
			if((~octRandUp == "on").and(~octRandDown == "on"),
				{~contbox.set(\roct2, [0.25, 0.5, 1, 2, 4].choose)});

			~seqNoteDurCurrent.wait;
		});
	};
}, clock: t);

~r2 = Routine.run({
	loop{
		~seqRoutInternalFiltered.lace(~seqSize).rotate(~routineStep).do({arg i, n;
			if((i.isNumber).and(~seq == "on").and(~mode == ~user2), {d.launchPadSOut.noteOn(0, i, 27)});
			~seqNoteDurCurrent.wait;
		});
	};
}, clock: t);

~r3 = Routine.run({
	loop{
		var note = ~seqRoutInternalFiltered.lace(~seqSize).rotate(~routineStep).wrapAt(-1);

		if((note.isNumber).and(~seq == "on").and(~modebtns.includes(note) == false).and(~mode == ~user2),
			{d.launchPadSOut.noteOn(0, note, 60)});

		~seqRoutInternalFiltered.lace(~seqSize).rotate(~routineStep).do({arg i, n;

			~seqNoteDurCurrent.wait;
			if((i.isNumber).and(~seq == "on").and(~mode == ~user2), {d.launchPadSOut.noteOn(0, i, 60)});
		});
	};
}, clock: t);

~r4 = Routine.run({
	loop{
		~seqCursorFiltered.lace(~seqSize).rotate(~routineStep).do({arg i, n;
			if((i.isNumber).and(~seq == "on").and(~mode == ~user2), {d.launchPadSOut.noteOn(0, i, 58)});
			~seqNoteDurCurrent.wait;
		});
	};
}, clock: t);

~r5 = Routine.run({
	loop{
		var note = ~seqCursorFiltered.lace(~seqSize).rotate(~routineStep).wrapAt(-1);

		if((note.isNumber).and(~seq == "on").and(~modebtns.includes(note) == false).and(~mode == ~user2),
			{d.launchPadSOut.noteOn(0, note, 16)});

		~seqCursorFiltered.lace(~seqSize).rotate(~routineStep).do({arg i, n;
			~seqNoteDurCurrent.wait;
			if((i.isNumber).and(~seq == "on").and(~mode == ~user2), {d.launchPadSOut.noteOn(0, i, 16)});
		});
	};
}, clock: t);

MIDIdef.noteOn("Sequencer", {arg vel, note, ch, id;

	Routine.run({
		if((id == d.launchPadS).and(~mode == ~user2).and(
			(
				(note == 8).and(~seq == "on")
			).or(
				(note == 24).and(~steps == "on")
			)).and(~layout == "x/y"), {
				d.launchPadSOut.control(0, 0, 2); ~layout = "drum-rack";
				d.launchPadSOut.noteOn(0, 100, 30);
				d.launchPadSOut.noteOn(0, 101, 30);

				if(~arm2 == 0, {
					if(~recOn1.isPlaying, {~recOn1.stop});
					d.launchPadSOut.noteOn(0, 107, 16);
					(52..67).do({arg n; d.launchPadSOut.noteOn(0, n, 17)});
					(84..99).do({arg n; d.launchPadSOut.noteOn(0, n, 16)});
					(36..51).do({arg n; d.launchPadSOut.noteOn(0, n, 16)});
					(68..83).do({arg n; d.launchPadSOut.noteOn(0, n, 1)});
					~lpswtch2.do({arg item, i;
						if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 48)});
					});
				});

				if(~arm2 == 1, {
					if(~recOn2.isPlaying == false, {~recOn2.play});
					(52..67).do({arg n; d.launchPadSOut.noteOn(0, n, 17)});
					(84..99).do({arg n; d.launchPadSOut.noteOn(0, n, 16)});
					(36..51).do({arg n; d.launchPadSOut.noteOn(0, n, 16)});
					(68..83).do({arg n; d.launchPadSOut.noteOn(0, n, 1)});
					~lprecbutnum2.do({arg item, i;
						if(item == 1, {d.launchPadSOut.noteOn(0, i + 36, 15)});
					});
					~lpswtch2.do({arg item, i;
						if((item == 1).and(~lprecbutnum2[i] != 1), {d.launchPadSOut.noteOn(0, i + 36, 48)});
					});
				});

				~seq = "off";
				~steps = "off"});

		if((id == d.launchPadS).and(~mode == ~user2).and(
			~layout == "x/y").and(~seq == "on").and(
				~modebtns.includes(note) == false).and(note < ~stepsNum), {
				var flash;

				flash = Routine.run({
					loop{
						if((~mode == ~user2).and(~layout == "x/y").and(~seq == "on"), {
							d.launchPadSOut.noteOn(0, note, 60);
						});
						0.1.wait;
						if((~mode == ~user2).and(~layout == "x/y").and(~seq == "on"), {
							d.launchPadSOut.noteOn(0, note, 16);
						});
						0.1.wait;
					};
				});

				~ledDelay = ~ledDelay + ~seqNoteDurCurrent;

				Routine({
					~ledDelay.wait;

					Routine({
						switch(~sequence[note],
							0, {~sequence[note] = 1; ~seqRoutInternal[note] = note;
								if((~mode == ~user2).and(~layout == "x/y").and(~seq == "on"), {
									d.launchPadSOut.noteOn(0, note, 60)});
							},
							1, {~sequence[note] = 0; ~seqRoutInternal[note] = nil;
								if((~mode == ~user2).and(~layout == "x/y").and(~seq == "on"), {
									d.launchPadSOut.noteOn(0, note, 16)});
						});

						~routineStep = ~routineStep - ~routineStepExchange;

						~r1.reset; ~r2.reset; ~r3.reset; ~r4.reset; ~r5.reset; flash.stop;

						~seqLedFeedback.value;
						~ledDelay = ~ledDelay - ~seqNoteDurCurrent;
					}).play(t, ~seqNoteDurCurrent);
				}).play(t);
		});

		s.wait;

		if((id == d.launchPadS).and(~mode == ~user2).and(
			((note == 100).and(~layout == "drum-rack")).or(
				(note == 8).and(~layout == "x/y")))	, {

				d.launchPadSOut.control(0, 0, 1); ~layout = "x/y";
				d.launchPadSOut.noteOn(0, 8, 63); ~seq = "on";
				d.launchPadSOut.noteOn(0, 24, 30); ~steps = "off";

				~stepsNum.do({arg n;
					if(~modebtns.includes(n) == false, {
						d.launchPadSOut.noteOn(0, n, 16)});
				});

				if((~stepsNum != 120).and(~stepsNum != 0), {
					(~stepsNum..120).do({arg n;
						if(~modebtns.includes(n) == false, {
							d.launchPadSOut.noteOn(0, n, 0);
						});
					});
				});

				~sequence.lace(~stepsNum).do({arg i, n; if(i == 1, {d.launchPadSOut.noteOn(0, n, 60)})});

				~seqLedFeedback.value;
		});

	});

	Routine.run({

		if((id == d.launchPadS).and(~mode == ~user2).and(
			~modebtns.includes(note) == false).and(~layout == "x/y").and(~steps == "on"), {
				~stepsNum = note + 1;

				~stepsNum.do({arg n;
					if(~modebtns.includes(n) == false, {
						d.launchPadSOut.noteOn(0, n, 16);
					});
				});

				if((~stepsNum != 120).and(~stepsNum != 0), {
					(~stepsNum..120).do({arg n;
						if(~modebtns.includes(n) == false, {
							d.launchPadSOut.noteOn(0, n, 0);
						});
					});
				});

				~seqSize = (((~stepsNum.roundUp(8) / 2) - 4) + ((~stepsNum - 1)%8 + 1)).asInteger;

				~r1.reset; ~r2.reset; ~r3.reset; ~r4.reset; ~r5.reset; ~stepCounter.reset;

				("Steps number changed to: " + ~seqSize.asString).postln;
		});

		s.wait;

		if((id == d.launchPadS).and(~mode == ~user2).and(
			((note == 24).and(~layout == "x/y")).or((note == 101).and(~layout == "drum-rack"))), {
				d.launchPadSOut.control(0, 0, 1); ~layout = "x/y";
				~steps = "on"; d.launchPadSOut.noteOn(0, 24, 63);
				~seq = "off"; d.launchPadSOut.noteOn(0, 8, 30);
				~stepsNum.do({arg n;
					if(~modebtns.includes(n) == false, {
						d.launchPadSOut.noteOn(0, n, 16);
					});
				});

				if((~stepsNum != 120).and(~stepsNum != 0), {
					(~stepsNum..120).do({arg n;
						if(~modebtns.includes(n) == false, {
							d.launchPadSOut.noteOn(0, n, 0);
						});
					});
				});
		});
	});

	// Durations
	if((id == d.launchPadS).and(
		(~mode == ~user1).or(~mode == ~user2)
		).and(~layout == "drum-rack").and((102..106).includes(note)), {
			d.launchPadSOut.noteOn(0, note, 63);
			(102..106).do({arg i, n;
				if(note == i, {~seqNoteDurCurrent = ~seqNoteDurs[n]},
					{d.launchPadSOut.noteOn(0, i, 29)});
			});
	});

	if((id == d.launchPadS).and(
		(~seq == "on").or(~steps == "on")
		).and(~layout == "x/y").and([40, 56, 72, 88, 104].includes(note)), {
			d.launchPadSOut.noteOn(0, note, 63);
			[40, 56, 72, 88, 104].do({arg i, n;
				if(note == i, {~seqNoteDurCurrent = ~seqNoteDurs[n]},
					{d.launchPadSOut.noteOn(0, i, 29)});
			});
	});
});