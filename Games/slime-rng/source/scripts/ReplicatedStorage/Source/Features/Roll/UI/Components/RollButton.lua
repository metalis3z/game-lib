-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollButton, time of decompilation: Sun May  3 10:11:49 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)

return function() -- line: 8
	-- upvalues: Frame (copy), Button (copy), RollServiceClient (copy), DropShadow (copy)
	return Frame({
		Name = "RollButton",
		Size = UDim2.fromOffset(119.2, 130.8),
		Button({
			Image = function() --[[ Image ]] -- line: 14
				-- upvalues: RollServiceClient (copy)
				return RollServiceClient:getRollButtonImage()
			end,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0.5, 1),
			AnchorPoint = Vector2.new(0.5, 1),
			Activated = function() --[[ Activated ]] -- line: 20
				-- upvalues: RollServiceClient (copy)
				RollServiceClient:activateRollButton()
			end
		}),
		DropShadow({
			ZIndex = 0,
			ImageTransparency = 0.33,
			Size = UDim2.fromScale(1.4, 0.6),
			Position = UDim2.fromScale(0.5, 0.85),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageColor3 = Color3.fromRGB(28, 25, 36)
		})
	})
end
