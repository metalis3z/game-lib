-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OtherMenu, time of decompilation: Sun May  3 10:11:16 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)

return {
	menuId = "otherMenu",
	alwaysMounted = true,
	Component = function() --[[ Component ]] -- line: 6
		-- upvalues: Menu (copy), StylizedButton (copy)
		return Menu.Component({
			menuId = "otherMenu",
			Title = "OTHER",
			StylizedButton({
				Theme = "Green",
				Text = "Test",
				Position = UDim2.fromScale(0.5, 0.95),
				AnchorPoint = Vector2.new(0.5, 1),
				Size = UDim2.fromOffset(120, 60)
			})
		})
	end
}
