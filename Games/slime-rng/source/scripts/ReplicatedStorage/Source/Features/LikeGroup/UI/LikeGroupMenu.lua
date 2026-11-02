-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LikeGroupMenu, time of decompilation: Sun May  3 10:11:32 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local LikeGroupServiceClient = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceClient)

return {
	menuId = "likeGroupMenu",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 10
		-- upvalues: Menu (copy), TextLabel (copy), StylizedButton (copy), LikeGroupServiceClient (copy)
		return Menu.Component({
			menuId = "likeGroupMenu",
			Title = "",
			Scale = 0.6,
			ShowTitle = false,
			ShowCloseButton = false,
			TextLabel({
				Name = "Body",
				Text = "Like the game and join the group for +1 Luck!",
				TextWrapped = true,
				TextSize = 40,
				ZIndex = 3,
				Size = UDim2.fromScale(0.9, 0.33),
				Position = UDim2.fromScale(0.5, 0.15),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {},
				DropShadow = {}
			}),
			StylizedButton({
				Theme = "Blue",
				Text = "Confirm",
				Size = UDim2.fromOffset(200, 80),
				Position = UDim2.fromScale(0.75, 0.85),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Activated = function() --[[ Activated ]] -- line: 37
					-- upvalues: LikeGroupServiceClient (copy), Menu (copy)
					LikeGroupServiceClient:confirmPrompt()
					Menu.setOpenedMenu(nil)
				end
			}),
			StylizedButton({
				Theme = "Grey",
				Text = "Close",
				Size = UDim2.fromOffset(200, 80),
				Position = UDim2.fromScale(0.25, 0.85),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Activated = function() --[[ Activated ]] -- line: 49
					-- upvalues: LikeGroupServiceClient (copy), Menu (copy)
					LikeGroupServiceClient:confirmPrompt()
					Menu.setOpenedMenu(nil)
				end
			})
		})
	end
}
