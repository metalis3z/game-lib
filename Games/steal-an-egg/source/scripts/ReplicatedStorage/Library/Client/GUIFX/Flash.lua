-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = require(ReplicatedStorage:WaitForChild("Library").Functions)
local GetHolder = require(script.Parent.GetHolder)

return function(p1, p2, p3, p4) --[[ Line: 6 | Upvalues: GetHolder (copy), Functions (copy) ]]
	local v1 = p1 or 1
	local v2 = p2 or 1
	local v3 = p3 or Color3.new(255/255, 255/255, 255/255)
	local v4 = p4 or 0

	task.spawn(function() --[[ Line: 12 | Upvalues: v3 (copy), GetHolder (ref), v1 (copy), Functions (ref), v4 (copy), v2 (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.BackgroundTransparency = 1
		Frame.BackgroundColor3 = v3
		Frame.Size = UDim2.new(2, 0, 2, 0)
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame.BorderSizePixel = 0
		Frame.Parent = GetHolder()

		if v1 > 0 then
			Functions.Tween(Frame, {
				BackgroundTransparency = v4
			}, { v1, "Expo", "Out" })
			wait(v1)
		else
			Frame.BackgroundTransparency = v4
		end

		if v2 > 0 then
			Functions.Tween(Frame, {
				BackgroundTransparency = 1
			}, { v2, "Sine", "Out" })
			wait(v2)
		else
			Frame.BackgroundTransparency = 1
		end

		Frame:Destroy()
	end)
end