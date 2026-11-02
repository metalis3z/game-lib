-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent.Parent
local Frame = v1.Frame
local TweenService = game:GetService("TweenService")
local v2 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local tbl = { Frame }

for k, v in pairs(Frame:GetDescendants()) do
	if v:IsA("TextLabel") or (v:IsA("UIStroke") or (v:IsA("ImageLabel") or v:IsA("Frame"))) then
		table.insert(tbl, v)
	end
end

local t = {}
local Background = Frame.Frame.Background

table.insert(t, TweenService:Create(Background, v2, {
	Position = UDim2.new(0.5, 0, 0.5, 0)
}))

for k, v in pairs(tbl) do
	if v:IsA("TextLabel") then
		if v.TextTransparency == 0 then
			table.insert(t, TweenService:Create(v, v2, {
				TextTransparency = 0
			}))
		end

		continue
	end

	if v:IsA("UIStroke") then
		if v.Transparency == 0 then
			table.insert(t, TweenService:Create(v, v2, {
				Transparency = 0
			}))
		end

		continue
	end

	if v:IsA("ImageLabel") and v.ImageTransparency == 0 then
		table.insert(t, TweenService:Create(v, v2, {
			ImageTransparency = 0
		}))
	end
end

script.Parent:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 33 | Upvalues: Background (copy), tbl (copy), t (copy), v1 (copy) ]]
	if script.Parent.Value ~= true then
		v1.Frame.Visible = false

		return
	end

	Background.Position = UDim2.new(0.75, 0, 0.5, 0)

	for k, v in pairs(tbl) do
		if v:IsA("TextLabel") then
			v.TextTransparency = 1

			continue
		end

		if v:IsA("UIStroke") then
			v.Transparency = 1

			continue
		end

		if v:IsA("Frame") then
			v.BackgroundTransparency = 1

			continue
		end

		if v:IsA("ImageLabel") then
			v.ImageTransparency = 1
		end
	end

	for k, v in pairs(t) do
		v:Play()
	end

	v1.Frame.Visible = true
end)