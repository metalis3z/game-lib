-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RarityTiers, time of decompilation: Sun May  3 10:12:41 2026 ]]
local t1 = {
	{
		name = "Basic",
		threshold = 0,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(241, 252, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 200, 207))
		})
	},
	{
		name = "Common",
		threshold = 6,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(216, 255, 204)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 92))
		})
	},
	{
		name = "Uncommon",
		threshold = 25,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 255, 224)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 214, 126))
		})
	},
	{
		name = "Rare",
		threshold = 100,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 255, 242)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(99, 185, 255))
		})
	},
	{
		name = "Epic",
		threshold = 500,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 211, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 89, 255))
		})
	},
	{
		name = "Legendary",
		threshold = 2500,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 204)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 132, 60))
		})
	},
	{
		name = "Mythic",
		threshold = 15000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 209, 229)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 66, 156))
		})
	},
	{
		name = "Divine",
		threshold = 60000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 201)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 214, 61))
		})
	},
	{
		name = "Prismatic",
		threshold = 500000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(208, 255, 247)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(98, 255, 198)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 212, 255))
		})
	},
	{
		name = "Transcendent",
		threshold = 4000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 250)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(224, 132, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 94, 255))
		})
	},
	{
		name = "Ethereal",
		threshold = 25000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(209, 240, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 203, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		})
	},
	{
		name = "Secret",
		threshold = 300000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 214)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 71, 71)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 0, 0))
		})
	},
	{
		name = "Celestial",
		threshold = 4000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(169, 228, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 133, 255))
		})
	},
	{
		name = "Astral",
		threshold = 50000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 236, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(137, 182, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 95, 255))
		})
	},
	{
		name = "Nova",
		threshold = 600000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 250)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 144, 227)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 196))
		})
	},
	{
		name = "Solar",
		threshold = 7000000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 249, 214)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 204, 87)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 136, 0))
		})
	},
	{
		name = "Lunar",
		threshold = 75000000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(233, 239, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(177, 191, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 124, 255))
		})
	},
	{
		name = "Galactic",
		threshold = 800000000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(228, 220, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 112, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 36, 196))
		})
	},
	{
		name = "Stellar",
		threshold = 10000000000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 255, 248)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(93, 255, 229)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 186, 255))
		})
	},
	{
		name = "Nebula",
		threshold = 90000000000000000,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 228, 246)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(206, 120, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 0, 179))
		})
	},
	{
		name = "Quantum",
		threshold = 7.5E+17,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 255, 229)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(89, 255, 149)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 163, 91))
		})
	},
	{
		name = "Void",
		threshold = 9E+18,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 173, 214)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 56, 110)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 8, 28))
		})
	},
	{
		name = "Paradox",
		threshold = 1E+20,
		gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 232)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 111, 111)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(129, 8, 8))
		})
	}
}

return {
	getTier = function(n1: number) --[[ getTier ]] -- line: 293
		-- upvalues: t1 (copy)
		local v3 = 1 / n1

		for i = #t1, 1, -1 do
			local v5 = t1[i]

			if v3 >= v5.threshold then
				return v5
			end
		end

		return t1[1]
	end,
	getTiers = function() --[[ getTiers ]] -- line: 305
		-- upvalues: t1 (copy)
		return t1
	end
}
