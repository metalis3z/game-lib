-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferMenu, time of decompilation: Sun May  3 10:12:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local XpTransferPage = require(ReplicatedStorage.Source.Features.XpTransfer.UI.XpTransferPage)

return {
	menuId = "XpTransfer",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 8
		-- upvalues: Menu (copy), XpTransferPage (copy)
		return Menu.Component({
			menuId = "XpTransfer",
			Title = "XP Transfer",
			XpTransferPage()
		})
	end
}
