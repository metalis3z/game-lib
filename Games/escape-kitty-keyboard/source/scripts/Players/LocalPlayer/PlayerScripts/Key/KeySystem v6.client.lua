-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
	["MusicalKey"] = {
		["PRESS_DEPTH"] = 1.4
	},
	["MusicalKey2"] = {
		["PRESS_DEPTH"] = 1
	}
}
local u12 = {}
local u13 = 0
local u14 = {}
local u15 = {
	["BASE_DETECTION_SIZE"] = Vector3.new(2.5, 5, 2.5),
	["LERP_SPEED_DOWN"] = 20,
	["LERP_SPEED_UP"] = 8,
	["HOLD_TIME"] = 0.15,
	["VELOCITY_PADDING"] = 1.2,
	["SOUND_COOLDOWN"] = 0.03
}
local u16 = {}
local u17 = { "rbxassetid://123413227426138" }
local u18 = 1
for v19 = 1, 40 do
	local v20 = Instance.new("Sound")
	v20.RollOffMaxDistance = 100
	v20.RollOffMinDistance = 10
	u10[v19] = v20
end
u5:GetAttributeChangedSignal("KeyVolume"):Connect(function()
	-- upvalues: (ref) u7, (copy) u5
	u7 = u5:GetAttribute("KeyVolume") or 1
end)
u5:GetAttributeChangedSignal("EquippedSoundPack"):Connect(function()
	-- upvalues: (ref) u8, (copy) u5
	u8 = u5:GetAttribute("EquippedSoundPack") or "Default"
end)
local function u26(p21) -- name: getSoundList
	-- upvalues: (copy) u12, (copy) u6, (copy) u17
	if u12[p21] then
		return u12[p21]
	end
	local v22 = {}
	if u6 then
		local v23 = u6:FindFirstChild(p21)
		if v23 then
			for _, v24 in ipairs(v23:GetChildren()) do
				if v24:IsA("Sound") and v24.SoundId ~= "" then
					local v25 = v24.SoundId
					table.insert(v22, v25)
				end
			end
		end
	end
	if #v22 == 0 then
		v22 = u17
	end
	u12[p21] = v22
	return v22
end
local u27 = OverlapParams.new()
u27.FilterType = Enum.RaycastFilterType.Exclude
v2.RenderStepped:Connect(function(p28)
	-- upvalues: (copy) u5, (copy) u27, (copy) u15, (copy) u11, (copy) u4, (copy) u16, (ref) u13, (ref) u7, (copy) u26, (ref) u8, (copy) u10, (ref) u18, (copy) u9, (copy) u14
	local v29 = os.clock()
	local v30 = u5.Character
	local v31
	if v30 then
		v31 = v30:FindFirstChild("HumanoidRootPart")
	else
		v31 = v30
	end
	if v31 then
		u27.FilterDescendantsInstances = { v30 }
		local v32 = v31.AssemblyLinearVelocity
		local v33 = v32.X
		local v34 = math.abs(v33) * p28 * u15.VELOCITY_PADDING
		local v35 = v32.Z
		local v36 = math.abs(v35) * p28 * u15.VELOCITY_PADDING
		local v37 = u15.BASE_DETECTION_SIZE + Vector3.new(v34, 0, v36)
		local v38 = workspace:GetPartBoundsInBox(v31.CFrame * CFrame.new(0, -2.5, 0), v37, u27)
		for _, v39 in ipairs(v38) do
			local v40 = nil
			for v41, v42 in pairs(u11) do
				if u4:HasTag(v39, v41) then
					v40 = v42
					break
				end
			end
			if v40 then
				local v43 = u16[v39]
				if not v43 then
					v43 = {
						["currentAlpha"] = 0,
						["targetAlpha"] = 0,
						["lastHit"] = 0,
						["originalCF"] = v39.CFrame,
						["pressDepth"] = v40.PRESS_DEPTH
					}
					u16[v39] = v43
				end
				if v43.targetAlpha == 0 and v29 - u13 >= u15.SOUND_COOLDOWN then
					if u7 > 0 then
						local v44 = u26(u8)
						local v45 = u10[u18]
						u18 = u18 % 40 + 1
						v45.SoundId = v44[u9:NextInteger(1, #v44)]
						v45.Volume = u7
						v45.Parent = v39
						v45:Play()
					end
					u13 = v29
				end
				v43.targetAlpha = 1
				v43.lastHit = v29
				u14[v39] = true
			end
		end
	end
	for v46, _ in pairs(u14) do
		local v47 = u16[v46]
		if v29 - v47.lastHit > u15.HOLD_TIME then
			v47.targetAlpha = 0
		end
		local v48 = v47.targetAlpha == 1 and u15.LERP_SPEED_DOWN or u15.LERP_SPEED_UP
		local v49 = v47.currentAlpha
		local v50 = v47.targetAlpha - v47.currentAlpha
		local v51 = p28 * v48
		v47.currentAlpha = v49 + v50 * math.clamp(v51, 0, 1)
		v46.CFrame = v47.originalCF * CFrame.new(0, -v47.currentAlpha * v47.pressDepth, 0)
		if v47.targetAlpha == 0 and v47.currentAlpha < 0.01 then
			v46.CFrame = v47.originalCF
			v47.currentAlpha = 0
			u14[v46] = nil
		end
	end
end)