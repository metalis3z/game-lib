-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopCodes, time of decompilation: Sun May  3 10:12:07 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local InsetFrame = require(ReplicatedStorage.Source.Features.App.Components.InsetFrame)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local CodeServiceClient = require(ReplicatedStorage.Source.Features.Codes.CodeServiceClient)

return function() -- line: 10
	-- upvalues: Vide (copy), CodeServiceClient (copy), StylizedFrame (copy), TextLabel (copy), StylizedButton (copy), InsetFrame (copy)
	local v8 = Vide.source("")
	local v9 = Vide.source(Color3.fromRGB(255, 255, 255))
	local v10 = Vide.create("TextBox")({
		TextSize = 38,
		TextScaled = false,
		BackgroundTransparency = 1,
		PlaceholderText = "Enter code here...",
		ClearTextOnFocus = false,
		TextStrokeTransparency = 0,
		Size = UDim2.fromScale(1, 1),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		PlaceholderColor3 = Color3.fromRGB(185, 204, 255),
		Font = Enum.Font.BuilderSansExtraBold
	})

	return StylizedFrame({
		Theme = "DarkBlue",
		Size = UDim2.new(1, 0, 0, 200),
		LayoutOrder = 10000,
		TextLabel({
			Text = "Follow socials for codes!",
			Size = UDim2.fromOffset(300, 42),
			Position = UDim2.fromScale(0.5, 0.04),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 3
			}
		}),
		TextLabel({
			Text = v8,
			Size = UDim2.fromOffset(200, 30),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5, 0.25),
			TextColor3 = v9,
			Stroke = {
				Thickness = 2
			}
		}),
		StylizedButton({
			Theme = "Green",
			Text = "Redeem",
			Size = UDim2.fromOffset(180, 75),
			Position = UDim2.fromScale(0.85, 0.66),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ redeem ]] -- line: 27
				-- upvalues: v10 (copy), CodeServiceClient (copy), v9 (copy), v8 (copy)
				local Text = v10.Text

				if Text == "" then
					return
				end

				local v12, v13 = CodeServiceClient:redeem(Text)

				if v12 then
					v9(Color3.fromRGB(92, 255, 92))
				else
					v9(Color3.fromRGB(255, 64, 64))
				end

				v8(v13)
				task.wait(3)

				if v13 == v8() then
					v8("")
				end
			end
		}),
		InsetFrame({
			Size = UDim2.fromScale(0.66, 0.4),
			Position = UDim2.fromScale(0.05, 0.85),
			AnchorPoint = Vector2.new(0, 1)
		}),
		InsetFrame({
			Size = UDim2.fromScale(0.66, 0.4),
			Position = UDim2.fromScale(0.05, 0.85),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 2,
			v10
		})
	})
end
