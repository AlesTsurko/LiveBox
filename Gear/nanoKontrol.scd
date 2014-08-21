12.do{| i | if(i + 1 <= 9) {("~but0" ++ (i + 1).asString + "= 0").interpret} {("~but" ++ (i + 1).asString + "= 0").interpret}};

~testpos = 0; ~testdur = 127; ~testatt = 1; ~testrel = 33; ~testgain = 63; ~testoct = 63;
~testpos2 = 0; ~testdur2 = 20; ~testatt2 = 1; ~testrel2 = 33; ~testgain2 = 63; ~testoct2 = 63;

~testrpos = ~testrdur = ~testratt = ~testrrel = ~testrgain = ~testroct = 0;
~testrpos2 = ~testrdur2 = ~testratt2 = ~testrrel2 = ~testrgain2 = ~testroct2 = 0;

~swtchpos = ~swtchdur = ~swtchatt = ~swtchrel = ~swtchgain = ~swtchoct = 0;
~swtchpos2 = ~swtchdur2 = ~swtchatt2 = ~swtchrel2 = ~swtchgain2 = ~swtchoct2 = 0;

~swtchrpos = ~swtchrdur = ~swtchratt = ~swtchrrel = ~swtchrgain = ~swtchroct = 0;
~swtchrpos2 = ~swtchrdur2 = ~swtchratt2 = ~swtchrrel2 = ~swtchrgain2 = ~swtchroct2 = 0;

