-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Functions.E)

local Digit = require(script.Digit)
local t = {}
local t2 = {
	Frame = true,
	Digits = true,
	CommaLabels = true,
	Text = true
}
local t3 = {
	ZeroPadding = "number",
	Value = "number",
	Duration = "number",
	Decimals = "number",
	Prefix = "string",
	Suffix = "string",
	Commas = "boolean"
}
local t4 = {
	[Enum.TextXAlignment.Center] = Enum.HorizontalAlignment.Center,
	[Enum.TextXAlignment.Left] = Enum.HorizontalAlignment.Left,
	[Enum.TextXAlignment.Right] = Enum.HorizontalAlignment.Right
}
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

TextLabel.TextScaled = true
TextLabel.TextWrapped = true
TextLabel.TextColor3 = Color3.fromRGB(250, 250, 255)
TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")

local function newSpinner(p1, p2, p3) --[[ newSpinner | Line: 32 | Upvalues: Frame (copy), TextLabel (copy), t2 (copy), t4 (copy), t3 (copy), Digit (copy) ]]
	local t = {
		Value = 0,
		Duration = 0.2,
		Decimals = 2,
		Prefix = "$",
		Suffix = "",
		Commas = false,
		ZeroPadding = 0,
		Digits = {
			Whole = table.create(3),
			Decimal = table.create(2)
		},
		CommaLabels = table.create(2)
	}
	local t5 = {
		__index = function(p1, p2) --[[ __index | Line: 48 | Upvalues: t (copy), Frame (ref), TextLabel (ref) ]]
			local v1 = t[p2]

			if v1 then
				return v1
			end

			if pcall(function() --[[ Line: 52 | Upvalues: Frame (ref), p2 (copy) ]]
				local _ = Frame[p2]
			end) then
				return t.Frame[p2]
			end

			local ok, result = pcall(function() --[[ Line: 57 | Upvalues: TextLabel (ref), p2 (copy) ]]
				return TextLabel[p2]
			end)

			if not ok then
				return nil
			end

			local v2 = t.Digits.Whole[1]

			if v2 then
				return v2[p2]
			end

			return result
		end,
		__newindex = function(p1, p2, p3) --[[ __newindex | Line: 72 | Upvalues: t2 (ref), Frame (ref), t (copy), t4 (ref), TextLabel (ref), t3 (ref) ]]
			if t2[p2] then
				warn("Attempted to set read-only value Spinner." .. p2)

				return
			end

			if pcall(function() --[[ Line: 76 | Upvalues: Frame (ref), p2 (copy) ]]
				local _ = Frame[p2]
			end) then
				local v2 = typeof(Frame[p2])

				if v2 ~= "nil" and v2 ~= typeof(p3) then
					warn("Attempted to set Spinner." .. p2 .. " to invalid value (" .. tostring(p3) .. ")")

					return
				end

				t.Frame[p2] = p3
			else
				if p2 == "TextXAlignment" then
					t.Layout.HorizontalAlignment = t4[p3]

					return
				end

				if pcall(function() --[[ Line: 96 | Upvalues: TextLabel (ref), p2 (copy) ]]
					local _ = TextLabel[p2]
				end) then
					local v4 = typeof(TextLabel[p2])

					if v4 ~= "nil" and v4 ~= typeof(p3) then
						warn("Attempted to set Spinner." .. p2 .. " to invalid value (" .. tostring(p3) .. ")")

						return
					end

					for k, v in pairs(t.Digits.Whole) do
						v[p2] = p3
					end

					for k, v in pairs(t.Digits.Decimal) do
						v[p2] = p3
					end

					for k, v in pairs(t.CommaLabels) do
						v[p2] = p3
					end

					t.PrefixLabel[p2] = p3
					t.SuffixLabel[p2] = p3
					t.DecimalLabel[p2] = p3
					t.NegativeLabel[p2] = p3
				else
					if not t3[p2] then
						return
					end

					if typeof(p3) == t3[p2] then
						t[p2] = p3
						t:Update(p2, p3)
					else
						warn("Attempted to set Spinner." .. p2 .. " to invalid value (" .. tostring(p3) .. ")")
					end
				end
			end
		end
	}
	local v1 = setmetatable({}, t5)

	function t.Destroy(p1) --[[ Line: 145 ]]
		p1.Frame:Destroy()
		table.clear(p1)
	end
	function t.Update(p12, p22, p32) --[[ Line: 149 | Upvalues: t (copy), Digit (ref), v1 (copy), p1 (copy), p2 (copy), p3 (copy) ]]
		if p22 == "Prefix" then
			t.PrefixLabel.Text = t.Prefix

			return
		end

		if p22 == "Suffix" then
			t.SuffixLabel.Text = t.Suffix

			return
		end

		local v2 = math.abs(t.Value)
		local v3 = t.Value < 0

		if t.NegativeLabel then
			t.NegativeLabel.Visible = v3
		end

		local v5 = string.split(t.Decimals > 0 and string.format("%." .. t.Decimals .. "f", v2) or string.format("%d", v2), ".")
		local v6 = v5[1]
		local v7 = v5[2]

		if not v6 then
			return
		end

		if t.ZeroPadding > 0 and #v6 < t.ZeroPadding then
			v6 = string.format("%0" .. t.ZeroPadding .. "i", tonumber(v6) or 0)
		end

		local v10 = #v6

		for i = 1, v10 do
			local v11 = t.Digits.Whole[i]

			if v11 then
				v11.Duration = t.Duration
				v11.Value = tonumber((string.sub(v6, i, i)))

				continue
			end

			t.Digits.Whole[i] = Digit.new(v1, t, i * 2 - 900, tonumber((string.sub(v6, i, i))), p1)
		end

		for j = v10 + 1, #t.Digits.Whole do
			local v18 = t.Digits.Whole[j]

			if v18 then
				v18:Destroy()
				t.Digits.Whole[j] = nil
			end
		end

		if t.Commas then
			local count = 0
			local v21 = v10 * 2 - 900

			for k = 0, #string.format("%d", (math.floor((math.abs(t.Value))))) - 1, 3 do
				if k ~= 0 then
					count = count + 1

					local v22 = t.CommaLabels[count]

					if not v22 then
						local Comma = Instance.new("TextLabel")

						Comma.RichText = false
						Comma.Name = "Comma"
						Comma.BackgroundTransparency = 1
						Comma.Size = UDim2.new(0, 0, 1, 0)
						Comma.Font = v1.Font
						Comma.TextColor3 = v1.TextColor3
						Comma.Text = ","
						Comma.AutomaticSize = Enum.AutomaticSize.X

						if v1.TextSize then
							Comma.TextSize = v1.TextSize
						else
							Comma.TextScaled = true
							Comma.TextWrapped = true
						end

						Comma.AutomaticSize = Enum.AutomaticSize.X
						v22 = Comma

						if p2 then
							p2:Clone().Parent = Comma
						end

						if p3 then
							p3:Clone().Parent = Comma
						end

						Comma.Parent = t.Frame
						t.CommaLabels[count] = Comma
					end

					v22.LayoutOrder = v21 - (k - 1) * 2 - 1
				end
			end

			for n = count + 1, #t.CommaLabels do
				t.CommaLabels[n]:Destroy()
				t.CommaLabels[n] = nil
			end
		end

		if v7 then
			if t.DecimalLabel then
				t.DecimalLabel.Visible = true
			end

			for m = 1, #v7 do
				local v23 = t.Digits.Decimal[m]

				if v23 then
					v23.Duration = t.Duration
					v23.Value = tonumber((string.sub(v7, m, m)))

					continue
				end

				t.Digits.Decimal[m] = Digit.new(v1, t, m, tonumber((string.sub(v7, m, m))), p1)
			end

			for i = #v7 + 1, #t.Digits.Decimal do
				local v30 = t.Digits.Decimal[i]

				if v30 then
					v30:Destroy()
					t.Digits.Decimal[i] = nil
				end
			end
		else
			if t.DecimalLabel then
				t.DecimalLabel.Visible = false
			end

			for i, v in ipairs(t.Digits.Decimal) do
				v:Destroy()
			end

			table.clear(t.Digits.Decimal)
		end
	end

	return v1, t
