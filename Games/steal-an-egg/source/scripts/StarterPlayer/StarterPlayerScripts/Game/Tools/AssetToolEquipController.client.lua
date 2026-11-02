-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetPlacementHints = require(script.Parent.Parent.Plots.ActiveAssetsController.AssetPlacementHints)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Player = require(ReplicatedStorage.Library.Player)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Color3.fromRGB(85, 255, 85)
local v2 = Color3.fromRGB(255, 70, 70)
local LocalPlayer = Players.LocalPlayer
local v3 = Trove.new()
local v4 = Trove.new()
local v5 = nil
local v6 = nil

local function isAssetTool(p1) --[[ isAssetTool | Line: 32 ]]
	return p1:GetAttribute("ItemType") == "Asset"
end

local function getAssetToolUid(p1) --[[ getAssetToolUid | Line: 36 ]]
	local v1 = p1:GetAttribute("UID")

	if typeof(v1) == "string" and v1 ~= "" then
		return v1
	end

	return nil
end

local function getAssetToolCategory(p1) --[[ getAssetToolCategory | Line: 41 ]]
	local v1 = p1:GetAttribute("Category")

	if typeof(v1) == "string" and v1 ~= "" then
		return v1
	end

	return nil
end

local function isNearPetAreaSurface(p1, p2) --[[ isNearPetAreaSurface | Line: 46 ]]
	local v1 = p1.CFrame:PointToObjectSpace(p2)
	local v2 = p1.Size * 0.5

	return (p2 - p1.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))).Magnitude <= 20
end

local function showGetCloserNotification() --[[ showGetCloserNotification | Line: 59 | Upvalues: Message (copy), v2 (copy) ]]
	Message.Bottom({
		Message = "Get closer to your Pen to place pets!",
		Time = 2,
		PreventDuplicateText = true,
		Color = v2
	})
end

local function showEquipSuccessNotification(p1) --[[ showEquipSuccessNotification | Line: 68 | Upvalues: Assets (copy), Message (copy), v1 (copy) ]]
	local v12 = p1:GetAttribute("Category")
	local v2 = if typeof(v12) == "string" and v12 ~= "" then v12 else nil

	if v2 == nil then
		return
	end

	local v3 = Assets.Directory[v2]
	local v4 = if v3.DisplayName == "" then v2 else v3.DisplayName

	Message.Bottom({
		Time = 2,
		Message = ("Sucessfully equipped <font color=\"#%*\">%*!</font>"):format((if v3.Rarity then v3.Rarity.Color else Color3.new(255/255, 255/255, 255/255)):ToHex(), v4),
		Color = v1
	})
end

local function showEquipErrorNotification(p1) --[[ showEquipErrorNotification | Line: 84 | Upvalues: Message (copy), v2 (copy) ]]
	Message.Bottom({
		Time = 2,
		PreventDuplicateText = true,
		Message = p1,
		Color = v2
	})
end

local function tryEquipToolAsset(p1) --[[ tryEquipToolAsset | Line: 93 | Upvalues: v6 (ref), Player (copy), LocalPlayer (copy), AssetCmds (copy), isNearPetAreaSurface (copy), Message (copy), v2 (copy), AssetPlacementHints (copy), v5 (ref), showEquipSuccessNotification (copy), v4 (copy) ]]
	local v1 = p1:GetAttribute("UID")
	local v22 = if typeof(v1) == "string" and v1 ~= "" then v1 else nil

	if v22 == nil or v6 == v22 then
		return
	end

	local v3 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if v3 ~= nil and not v3:IsA("BasePart") then
		return
	end

	local v42 = AssetCmds.ResolveAssetArea(LocalPlayer)

	if v3 == nil or v42 == nil then
		return
	end

	if not isNearPetAreaSurface(v42, v3.Position) then
		Message.Bottom({
			Message = "Get closer to your Pen to place pets!",
			Time = 2,
			PreventDuplicateText = true,
			Color = v2
		})

		return
	end

	v6 = v22
	AssetPlacementHints.SetFrontPlacement(v22, v3.CFrame)

	local v52, v62 = AssetCmds.RequestEquipAsset(v22)

	if v6 == v22 then
		v6 = nil
	end

	if not v52 then
		AssetPlacementHints.ClearFrontPlacement(v22)

		if v62 ~= nil then
			Message.Bottom({
				Time = 2,
				PreventDuplicateText = true,
				Message = v62,
				Color = v2
			})
		end
	end

	if not v52 or v5 ~= p1 then
		return
	end

	showEquipSuccessNotification(p1)
	v4:Clean()
	v5 = nil
end

local function bindTool(p1) --[[ bindTool | Line: 133 | Upvalues: v4 (copy), v5 (ref), tryEquipToolAsset (copy) ]]
	v4:Clean()
	v5 = p1
	v4:Connect(p1.Activated, function() --[[ Line: 136 | Upvalues: tryEquipToolAsset (ref), p1 (copy) ]]
		tryEquipToolAsset(p1)
	end)
end

local function refreshCharacter(p1) --[[ refreshCharacter | Line: 141 | Upvalues: v4 (copy), v5 (ref), tryEquipToolAsset (copy) ]]
	v4:Clean()
	v5 = nil

	local Tool = p1:FindFirstChildOfClass("Tool")

	if Tool == nil then
		return
	end

	if not (Tool:GetAttribute("ItemType") == "Asset") then
		return
	end

	v4:Clean()
	v5 = Tool
	v4:Connect(Tool.Activated, function() --[[ Line: 136 | Upvalues: tryEquipToolAsset (ref), Tool (copy) ]]
		tryEquipToolAsset(Tool)
	end)
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 150 | Upvalues: v3 (copy), v4 (copy), v5 (ref), tryEquipToolAsset (copy) ]]
	v3:Clean()
	v4:Clean()
	v5 = nil

	local Tool = p1:FindFirstChildOfClass("Tool")

	if Tool ~= nil and Tool:GetAttribute("ItemType") == "Asset" then
		v4:Clean()
		v5 = Tool
		v4:Connect(Tool.Activated, function() --[[ Line: 136 | Upvalues: tryEquipToolAsset (ref), Tool (copy) ]]
			tryEquipToolAsset(Tool)
		end)
	end

	v3:Connect(p1.ChildAdded, function(p1) --[[ Line: 154 | Upvalues: v4 (ref), v5 (ref), tryEquipToolAsset (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if not (p1:GetAttribute("ItemType") == "Asset") then
			return
		end

		v4:Clean()
		v5 = p1
		v4:Connect(p1.Activated, function() --[[ Line: 136 | Upvalues: tryEquipToolAsset (ref), p1 (copy) ]]
			tryEquipToolAsset(p1)
		end)
	end)
	v3:Connect(p1.ChildRemoved, function(p1) --[[ Line: 160 | Upvalues: v5 (ref), v4 (ref) ]]
		if p1 ~= v5 then
			return
		end

		v4:Clean()
		v5 = nil
	end)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 173 | Upvalues: v3 (copy), v4 (copy), v5 (ref), v6 (ref) ]]
	v3:Clean()
	v4:Clean()
	v5 = nil
	v6 = nil
end)

if LocalPlayer.Character == nil then
	return
end

bindCharacter(LocalPlayer.Character)