MIDIdef.cc("controllers", {arg val, num, ch, id;
	// Buttons
	// first synth
	case
	{(id == d.nanoKontrol).and(num == 23)} {~but01 = val}
	{(id == d.nanoKontrol).and(num == 53)} {~but02 = val}

	{(id == d.nanoKontrol).and(num == 24)} {~but03 = val}
	{(id == d.nanoKontrol).and(num == 54)} {~but04 = val}

	{(id == d.nanoKontrol).and(num == 25)} {~but05 = val}
	{(id == d.nanoKontrol).and(num == 55)} {~but06 = val}

	// second synth
	{(id == d.nanoKontrol).and(num == 26)} {~but07 = val}
	{(id == d.nanoKontrol).and(num == 57)} {~but08 = val}

	{(id == d.nanoKontrol).and(num == 27)} {~but09 = val}
	{(id == d.nanoKontrol).and(num == 59)} {~but10 = val}

	{(id == d.nanoKontrol).and(num == 28)} {~but11 = val}
	{(id == d.nanoKontrol).and(num == 60)} {~but12 = val};

	// First synth
	//////////////////////
	// Position
	// button
	if((id == d.nanoKontrol).and(num == 23).and(~but01 == 0).and(~pos.notNil),
		{~contbox.set(\rcursor, 0); ~swtchpos = 0;
			"grntbl1 position set to ".post; ~pos.round(0.001).postln});
	if((id == d.nanoKontrol).and(num == 23).and(~but01 == 127).and(~rpos.notNil),
		{~contbox.set(\rcursor, ~rpos); ~swtchrpos = 0;
			"grntbl1 random position set to ".post; (~rpos * 100).round(0.001).post; "%".postln});

	// hand controlled
	switch(~swtchpos,
		0, {if((id == d.nanoKontrol).and(num == 14).and(~but01 == 0).and(~testpos == val), {~swtchpos = 1})},
		1, {if((id == d.nanoKontrol).and(num == 14).and(~but01 == 0),
			{~contbox.set(\cursor, ~pos = (val + 1) / 128); ~testpos = val;
				"grntbl1 POSITION: ".post; ((val + 1) / 128).round(0.01).postln})});

	// random
	switch(~swtchrpos,
		0, {if((id == d.nanoKontrol).and(num == 14).and(~but01 == 127).and(~testrpos == val), {~swtchrpos = 1})},
		1, {if((id == d.nanoKontrol).and(num == 14).and(~but01 == 127),
			{~contbox.set(\rcursor, ~rpos = (val + 1) / 128); ~testrpos = val;
				"grntbl1 RANDOM POSITION: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 82), {~contbox.set(\rratepos, ((val + 1) / 128) * 20);
		"grntbl1 POSITION RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	////////////////////////
	// Duration
	// button
	if((id == d.nanoKontrol).and(num == 53).and(~but02 == 127).and(~rdur.notNil),
		{~contbox.set(\rdur, ~rdur); ~swtchrdur = 0;
			"grntbl1 random duration set to ".post; (~rdur * 100).round(0.001).post; "%".postln});
	if((id == d.nanoKontrol).and(num == 53).and(~but02 == 0).and(~dur.notNil),
		{~contbox.set(\rdur, 0); ~swtchdur = 0;
			"grntbl1 duration set to ".post; ~dur.round(0.001).post; " s".postln});

	// hand controlled
	switch(~swtchdur,
		0, {if((id == d.nanoKontrol).and(num == 2).and(~but02 == 0).and(~testdur == val), {~swtchdur = 1})},
		1, {if((id == d.nanoKontrol).and(num == 2).and(~but02 == 0),
			{~contbox.set(\dur, ~dur = (val + 1) / 128); ~testdur = val;
				"grntbl1 DURATION: ".post; ((val + 1) / 128).round(0.01).post; " s".postln})});

	// random
	switch(~swtchrdur,
		0, {if((id == d.nanoKontrol).and(num == 2).and(~but02 == 127).and(~testrdur == val), {~swtchrdur = 1})},
		1, {if((id == d.nanoKontrol).and(num == 2).and(~but02 == 127),
			{~contbox.set(\rdur, ~rdur = (val + 1) / 128); ~testrdur = val;
				"grntbl1 RANDOM DURATION: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 83), {~contbox.set(\rratedur, ((val + 1) / 128) * 20);
		"grntbl1 DURATION RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	/////////////////////////
	// Attack
	// button
	if((id == d.nanoKontrol).and(num == 24).and(~but03 == 127).and(~ratt.notNil),
		{~contbox.set(\att, 0, \ratt, ~ratt); ~swtchratt = 0;
			"grntbl1 random attack set to ".post; ((~ratt / 14) * 100).round(0.001).post; "%".postln});
	if((id == d.nanoKontrol).and(num == 24).and(~but03 == 0).and(~att.notNil),
		{~contbox.set(\ratt, 0, \att, ~att); ~swtchatt = 0;
			"grntbl1 attack set to ".post; ~att.round(0.001).post; " s".postln});

	// hand controlled
	switch(~swtchatt,
		0, {if((id == d.nanoKontrol).and(num == 15).and(~but03 == 0).and(~testatt == val), {~swtchatt = 1})},
		1, {if((id == d.nanoKontrol).and(num == 15).and(~but03 == 0),
			{~contbox.set(\att, ~att = ((val + 1) / 128) * 7); ~testatt = val;
				"grntbl1 ATTACK: ".post; (((val + 1) / 128) * 7).round(0.01).post; " s".postln})});

	// random
	switch(~swtchratt,
		0, {if((id == d.nanoKontrol).and(num == 15).and(~but03 == 127).and(~testratt == val), {~swtchratt = 1})},
		1, {if((id == d.nanoKontrol).and(num == 15).and(~but03 == 127),
			{~contbox.set(\ratt, ~ratt = ((val + 1) / 128) * 14); ~testratt = val;
				"grntbl1 RANDOM ATTACK: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 28), {~contbox.set(\rrateatt, ((val + 1) / 128) * 20);
		"grntbl1 ATTACK RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	/////////////////////////
	// Release
	// button
	if((id == d.nanoKontrol).and(num == 54).and(~but04 == 127).and(~rrel.notNil),
		{~contbox.set(\rel, 0, \rrel, ~rrel); ~swtchrrel = 0;
			"grntbl1 random release set to ".post; ((~rrel / 30) * 100).round(0.001).post; "%".postln});
	if((id == d.nanoKontrol).and(num == 54).and(~but04 == 0).and(~rel.notNil),
		{~contbox.set(\rrel, 0, \rel, ~rel); ~swtchrel = 0;
			"grntbl1 release set to ".post; ~rel.round(0.001).post; " s".postln});

	// hand controlled
	switch(~swtchrel,
		0, {if((id == d.nanoKontrol).and(num == 3).and(~but04 == 0).and(~testrel == val), {~swtchrel = 1})},
		1, {if((id == d.nanoKontrol).and(num == 3).and(~but04 == 0),
			{~contbox.set(\rel, ~rel = ((val + 1) / 128) * 15); ~testrel = val;
				"grntbl1 RELEASE: ".post; (((val + 1) / 128) * 15).round(0.01).post; " s".postln})});

	// random
	switch(~swtchrrel,
		0, {if((id == d.nanoKontrol).and(num == 3).and(~but04 == 127).and(~testrrel == val), {~swtchrrel = 1})},
		1, {if((id == d.nanoKontrol).and(num == 3).and(~but04 == 127),
			{~contbox.set(\rrel, ~rrel = ((val + 1) / 128) * 30); ~testrrel = val;
				"grntbl1 RANDOM RELEASE: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 29), {~contbox.set(\rraterel, ((val + 1) / 128) * 20);
		"grntbl1 RELEASE RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	///////////////////
	// Gain
	// button
	case
	{(id == d.nanoKontrol).and(num == 55).and(~but06 == 0)} {~swtchgain = 0}
	{(id == d.nanoKontrol).and(num == 55).and(~but06 == 127)} {~swtchrgain = 0};

	// hand controlled
	switch(~swtchgain,
		0, {if((id == d.nanoKontrol).and(num == 4).and(~but06 == 0).and(~testgain == val), {~swtchgain = 1})},
		1, {if((id == d.nanoKontrol).and(num == 4).and(~but06 == 0),
			{~contbox.set(\gain, val / 127); ~testgain = val;
				"grntbl1 AMP: ".post; (val / 127).round(0.01).postln})});

	// verb send
	switch(~swtchrgain,
		0, {if((id == d.nanoKontrol).and(num == 4).and(~but06 == 127).and(~testrgain == val), {~swtchrgain = 1})},
		1, {if((id == d.nanoKontrol).and(num == 4).and(~but06 == 127),
			{~contbox.set(\send01, val / 127); ~testrgain = val;
				"VERB AMP: ".post; (val / 127).round(0.01).postln})});

	///////////////////
	// Octave
	// button
	if((id == d.nanoKontrol).and(num == 25).and(~but05 == 0).and(~oct.notNil),
		{~contbox.set(\oct, ~oct); ~swtchoct = 0;
			"oct set to * ".post; ~oct.postln});
	if((id == d.nanoKontrol).and(num == 25).and(~but05 == 127).and(~verbtime.notNil),
		{~verb.set(\vtime, ~verbtime); ~swtchroct = 0;
			"reverb time set to ".post; ~verbtime.round(0.01).postln});

	// hand controlled
	switch(~swtchoct,
		0, {if((id == d.nanoKontrol).and(num == 16).and(~but05 == 0).and(~testoct == val), {~swtchoct = 1})},
		1, {case
			{(id == d.nanoKontrol).and(num == 16).and(val <= 24).and(~but05 == 0)}
			{~contbox.set(\oct, ~oct = 0.25); ~testoct = val; "grntbl1 OCT: - 2".postln}

			{(id == d.nanoKontrol).and(num == 16).and(val > 24).and(val <= 59).and(~but05 == 0)}
			{~contbox.set(\oct, ~oct = 0.5); ~testoct = val; "grntbl1 OCT: - 1".postln}

			{(id == d.nanoKontrol).and(num == 16).and(val > 59).and(val <= 84).and(~but05 == 0)}
			{~contbox.set(\oct, ~oct = 1); ~testoct = val; "grntbl1 OCT: 0".postln}

			{(id == d.nanoKontrol).and(num == 16).and(val > 84).and(val <= 109).and(~but05 == 0)}
			{~contbox.set(\oct, ~oct = 2); ~testoct = val; "grntbl1 OCT: + 1".postln}

			{(id == d.nanoKontrol).and(num == 16).and(val > 109).and(val <= 127).and(~but05 == 0)}
			{~contbox.set(\oct, ~oct = 4); ~testoct = val; "grntbl1 OCT: + 2".postln}});

	// verb time
	switch(~swtchroct,
		0, {if((id == d.nanoKontrol).and(num == 16).and(~but05 == 127).and(~testroct == val), {~swtchroct = 1})},
		1, {if((id == d.nanoKontrol).and(num == 16).and(~but05 == 127),
			{~verb.set(\vtime, ~verbtime = ((val + 1) / 128) * 20); ~testroct = val;
				"VERB TIME: ".post; ~verbtime.round(0.1).post; " s".postln})});

	// Second synth
	/////////////////////////
	// Position
	// button
	if((id == d.nanoKontrol).and(num == 26).and(~but07 == 0).and(~pos2.notNil),
		{~contbox.set(\rcursor2, 0); ~swtchpos2 = 0;
			"grntbl2 position set to ".post; ~pos2.round(0.001).postln});
	if((id == d.nanoKontrol).and(num == 26).and(~but07 == 127).and(~rpos2.notNil),
		{~contbox.set(\rcursor2, ~rpos2); ~swtchrpos2 = 0;
			"grntbl2 random position set to ".post; (~rpos2 * 100).round(0.001).post; "%".postln});

	// hand controlled
	switch(~swtchpos2,
		0, {if((id == d.nanoKontrol).and(num == 17).and(~but07 == 0).and(~testpos2 == val), {~swtchpos2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 17).and(~but07 == 0),
			{~contbox.set(\cursor2, ~pos2 = (val + 1) / 128); ~testpos2 = val;
				"grntbl2 POSITION: ".post; ((val + 1) / 128).round(0.01).postln})});

	// random
	switch(~swtchrpos2,
		0, {if((id == d.nanoKontrol).and(num == 17).and(~but07 == 127).and(~testrpos2 == val), {~swtchrpos2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 17).and(~but07 == 127),
			{~contbox.set(\rcursor2, ~rpos2 = (val + 1) / 128); ~testrpos2 = val;
				"grntbl2 RANDOM POSITION: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 16), {~contbox.set(\rratepos2, ((val + 1) / 128) * 20);
		"grntbl2 POSITION RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	/////////////////////
	// Duration
	// button
	if((id == d.nanoKontrol).and(num == 57).and(~but08 == 0).and(~dur2.notNil),
		{~contbox.set(\rdur2, 0); ~swtchdur2 = 0;
			"grntbl2 duration set to ".post; ~dur2.round(0.001).post; " s".postln});
	if((id == d.nanoKontrol).and(num == 57).and(~but08 == 127).and(~rdur2.notNil),
		{~contbox.set(\rdur2, ~rdur2); ~swtchrdur2 = 0;
			"grntbl2 random duration set to ".post; (~rdur2 * 100).round(0.001).post; "%".postln});

	// hand controlled
	switch(~swtchdur2,
		0, {if((id == d.nanoKontrol).and(num == 5).and(~but08 == 0).and(~testdur2 == val), {~swtchdur2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 5).and(~but08 == 0),
			{~contbox.set(\dur2, ~dur2 = (val + 1) / 128); ~testdur2 = val;
				"grntbl2 DURATION: ".post; (((val + 1) / 128) * 2.5).round(0.01).post; " s".postln})});

	// random
	switch(~swtchrdur2,
		0, {if((id == d.nanoKontrol).and(num == 5).and(~but08 == 127).and(~testrdur2 == val), {~swtchrdur2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 5).and(~but08 == 127),
			{~contbox.set(\rdur2, ~rdur2 = (val + 1) / 128); ~testrdur2 = val;
				"grntbl2 RANDOM DURATION: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 80), {~contbox.set(\rratedur2, ((val + 1) / 128) * 20);
		"grntbl2 DURATION RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	////////////////////
	// Attack
	// button
	if((id == d.nanoKontrol).and(num == 27).and(~but09 == 0).and(~att2.notNil),
		{~contbox.set(\ratt2, 0, \att2, ~att2); ~swtchatt2 = 0;
			"grntbl2 attack set to ".post; ~att2.round(0.001).post; " s".postln});
	if((id == d.nanoKontrol).and(num == 27).and(~but09 == 127).and(~ratt2.notNil),
		{~contbox.set(\att2, 0, \ratt2, ~ratt2); ~swtchratt2 = 0;
			"grntbl2 random attack set to ".post; ((~ratt2 / 14) * 100).round(0.001).post; "%".postln});

	// hand controlled
	switch(~swtchatt2,
		0, {if((id == d.nanoKontrol).and(num == 18).and(~but09 == 0).and(~testatt2 == val), {~swtchatt2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 18).and(~but09 == 0),
			{~contbox.set(\att2, ~att2 = ((val + 1) / 128) * 7);
				~testatt2 = val;
				"grntbl2 ATTACK: ".post; (((val + 1) / 128) * 7).round(0.01).post; " s".postln})});

	// random
	switch(~swtchratt2,
		0, {if((id == d.nanoKontrol).and(num == 18).and(~but09 == 127).and(~testratt2 == val), {~swtchratt2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 18).and(~but09 == 127),
			{~contbox.set(\ratt2, ~ratt2 = ((val + 1) / 128) * 14); ~testratt2 = val;
				"grntbl2 RANDOM ATTACK: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 18), {~contbox.set(\rrateatt2, ((val + 1) / 128) * 20);
		"grntbl2 ATTACK RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	////////////////////
	// Release
	// button
	if((id == d.nanoKontrol).and(num == 59).and(~but10 == 0).and(~rel2.notNil),
		{~contbox.set(\rrel2, 0, \rel2, ~rel2); ~swtchrel2 = 0;
			"grntbl2 release set to ".post; ~rel2.round(0.001).post; " s".postln});
	if((id == d.nanoKontrol).and(num == 59).and(~but10 == 127).and(~rrel2.notNil),
		{~contbox.set(\rel2, 0, \rrel2, ~rrel2); ~swtchrrel2 = 0;
			"grntbl2 random release set to ".post; ((~rrel2 / 30) * 100).round(0.001).post; "%".postln});

	// hand controlled
	switch(~swtchrel2,
		0, {if((id == d.nanoKontrol).and(num == 6).and(~but10 == 0).and(~testrel2 == val), {~swtchrel2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 6).and(~but10 == 0),
			{~contbox.set(\rel2, ~rel2 = ((val + 1) / 128) * 15); ~testrel2 = val;
				"grntbl2 RELEASE: ".post; (((val + 1) / 128) * 15).round(0.01).post; " s".postln})});

	// random
	switch(~swtchrrel2,
		0, {if((id == d.nanoKontrol).and(num == 6).and(~but10 == 127).and(~testrrel2 == val), {~swtchrrel2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 6).and(~but10 == 127),
			{~contbox.set(\rrel2, ~rrel2 = ((val + 1) / 128) * 30); ~testrrel2 = val;
				"grntbl2 RANDOM RELEASE: ".post; (((val + 1) / 128) * 100).round(0.1).post; "%".postln})});

	if((id == d.radium).and(num == 19), {~contbox.set(\rraterel2, ((val + 1) / 128) * 20);
		"grntbl2 RELEASE RRATE: ".post; (((val + 1) / 128) * 20).round(0.1).post; " Hz".postln});

	////////////////////
	// Gain
	// button
	case
	{(id == d.nanoKontrol).and(num == 60).and(~but12 == 0)} {~swtchgain2 = 0}
	{(id == d.nanoKontrol).and(num == 60).and(~but12 == 127)} {~swtchrgain2 = 0};

	// hand controlled
	switch(~swtchgain2,
		0, {if((id == d.nanoKontrol).and(num == 7).and(~but12 == 0).and(~testgain2 == val), {~swtchgain2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 7).and(~but12 == 0),
			{~contbox.set(\gain2, val / 127); ~testgain2 = val;
				"grntbl2 AMP: ".post; (val / 127).round(0.01).postln})});

	// verb gain
	switch(~swtchrgain2,
		0, {if((id == d.nanoKontrol).and(num == 7).and(~but12 == 127).and(~testrgain2 == val), {~swtchrgain2 = 1})},
		1, {if((id == d.nanoKontrol).and(num == 7).and(~but12 == 127),
			{~contbox.set(\send02, val / 127); ~testrgain2 = val;
				"VERB AMP: ".post; (val / 127).round(0.01).postln})});

	////////////////////
	// Octave
	case
	{(id == d.nanoKontrol).and(num == 19).and(val <= 24).and(~but11 == 0)}
	{~contbox.set(\oct2, ~oct2 = 0.25); "grntbl2 OCT: - 2".postln}

	{(id == d.nanoKontrol).and(num == 19).and(val > 24).and(val <= 59).and(~but11 == 0)}
	{~contbox.set(\oct2, ~oct2 = 0.5); "grntbl2 OCT: - 1".postln}

	{(id == d.nanoKontrol).and(num == 19).and(val > 59).and(val <= 84).and(~but11 == 0)}
	{~contbox.set(\oct2, ~oct2 = 1); "grntbl2 OCT: 0".postln}

	{(id == d.nanoKontrol).and(num == 19).and(val > 84).and(val <= 109).and(~but11 == 0)}
	{~contbox.set(\oct2, ~oct2 = 2); "grntbl2 OCT: + 1".postln}

	{(id == d.nanoKontrol).and(num == 19).and(val > 109).and(val <= 127).and(~but11 == 0)}
	{~contbox.set(\oct2, ~oct2 = 4); "grntbl2 OCT: + 2".postln};
});