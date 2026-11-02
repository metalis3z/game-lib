

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = require(v3:WaitForChild("TopbarPlus"):WaitForChild("Icon"))
local u5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local function u7() 

	for _, v6 in ipairs(u2:GetTagged("SocialVerifyGui")) do
		if v6:IsA("ScreenGui") and v6:IsDescendantOf(u5) then
			return v6
		end
	end
	return nil
end
local u8 = v4.new():setName("CodeButton"):setLabel("Code")
u8.selected:Connect(function()

	local v9 = u7()
	if v9 then
		v9.Enabled = true
	end
end)
u8.deselected:Connect(function()

	local v10 = u7()
	if v10 then
		v10.Enabled = false
	end
end)
local function v13(p11) 

	if p11:IsA("GuiButton") and p11:IsDescendantOf(u5) then
		p11.Activated:Connect(function()

			local v12 = u7()
			if v12 then
				v12.Enabled = false
			end
			u8:deselect()
		end)
	end
end
for _, v14 in ipairs(u2:GetTagged("SocialVerifyButton")) do
	if v14:IsA("GuiButton") and v14:IsDescendantOf(u5) then
		v14.Activated:Connect(function()

			local v15 = u7()
			if v15 then
				v15.Enabled = false
			end
			u8:deselect()
		end)
	end
end
u2:GetInstanceAddedSignal("SocialVerifyButton"):Connect(v13)
task.defer(function()

	local v16 = u7()
	if v16 then
		v16.Enabled = false
	end
end)