-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Variables = require(ReplicatedStorage.Library.Shared.Variables)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Player = require(ReplicatedStorage.Library.Player)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local t = {
	ActiveEggs = {}
}

function t.ComputePositions(p1, p2, p3) --[[ ComputePositions | Line: 11 | Upvalues: Variables (copy), Player (copy), Asserts (copy), t (copy), PlotCmds (copy) ]]
	local ExclusiveEggSpacingRadius = Variables.ExclusiveEggSpacingRadius
	local ExclusiveEggRadiusRange = Variables.ExclusiveEggRadiusRange
	local ExclusiveEggRadiusStep = Variables.ExclusiveEggRadiusStep
	local ExclusiveEggMaxHeight = Variables.ExclusiveEggMaxHeight
	local ExclusiveEggHeightOffset = Variables.ExclusiveEggHeightOffset
	local v1 = p1 or 1
	local v2 = 360 / (v1 * 6)
	local v3 = Player.Optional.PrimaryPart()

	if not v3 then
		return nil
	end

	local v4 = Player.Optional.Humanoid()

	if not v4 then
		return nil
	end

	Asserts.optional.Vector3(p3)

	local v5 = p3 and CFrame.new(p3) or v3.CFrame
	local Position = v5.Position
	local v7 = Position - v5.UpVector * Vector3.new(0, v4.HipHeight + v3.Size.Y / 2, 0)
	local t2 = {}

	for k in pairs(t.ActiveEggs) do
		if not k.completed then
			table.insert(t2, k.position)
		end
	end

	if p2 then
		for i, v in ipairs(p2) do
			Asserts.Vector3(v)
			table.insert(t2, v)
		end
	end

	local t3 = {}
	local __OBJECTS = workspace:FindFirstChild("__OBJECTS")

	if __OBJECTS then
		local Build = __OBJECTS:FindFirstChild("Build")

		if Build then
			table.insert(t3, Build)
		end
	end

	local v8 = PlotCmds.GetPlotsFolder()

	if v8 then
		table.insert(t3, v8)
	end

	if #t3 == 0 then
		return nil
	end

	local v9 = RaycastParams.new()

	v9.FilterDescendantsInstances = t3
	v9.FilterType = Enum.RaycastFilterType.Include
	v9.IgnoreWater = false
	v9.RespectCanCollide = false

	local function canSee(p1, p2) --[[ canSee | Line: 80 | Upvalues: ExclusiveEggSpacingRadius (copy), Position (copy), v7 (copy), v9 (copy) ]]
		local CurrentCamera = workspace.CurrentCamera
		local v2 = p1 + Vector3.new(0, ExclusiveEggSpacingRadius, 0)

		for i, v in ipairs({
			{ CurrentCamera.Focus.Position, v2 },
			{ Position, v2 },
			{ v7 + Vector3.new(0, 0.25, 0), v2 },
			{ CurrentCamera.Focus.Position, p1 },
			{ Position, p1 },
			{ v7 + Vector3.new(0, 0.25, 0), p1 }
		}) do
			local v3 = v[1]
			local v5 = workspace:Raycast(v3, v[2] - v3, v9)

			if v5 then
				assert(v5, "Raycast result is nil")

				if v5.Instance ~= p2 then
					return false
				end
			end
		end

		return true
	end

	local function tryFind() --[[ tryFind | Line: 106 | Upvalues: v5 (copy), ExclusiveEggRadiusRange (copy), ExclusiveEggRadiusStep (copy), v2 (copy), ExclusiveEggSpacingRadius (copy), Position (copy), ExclusiveEggHeightOffset (copy), ExclusiveEggMaxHeight (copy), v9 (copy), t2 (copy), canSee (copy) ]]
		local _, v1 = v5:ToOrientation()
		local list = { -1, 1 }
		local v22 = v1 + 1.5707963267948966

		for i = ExclusiveEggRadiusRange.X, ExclusiveEggRadiusRange.Y, ExclusiveEggRadiusStep do
			for j = 0, 180, v2 do
				for i2, v in ipairs(list) do
					local v3 = ExclusiveEggSpacingRadius + i
					local v4 = math.rad(j * v) - v22
					local v52 = v3 * math.cos(v4)
					local v6 = v3 * math.sin(v4)
					local v11 = workspace:Raycast(Position + Vector3.new(v52, 0, v6) + Vector3.new(0, ExclusiveEggHeightOffset, 0), Vector3.new(0, -(ExclusiveEggMaxHeight + ExclusiveEggHeightOffset), 0), v9) or nil

					if v11 then
						assert(v11, "Ground result is nil")

						local Position2 = v11.Position
						local v12 = false

						for i3, v13 in ipairs(t2) do
							if (Position2 - v13).Magnitude <= 2 * ExclusiveEggSpacingRadius then
								v12 = true

								break
							end
						end

						if not v12 and canSee(Position2, v11.Instance) then
							return Position2
						end
					end
				end
			end
		end
	end

	local t4 = {}

	for i = 1, v1 do
		local v10 = tryFind()

		if not v10 then
			return nil
		end

		assert(v10, "Found position is nil")
		table.insert(t4, v10)
		table.insert(t2, v10)
	end

	return t4
end

return t