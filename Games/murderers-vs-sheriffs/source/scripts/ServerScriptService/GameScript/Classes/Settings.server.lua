local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SettingsRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Settings")

local NightTimeRemote = SettingsRemotes:WaitForChild("NightTime")
local DisableShadowsRemote = SettingsRemotes:WaitForChild("DisableShadows")
local LowGraphicsRemote = SettingsRemotes:WaitForChild("LowGraphics")
local LowFogRemote = SettingsRemotes:WaitForChild("LowFog")
local KnifePositionRemote = SettingsRemotes:WaitForChild("KnifePosition")
local GunAnimationsRemote = SettingsRemotes:WaitForChild("GunAnimations")

NightTimeRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	NightTimeRemote:FireClient(Player, IsEnabled)
end)
DisableShadowsRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	DisableShadowsRemote:FireClient(Player, IsEnabled)
end)
LowGraphicsRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	LowGraphicsRemote:FireClient(Player, IsEnabled)
end)
LowFogRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	LowFogRemote:FireClient(Player, IsEnabled)
end)
LowFogRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	LowFogRemote:FireClient(Player, IsEnabled)
end)
KnifePositionRemote.OnServerEvent:Connect(function(Player, Position)
	local DataModule = require(script.Parent.Parent.DataModule)
	local DataTable = DataModule.GetDataTable()
	if Position ~= "Belt" and Position ~= "Back" then return end
	if not DataTable[Player.Name] then return end
	DataTable[Player.Name].KnifePosition = Position
	Player:SetAttribute("KnifePosition", Position)
	if Position == "Back" then
		local EquippedRadios = DataTable[Player.Name].Radios and DataTable[Player.Name].Radios.Equipped
		if EquippedRadios and next(EquippedRadios) then
			DataModule.Unequip(Player, 1, "Radios")
		end
	end
	if _G.WeldWeapons then
		_G.WeldWeapons(Player)
	end
end)

GunAnimationsRemote.OnServerEvent:Connect(function(Player, IsEnabled)
	GunAnimationsRemote:FireClient(Player, IsEnabled)
end)