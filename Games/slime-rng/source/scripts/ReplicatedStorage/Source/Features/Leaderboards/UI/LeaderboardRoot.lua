-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LeaderboardRoot, time of decompilation: Sun May  3 10:12:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local LeaderboardServiceClient = require(ReplicatedStorage.Source.Features.Leaderboards.LeaderboardServiceClient)
local LeaderboardTemplate = require(ReplicatedStorage.Source.Features.Leaderboards.LeaderboardTemplate)

require(ReplicatedStorage.Source.Features.Leaderboards.LeaderboardTypes)

local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local t1 = {
	[1] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 166)),
		ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 228, 108)),
		ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 187, 61)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(204, 143, 31))
	}),
	[2] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(241, 241, 241)),
		ColorSequenceKeypoint.new(0.1, Color3.fromRGB(169, 169, 169)),
		ColorSequenceKeypoint.new(0.8, Color3.fromRGB(128, 128, 128)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 105, 105))
	}),
	[3] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 163, 86)),
		ColorSequenceKeypoint.new(0.1, Color3.fromRGB(139, 88, 46)),
		ColorSequenceKeypoint.new(0.8, Color3.fromRGB(129, 80, 45)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 57, 27))
	})
}
local colorSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 110, 110)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(82, 82, 82))
})

local function ResetTimer(n1: number?) -- line: 44
	-- upvalues: TextLabel (copy), serverTimeSource (copy), FormatTime (copy)
	if not n1 or n1 <= 0 then
		return nil
	end

	return TextLabel({
		Name = "Timer",
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 0.2),
		Stroke = {},
		Text = function() --[[ Text ]] -- line: 54
			-- upvalues: serverTimeSource (copy), n1 (copy), FormatTime (copy)
			local v28 = serverTimeSource()
			local v29 = (v28 // n1 + 1) * n1 - v28

			return "Resets in: " .. FormatTime(v29)
		end
	})
end
local function LeaderboardEntry(p1, n2: number) -- line: 63
	-- upvalues: Frame (copy), TextLabel (copy), ImageLabel (copy), UICorner (copy), UIGradient (copy), t1 (copy), colorSequence (copy)
	return Frame({
		Name = n2,
		Size = UDim2.new(1, 0, 0, 55),
		LayoutOrder = n2,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextLabel({
			Name = "Place",
			Text = n2,
			Size = UDim2.fromScale(0.1, 0.6),
			Position = UDim2.fromScale(0.05, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {}
		}),
		ImageLabel({
			Name = "ProfileImage",
			Size = UDim2.fromScale(0.8, 0.8),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Position = UDim2.fromScale(0.125, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(229, 232, 235),
			Image = function() --[[ Image ]] -- line: 89
				-- upvalues: p1 (copy)
				return p1().profileImage
			end,
			UICorner({
				CornerRadius = UDim.new(0.5, 0)
			})
		}),
		TextLabel({
			Name = "Username",
			Text = function() --[[ Text ]] -- line: 100
				-- upvalues: p1 (copy)
				return "@" .. p1().username
			end,
			Size = UDim2.fromScale(0.525, 0.6),
			Position = UDim2.fromScale(0.225, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {}
		}),
		TextLabel({
			Name = "Value",
			Text = function() --[[ Text ]] -- line: 112
				-- upvalues: p1 (copy)
				return p1().value
			end,
			Size = UDim2.fromScale(0.21, 0.6),
			Position = UDim2.fromScale(0.975, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {}
		}),
		UIGradient({
			Rotation = 90,
			Color = t1[n2] or colorSequence
		}),
		UICorner({
			CornerRadius = UDim.new(0, 6)
		})
	})
end
local function LeaderboardGui(p2, s1: string) -- line: 133
	-- upvalues: LeaderboardTemplate (copy), Vide (copy), Frame (copy), TextLabel (copy), ResetTimer (copy), ImageLabel (copy), UIListLayout (copy), ScrollingFrame (copy), LeaderboardEntry (copy), UIPadding (copy)
	local v25 = LeaderboardTemplate[s1]

	return Vide.create("SurfaceGui")({
		Name = "LeaderboarGui_" .. s1,
		Adornee = v25.parent,
		LightInfluence = 0,
		MaxDistance = 200,
		ClipsDescendants = false,
		Frame({
			Name = "TitleInfo",
			Size = UDim2.fromScale(1, 0.2),
			TextLabel({
				Name = "Title",
				LayoutOrder = 1,
				Text = v25.title,
				Size = UDim2.fromScale(0.825, 0.75),
				Stroke = {}
			}),
			ResetTimer(v25.resetFrequency),
			ImageLabel({
				Name = "Divider",
				Image = "rbxassetid://18951662446",
				LayoutOrder = 3,
				Size = UDim2.fromScale(1.1, 0.05),
				Position = UDim2.fromScale(0.5, 0.95),
				AnchorPoint = Vector2.new(0.5, 1)
			}),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				Padding = UDim.new(0, 0)
			})
		}),
		ScrollingFrame({
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 8,
			VerticalScrollBarInset = Enum.ScrollBarInset.Always,
			ScrollBarImageTransparency = 1,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0.8),
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			Vide.indexes(p2, LeaderboardEntry),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 5)
			}),
			UIPadding({
				PaddingTop = UDim.new(0, 5),
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5)
			})
		})
	})
end

return function() -- line: 206
	-- upvalues: Vide (copy), LeaderboardServiceClient (copy), LeaderboardGui (copy)
	local v26 = Vide.source(LeaderboardServiceClient.leaderboardData)
	local connection = LeaderboardServiceClient.leaderboardsChanged:Connect(function() -- line: 208
		-- upvalues: v26 (copy), LeaderboardServiceClient (copy)
		v26(LeaderboardServiceClient.leaderboardData)
	end)

	Vide.cleanup(function() -- line: 212
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return Vide.indexes(v26, LeaderboardGui)
end
