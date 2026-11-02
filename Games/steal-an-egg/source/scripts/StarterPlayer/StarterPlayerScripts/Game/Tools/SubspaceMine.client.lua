-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Audio = require(ReplicatedStorage.Library.Audio)
local SubspaceMine = require(ReplicatedStorage.Directory.Gears._Index.Other.SubspaceMine)
local COOLDOWN = SubspaceMine.COOLDOWN
local SubspaceMine2 = Constants.NETWORK_MAP.SubspaceMine
local LocalPlayer = Players.LocalPlayer
local v1 = 0

local function onActivated(p1) --[[ onActivated | Line: 27 | Upvalues: v1 (ref), LocalPlayer (copy), Network (copy), SubspaceMine2 (copy) ]]
	local v12 = tick()

	if v12 - v1 < 1 then
		return
	end

	if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
		return
	end

	v1 = v12

	local Character = LocalPlayer.Character
	local PrimaryPart = Character.PrimaryPart
	local LookVector = PrimaryPart.CFrame.LookVector
	local v2 = PrimaryPart.Position + LookVector * 4
	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Exclude
	v3.FilterDescendantsInstances = { Character }

	if workspace:Raycast(PrimaryPart.Position, LookVector * 4, v3) then
		return
	end

	local v6 = workspace:Raycast(Vector3.new(v2.X, v2.Y + 5, v2.Z), Vector3.new(0, -100, 0), v3)
	local v7 = if v6 then v6.Position else v2
	local v8 = p1:GetAttribute("GearName")

	if typeof(v8) ~= "string" then
		v8 = p1.Name
	end

	Network.Fire(SubspaceMine2.REQUEST_PLACE, v8, v7)
end

local v2 = ToolSetup.Initialize(SubspaceMine.DisplayName, {
	onActivated = onActivated
})

Network.Fired(SubspaceMine2.TRAP_PLACED):Connect(function() --[[ Line: 78 | Upvalues: ToolSetup (copy), v2 (ref), COOLDOWN (copy), Audio (copy) ]]
	ToolSetup.StartCooldown(v2, COOLDOWN)
	Audio.Play(6290067239, script, { 0.9, 1.1 }, 0.43)
end)
Network.Fired(SubspaceMine2.APPLY_HIGHLIGHT):Connect(function(p1, p2) --[[ Line: 84 | Upvalues: SubspaceMine (copy) ]]
	if p1 and p1.Character then
		local SubspaceMineHighlight = Instance.new("Highlight")

		SubspaceMineHighlight.Name = "SubspaceMineHighlight"
		SubspaceMineHighlight.OutlineColor = SubspaceMine.HIGHLIGHT_COLOR
		SubspaceMineHighlight.FillColor = SubspaceMine.HIGHLIGHT_COLOR
		SubspaceMineHighlight.FillTransparency = 0.5
		SubspaceMineHighlight.OutlineTransparency = 0
		SubspaceMineHighlight.Parent = p1.Character
		task.delay(p2, function() --[[ Line: 99 | Upvalues: SubspaceMineHighlight (copy) ]]
			if not (SubspaceMineHighlight and SubspaceMineHighlight.Parent) then
				return
			end

			SubspaceMineHighlight:Destroy()
		end)
	end
end)