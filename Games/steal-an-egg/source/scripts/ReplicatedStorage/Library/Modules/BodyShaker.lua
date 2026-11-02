-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local t = {}
local v1 = false
local t2 = {}

local function disconnectConnections() --[[ disconnectConnections | Line: 30 | Upvalues: t (copy) ]]
	for v1, v2 in t do
		v2:Disconnect()
	end

	table.clear(t)
end

local function getShakeJoints(p1) --[[ getShakeJoints | Line: 38 ]]
	local UpperTorso = p1:WaitForChild("UpperTorso")
	local LowerTorso = p1:WaitForChild("LowerTorso")

	return {
		Neck = p1:WaitForChild("Head"):WaitForChild("Neck"),
		LeftShoulder = UpperTorso:WaitForChild("LeftShoulder"),
		RightShoulder = UpperTorso:WaitForChild("RightShoulder"),
		LeftHip = LowerTorso:WaitForChild("LeftHip"),
		RightHip = LowerTorso:WaitForChild("RightHip")
	}
end

local function getJointDefaults(p1) --[[ getJointDefaults | Line: 52 ]]
	return {
		Neck = p1.Neck.C0,
		LeftShoulder = p1.LeftShoulder.C0,
		RightShoulder = p1.RightShoulder.C0,
		LeftHip = p1.LeftHip.C0,
		RightHip = p1.RightHip.C0
	}
end

local function resetJoints(p1, p2) --[[ resetJoints | Line: 62 ]]
	p1.Neck.C0 = p2.Neck
	p1.LeftShoulder.C0 = p2.LeftShoulder
	p1.RightShoulder.C0 = p2.RightShoulder
	p1.LeftHip.C0 = p2.LeftHip
	p1.RightHip.C0 = p2.RightHip
end

local function shakeBody(p1) --[[ shakeBody | Line: 70 | Upvalues: LocalPlayer (copy), Workspace (copy), getShakeJoints (copy), v1 (ref) ]]
	local v12 = if p1 then p1 else LocalPlayer.Character

	if not v12 then
		return
	end

	repeat
		task.wait()
	until v12:IsDescendantOf(Workspace)

	if v12:GetAttribute("Shaking") then
		return
	end

	v12:SetAttribute("Shaking", true)

	local v2 = getShakeJoints(v12)
	local t = {
		Neck = v2.Neck.C0,
		LeftShoulder = v2.LeftShoulder.C0,
		RightShoulder = v2.RightShoulder.C0,
		LeftHip = v2.LeftHip.C0,
		RightHip = v2.RightHip.C0
	}
	local count = 0

	while v12:IsDescendantOf(Workspace) and v1 do
		task.wait()
		count = count + 1

		local v3 = math.sin(count)
		local v4 = math.rad(v3)
		local v5 = math.rad(-v3)

		v2.LeftShoulder.C0 = t.LeftShoulder * CFrame.Angles(0, v4, 0)
		v2.RightShoulder.C0 = t.RightShoulder * CFrame.Angles(0, -v4, 0)
		v2.RightHip.C0 = t.RightHip * CFrame.Angles(0, v5, 0)
		v2.LeftHip.C0 = t.LeftHip * CFrame.Angles(0, -v5, 0)
		v2.Neck.C0 = t.Neck * CFrame.Angles(0, 0, (math.rad(v3)))
	end

	v2.Neck.C0 = t.Neck
	v2.LeftShoulder.C0 = t.LeftShoulder
	v2.RightShoulder.C0 = t.RightShoulder
	v2.LeftHip.C0 = t.LeftHip
	v2.RightHip.C0 = t.RightHip
	v12:SetAttribute("Shaking", false)
end

function t2.EnableShaking() --[[ EnableShaking | Line: 110 | Upvalues: t (copy), v1 (ref), LocalPlayer (copy), shakeBody (copy) ]]
	for v12, v2 in t do
		v2:Disconnect()
	end

	table.clear(t)
	v1 = true

	local v4

	if not LocalPlayer.Character then
		local v3, v5

		v3 = t
		v4 = LocalPlayer.CharacterAdded
		v5 = shakeBody
		table.insert(t, v4:Connect(shakeBody))

		return
	end

	task.spawn(shakeBody, LocalPlayer.Character)
	v4 = LocalPlayer.CharacterAdded
	table.insert(t, v4:Connect(shakeBody))
end
function t2.DisableShaking() --[[ DisableShaking | Line: 122 | Upvalues: v1 (ref), t (copy) ]]
	v1 = false

	for v12, v2 in t do
		v2:Disconnect()
	end

	table.clear(t)
end

return t2