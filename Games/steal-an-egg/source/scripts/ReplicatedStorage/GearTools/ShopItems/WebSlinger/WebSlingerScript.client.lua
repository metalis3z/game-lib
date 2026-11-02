-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local WebSlingerRemote = v1.WebSlingerRemote
local v2 = LocalPlayer:GetMouse()

local function buildRaycastParams() --[[ buildRaycastParams | Line: 74 | Upvalues: LocalPlayer (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude
	v1.IgnoreWater = true

	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	v1.FilterDescendantsInstances = t

	return v1
end

local function resolveHitTarget(p1) --[[ resolveHitTarget | Line: 89 | Upvalues: Players (copy), LocalPlayer (copy) ]]
	if not p1 then
		return nil, nil
	end

	local v1 = p1

	while v1 and not (v1:IsA("Model") or v1:FindFirstChildWhichIsA("Humanoid")) do
		v1 = v1.Parent
	end

	if not v1 then
		return nil, nil
	end

	local v2 = Players:GetPlayerFromCharacter(v1)

	if v2 and v2 ~= LocalPlayer then
		return v2, "PlayerType"
	end

	return nil, nil
end

local function onActivated() --[[ onActivated | Line: 111 | Upvalues: ToolGameplayGuard (copy), v1 (copy), LocalPlayer (copy), Workspace (copy), v2 (copy), resolveHitTarget (copy), WebSlingerRemote (copy) ]]
	if not ToolGameplayGuard.CanActivateLocal(v1) then
		return
	end

	local Character = LocalPlayer.Character

	if not (Character and Character.PrimaryPart) then
		return
	end

	if not Workspace.CurrentCamera then
		return
	end

	local Handle = v1.Handle
	local v12 = v2.Hit.Position - Handle.Position

	if v12.Magnitude == 0 then
		return
	end

	local Unit = v12.Unit
	local v22 = RaycastParams.new()

	v22.FilterType = Enum.RaycastFilterType.Exclude
	v22.IgnoreWater = true

	local t = {}
	local Character2 = LocalPlayer.Character

	if Character2 then
		table.insert(t, Character2)
	end

	v22.FilterDescendantsInstances = t

	local v3 = Workspace:Raycast(Handle.Position, Unit * 12, v22)
	local v6, v7 = resolveHitTarget(v3 and v3.Instance or nil)

	WebSlingerRemote:FireServer({
		type = "fire",
		target = v6,
		targetType = v7,
		aimDirection = Unit,
		hitDistance = if v3 then math.min(v3.Distance, 20) else 20
	})
end

local function onUnequipped() --[[ onUnequipped | Line: 153 | Upvalues: WebSlingerRemote (copy) ]]
	WebSlingerRemote:FireServer({
		type = "disconnect"
	})
end

v1.Activated:Connect(onActivated)
v1.Unequipped:Connect(onUnequipped)