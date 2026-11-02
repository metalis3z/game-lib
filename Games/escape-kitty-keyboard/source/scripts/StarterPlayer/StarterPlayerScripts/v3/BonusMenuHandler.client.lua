

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
if v3.UserId == 3845375404 then
	local u4 = v2:WaitForChild("BonusMenuAction")
	local v5 = v3:WaitForChild("PlayerGui")
	local function u41(u6) 

		local v7 = u6:WaitForChild("Background")
		local u8 = v7:WaitForChild("Panel")
		local v9 = u8:WaitForChild("CloseBtn")
		local u10 = u8:WaitForChild("ScopeFrame")
		local u11 = u8:WaitForChild("PlayerFrame")
		local u12 = u11:WaitForChild("PlayerInput")
		local u13 = u8:WaitForChild("TypeFrame")
		local u14 = u8:WaitForChild("MultInput")
		local u15 = u8:WaitForChild("DurInput")
		local v16 = u8:WaitForChild("ActivateBtn")
		local v17 = u8:WaitForChild("StopAllBtn")
		local u18 = "server"
		local u19 = "Wins"
		local u20 = Color3.fromRGB(40, 40, 55)
		local function u30() 

			for _, v21 in ipairs(u10:GetChildren()) do
				if v21:IsA("TextButton") then
					if v21:GetAttribute("ScopeValue") == u18 then
						local v22 = v21:GetAttribute("ActiveColor")
						if v22 then
							local v23 = string.split(v22, ",")
							local v24 = Color3.fromRGB
							local v25 = v23[1]
							local v26 = tonumber(v25) or 40
							local v27 = v23[2]
							local v28 = tonumber(v27) or 40
							local v29 = v23[3]
							v21.BackgroundColor3 = v24(v26, v28, tonumber(v29) or 55)
						end
					else
						v21.BackgroundColor3 = u20
					end
				end
			end
			u11.Visible = u18 == "player"
		end
		local function u32() 

			for _, v31 in ipairs(u13:GetChildren()) do
				if v31:IsA("TextButton") then
					if v31:GetAttribute("TypeValue") == u19 then
						v31.BackgroundColor3 = Color3.fromRGB(50, 100, 160)
					else
						v31.BackgroundColor3 = u20
					end
				end
			end
		end
		local u33 = u19
		local u34 = u18
		for _, u35 in ipairs(u10:GetChildren()) do
			if u35:IsA("TextButton") then
				u35.MouseButton1Click:Connect(function()

					u34 = u35:GetAttribute("ScopeValue") or "server"
					u30()
				end)
			end
		end
		for _, u36 in ipairs(u13:GetChildren()) do
			if u36:IsA("TextButton") then
				u36.MouseButton1Click:Connect(function()

					u33 = u36:GetAttribute("TypeValue") or "Wins"
					u32()
				end)
			end
		end
		v16.MouseButton1Click:Connect(function()

			u4:FireServer({
				["action"] = "activate",
				["scope"] = u34,
				["bonusType"] = u33,
				["multiplier"] = u14.Text,
				["duration"] = u15.Text,
				["playerName"] = u12.Text
			})
		end)
		v17.MouseButton1Click:Connect(function()

			u4:FireServer({
				["action"] = "stopAll"
			})
		end)
		v9.MouseButton1Click:Connect(function()

			u6:Destroy()
		end)
		v7.InputBegan:Connect(function(p37)

			if p37.UserInputType == Enum.UserInputType.MouseButton1 or p37.UserInputType == Enum.UserInputType.Touch then
				local v38 = u8.AbsolutePosition
				local v39 = u8.AbsoluteSize
				local v40 = p37.Position
				if v40.X < v38.X or (v40.X > v38.X + v39.X or (v40.Y < v38.Y or v40.Y > v38.Y + v39.Y)) then
					u6:Destroy()
				end
			end
		end)
		u30()
		u32()
	end
	v5.ChildAdded:Connect(function(p42)

		if p42.Name == "BonusMenuGUI" and p42:IsA("ScreenGui") then
			task.defer(u41, p42)
		end
	end)
	local v43 = v5:FindFirstChild("BonusMenuGUI")
	if v43 then
		u41(v43)
	end
end