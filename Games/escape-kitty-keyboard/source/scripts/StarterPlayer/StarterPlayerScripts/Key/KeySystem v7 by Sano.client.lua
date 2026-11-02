

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("SoundService")
local u4 = v1.LocalPlayer
local u5 = v3:WaitForChild("SoundBank", 10)
local u6 = u4:GetAttribute("KeyVolume") or 1
local u7 = u4:GetAttribute("EquippedSoundPack") or "Default"
local u8 = Random.new()
local u9 = table.create(40)
local u10 = { "rbxassetid://123413227426138" }
local u11 = {}
local u12 = {
	["BASE_DETECTION_SIZE"] = Vector3.new(2.5, 5, 2.5),
	["LERP_SPEED_DOWN"] = 20,
	["LERP_SPEED_UP"] = 8,
	["HOLD_TIME"] = 0.15,
	["VELOCITY_PADDING"] = 1.2,
	["SOUND_COOLDOWN"] = 0.03
}
local u13 = 1
local u14 = {
	["MusicalKey"] = {
		["PRESS_DEPTH"] = 1.4
	},
	["MusicalKey2"] = {
		["PRESS_DEPTH"] = 1
	}
}
local u15 = {}
local u16 = 0
local u17 = {}
for v18 = 1, 40 do
	local v19 = Instance.new("Sound")
	v19.RollOffMaxDistance = 100
	v19.RollOffMinDistance = 10
	u9[v18] = v19
end
u4:GetAttributeChangedSignal("KeyVolume"):Connect(function()

	u6 = u4:GetAttribute("KeyVolume") or 1
end)
u4:GetAttributeChangedSignal("EquippedSoundPack"):Connect(function()

	u7 = u4:GetAttribute("EquippedSoundPack") or "Default"
end)
local function u25(p20) 

	if u17[p20] then
		return u17[p20]
	end
	local v21 = {}
	if u5 then
		local v22 = u5:FindFirstChild(p20)
		if v22 then
			for _, v23 in ipairs(v22:GetChildren()) do
				if v23:IsA("Sound") and v23.SoundId ~= "" then
					local v24 = v23.SoundId
					table.insert(v21, v24)
				end
			end
		end
	end
	if #v21 == 0 then
		v21 = u10
	end
	u17[p20] = v21
	return v21
end
local u26 = OverlapParams.new()
u26.FilterType = Enum.RaycastFilterType.Include
u26:AddToFilter(workspace.Keycaps)
v2.RenderStepped:Connect(function(p27)

	local v28 = os.clock()
	local v29 = u4.Character
	if v29 then
		v29 = v29:FindFirstChild("HumanoidRootPart")
	end
	if v29 then
		local v30 = v29.AssemblyLinearVelocity
		local v31 = v30.X
		local v32 = math.abs(v31) * p27 * u12.VELOCITY_PADDING
		local v33 = v30.Z
		local v34 = math.abs(v33) * p27 * u12.VELOCITY_PADDING
		local v35 = u12.BASE_DETECTION_SIZE + Vector3.new(v32, 0, v34)
		local v36 = workspace:GetPartBoundsInBox(v29.CFrame * CFrame.new(0, -2.5, 0), v35, u26)
		for _, v37 in ipairs(v36) do
			local v38 = u14[v37:GetAttribute("MusicType")] or u14.MusicalKey
			local v39 = u15[v37]
			if not v39 then
				v39 = {
					["currentAlpha"] = 0,
					["targetAlpha"] = 0,
					["lastHit"] = 0,
					["originalCF"] = v37.CFrame,
					["pressDepth"] = v38.PRESS_DEPTH
				}
				u15[v37] = v39
			end
			if v39.targetAlpha == 0 and v28 - u16 >= u12.SOUND_COOLDOWN then
				if u6 > 0 then
					local v40 = u25(u7)
					local v41 = u9[u13]
					u13 = u13 % 40 + 1
					v41.SoundId = v40[u8:NextInteger(1, #v40)]
					v41.Volume = u6
					v41.Parent = v37
					v41:Play()
				end
				u16 = v28
			end
			v39.targetAlpha = 1
			v39.lastHit = v28
			u11[v37] = true
		end
	end
	local v42 = {}
	local v43 = {}
	for v44, _ in pairs(u11) do
		local v45 = u15[v44]
		if v28 - v45.lastHit > u12.HOLD_TIME then
			v45.targetAlpha = 0
		end
		local v46 = v45.targetAlpha == 1 and u12.LERP_SPEED_DOWN or u12.LERP_SPEED_UP
		local v47 = v45.currentAlpha
		local v48 = v45.targetAlpha - v45.currentAlpha
		local v49 = p27 * v46
		v45.currentAlpha = v47 + v48 * math.clamp(v49, 0, 1)
		local v50
		if v45.targetAlpha == 0 then
			v50 = v45.currentAlpha < 0.01
		else
			v50 = false
		end
		local v51 = v50 and v45.originalCF or v45.originalCF * CFrame.new(0, -v45.currentAlpha * v45.pressDepth, 0)
		if v50 then
			v45.currentAlpha = 0
			u11[v44] = nil
		end
		table.insert(v42, v44)
		table.insert(v43, v51)
	end
	workspace:BulkMoveTo(v42, v43)
end)