end

function t.new(p1, p2, p3) --[[ Line: 286 | Upvalues: newSpinner (copy) ]]
	local v1, v2 = newSpinner(p1, p2)
	local Frame = Instance.new("Frame")

	Frame.BackgroundTransparency = 1
	Frame.ClipsDescendants = true
	Frame.Size = UDim2.new(0, 200, 0, 50)
	Frame.Position = UDim2.new(0, 0, 0, 0)
	Frame.ZIndex = p1 and p1.ZIndex or 1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 0)
	UIListLayout.Parent = Frame

	local Prefix = Instance.new("TextLabel")

	Prefix.Name = "Prefix"
	Prefix.LayoutOrder = -1000
	Prefix.BackgroundTransparency = 1
	Prefix.Size = UDim2.new(0, 0, 0.75, 0)
	Prefix.Font = v1.Font
	Prefix.TextSize = v1.TextSize
	Prefix.TextColor3 = v1.TextColor3
	Prefix.Text = v1.Prefix
	Prefix.AutomaticSize = Enum.AutomaticSize.X
	Prefix.Parent = Frame
	Prefix.ZIndex = p1 and p1.ZIndex or 1

	if v2.TextSize then
		Prefix.TextSize = v1.TextSize
	else
		Prefix.TextScaled = true
		Prefix.TextWrapped = true
	end

	Prefix.AutomaticSize = Enum.AutomaticSize.X

	local Suffix = Instance.new("TextLabel")

	Suffix.Name = "Suffix"
	Suffix.LayoutOrder = 1000
	Suffix.BackgroundTransparency = 1
	Suffix.Size = UDim2.new(0, 0, 0.75, 0)
	Suffix.Font = v1.Font
	Suffix.TextSize = v1.TextSize
	Suffix.TextColor3 = v1.TextColor3
	Suffix.Text = v1.Suffix
	Suffix.AutomaticSize = Enum.AutomaticSize.X
	Suffix.Parent = Frame
	Suffix.ZIndex = p1 and p1.ZIndex or 1

	if v2.TextSize then
		Suffix.TextSize = v1.TextSize
	else
		Suffix.TextScaled = true
		Suffix.TextWrapped = true
	end

	Suffix.AutomaticSize = Enum.AutomaticSize.X

	local Decimal = Instance.new("TextLabel")

	Decimal.Name = "Decimal"
	Decimal.LayoutOrder = 0
	Decimal.BackgroundTransparency = 1
	Decimal.Size = UDim2.new(0, 0, 1, 0)
	Decimal.Font = v1.Font
	Decimal.TextSize = v1.TextSize
	Decimal.TextColor3 = v1.TextColor3
	Decimal.Text = "."
	Decimal.AutomaticSize = Enum.AutomaticSize.X
	Decimal.Parent = Frame
	Decimal.ZIndex = p1 and p1.ZIndex or 1

	if v2.TextSize then
		Decimal.TextSize = v1.TextSize
	else
		Decimal.TextScaled = true
		Decimal.TextWrapped = true
	end

	Decimal.AutomaticSize = Enum.AutomaticSize.X

	local Negative = Instance.new("TextLabel")

	Negative.Name = "Negative"
	Negative.LayoutOrder = -999
	Negative.BackgroundTransparency = 1
	Negative.Size = UDim2.new(0, 0, 1, 0)
	Negative.Font = v1.Font
	Negative.TextSize = v1.TextSize
	Negative.TextColor3 = v1.TextColor3
	Negative.Text = "-"
	Negative.AutomaticSize = Enum.AutomaticSize.X
	Negative.Parent = Frame
	Negative.ZIndex = p1 and p1.ZIndex or 1

	if v2.TextSize then
		Negative.TextSize = v1.TextSize
	else
		Negative.TextScaled = true
		Negative.TextWrapped = true
	end

	Negative.AutomaticSize = Enum.AutomaticSize.X
	v2.Frame = Frame
	v2.Layout = UIListLayout
	v2.PrefixLabel = Prefix
	v2.SuffixLabel = Suffix
	v2.DecimalLabel = Decimal
	v2.NegativeLabel = Negative

	if p2 then
		for i, v in ipairs({ Prefix, Suffix, Decimal, Negative }) do
			p2:Clone().Parent = v
		end
	end

	if p3 then
		for i, v in ipairs({ Prefix, Suffix, Decimal, Negative }) do
			p3:Clone().Parent = v
		end
	end

	v1:Update()

	return v1
