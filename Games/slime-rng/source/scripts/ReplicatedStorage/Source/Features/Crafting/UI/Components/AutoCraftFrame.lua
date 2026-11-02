-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AutoCraftFrame, time of decompilation: Sun May  3 10:12:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local OptionSlider = require(ReplicatedStorage.Source.Core.UI.Components.OptionSlider)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local InsetFrame = require(ReplicatedStorage.Source.Features.App.Components.InsetFrame)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)

local function getSliderOptions(n1: number) -- line: 21
	local t1 = {}

	if n1 <= 10 then
		for i = 1, n1 do
			table.insert(t1, {
				value = i,
				label = tostring(i)
			})
		end

		return t1
	end

	table.insert(t1, {
		value = 1,
		label = "1"
	})

	local n2 = 1

	for i = 2, 10 do
		local v16 = i * 10

		n2 = math.clamp(math.round(n1 * v16 / 100), n2 + 1, n1)
		table.insert(t1, {
			value = n2,
			label = `{ v16 }%`
		})
	end

	t1[#t1].value = n1
	t1[#t1].label = "100%"

	return t1
end
local function getClosestOptionValue(t2: {[any]: any}, n3: number) -- line: 60
	local v19 = not t2[1] and 1 or t2[1].value
	local n4 = 1e999

	for _, v22 in t2 do
		if type(v22.value) == "number" then
			local v23 = math.abs(v22.value - n3)

			if v23 < n4 then
				n4 = v23
				v19 = v22.value
			end
		end
	end

	return v19
end

return function(t3: {[any]: any}) -- line: 79
	-- upvalues: Vide (copy), getSliderOptions (copy), getClosestOptionValue (copy), InsetFrame (copy), TextLabel (copy), Frame (copy), OptionSlider (copy), StylizedButton (copy)
	local v25 = Vide.source(1)
	local v26 = Vide.derive(function() -- line: 81
		-- upvalues: getSliderOptions (copy), t3 (copy)
		return (getSliderOptions((math.max(math.floor(t3.MaxCrafts() or 1), 1))))
	end)

	Vide.effect(function() -- line: 85
		-- upvalues: getClosestOptionValue (copy), v26 (copy), v25 (copy)
		local v27 = getClosestOptionValue(v26(), v25())

		if v27 ~= v25() then
			v25(v27)
		end
	end)

	return InsetFrame({
		Name = "AutoCraftFrame",
		Size = UDim2.new(1, -40, 0, 96),
		Position = UDim2.fromOffset(20, 334),
		ZIndex = 3,
		TextLabel({
			Name = "AmountLabel",
			Text = "Autocraft Amount:",
			TextSize = 20,
			ZIndex = 4,
			Size = UDim2.fromOffset(140, 26),
			Position = UDim2.fromOffset(24, 20),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 2
			},
			DropShadow = {}
		}),
		Frame({
			Name = "AmountValueFrame",
			Size = UDim2.fromOffset(84, 32),
			Position = UDim2.fromOffset(166, 20),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			ZIndex = 4,
			TextLabel({
				ZIndex = 5,
				Text = function() --[[ Text ]] -- line: 126
					-- upvalues: v25 (copy)
					return (tostring(v25()))
				end,
				Size = UDim2.fromScale(1, 1),
				Stroke = {
					Thickness = 2
				},
				DropShadow = {}
			})
		}),
		OptionSlider({
			ZIndex = 4,
			Options = v26,
			Value = v25,
			OnChanged = function(p1) --[[ OnChanged ]] -- line: 139
				-- upvalues: v25 (copy)
				if type(p1) == "number" then
					v25(p1)
				end
			end,
			Size = UDim2.new(0.66, 0, 0, 50),
			Position = UDim2.fromScale(0.36, 0.66),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}),
		StylizedButton({
			Theme = "Green",
			HoverScale = 1.04,
			ZIndex = 4,
			Text = function() --[[ Text ]] -- line: 152
				-- upvalues: v25 (copy)
				return `Autocraft ({ v25() })`
			end,
			Size = UDim2.fromOffset(190, 58),
			Position = UDim2.fromScale(0.855, 0.52),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ activateAutoCraft ]] -- line: 92
				-- upvalues: t3 (copy), v25 (copy)
				if t3.OnAutoCraft then
					t3.OnAutoCraft(v25())
				end
			end
		})
	})
end
