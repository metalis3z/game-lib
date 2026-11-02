-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = require(v3:WaitForChild("TopbarPlus"):WaitForChild("Icon"))
local u5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local u6 = true
local function u9(p7) -- name: setUIVisible
	-- upvalues: (ref) u6, (copy) u2, (copy) u5
	u6 = p7
	for _, v8 in ipairs(u2:GetTagged("UI")) do
		if v8:IsA("Frame") and v8:IsDescendantOf(u5) then
			v8.Visible = p7
		end
	end
end
u2:GetInstanceAddedSignal("UI"):Connect(function(p10)
	-- upvalues: (copy) u5, (ref) u6
	if p10:IsA("Frame") and p10:IsDescendantOf(u5) then
		p10.Visible = u6
	end
end)
local v11 = v4.new():setName("UIToggle"):setImage("rbxassetid://94652404380463", "Selected"):setImage("rbxassetid://106788007315711", "Deselected"):setLabel("")
v11.selected:Connect(function()
	-- upvalues: (copy) u9
	u9(false)
end)
v11.deselected:Connect(function()
	-- upvalues: (copy) u9
	u9(true)
end)