-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MountUI, time of decompilation: Sun May  3 10:12:43 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Vide = require(ReplicatedStorage.Packages.Vide)
local RootUI = require(ReplicatedStorage.Source.Features.App.RootUI)
local TopBarButtons = require(ReplicatedStorage.Source.Features.Hud.TopBarButtons)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

return function() -- line: 12
	-- upvalues: TopBarButtons (copy), StarterGui (copy), Vide (copy), RootUI (copy), PlayerGui (copy)
	TopBarButtons()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	return Vide.mount(RootUI, PlayerGui)
end
