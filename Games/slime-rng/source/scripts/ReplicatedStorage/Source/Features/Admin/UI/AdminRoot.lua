-- AdminRoot (Client ModuleScript)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local AdminServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminServiceClient)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local TutorialSlice = require(ReplicatedStorage.Source.Features.Tutorial.TutorialSlice)

return function()
	-- AdminServiceClient is already initialized from Client startup script
	local v10 = AdminServiceClient:getCountdownSource()
	local v11 = TutorialSlice.completed()
	local v12 = Vide.source(nil)

	return AutoScaledFrame({
		Name = "GlobalUpdateCountdown",
		Size = UDim2.fromOffset(300, 65),
		Position = UDim2.fromScale(0.5, 0.3),
		AnchorPoint = Vector2.new(0.5, 0),

		Visible = function()
			local v13 = v10()
			local v14 = if v13 == nil or type(v13.endsAt) ~= "number" then nil else v13.endsAt
			return v11() == true and (v14 ~= nil and (v14 > serverTimeSource() and v14 ~= v12()))
		end,

		Button({
			Name = "DismissButton",
			Size = UDim2.fromScale(1, 1),
			HoverScale = 1,
			ZIndex = 60,

			Activated = function()
				local v15 = v10()
				if v15 ~= nil and type(v15.endsAt) == "number" then
					v12(v15.endsAt)
				end
			end,

			StylizedFrame({
				Theme = "Orange",
				Size = UDim2.fromScale(1, 1),

				TextLabel({
					Name = "Title",
					TextSize = 24,
					ZIndex = 61,
					Text = function()
						local v16 = v10()
						if v16 and type(v16.title) == "string" then
							return v16.title
						end
						return ""
					end,
					Size = UDim2.new(1, -18, 0, 28),
					Position = UDim2.fromScale(0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					Stroke = { Thickness = 3 },
					DropShadow = {}
				}),

				TextLabel({
					Name = "Timer",
					ZIndex = 61,
					Text = function()
						local v17 = v10()
						-- FIX: guard endsAt before arithmetic — it may be nil
						-- even when v17 is a non-nil table
						if v17 == nil or type(v17.endsAt) ~= "number" then
							return ""
						end
						local v18 = math.max(v17.endsAt - serverTimeSource(), 0)
						local v19 = v18 // 60
						local v20 = v18 % 60
						return string.format("Update in %02d:%02d", v19, v20)
					end,
					Size = UDim2.new(1, -18, 0, 32),
					Position = UDim2.fromScale(0.5, 0.55),
					AnchorPoint = Vector2.new(0.5, 0.5),
					TextColor3 = Color3.fromRGB(255, 244, 209),
					Stroke = { Thickness = 3 },
					DropShadow = {}
				}),

				TextLabel({
					Name = "DismissHint",
					Text = "Click to hide",
					ZIndex = 61,
					Size = UDim2.fromOffset(150, 18),
					Position = UDim2.new(1, -12, 0.95, 0),
					AnchorPoint = Vector2.new(1, 1),
					TextColor3 = Color3.fromRGB(255, 244, 209),
					Stroke = { Thickness = 2 }
				})
			})
		})
	})
end