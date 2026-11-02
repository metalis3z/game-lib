

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("SoundService")
local u4 = game:GetService("CollectionService")
local u5 = v1.LocalPlayer
local u6 = v3:WaitForChild("SoundBank", 10)
local u7 = u5:GetAttribute("KeyVolume") or 1
local u8 = u5:GetAttribute("EquippedSoundPack") or "Default"
local u9 = Random.new()
local u10 = table.create(40)
local u11 = {
	["DETECTION_SIZE"] = Vector3.new(2.5, 5, 2.5),
	["LERP_SPEED"] = 20,
	["HOLD_TIME"] = 0.25,
	["DETECTION_TICK"] = 0.05
}
local u12 = {
	["MusicalKey"] = {
		["PRESS_DEPTH"] = 1.4
	},
	["MusicalKey2"] = {
		["PRESS_DEPTH"] = 1
	}
}
local u13 = {}
local u14 = {}
local u15 = 1
local u16 = {}
local u17 = { "rbxassetid://123413227426138" }
for v18 = 1, 40 do
	local v19 = Instance.new("Sound")
	v19.RollOffMaxDistance = 100
	v19.RollOffMinDistance = 10
	u10[v18] = v19
end
u5:GetAttributeChangedSignal("KeyVolume"):Connect(function()

	u7 = u5:GetAttribute("KeyVolume") or 1
end)
u5:GetAttributeChangedSignal("EquippedSoundPack"):Connect(function()

	u8 = u5:GetAttribute("EquippedSoundPack") or "Default"
end)
local function u25(p20) 

	if u14[p20] then
		return u14[p20]
	end
	local v21 = {}
	if u6 then
		local v22 = u6:FindFirstChild(p20)
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
		v21 = u17
	end
	u14[p20] = v21
	return v21
end
local u26 = OverlapParams.new()
u26.FilterType = Enum.RaycastFilterType.Exclude
task.spawn(function()

	while true do
		if true then
			local v27 = u5.Character
			local v28
			if v27 then
				v28 = v27:FindFirstChild("HumanoidRootPart")
			else
				v28 = v27
			end
		end
		if v28 then
			u26.FilterDescendantsInstances = { v27 }
			local v29 = os.clock()
			local v30 = workspace:GetPartBoundsInBox(v28.CFrame * CFrame.new(0, -2.5, 0), u11.DETECTION_SIZE, u26)
			for _, v31 in ipairs(v30) do
				local v32 = nil
				for v33, v34 in pairs(u12) do
					if u4:HasTag(v31, v33) then
						v32 = v34
					end
				end
				if v32 then
					local v35 = u13[v31]
					if not v35 then
						v35 = {
							["currentAlpha"] = 0,
							["targetAlpha"] = 0,
							["lastHit"] = 0,
							["originalCF"] = v31.CFrame,
							["pressDepth"] = v32.PRESS_DEPTH
						}
						u13[v31] = v35
					end
					if v35.targetAlpha == 0 and u7 > 0 then
						local v36 = u25(u8)
						local v37 = u10[u15]
						u15 = u15 % 40 + 1
						v37.SoundId = v36[u9:NextInteger(1, #v36)]
						v37.Volume = u7
						v37.Parent = v31
						v37:Play()
					end
					v35.targetAlpha = 1
					v35.lastHit = v29
					u16[v31] = true
				end
			end
		end
		task.wait(u11.DETECTION_TICK)
	end
end)
v2.RenderStepped:Connect(function(p38)

	local v39 = os.clock()
	for v40, _ in pairs(u16) do
		local v41 = u13[v40]
		if v39 - v41.lastHit > u11.HOLD_TIME then
			v41.targetAlpha = 0
		end
		local v42 = v41.currentAlpha
		local v43 = v41.targetAlpha - v41.currentAlpha
		local v44 = p38 * u11.LERP_SPEED
		v41.currentAlpha = v42 + v43 * math.clamp(v44, 0, 1)
		v40.CFrame = v41.originalCF * CFrame.new(0, -v41.currentAlpha * v41.pressDepth, 0)
		if v41.targetAlpha == 0 and v41.currentAlpha < 0.01 then
			v40.CFrame = v41.originalCF
			v41.currentAlpha = 0
			u16[v40] = nil
		end
	end
end)