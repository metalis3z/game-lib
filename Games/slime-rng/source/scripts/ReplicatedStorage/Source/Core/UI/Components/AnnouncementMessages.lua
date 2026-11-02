-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AnnouncementMessages, time of decompilation: Sun May  3 10:11:07 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local create = Vide.create
local indexes = Vide.indexes
local color3 = Color3.fromRGB(255, 233, 122)
local v10 = Vide.source({})
local n1 = 0
local v12 = Vide.source(0)

local function AnnouncementCard(p1, n2: number, p2) -- line: 48
	-- upvalues: Vide (copy), v10 (copy), Frame (copy), TextLabel (copy)
	local v20 = Vide.source(0)
	local v21 = Vide.spring(v20, 0.24, 0.8)
	local u22 = nil

	u22 = task.delay(p1().duration or 7, function() -- line: 52
		-- upvalues: n2 (copy), v10 (copy), u22 (ref)
		local v28 = n2
		local v29 = v10()

		if v29[v28] ~= nil then
			local v30 = table.clone(v29)

			v30[v28] = nil
			v10(v30)
		end

		u22 = nil
	end)
	Vide.effect(function() -- line: 57
		-- upvalues: v20 (copy), p2 (copy)
		v20(not p2() and 0 or 1)
	end)
	Vide.cleanup(function() -- line: 61
		-- upvalues: u22 (ref)
		if u22 then
			task.cancel(u22)
			u22 = nil
		end
	end)

	return Frame({
		Name = "AnnouncementMessage",
		LayoutOrder = n2,
		Size = function() --[[ Size ]] -- line: 71
			-- upvalues: v21 (copy)
			return UDim2.fromScale(v21(), v21())
		end,
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = function() --[[ Position ]] -- line: 77
			-- upvalues: p1 (copy)
			return p1().position or UDim2.new()
		end,
		TextLabel({
			TextWrapped = true,
			Text = function() --[[ Text ]] -- line: 82
				-- upvalues: p1 (copy)
				return p1().message
			end,
			Size = function() --[[ Size ]] -- line: 85
				-- upvalues: p1 (copy)
				return p1().size or UDim2.new(1, -28, 0, 44)
			end,
			AutomaticSize = Enum.AutomaticSize.Y,
			TextColor3 = function() --[[ TextColor3 ]] -- line: 89
				-- upvalues: p1 (copy)
				return p1().color
			end,
			Stroke = {
				Thickness = 2,
				Color = Color3.fromRGB(0, 0, 0)
			},
			DropShadow = {}
		})
	}), 0.35
end

return {
	Component = function() --[[ Component ]] -- line: 103
		-- upvalues: indexes (copy), v10 (copy), AnnouncementCard (copy), Frame (copy), ConfettiSequence (copy), v12 (copy), create (copy)
		local v23 = indexes(v10, AnnouncementCard)

		return Frame({
			Name = "AnnouncementMessages",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = function() --[[ Visible ]] -- line: 110
				-- upvalues: v23 (copy)
				return next(v23()) ~= nil
			end,
			ZIndex = 2147483646,
			ConfettiSequence({
				Name = "AnnouncementConfetti",
				ZIndex = 2147483646,
				Trigger = v12
			}),
			Frame({
				Name = "AnnouncementList",
				Size = UDim2.new(0.72, 0, 0, 36),
				Position = UDim2.fromScale(0.5, 0.19),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 2147483646,
				v23,
				create("UIListLayout")({
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0.18, 0)
				})
			})
		})
	end,
	add = function(s1: string, t1: {[any]: any}?) --[[ add ]] -- line: 141
		-- upvalues: n1 (ref), v10 (copy), color3 (copy), SoundController (copy), v12 (copy)
		n1 += 1

		local v26 = t1 or {}
		local v27 = table.clone(v10())

		v27[n1] = {
			message = s1,
			color = v26.Color or color3,
			position = v26.Position,
			size = v26.Size,
			duration = v26.Duration
		}
		v10(v27)

		if t1 and t1.Sound then
			SoundController:Play(t1.Sound)
		end

		if t1 and t1.Confetti then
			v12(v12() + 1)
		end
	end
}
