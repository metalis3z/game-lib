-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Holder = script.Parent.Holder
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

Holder.Position = UDim2.new(1.25, 0, 0.5, 0)

local v2 = TweenService:Create(Holder, v1, {
	Position = UDim2.new(0.5, 0, 0.5, 0)
})

v2:Play()
game.Debris:AddItem(v2, v1.Time)

local tbl = { script.Parent }

for k, v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("Frame") or (v:IsA("TextLabel") or (v:IsA("UIStroke") or (v:IsA("ImageLabel") or v:IsA("TextButton")))) then
		table.insert(tbl, v)
	end
end

local t = {}

for k, v in pairs(tbl) do
	if v:IsA("TextLabel") then
		local TextTransparency = v.TextTransparency
		local TextStrokeTransparency = v.TextStrokeTransparency

		v.TextTransparency = 1
		v.TextStrokeTransparency = 1

		local v3 = TweenService:Create(v, v1, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency
		})

		v3:Play()
		game.Debris:AddItem(v3, v1.Time)
		table.insert(t, TweenService:Create(v, v1, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}))

		continue
	end

	if v:IsA("Frame") then
		local BackgroundTransparency = v.BackgroundTransparency

		v.BackgroundTransparency = 1

		local v4 = TweenService:Create(v, v1, {
			BackgroundTransparency = BackgroundTransparency
		})

		v4:Play()
		game.Debris:AddItem(v4, v1.Time)
		table.insert(t, TweenService:Create(v, v1, {
			BackgroundTransparency = 1
		}))

		continue
	end

	if v:IsA("UIStroke") then
		local Transparency = v.Transparency

		v.Transparency = 1

		local v5 = TweenService:Create(v, v1, {
			Transparency = Transparency
		})

		v5:Play()
		game.Debris:AddItem(v5, v1.Time)
		table.insert(t, TweenService:Create(v, v1, {
			Transparency = 1
		}))

		continue
	end

	if v:IsA("ImageLabel") then
		local ImageTransparency = v.ImageTransparency
		local BackgroundTransparency = v.BackgroundTransparency

		v.ImageTransparency = 1
		v.BackgroundTransparency = 1

		local v6 = TweenService:Create(v, v1, {
			ImageTransparency = ImageTransparency,
			BackgroundTransparency = BackgroundTransparency
		})

		v6:Play()
		game.Debris:AddItem(v6, v1.Time)
		table.insert(t, TweenService:Create(v, v1, {
			ImageTransparency = 1,
			BackgroundTransparency = 1
		}))

		continue
	end

	if v:IsA("TextButton") then
		local TextTransparency = v.TextTransparency
		local BackgroundTransparency = v.BackgroundTransparency

		v.TextTransparency = 1
		v.BackgroundTransparency = 1

		local v7 = TweenService:Create(v, v1, {
			TextTransparency = TextTransparency,
			BackgroundTransparency = BackgroundTransparency
		})

		v7:Play()
		game.Debris:AddItem(v7, v1.Time)
		table.insert(t, TweenService:Create(v, v1, {
			TextTransparency = 1,
			BackgroundTransparency = 1
		}))
	end
end

task.spawn(function() --[[ Line: 89 | Upvalues: t (copy), v1 (copy) ]]
	task.wait(30)

	if not script.Parent then
		return
	end

	for k, v in pairs(t) do
		v:Play()
	end

	game.Debris:AddItem(script.Parent, v1.Time)
end)