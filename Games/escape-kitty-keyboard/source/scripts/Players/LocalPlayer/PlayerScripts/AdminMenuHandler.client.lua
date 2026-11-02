-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
if v3.UserId == 1580586066 then
	local u4 = v2:WaitForChild("AdminMenuAction")
	local v5 = v3:WaitForChild("PlayerGui")
	local function u20(u6) -- name: wireMenu
		-- upvalues: (copy) u4
		local v7 = u6:WaitForChild("Background")
		local u8 = v7:WaitForChild("Panel")
		local u9 = u8:WaitForChild("InputFrame"):WaitForChild("PlayerInput")
		local v10 = u8:WaitForChild("CloseBtn")
		local v11 = u8:WaitForChild("ButtonScroll")
		v10.MouseButton1Click:Connect(function()
			-- upvalues: (copy) u6
			u6:Destroy()
		end)
		v7.InputBegan:Connect(function(p12)
			-- upvalues: (copy) u8, (copy) u6
			if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch then
				local v13 = u8.AbsolutePosition
				local v14 = u8.AbsoluteSize
				local v15 = p12.Position
				if v15.X < v13.X or (v15.X > v13.X + v14.X or (v15.Y < v13.Y or v15.Y > v13.Y + v14.Y)) then
					u6:Destroy()
				end
			end
		end)
		for _, u16 in ipairs(v11:GetChildren()) do
			if u16:IsA("TextButton") then
				u16.MouseButton1Click:Connect(function()
					-- upvalues: (copy) u16, (ref) u4, (copy) u9
					local v17 = string.match
					local v18 = u16.Name
					local v19 = tonumber(v17(v18, "%d+"))
					if v19 then
						u4:FireServer({
							["Index"] = v19,
							["PlayerName"] = u9.Text
						})
					end
				end)
			end
		end
	end
	v5.ChildAdded:Connect(function(p21)
		-- upvalues: (copy) u20
		if p21.Name == "AdminCmdMenu" and p21:IsA("ScreenGui") then
			task.defer(u20, p21)
		end
	end)
	local v22 = v5:FindFirstChild("AdminCmdMenu")
	if v22 then
		u20(v22)
	end
end