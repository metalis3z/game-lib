-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ConsoleHint, time of decompilation: Sun May  3 10:11:08 2026 ]]
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local preferredInputSource = require(ReplicatedStorage.Source.Core.UI.Sources.preferredInputSource)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)

return function(t1: {[any]: any}) -- line: 22
	-- upvalues: preferredInputSource (copy), Frame (copy), UICorner (copy), UIStroke (copy), ImageLabel (copy), UserInputService (copy), TextLabel (copy)
	local v10 = t1.Text ~= nil and t1.Text ~= ""

	return Frame({
		Name = "ConsoleHint",
		Visible = function() --[[ isVisible ]] -- line: 23
			-- upvalues: preferredInputSource (copy), t1 (copy)
			if preferredInputSource() ~= Enum.PreferredInput.Gamepad then
				return false
			end

			if t1.Visible then
				return (t1.Visible())
			end

			return true
		end,
		Size = t1.Size or if not v10 then UDim2.fromOffset(34, 34) else UDim2.fromOffset(112, 32),
		Position = t1.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = t1.AnchorPoint or Vector2.zero,
		BackgroundColor3 = Color3.fromRGB(23, 27, 39),
		BackgroundTransparency = 0.18,
		ZIndex = t1.ZIndex or 30,
		UICorner({
			CornerRadius = UDim.new(0, 8)
		}),
		UIStroke({
			Transparency = 0.45,
			Thickness = 1.5,
			Color = Color3.fromRGB(255, 255, 255)
		}),
		ImageLabel({
			Name = "Icon",
			Image = function() --[[ Image ]] -- line: 55
				-- upvalues: UserInputService (copy), t1 (copy)
				return UserInputService:GetImageForKeyCode(t1.KeyCode)
			end,
			Size = if not v10 then UDim2.fromScale(0.72, 0.72) else UDim2.fromOffset(22, 22),
			Position = if not v10 then UDim2.fromScale(0.5, 0.5) else UDim2.new(0, 6, 0.5, 0),
			AnchorPoint = if not v10 then Vector2.new(0.5, 0.5) else Vector2.new(0, 0.5),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = (t1.ZIndex or 30) + 1
		}),
		if not v10 then nil else TextLabel({
			TextSize = 18,
			Text = t1.Text,
			Size = UDim2.new(1, -36, 1, 0),
			Position = UDim2.new(0, 32, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 2
			},
			DropShadow = {},
			ZIndex = (t1.ZIndex or 30) + 1
		})
	})
end
