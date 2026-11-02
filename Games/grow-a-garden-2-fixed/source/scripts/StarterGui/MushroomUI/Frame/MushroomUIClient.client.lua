--credit to leon games studio
local MushroomData = require(game.ReplicatedStorage.SharedModules.MushroomData)

local function DarkenColor(p1, p2) --[[ DarkenColor | Line: 7 ]]
	local v1 = p2 or 0.7

	return Color3.new(p1.R * v1, p1.G * v1, p1.B * v1)
end

task.wait(3)

local t = {}

for k, v in pairs(MushroomData.Data) do
	local v1 = script.Parent.TemplateUI:Clone()

	v1.BackgroundColor3 = v.Color
	v1:SetAttribute("HoverDescription", v.Description)

	local Color = v.Color
	local v2 = 0.7
	local v4 = Color3.new(Color.R * v2, Color.G * v2, Color.B * v2)

	for k2, v5 in pairs(v1:GetDescendants()) do
		if v5:IsA("UIStroke") then
			v5.Color = v4
		end
	end

	v1.Parent = script.Parent
	v1.Vector.Image = v.IMG
	v1.Visible = false
	table.insert(t, {
		LastAmount = 0,
		Name = v.Name,
		UI = v1
	})
end

local MushroomData2 = game.Players.LocalPlayer:WaitForChild("MushroomData")
local TweenService = game:GetService("TweenService")
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

function EDIT_UI(p1, p2) --[[ EDIT_UI | Line: 47 | Upvalues: TweenService (copy), v5 (copy) ]]
	if p1.ON.Value == p2 then
		return
	end

	if p2 == true then
		local tbl = {}
		local UIScale = p1.UIScale

		table.insert(tbl, (TweenService:Create(UIScale, v5, {
			Scale = 1
		})))
		UIScale.Scale = 0.7
		table.insert(tbl, (TweenService:Create(p1.Vector, v5, {
			ImageTransparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1, v5, {
			BackgroundTransparency = 0,
			ImageTransparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.BevelEffect, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 0.05
		})))
		table.insert(tbl, (TweenService:Create(p1.InletTexture, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 0.64
		})))
		table.insert(tbl, (TweenService:Create(p1.Vector, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.Time, v5, {
			TextTransparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.Time.UIStroke, v5, {
			Transparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.Amount, v5, {
			TextTransparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.Amount.UIStroke, v5, {
			Transparency = 0
		})))
		table.insert(tbl, (TweenService:Create(p1.UIStroke, v5, {
			Transparency = 0
		})))

		for k, v in pairs(tbl) do
			v:Play()
		end

		p1.Visible = true
	else
		local tbl = {}
		local v12 = TweenService:Create(p1.UIScale, v5, {
			Scale = 0.7
		})

		table.insert(tbl, v12)

		local v13 = TweenService:Create(p1.Vector, v5, {
			ImageTransparency = 1
		})

		table.insert(tbl, v13)

		local v14 = TweenService:Create(p1, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})

		table.insert(tbl, v14)

		local v15 = TweenService:Create(p1.BevelEffect, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})

		table.insert(tbl, v15)

		local v16 = TweenService:Create(p1.InletTexture, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})

		table.insert(tbl, v16)

		local v17 = TweenService:Create(p1.Vector, v5, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})

		table.insert(tbl, v17)

		local v18 = TweenService:Create(p1.Time, v5, {
			TextTransparency = 1
		})

		table.insert(tbl, v18)

		local v19 = TweenService:Create(p1.Time.UIStroke, v5, {
			Transparency = 1
		})

		table.insert(tbl, v19)

		local v20 = TweenService:Create(p1.Amount, v5, {
			TextTransparency = 1
		})

		table.insert(tbl, v20)

		local v21 = TweenService:Create(p1.Amount.UIStroke, v5, {
			Transparency = 1
		})

		table.insert(tbl, v21)

		local v22 = TweenService:Create(p1.UIStroke, v5, {
			Transparency = 1
		})

		table.insert(tbl, v22)

		for k, v in pairs(tbl) do
			v:Play()
		end

		task.spawn(function() --[[ Line: 107 | Upvalues: v5 (ref), p1 (copy) ]]
			task.wait(v5.Time)

			if p1.ON.Value ~= false then
				return
			end

			p1.Visible = false
		end)
	end

	p1.ON.Value = p2
end
function UPD(p1) --[[ UPD | Line: 118 | Upvalues: t (copy), MushroomData (copy), TweenService (copy), v5 (copy) ]]
	for k, v in pairs(t) do
		if v.Name == p1.Name then
			local TimeLeft = p1.TimeLeft.Value
			local v1 = math.floor(TimeLeft / 60)
			local v2 = nil

			for k2, v4 in pairs(MushroomData.Data) do
				if v4.Name == v.Name then
					v2 = v4

					break
				end
			end

			if v2 then
				local Amount = p1.Amount.Value

				v.UI:SetAttribute("HoverDescription", (v2.Description:gsub("([%d%.]+)", function(p1) --[[ Line: 137 | Upvalues: Amount (copy) ]]
					local v1 = tonumber(p1)

					if v1 then
						return tostring(v1 * Amount)
					end

					return p1
				end)))
			end

			if p1.Amount.Value ~= v.LastAmount and (v.UI.Visible == true and p1.Amount.Value > 1) then
				TweenService:Create(v.UI.UIScale, v5, {
					Scale = 1.075
				}):Play()
				task.delay(v5.Time, function() --[[ Line: 152 | Upvalues: TweenService (ref), v (copy), v5 (ref) ]]
					TweenService:Create(v.UI.UIScale, v5, {
						Scale = 1
					}):Play()
				end)
			end

			v.LastAmount = p1.Amount.Value
			v.UI.Amount.Text = "x" .. tostring(p1.Amount.Value)
			v.UI.Time.Text = string.format("%d:%02d", v1, TimeLeft % 60)

			if p1.TimeLeft.Value > 0 then
				v.UI.Visible = true

				return
			end

			break
		end
	end
end
function TRACK(p1) --[[ TRACK | Line: 171 | Upvalues: t (copy) ]]
	local Active = p1.Active

	p1.TimeLeft:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 175 | Upvalues: p1 (copy) ]]
		UPD(p1)
	end)
	p1.Amount:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 178 | Upvalues: p1 (copy) ]]
		UPD(p1)
	end)
	Active:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 181 | Upvalues: t (ref), p1 (copy), Active (copy) ]]
		for k, v in pairs(t) do
			if v.Name == p1.Name then
				EDIT_UI(v.UI, Active.Value)

				return
			end
		end
	end)
end

for k, v in pairs(MushroomData2:GetChildren()) do
	TRACK(v)
end

MushroomData2.ChildAdded:Connect(function(p1) --[[ Line: 195 ]]
	TRACK(p1)
end)