(
Server.default = Server.local;
s = Server.default;
s.waitForBoot({
	Routine.run{
		MIDIClient.init;
		MIDIIn.connectAll;
		~samples1 = Buffer.readDir("Samples/".resolveRelative, server: s);

		~samples1 = ~samples1 ++ Array.newClear(128 - ~samples1.size);
		~samples1.do({arg item, i;
			if(item == nil, {
				~samples1[i] = Buffer.read(s, "Samples/Silence.wav".resolveRelative)});
				});

		~samples2 = Buffer.readDir(
			"Samples/".resolveRelative, server: s);

		~samples2 = ~samples2 ++ Array.newClear(128 - ~samples2.size);
		~samples2.do({arg item, i;
			if(item == nil, {
				~samples2[i] = Buffer.read(s, "Samples/Silence.wav".resolveRelative)});
				});

		s.wait;

		e = Buffer.alloc(s, s.sampleRate * 0.2, 1);
		y = Signal.hanningWindow(s.sampleRate * 0.4);
		h = Array.fill(s.sampleRate * 0.2, {arg i; y[i]});
		e.loadCollection(h);

		~pitches1 = Array.fill(128, 60.midicps);
		~pitches2 = Array.fill(128, 60.midicps);
		~buttsCatLPs1 = [0, 0, 0, 0];
		~sampleNumber1 = ~buttsCatLPs1.as(Array);
		~buttsCatLPs2 = [0, 0, 0, 0];
		~sampleNumber2 = ~buttsCatLPs2.as(Array);

		~unpitched = (33..48);

		s.wait;

		~recfolder = "Recordings".resolveRelative.replace("Gear/");
		b = ();
		b.verb = Bus.audio(s, 2);
		~micChNum = 0; // номер канала микрофона

		c = ();
		c.send01 = Bus.control;
		c.cursor = Bus.control;
		c.dur = Bus.control;
		c.att = Bus.control;
		c.rel = Bus.control;
		c.gain = Bus.control;
		c.oct = Bus.control;

		c.send02 = Bus.control;
		c.cursor2 = Bus.control;
		c.dur2 = Bus.control;
		c.att2 = Bus.control;
		c.rel2 = Bus.control;
		c.gain2 = Bus.control;
		c.oct2 = Bus.control;

		c.buf1 = Bus.control;
		c.buf2 = Bus.control;
		c.buf3 = Bus.control;
		c.buf4 = Bus.control;
		c.buf5 = Bus.control;
		c.buf6 = Bus.control;
		c.buf7 = Bus.control;
		c.buf8 = Bus.control;

		c.ptc1 = Bus.control;
		c.ptc2 = Bus.control;
		c.ptc3 = Bus.control;
		c.ptc4 = Bus.control;
		c.ptc5 = Bus.control;
		c.ptc6 = Bus.control;
		c.ptc7 = Bus.control;
		c.ptc8 = Bus.control;

		c.state1 = Bus.control;
		c.state2 = Bus.control;
		c.state3 = Bus.control;
		c.state4 = Bus.control;
		c.state5 = Bus.control;
		c.state6 = Bus.control;
		c.state7 = Bus.control;
		c.state8 = Bus.control;

		c.trigger = Bus.control;

		c.pitcher = Bus.control;
		c.pitcher2 = Bus.control;

		// device ID's
		d = ();
		d.launchPadS = -1471401813;
		d.launchPadSOut = MIDIOut.newByName("Launchpad S", "Launchpad S");
		d.radium = -274920389;
		d.nanoPad = 441860033; // изменить на правильный
		d.nanoKontrol = 1764340990;
		d.virtualA = -803950327;
		d.virtualB = -1933114777;

		t = TempoClock.new;

		~contbox = SynthDef("control", {arg send01 = 0, cursor = 0, direction1 = 1,
			dur = 1, att = 0.11, rel = 3.98, gain = 0.5, oct = 1, rcursor = 0,
			rratepos = 5, rdur = 0, rratedur = 5, ratt = 0, rrateatt = 5,
			rrel = 0, rraterel = 5,

			send02 = 0, cursor2 = 0,  direction2 = 1, dur2 = 0.4, att2 = 0.11,
			rel2 = 3.98, gain2 = 0.5, oct2 = 1, roct2 = 1, rcursor2 = 0,
			rratepos2 = 5, rdur2 = 0, rratedur2 = 5, ratt2 = 0, rrateatt2 = 5,
			rrel2 = 0, rraterel2 = 5,

			b1 = 0, b2 = 0, b3 = 0, b4 = 0, b5 = 0, b6 = 0, b7 = 0, b8 = 0,

			p1 = 60.midicps, p2 = 60.midicps, p3 = 60.midicps, p4 = 60.midicps,
			p5 = 60.midicps, p6 = 60.midicps, p7 = 60.midicps, p8 = 60.midicps,

			st1 = 1, st2 = 1, st3 = 1, st4 = 1, st5 = 1, st6 = 1, st7 = 1, st8 = 1,

			trigger;


			Out.kr(c.send01.index, send01);
			Out.kr(c.cursor.index,
				(cursor + LFNoise1.kr(rratepos, rcursor).abs).clip(0, 0.98));
			Out.kr(c.dur.index, (dur + LFNoise1.kr(rratedur, rdur).abs).clip(0.01, 1));
			Out.kr(c.att.index, (att + LFNoise1.kr(rrateatt, ratt).abs).clip(0, 7));
			Out.kr(c.rel.index, (rel + LFNoise1.kr(rraterel, rrel).abs).clip(0, 15));
			Out.kr(c.gain.index, gain); Out.kr(c.oct.index, oct * direction1);

			Out.kr(c.send02.index, send02);
			Out.kr(c.cursor2.index,
				(cursor2 + LFNoise1.kr(rratepos2, rcursor2).abs).clip(0, 0.98));
			Out.kr(c.dur2.index,
				((dur2 * 2.5) + LFNoise1.kr(rratedur2, rdur2).abs).clip(0.01, 2));
			Out.kr(c.att2.index,
				(att2 + LFNoise1.kr(rrateatt2, ratt2).abs).clip(0, 7));
			Out.kr(c.rel2.index,
				(rel2 + LFNoise1.kr(rraterel2, rrel2).abs).clip(0, 15));
			Out.kr(c.gain2.index, gain2);
			Out.kr(c.oct2.index, oct2 * roct2 * direction2);

			Out.kr(c.buf1.index, b1);
			Out.kr(c.buf2.index, b2);
			Out.kr(c.buf3.index, b3);
			Out.kr(c.buf4.index, b4);
			Out.kr(c.buf5.index, b5);
			Out.kr(c.buf6.index, b6);
			Out.kr(c.buf7.index, b7);
			Out.kr(c.buf8.index, b8);

			Out.kr(c.ptc1.index, p1);
			Out.kr(c.ptc2.index, p2);
			Out.kr(c.ptc3.index, p3);
			Out.kr(c.ptc4.index, p4);
			Out.kr(c.ptc5.index, p5);
			Out.kr(c.ptc6.index, p6);
			Out.kr(c.ptc7.index, p7);
			Out.kr(c.ptc8.index, p8);

			Out.kr(c.state1.index, st1);
			Out.kr(c.state2.index, st2);
			Out.kr(c.state3.index, st3);
			Out.kr(c.state4.index, st4);
			Out.kr(c.state5.index, st5);
			Out.kr(c.state6.index, st6);
			Out.kr(c.state7.index, st7);
			Out.kr(c.state8.index, st8);

			Out.kr(c.trigger.index, Changed.kr(trigger));
		}).play;

		SynthDef("recorder", {arg bufnum;
			DiskOut.ar(bufnum, SoundIn.ar(~micChNum));
		}).add;

		SynthDef("pitchtector", {var in, hasFreq, freq, out;
			in = SoundIn.ar(~micChNum);
			# freq, hasFreq = Pitch.kr(in);
			Out.kr(c.pitcher.index, freq);
		}).add;

		SynthDef("pitchtector2", {var in, hasFreq, freq, out;
			in = SoundIn.ar(~micChNum);
			# freq, hasFreq = Pitch.kr(in);
			Out.kr(c.pitcher2.index, freq);
		}).add;

		SynthDef("granulatorI", {arg note, gate = 1;
			var send1, cursor, dur, att, rel, gain,
			oct, b1, b2, b3, b4, p1, p2, p3, p4, st1,
			st2, st3, st4, env, osc1, osc2, osc3,
			osc4, out;
			send1 = In.kr(c.send01.index);
			cursor = In.kr(c.cursor.index);
			dur = In.kr(c.dur.index);
			att = In.kr(c.att.index);
			rel = In.kr(c.rel.index);
			gain = In.kr(c.gain.index);
			oct = In.kr(c.oct.index);
			b1 = In.kr(c.buf1.index);
			b2 = In.kr(c.buf2.index);
			b3 = In.kr(c.buf3.index);
			b4 = In.kr(c.buf4.index);
			p1 = In.kr(c.ptc1.index);
			p2 = In.kr(c.ptc2.index);
			p3 = In.kr(c.ptc3.index);
			p4 = In.kr(c.ptc4.index);
			st1 = In.kr(c.state1.index);
			st2 = In.kr(c.state2.index);
			st3 = In.kr(c.state3.index);
			st4 = In.kr(c.state4.index);

			p1 = Select.kr(st1,
				[1, (note - 60).midiratio * (60 - p1.cpsmidi).midiratio]);
			p2 = Select.kr(st2,
				[1, (note - 60).midiratio * (60 - p2.cpsmidi).midiratio]);
			p3 = Select.kr(st3,
				[1, (note - 60).midiratio * (60 - p3.cpsmidi).midiratio]);
			p4 = Select.kr(st4,
				[1, (note - 60).midiratio * (60 - p4.cpsmidi).midiratio]);


			env = EnvGen.kr(Env.asr(att, 1, rel), gate, doneAction: 2);

			osc1 = Warp1.ar(1, b1, cursor,
				p1 * BufRateScale.kr(b1) * oct,
				dur, -1, 3, 0.1, 4, 0.4);
			osc2 = Warp1.ar(1, b2, cursor,
				p2 * BufRateScale.kr(b2) * oct,
				dur, -1, 3, 0.1, 4, 0.4);
			osc3 = Warp1.ar(1, b3, cursor,
				p3 * BufRateScale.kr(b3) * oct,
				dur, -1, 3, 0.1, 4, 0.4);
			osc4 = Warp1.ar(1, b4, cursor,
				p4 * BufRateScale.kr(b4) * oct,
				dur, -1, 3, 0.1, 4, 0.4);

			out = (osc1 + osc2 + osc3 + osc4) * env;

			Out.ar(4, Pan2.ar(out, 0, gain));
			Out.ar(b.verb.index, out * send1)
		}).add;

		SynthDef("granulatorII", {arg note, gate = 1;
			var send1, cursor, dur, att, rel, gain, oct, b1, b2, b3, b4,
			p1, p2, p3, p4, st1, st2, st3, st4,
			trig, env, osc1, osc2, osc3, osc4, out;
			send1 = In.kr(c.send02.index);
			cursor = In.kr(c.cursor2.index);
			dur = In.kr(c.dur2.index);
			att = In.kr(c.att2.index);
			rel = In.kr(c.rel2.index);
			gain = In.kr(c.gain2.index);
			oct = In.kr(c.oct2.index);
			b1 = In.kr(c.buf5.index);
			b2 = In.kr(c.buf6.index);
			b3 = In.kr(c.buf7.index);
			b4 = In.kr(c.buf8.index);
			p1 = In.kr(c.ptc5.index);
			p2 = In.kr(c.ptc6.index);
			p3 = In.kr(c.ptc7.index);
			p4 = In.kr(c.ptc8.index);
			st1 = In.kr(c.state5.index);
			st2 = In.kr(c.state6.index);
			st3 = In.kr(c.state7.index);
			st4 = In.kr(c.state8.index);

			p1 = Select.kr(st1,
				[1, (note - 60).midiratio * (60 - p1.cpsmidi).midiratio]);
			p2 = Select.kr(st2,
				[1, (note - 60).midiratio * (60 - p2.cpsmidi).midiratio]);
			p3 = Select.kr(st3,
				[1, (note - 60).midiratio * (60 - p3.cpsmidi).midiratio]);
			p4 = Select.kr(st4,
				[1, (note - 60).midiratio * (60 - p4.cpsmidi).midiratio]);

			trig = In.kr(c.trigger.index);

			env = EnvGen.kr(Env.asr(att, 1, rel), gate, doneAction: 2);

			osc1 = TGrains3.ar(2, trig, b1,
				p1 * BufRateScale.kr(b1) * oct,
				BufDur.kr(b1) * cursor, dur, 0, 0.4, att, rel, e.bufnum);
			osc2 = TGrains3.ar(2, trig, b2,
				p2 * BufRateScale.kr(b2) * oct,
				BufDur.kr(b2) * cursor, dur, 0, 0.4, att, rel, e.bufnum);
			osc3 = TGrains3.ar(2, trig, b3,
				p3 * BufRateScale.kr(b3) * oct,
				BufDur.kr(b3) * cursor, dur, 0, 0.4, att, rel, e.bufnum);
			osc4 = TGrains3.ar(2, trig, b4,
				p4 * BufRateScale.kr(b4) * oct,
				BufDur.kr(b4) * cursor, dur, 0, 0.4, att, rel, e.bufnum);

			out = (osc1 + osc2 + osc3 + osc4) * env;

			Out.ar(6, out * gain);
			Out.ar(b.verb.index, out * send1)
		}).add;

		~verb = SynthDef("reverb", {arg vtime = 0.5;
			var in, out;
			in = In.ar(b.verb.index);
			out = GVerb.ar(in, 200, vtime, 0.1, drylevel: 0);
			Out.ar(0, out)
		}).play;

		"Gear/Keys.scd".loadRelative;
		"Gear/nanoKontrol.scd".loadRelative;
		"Gear/LaunchpadS.scd".loadRelative;
		"Gear/LiveOSC.scd".loadRelative;
	};
});
)

(
// Stop the programm
CmdPeriod.run;
s.freeAll;
MIDIdef.freeAll;
currentEnvironment.clear;
)
// Quite from the server before restarting the program.
s.quit;

// For testing
(
MIDIdef.cc("testcontrol",
	{arg val, num, ch, id; "control: ".post; [val, num, ch, id].postln});
MIDIdef.noteOn("testkeys",
	{arg vel, note, ch, id; "note: ".post; [vel, note, ch, id].postln});
)
