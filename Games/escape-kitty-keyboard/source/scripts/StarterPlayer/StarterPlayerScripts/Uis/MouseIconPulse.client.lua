

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local u3 = game:GetService("TweenService")
local u4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local function u6(p5) 

	u3:Create(p5, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		["Size"] = p5.Size + UDim2.fromScale(0.07, 0.07)
	}):Play()
end
local v9 = (function(p7) 

	for _, v8 in ipairs(u2:GetTagged(p7)) do
		if v8:IsDescendantOf(u4) then
			return v8
		end
	end
	return nil
end)("MouseIcon")
local v10
if v9 and v9:IsA("GuiObject") then
	u6(v9)
	v10 = true
else
	v10 = false
end
if not v10 then
	u2:GetInstanceAddedSignal("MouseIcon"):Connect(function(p11)

		if p11:IsDescendantOf(u4) and p11:IsA("GuiObject") then
			u6(p11)
		end
	end)
end