end
function t.fromGuiObject(p1, p2, p3) --[[ Line: 410 | Upvalues: t (copy), t4 (copy) ]]
	if typeof(p1) ~= "Instance" then
		error("Invalid")
	end

	if not p1:IsA("GuiObject") then
		error("Not a GUI object")
	end

	local v1 = p1:FindFirstChildWhichIsA("UIStroke")
	local v2 = p1:FindFirstChildWhichIsA("UIGradient")

	if v1 then
		p3 = v2
	end

	local v3 = t.new(p1, v1, p3)

	v3.Name = "Spinner_" .. p1.Name
	v3.SizeConstraint = p1.SizeConstraint
	v3.Size = p1.Size
	v3.Position = p1.Position
	v3.AnchorPoint = p1.AnchorPoint
	v3.Rotation = p1.Rotation
	v3.LayoutOrder = p1.LayoutOrder
	v3.ZIndex = p1.ZIndex
	v3.Visible = p1.Visible
	v3.BackgroundColor3 = p1.BackgroundColor3
	v3.BorderColor3 = p1.BorderColor3
	v3.BorderSizePixel = p1.BorderSizePixel
	v3.BackgroundTransparency = p1.BackgroundTransparency
	v3.AutomaticSize = p1.AutomaticSize
	v3.ClipsDescendants = false

	if p1:IsA("TextLabel") or (p1:IsA("TextButton") or p1:IsA("TextBox")) then
		v3.Font = p1.Font
		v3.TextSize = p1.TextSize
		v3.TextColor3 = p1.TextColor3
		v3.TextTransparency = p1.TextTransparency
		v3.TextStrokeColor3 = p1.TextStrokeColor3
		v3.TextStrokeTransparency = p1.TextStrokeTransparency
		v3.Layout.HorizontalAlignment = t4[p1.TextXAlignment]
	end

	v3.Parent = p1.Parent
	p1.Visible = false

	return v3
end

return t