-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TitleServiceUtils, time of decompilation: Sun May  3 10:12:17 2026 ]]
return {
	titles = {
		vip = {
			rotation = 90,
			text = "VIP",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 248, 210)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 70))
			})
		},
		tester = {
			rotation = 90,
			text = "TESTER",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(211, 255, 170)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 199, 73))
			})
		},
		carlos = {
			rotation = 90,
			text = "CARLOS",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 170)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 199, 0))
			})
		},
		mod = {
			rotation = 90,
			text = "MOD",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 211, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 0, 199))
			})
		},
		developer = {
			rotation = 90,
			text = "DEV",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 211)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 0, 80))
			})
		},
		owner = {
			rotation = 90,
			text = "OWNER",
			colorSequnce = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 248, 248)),
				ColorSequenceKeypoint.new(0.2, Color3.fromRGB(82, 82, 82)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
			})
		}
	},
	groupRanks = {
		tester = 45,
		carlos = 51,
		mod = 100,
		developer = 254,
		owner = 255
	}
}
