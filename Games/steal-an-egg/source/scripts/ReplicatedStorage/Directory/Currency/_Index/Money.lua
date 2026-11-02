-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Directory.Rarity)

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local InstanceCache = require(ReplicatedStorage.Library.Modules.Packages.InstanceCache)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Money = ReplicatedStorage.Assets.Models.Orbs.Money
local t = {
	Icon = "rbxassetid://112678965246772",
	DisplayName = script.Name
}

t.Instance = if Constants.IS_SERVER and Money then Money else InstanceCache.new(Money, 1):SetExpandAmount(1)
t.Rarity = Rarity.Rarities.Uncommon

return setmetatable(t, {
	__index = Default
})