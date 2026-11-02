-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local LocalPlayer = Players.LocalPlayer
local v1 = GUI.PetList()
local Pets = GUI.SideButtons().Left.Tools.Pets
local EquipBest = v1.Frame.EquipBest
local Badge = Pets.Badge
local Badge2 = EquipBest.Badge
local v2 = nil
local v3 = nil

assert(v1:IsA("ScreenGui"), "PlayerGui.PetList must be a ScreenGui")
assert(Pets:IsA("GuiButton"), "Elements.Tabs.Pets must be a GuiButton")
assert(EquipBest:IsA("GuiButton"), "PetList.Frame.EquipBest must be a GuiButton")
assert(Badge:IsA("Frame"), "Elements.Tabs.Pets.Badge must be a Frame")
assert(Badge2:IsA("Frame"), "PetList.Frame.EquipBest.Badge must be a Frame")

local t = {}

local function stopBadgePulse(p1, p2) --[[ stopBadgePulse | Line: 60 | Upvalues: GetOrCreateUIScale (copy) ]]
	if p2 == nil then
		GetOrCreateUIScale(p1).Scale = 1
		p1.Visible = false

		return nil
	end

	p2:Cancel()
	p2:Destroy()
	GetOrCreateUIScale(p1).Scale = 1
	p1.Visible = false

	return nil
end

local function startBadgePulse(p1, p2) --[[ startBadgePulse | Line: 70 | Upvalues: GetOrCreateUIScale (copy), Tween (copy) ]]
	p1.Visible = true

	if p2 == nil then
		local v1 = GetOrCreateUIScale(p1)

		v1.Scale = 0.8

		return Tween(v1, {
			Scale = 1.2
		}, {
			0.7,
			Enum.EasingStyle.Elastic,
			Enum.EasingDirection.Out,
			-1,
			true
		})
	end

	return p2
end

local function refresh() --[[ refresh | Line: 85 | Upvalues: Save (copy), LocalPlayer (copy), v2 (ref), startBadgePulse (copy), Badge (copy), GetOrCreateUIScale (copy), v3 (ref), Badge2 (copy) ]]
	local v1 = Save.Get(LocalPlayer)
	local v22 = if v1 == nil then nil else v1.PetPenCapacityGuidance
	local v32 = if v22 == nil then false else v22.Triggered and not v22.PetsTabAcknowledged
	local v4 = if v22 == nil then false else v22.Triggered and not v22.EquipBestAcknowledged

	if v32 then
		v2 = startBadgePulse(Badge, v2)
	else
		local v5 = Badge
		local v6 = v2

		if v6 ~= nil then
			v6:Cancel()
			v6:Destroy()
		end

		GetOrCreateUIScale(v5).Scale = 1
		v5.Visible = false
		v2 = nil
	end

	if v4 then
		v3 = startBadgePulse(Badge2, v3)

		return
	end

	local v7 = Badge2
	local v8 = v3

	if v8 == nil then
		GetOrCreateUIScale(v7).Scale = 1
		v7.Visible = false
		v3 = nil

		return
	end

	v8:Cancel()
	v8:Destroy()
	GetOrCreateUIScale(v7).Scale = 1
	v7.Visible = false
	v3 = nil
end

function t.AcknowledgePetsBadge() --[[ AcknowledgePetsBadge | Line: 107 | Upvalues: Badge (copy), v2 (ref), GetOrCreateUIScale (copy), wcall (copy), AssetCmds (copy), refresh (copy) ]]
	if not Badge.Visible then
		return
	end

	local v1 = Badge
	local v22 = v2

	if v22 ~= nil then
		v22:Cancel()
		v22:Destroy()
	end

	GetOrCreateUIScale(v1).Scale = 1
	v1.Visible = false
	v2 = nil
	task.spawn(function() --[[ Line: 112 | Upvalues: wcall (ref), AssetCmds (ref), refresh (ref) ]]
		local v1, v2 = wcall(AssetCmds.AcknowledgePenFullPetsBadge)

		if v1 and v2 == true then
			return
		end

		refresh()
	end)
end
function t.AcknowledgeEquipBestBadge() --[[ AcknowledgeEquipBestBadge | Line: 120 | Upvalues: Badge2 (copy), v3 (ref), GetOrCreateUIScale (copy), wcall (copy), AssetCmds (copy), refresh (copy) ]]
	if not Badge2.Visible then
		return
	end

	local v1 = Badge2
	local v2 = v3

	if v2 == nil then
		GetOrCreateUIScale(v1).Scale = 1
		v1.Visible = false
		v3 = nil
		task.spawn(function() --[[ Line: 125 | Upvalues: wcall (ref), AssetCmds (ref), refresh (ref) ]]
			local v1, v2 = wcall(AssetCmds.AcknowledgePenFullEquipBestBadge)

			if v1 and v2 == true then
				return
			end

			refresh()
		end)

		return
	end

	v2:Cancel()
	v2:Destroy()
	GetOrCreateUIScale(v1).Scale = 1
	v1.Visible = false
	v3 = nil
	task.spawn(function() --[[ Line: 125 | Upvalues: wcall (ref), AssetCmds (ref), refresh (ref) ]]
		local v1, v2 = wcall(AssetCmds.AcknowledgePenFullEquipBestBadge)

		if v1 and v2 == true then
			return
		end

		refresh()
	end)
end
function t.Initialize() --[[ Initialize | Line: 133 | Upvalues: Save (copy), refresh (copy) ]]
	Save.GetStatChangedSignal("PetPenCapacityGuidance"):Connect(refresh)
	task.spawn(refresh)
end

return t