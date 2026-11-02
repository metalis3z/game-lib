-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Enemies, time of decompilation: Sun May  3 10:12:41 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local t1 = {
	[1] = {
		reward = 50,
		health = 20,
		damage = 1,
		speed = 12,
		attackSpeed = 1.2
	},
	[2] = {
		reward = 250,
		health = 100,
		damage = 3,
		speed = 12,
		attackSpeed = 1.2
	},
	[3] = {
		reward = 1000,
		health = 200,
		damage = 7,
		speed = 12,
		attackSpeed = 1.2
	},
	[4] = {
		reward = 3500,
		health = 350,
		damage = 9,
		speed = 12,
		attackSpeed = 1.2
	},
	[5] = {
		reward = 10000,
		health = 500,
		damage = 13,
		speed = 12,
		attackSpeed = 1.2
	},
	[6] = {
		reward = 30000,
		health = 750,
		damage = 20,
		speed = 12,
		attackSpeed = 1.2
	},
	[7] = {
		reward = 96000,
		health = 1200,
		damage = 27,
		speed = 12,
		attackSpeed = 1.2
	},
	[8] = {
		reward = 288000,
		health = 1800,
		damage = 37,
		speed = 12,
		attackSpeed = 1.2
	},
	[9] = {
		reward = 928000,
		health = 2900,
		damage = 50,
		speed = 12,
		attackSpeed = 1.2
	},
	[10] = {
		reward = 2944000,
		health = 4600,
		damage = 70,
		speed = 12,
		attackSpeed = 1.2
	},
	[11] = {
		reward = 9500000,
		health = 7400,
		damage = 100,
		speed = 12,
		attackSpeed = 1.2
	},
	[12] = {
		reward = 30200000,
		health = 11800,
		damage = 150,
		speed = 12,
		attackSpeed = 1.2
	},
	[13] = {
		reward = 96700000,
		health = 18900,
		damage = 225,
		speed = 12,
		attackSpeed = 1.2
	},
	[14] = {
		reward = 290000000,
		health = 28300,
		damage = 337,
		speed = 12,
		attackSpeed = 1.2
	},
	[15] = {
		reward = 870000000,
		health = 42500,
		damage = 505,
		speed = 12,
		attackSpeed = 1.2
	},
	[16] = {
		reward = 2610000000,
		health = 64000,
		damage = 757,
		speed = 12,
		attackSpeed = 1.2
	},
	[17] = {
		reward = 7830000000,
		health = 96000,
		damage = 1135,
		speed = 12,
		attackSpeed = 1.2
	},
	[18] = {
		reward = 23500000000,
		health = 144000,
		damage = 1700,
		speed = 12,
		attackSpeed = 1.2
	},
	[19] = {
		reward = 70500000000,
		health = 216000,
		damage = 2550,
		speed = 12,
		attackSpeed = 1.2
	},
	[20] = {
		reward = 211500000000,
		health = 324000,
		damage = 3825,
		speed = 12,
		attackSpeed = 1.2
	},
	[21] = {
		reward = 634500000000,
		health = 486000,
		damage = 5737,
		speed = 12,
		attackSpeed = 1.2
	},
	[22] = {
		reward = 1900000000000,
		health = 729000,
		damage = 8605,
		speed = 12,
		attackSpeed = 1.2
	},
	[23] = {
		reward = 5700000000000,
		health = 1090000,
		damage = 12900,
		speed = 12,
		attackSpeed = 1.2
	},
	[24] = {
		reward = 17100000000000,
		health = 1630000,
		damage = 19350,
		speed = 12,
		attackSpeed = 1.2
	},
	[25] = {
		reward = 51300000000000,
		health = 2440000,
		damage = 29000,
		speed = 12,
		attackSpeed = 1.2
	}
}
local t2 = {
	Color3.fromRGB(111, 0, 255),
	Color3.fromRGB(2, 1, 22)
}

return {
	getEnemyColors = function() --[[ getEnemyColors ]] -- line: 241
		-- upvalues: t2 (copy)
		return t2
	end,
	getEnemyInfo = function(n1: number) --[[ getEnemyInfo ]] -- line: 245
		-- upvalues: t1 (copy)
		return t1[n1]
	end,
	applyMutationVisuals = function(p1, n2: number, p2) --[[ applyMutationVisuals ]] -- line: 249
		-- upvalues: Mutations (copy), ReplicatedStorage (copy)
		if not Mutations.has(p2, "inverted") then
			return
		end

		for _, v15 in p1:GetDescendants() do
			if v15:IsA("BasePart") then
				local SurfaceAppearance = v15:FindFirstChildWhichIsA("SurfaceAppearance")

				if SurfaceAppearance ~= nil then
					local Assets = ReplicatedStorage:FindFirstChild("Assets")
					local v18 = Assets and Assets:FindFirstChild("InvertedEnemySurfaceAppearances")
					local v19 = v18 and v18:FindFirstChild((tostring(n2)))
					local v20 = if not v19 or not v19:IsA("SurfaceAppearance") then nil else v19

					if v20 ~= nil then
						local clone = v20:Clone()

						clone.Name = SurfaceAppearance.Name
						SurfaceAppearance:Destroy()
						clone.Parent = v15
					end
				end
			end
		end
	end,
	getModel = function(n3: number) --[[ getModel ]] -- line: 276
		-- upvalues: ReplicatedStorage (copy)
		local v23 = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Enemies"):FindFirstChild((tostring(n3)))

		assert(v23 ~= nil, "Enemy model not found: " .. tostring(n3))
		assert(v23:IsA("Model"), "Enemy asset must be a Model: " .. tostring(n3))

		return v23
	end
}
