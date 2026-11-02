

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("CollectionService")
local u4 = require(v2:WaitForChild("SoundManager"))
local v5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local function u8(u6) 

	if u6:IsA("GuiButton") then
		local v7 = u6:FindFirstAncestorOfClass("ScreenGui")
		if v7 and u3:HasTag(v7, "MainGUI") and true or false then
			u6.MouseEnter:Connect(function()

				if u6.Visible and u6.Active then
					u4:Play("HOVER")
				end
			end)
			u6.MouseButton1Click:Connect(function()

				if u6.Visible and u6.Active then
					u4:Play("CLICK")
				end
			end)
		end
	else
		return
	end
end
for _, v9 in ipairs(v5:GetDescendants()) do
	u8(v9)
end
v5.DescendantAdded:Connect(function(p10)

	u8(p10)
end)