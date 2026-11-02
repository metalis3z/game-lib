-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GameplayServiceUtils, time of decompilation: Sun May  3 10:11:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	enums = {
		slimeStates = {
			following = 1,
			targeting = 2,
			attacking = 3,
			knockedOut = 4
		},
		enemyStates = {
			followingPlayer = 1,
			targetingSlime = 2,
			attacking = 3
		}
	},
	moveTowards = function(vector3: Vector3, vector3_2: Vector3, n1: number, n2: number) --[[ moveTowards ]] -- line: 61
		local v7 = vector3_2 - vector3
		local Magnitude = v7.Magnitude

		if Magnitude == 0 or Magnitude ~= Magnitude then
			return vector3_2
		end

		local v9 = math.max(n1 * n2, 0)

		if v9 == 0 then
			return vector3
		end

		if Magnitude <= v9 then
			return vector3_2
		end

		return vector3 + v7.Unit * v9
	end,
	getSmoothingAlpha = function(n3: number, n4: number) --[[ getSmoothingAlpha ]] -- line: 80
		if n3 <= 0 or n4 <= 0 then
			return 0
		end

		return 1 - math.exp(-n3 * n4)
	end
}

function t1.smoothDirection(vector3: Vector3, vector3_3: Vector3?, n5: number, n6: number) -- line: 88
	-- upvalues: t1 (copy)
	local v16 = vector3

	if vector3_3 and (vector3_3.Magnitude > 0 and vector3_3.Magnitude == vector3_3.Magnitude) then
		v16 = vector3_3.Unit
	end

	if v16.Magnitude <= 0 or v16.Magnitude ~= v16.Magnitude then
		v16 = Vector3.new(0, 0, 1)
	end

	local v17 = vector3:Lerp(v16, (t1.getSmoothingAlpha(n5, n6)))

	if v17.Magnitude <= 0 or v17.Magnitude ~= v17.Magnitude then
		v17 = v16
	end

	return v17.Unit
end
function t1.predictFluidMovement(vector3: Vector3, vector3_4: Vector3, vector3_5: Vector3, n7: number, n8: number, n9: number, n10: number) -- line: 112
	-- upvalues: t1 (copy)
	local vector3_6 = Vector3.new(vector3.X, 0, vector3.Z)
	local vector3_7 = Vector3.new(vector3_4.X, 0, vector3_4.Z)
	local vector3_8 = Vector3.new(vector3_5.X, 0, vector3_5.Z)
	local v28 = vector3_8 - vector3_6
	local Magnitude = v28.Magnitude

	if Magnitude ~= Magnitude then
		return vector3_6, (Vector3.new(0, 0, 0))
	end

	local vector3_9 = Vector3.new(0, 0, 0)

	if Magnitude > 0.001 then
		vector3_9 = v28.Unit
	end

	local n11 = 0

	if n7 > 0 and Magnitude > 0.001 then
		n11 = n7 * math.clamp(Magnitude / math.max(n9, 0.001), 0, 1)
	end

	local v32 = vector3_7:Lerp(vector3_9 * n11, (t1.getSmoothingAlpha(n8, n10)))

	if v32.Magnitude <= 0.001 then
		v32 = Vector3.new(0, 0, 0)
	end

	local v33 = vector3_6 + v32 * math.max(n10, 0)
	local v34 = vector3_8 - v33

	if Magnitude <= 0.001 or Magnitude > 0.001 and vector3_9:Dot(v34) < 0 then
		return vector3_8, (Vector3.new(0, 0, 0))
	end

	return Vector3.new(v33.X, 0, v33.Z), (Vector3.new(v32.X, 0, v32.Z))
end

return t1
