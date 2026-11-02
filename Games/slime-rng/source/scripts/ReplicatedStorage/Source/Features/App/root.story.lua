-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: root.story, time of decompilation: Sun May  3 10:11:10 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local SubMenu = require(ReplicatedStorage.Source.Features.App.Components.SubMenu)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local UpgradeTree = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)
local RootUI = require(script.Parent.RootUI)
local DataTemplate = require(ReplicatedStorage.Source.Game.Items.DataTemplate)
local client = require(ReplicatedStorage.Packages.DataService).client

return function(p1) -- line: 13
	-- upvalues: DataTemplate (copy), client (copy), MonetizationServiceClient (copy), Products (copy), UpgradeTree (copy), Vide (copy), RootUI (copy), Menu (copy), SubMenu (copy)
	DataTemplate.tutorial.completed = true
	client:init(DataTemplate)
	MonetizationServiceClient:init(Products)
	client:set({
		"inventory",
		"uid1"
	}, {
		id = "goopy",
		level = 1,
		xp = 30,
		mutations = {}
	})
	client:set("coins", 1000)

	local t1 = {}

	for _, v14 in UpgradeTree do
		for v15, _ in v14 do
			t1[v15] = true
		end
	end

	client:set("upgrades", t1)
	client:set({
		"craftingRecipes",
		"crafty"
	}, true)

	local v17 = Vide.mount(RootUI, p1)

	Menu.setOpenedMenu("Shop")
	SubMenu.setOpenedMenu("JackpotPurchase")

	return function() -- line: 38
		-- upvalues: v17 (copy)
		v17()
	end
end
