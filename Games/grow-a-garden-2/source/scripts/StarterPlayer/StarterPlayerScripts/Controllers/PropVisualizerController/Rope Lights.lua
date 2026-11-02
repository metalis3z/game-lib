--credit to leon games studio
local Networking = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"))
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SmartProximityPrompt = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt"))
local t = {
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 60, 60),
	Color3.fromRGB(255, 150, 60),
	Color3.fromRGB(255, 235, 80),
	Color3.fromRGB(255, 130, 200),
	Color3.fromRGB(170, 95, 255),
	Color3.fromRGB(80, 255, 120),
	Color3.fromRGB(80, 160, 255)
}

return function(p1) --[[ Line: 21 | Upvalues: Players (copy), t (copy), RunService (copy), SmartProximityPrompt (copy), Networking (copy) ]]
	local v1

	repeat
		v1 = Players:GetPlayerByUserId(p1:GetAttribute("UserId"))
	until v1

	local function extractNameNumber(p1) --[[ extractNameNumber | Line: 26 ]]
		local v1 = p1:match("(%d+)")

		return if v1 then tonumber(v1) or nil else nil
	end

	local function isNight() --[[ isNight | Line: 31 ]]
		return workspace:GetAttribute("ActivePhase") == "Night"
	end

	local function clampColorId(p1) --[[ clampColorId | Line: 36 | Upvalues: t (ref) ]]
		return (math.floor(tonumber(p1) or 1) - 1) % #t + 1
	end

	local function parseColorId(p1) --[[ parseColorId | Line: 44 | Upvalues: t (ref) ]]
		if type(p1) == "number" then
			return (math.floor(tonumber(p1) or 1) - 1) % #t + 1
		end

		if type(p1) == "string" then
			return (math.floor(tonumber(tonumber((p1:match("(%d+)"))) or 1) or 1) - 1) % #t + 1
		end

		return 1
	end

	local function collectBulbs(p1) --[[ collectBulbs | Line: 55 ]]
		local t = {}
		local t2 = {}

		for v1, v2 in (p1:FindFirstChild("Build") or p1):GetDescendants() do
			if v2:IsA("BasePart") then
				local v4 = tonumber((v2:GetAttribute("String")))

				if v4 then
					t[v4] = t[v4] or {}
					table.insert(t[v4], v2)
				end
			end
		end

		for v7, v8 in t do
			table.sort(v8, function(p1, p2) --[[ Line: 73 ]]
				local v1 = tonumber(p1:GetAttribute("Index"))
				local v2 = tonumber(p2:GetAttribute("Index"))

				if v1 and (v2 and v1 ~= v2) then
					return v1 < v2
				end

				local v4 = p1.Name:match("(%d+)")
				local v5 = v4 and tonumber(v4) or nil
				local v7 = p2.Name:match("(%d+)")
				local v8 = v7 and tonumber(v7) or nil

				if v5 and (v8 and v5 ~= v8) then
					return v5 < v8
				end

				local Position = p1.Position
				local Position2 = p2.Position

				if Position.X == Position2.X then
					if Position.Z == Position2.Z then
						return Position.Y < Position2.Y
					end

					return Position.Z < Position2.Z
				end

				return Position.X < Position2.X
			end)

			for i, v in ipairs(v8) do
				local t3 = {}

				for v9, v10 in v:GetChildren() do
					if v10:IsA("Light") then
						table.insert(t3, {
							Obj = v10,
							BaseBrightness = v10.Brightness
						})
					end
				end

				t2[v] = {
					StringId = v7,
					Index = i,
					Lights = t3
				}
			end
		end

		return t, t2
	end

	local v2 = nil

	local function applyToPart(p1, p2, p3, p4) --[[ applyToPart | Line: 116 ]]
		p1.Material = Enum.Material.Neon
		p1.Color = p3

		for i, v in ipairs(p2.Lights) do
			local Obj = v.Obj

			if Obj and Obj.Parent then
				Obj.Color = p3
				Obj.Brightness = v.BaseBrightness * p4
			end
		end
	end

	local function applyStyle(p12) --[[ applyStyle | Line: 129 | Upvalues: v2 (ref), t (ref), collectBulbs (copy), p1 (copy), applyToPart (copy), RunService (ref) ]]
		if v2 then
			v2:Disconnect()
			v2 = nil
		end

		local v4 = t[(math.floor(tonumber(p12) or 1) - 1) % #t + 1]
		local v5, v6 = collectBulbs(p1)
		local v7, v8, _ = v4:ToHSV()
		local v10 = if workspace:GetAttribute("ActivePhase") == "Night" then 1 else 0.5
		local v11 = v10
		local v12 = 1
		local v13 = if workspace:GetAttribute("ActivePhase") == "Night" then true else false

		local function getColor(p1) --[[ getColor | Line: 144 | Upvalues: v7 (copy), v8 (copy) ]]
			return Color3.fromHSV(v7, v8, p1)
		end

		local function getBrightMul(p1) --[[ getBrightMul | Line: 148 ]]
			return (p1 - 0.5) / 0.5 * 0.85 + 0.15
		end

		for v14, v15 in v5 do
			for i, v in ipairs(v15) do
				local v16 = v6[v]

				if v16 then
					applyToPart(v, v16, Color3.fromHSV(v7, v8, v10), (v10 - 0.5) / 0.5 * 0.85 + 0.15)
				end
			end
		end

		v2 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 161 | Upvalues: p1 (ref), v2 (ref), v13 (ref), v11 (ref), v12 (ref), v10 (ref), v7 (copy), v8 (copy), v5 (copy), v6 (copy), applyToPart (ref) ]]
			if p1.Parent then
				local v1 = if workspace:GetAttribute("ActivePhase") == "Night" then true else false

				if v1 ~= v13 then
					v13 = v1
					v11 = if v1 then 1 else 0.5
					v12 = 0
				end

				if v12 >= 1 then
					return
				end

				v12 = math.min(v12 + p12, 1)

				local v4 = v12 / 1
				local v62 = if v11 == 1 then 0.5 else 1

				v10 = v62 + (v11 - v62) * (v4 * v4 * (3 - v4 * 2))

				local v9 = (v10 - 0.5) / 0.5 * 0.85 + 0.15
				local v102 = Color3.fromHSV(v7, v8, v10)

				for v112, v122 in v5 do
					for i, v in ipairs(v122) do
						local v132 = v6[v]

						if v132 then
							applyToPart(v, v132, v102, v9)
						end
					end
				end
			else
				if not v2 then
					return
				end

				v2:Disconnect()
				v2 = nil
			end
		end)
	end

	local function applyFromAttribute() --[[ applyFromAttribute | Line: 203 | Upvalues: p1 (copy), t (ref), applyStyle (copy) ]]
		local v1 = p1:GetAttribute("ExtraData")

		applyStyle(if type(v1) == "number" then (math.floor(tonumber(v1) or 1) - 1) % #t + 1 elseif type(v1) == "string" then (math.floor(tonumber(tonumber((v1:match("(%d+)"))) or 1) or 1) - 1) % #t + 1 else 1)
	end

	local v3 = p1:GetAttribute("ExtraData")
	local v4 = if type(v3) == "number" then (math.floor(tonumber(v3) or 1) - 1) % #t + 1 elseif type(v3) == "string" then (math.floor(tonumber(tonumber((v3:match("(%d+)"))) or 1) or 1) - 1) % #t + 1 else 1

	applyStyle(v4)
	p1:GetAttributeChangedSignal("ExtraData"):Connect(applyFromAttribute)

	if v1 == Players.LocalPlayer then
		local Primary = p1:FindFirstChild("Primary")

		if not (Primary and Primary:FindFirstChild("ChangeColour")) then
			return
		end

		local ChangeColour = Primary.ChangeColour

		if not (ChangeColour and ChangeColour:IsA("ProximityPrompt")) then
			return
		end

		SmartProximityPrompt.AttachToModel(ChangeColour, p1, {
			PartName = "ChangeColourPart",
			MaxActivationDistance = 10,
			TrackDistance = 24,
			SurfaceOffset = 0.75,
			FollowSpeed = 18
		})
		ChangeColour.Triggered:Connect(function() --[[ Line: 230 | Upvalues: p1 (copy), t (ref), Networking (ref) ]]
			local v1 = p1:GetAttribute("ExtraData")
			local v13 = (math.floor(tonumber((if type(v1) == "number" then (math.floor(tonumber(v1) or 1) - 1) % #t + 1 elseif type(v1) == "string" then (math.floor(tonumber(tonumber((v1:match("(%d+)"))) or 1) or 1) - 1) % #t + 1 else 1) + 1) or 1) - 1) % #t + 1

			Networking.Prop.SetPropExtraData:Fire(p1:GetAttribute("PropId") or p1.Name, (tostring(v13)))
		end)
	else
		local Primary = p1:FindFirstChild("Primary")

		if not Primary then
			return
		end

		Primary:ClearAllChildren()
	end
end