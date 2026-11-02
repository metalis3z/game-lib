-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ErrorMessages, time of decompilation: Sun May  3 10:11:07 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local create = Vide.create
local indexes = Vide.indexes
local v7 = Vide.source({})
local n1 = 0

local function ErrorMessage(p1, n2: number, p2) -- line: 27
	-- upvalues: Vide (copy), v7 (copy), Frame (copy), create (copy), TextLabel (copy)
	local v16 = Vide.source(0)
	local v17 = Vide.spring(v16, 0.24, 0.8)
	local u18 = nil

	u18 = task.delay(3, function() -- line: 31
		-- upvalues: n2 (copy), v7 (copy), u18 (ref)
		local v22 = n2
		local v23 = v7()

		if v23[v22] ~= nil then
			local v24 = table.clone(v23)

			v24[v22] = nil
			v7(v24)
		end

		u18 = nil
	end)
	Vide.effect(function() -- line: 36
		-- upvalues: v16 (copy), p2 (copy)
		v16(not p2() and 0 or 1)
	end)
	Vide.cleanup(function() -- line: 40
		-- upvalues: u18 (ref)
		if u18 then
			task.cancel(u18)
			u18 = nil
		end
	end)

	return Frame({
		Name = "ErrorMessage",
		LayoutOrder = n2,
		Size = function() --[[ Size ]] -- line: 50
			-- upvalues: v17 (copy)
			return UDim2.fromScale(v17(), v17())
		end,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		create("UIGradient")({
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.33, 0.5),
				NumberSequenceKeypoint.new(0.66, 0.5),
				NumberSequenceKeypoint.new(1, 1)
			})
		}),
		TextLabel({
			Text = function() --[[ Text ]] -- line: 68
				-- upvalues: p1 (copy)
				return p1() or ""
			end,
			Size = UDim2.fromScale(1, 1),
			TextColor3 = Color3.fromRGB(255, 0, 0),
			Stroke = {
				Thickness = 2,
				Color = Color3.fromRGB(87, 0, 0)
			}
		})
	}), 0.35
end

return {
	Component = function() --[[ Component ]] -- line: 82
		-- upvalues: indexes (copy), v7 (copy), ErrorMessage (copy), Frame (copy), create (copy)
		local v19 = indexes(v7, ErrorMessage)

		return Frame({
			Name = "ErrorMessages",
			Size = UDim2.new(0.55, 0, 0, 30),
			Position = UDim2.fromScale(0.5, 0.7),
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundTransparency = 1,
			Visible = function() --[[ Visible ]] -- line: 91
				-- upvalues: v19 (copy)
				return next(v19()) ~= nil
			end,
			ZIndex = 2147483647,
			v19,
			create("UIListLayout")({
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0.1, 0)
			})
		})
	end,
	add = function(s1: string) --[[ add ]] -- line: 107
		-- upvalues: n1 (ref), v7 (copy)
		n1 += 1

		local v21 = table.clone(v7())

		v21[n1] = s1
		v7(v21)
	end
}
