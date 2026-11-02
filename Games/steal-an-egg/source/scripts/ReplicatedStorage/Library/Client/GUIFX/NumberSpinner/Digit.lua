-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.15)

return {
	new = function(p1, p2, p3, p4, p5) --[[ new | Line: 6 | Upvalues: TweenService (copy), TextService (copy), v1 (copy) ]]
		local t = {
			Duration = p1.Duration,
			Value = p4,
			Labels = table.create(10),
			CanvasTweens = table.create(10)
		}
		local v12 = TweenInfo.new(p1.Duration)
		local digit = Instance.new("Frame")

		digit.Name = "digit"
		digit.LayoutOrder = p3
		digit.BackgroundTransparency = 1

		if p2.TextSize then
			digit.Size = UDim2.new(0, 0, 0, p1.TextSize + 6)
		else
			digit.Size = UDim2.fromScale(0, 1)
			digit.AutomaticSize = Enum.AutomaticSize.X
		end

		digit.ClipsDescendants = true
		digit.ZIndex = p5 and p5.ZIndex or 1

		local canvas = Instance.new("Frame")

		canvas.Name = "canvas"
		canvas.Size = UDim2.new(1, 0, 10, 0)
		canvas.BackgroundTransparency = 1
		canvas.Parent = digit
		canvas.ZIndex = p5 and p5.ZIndex or 1
		canvas.Position = UDim2.new(0, 0, -t.Value, 0)

		local v4 = p2.PrefixLabel:FindFirstChildWhichIsA("UIStroke")
		local v5 = p2.PrefixLabel:FindFirstChildWhichIsA("UIGradient")

		for i = 0, 9 do
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "n_" .. i
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextSize = p1.TextSize
			TextLabel.TextColor3 = p1.TextColor3
			TextLabel.Font = p1.Font
			TextLabel.Text = i
			TextLabel.Position = UDim2.new(0, 0, i * 0.1, 0)
			TextLabel.ZIndex = p5 and p5.ZIndex or 1

			if p2.TextSize then
				TextLabel.TextSize = p2.TextSize
				TextLabel.Size = UDim2.new(1, 0, 0.1, 0)
			else
				TextLabel.Size = UDim2.new(0, 0, 0.1, 0)
				TextLabel.TextScaled = true
				TextLabel.TextWrapped = true
				TextLabel.AutomaticSize = Enum.AutomaticSize.X
			end

			if v4 then
				v4:Clone().Parent = TextLabel
			end

			if v5 then
				v5:Clone().Parent = TextLabel
			end

			TextLabel.Parent = canvas
			t.Labels[i] = TextLabel
			t.CanvasTweens[i] = TweenService:Create(canvas, v12, {
				Position = UDim2.new(0, 0, -i, 0)
			})
		end

		digit.Parent = p1.Frame

		local v7 = TextService:GetTextSize("8", p1.TextSize, p1.Font, Vector2.new(p1.TextSize, p1.TextSize))

		TweenService:Create(digit, v1, {
			Size = UDim2.new(0, v7.X + 1, 0, v7.Y + 10)
		}):Play()

		local v8 = setmetatable({}, {
			__index = function(p1, p2) --[[ __index | Line: 79 | Upvalues: t (copy) ]]
				local v1 = t[p2]

				if v1 then
					return v1
				end

				if pcall(function() --[[ Line: 83 | Upvalues: t (ref), p2 (copy) ]]
					local _ = t.Labels[1][p2]
				end) then
					return t.Labels[1][p2]
				end

				return nil
			end,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 91 | Upvalues: t (copy) ]]
				if t[p2] then
					t[p2] = p3
					t:Update(p2, p3)

					return
				end

				if not pcall(function() --[[ Line: 97 | Upvalues: t (ref), p2 (copy) ]]
					local _ = t.Labels[1][p2]
				end) then
					return
				end

				t.Labels[0][p2] = p3
				t.Labels[1][p2] = p3
				t.Labels[2][p2] = p3
				t.Labels[3][p2] = p3
				t.Labels[4][p2] = p3
				t.Labels[5][p2] = p3
				t.Labels[6][p2] = p3
				t.Labels[7][p2] = p3
				t.Labels[8][p2] = p3
				t.Labels[9][p2] = p3
				t:Update(p2, p3)
			end
		})

		function t.Destroy(p12) --[[ Line: 116 | Upvalues: TextService (ref), p1 (copy), TweenService (ref), digit (copy), v1 (ref), t (copy) ]]
			local v2 = TweenService:Create(digit, v1, {
				Size = UDim2.new(0, 0, 0, TextService:GetTextSize("8", p1.TextSize, p1.Font, Vector2.new(p1.TextSize, p1.TextSize)).Y + 10)
			})

			v2.Completed:Connect(function() --[[ Line: 126 | Upvalues: digit (ref), t (ref), v2 (copy) ]]
				digit:Destroy()
				table.clear(t)
				v2:Destroy()
			end)
			v2:Play()
		end
		function t.Update(p12, p2, p3) --[[ Line: 133 | Upvalues: v12 (ref), t (copy), TweenService (ref), canvas (copy), TextService (ref), p1 (copy), digit (copy), v1 (ref) ]]
			if p2 == "Duration" then
				v12 = TweenInfo.new(p3)

				for i = 0, 9 do
					t.CanvasTweens[i] = TweenService:Create(canvas, v12, {
						Position = UDim2.new(0, 0, -i, 0)
					})
				end
			elseif p2 == "Value" then
				local v13 = t.CanvasTweens[p3]

				if v13 then
					v13:Play()
				end
			else
				if p2 ~= "TextSize" and p2 ~= "Font" then
					return
				end

				local v2 = TextService:GetTextSize("8", p1.TextSize, p1.Font, Vector2.new(p1.TextSize, p1.TextSize))

				TweenService:Create(digit, v1, {
					Size = UDim2.new(0, v2.X + 1, 0, v2.Y + 10)
				}):Play()
			end
		end

		return v8
	end
}