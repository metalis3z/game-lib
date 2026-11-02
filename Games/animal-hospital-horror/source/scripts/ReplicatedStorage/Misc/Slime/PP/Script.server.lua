local LocalPlayer = game.Players.LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local v2 = script.Parent
local HoldDuration = v2.HoldDuration

local function setupchar(p1) --[[ setupchar | Line: 7 | Upvalues: v2 (copy), HoldDuration (copy) ]]
	p1.ChildAdded:Connect(function(p1) --[[ Line: 8 | Upvalues: v2 (ref) ]]
		if p1.Name ~= "Cough Syrup" then
			return
		end

		local v1 = v2

		v1.HoldDuration = v1.HoldDuration / 3
	end)
	p1.ChildRemoved:Connect(function(p1) --[[ Line: 14 | Upvalues: v2 (ref), HoldDuration (ref) ]]
		if p1.Name ~= "Cough Syrup" then
			return
		end

		v2.HoldDuration = HoldDuration
	end)
	v2.HoldDuration = HoldDuration
end

LocalPlayer.CharacterAdded:Connect(setupchar)
setupchar(v1)