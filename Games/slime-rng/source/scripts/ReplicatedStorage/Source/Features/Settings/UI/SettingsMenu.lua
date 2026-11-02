-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingsMenu, time of decompilation: Sun May  3 10:11:56 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local SettingMenuPage = require(ReplicatedStorage.Source.Features.Settings.UI.SettingMenuPage)
local StatsPage = require(ReplicatedStorage.Source.Features.Settings.UI.StatsPage)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

return {
	menuId = "Settings",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 8
		-- upvalues: Menu (copy), ImageIds (copy), SettingMenuPage (copy), StatsPage (copy)
		return Menu.Component({
			menuId = "Settings",
			Title = "Settings",
			SideBarButtons = {
				Settings = {
					Text = "Settings",
					LayoutOrder = 1,
					Image = ImageIds.settingsWhite
				},
				Stats = {
					Text = "Stats",
					LayoutOrder = 2,
					Image = ImageIds.settingsWhite
				}
			},
			Pages = {
				Settings = SettingMenuPage(),
				Stats = StatsPage()
			}
		})
	end
}
