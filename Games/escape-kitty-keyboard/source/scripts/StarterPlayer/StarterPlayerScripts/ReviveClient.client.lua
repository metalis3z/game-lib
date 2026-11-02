

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("MarketplaceService")
local u4 = game:GetService("SoundService")
local v5 = game:GetService("ReplicatedStorage")
local u6 = game:GetService("Debris")
local u7 = require(v5:WaitForChild("Config"))
local u8 = v1.LocalPlayer
local u9 = u8:WaitForChild("PlayerGui")
local v10 = v5:WaitForChild("Remotes")
local v11 = v10:WaitForChild("RevivePrompt")
local u12 = v10:WaitForChild("RequestRevive")
local v13 = v10:WaitForChild("ReviveSuccess")
local u14 = u7.DEV_PRODUCTS.REVIVE
local function u17(p15) 

	for _, v16 in ipairs(u2:GetTagged(p15)) do
		if v16:IsDescendantOf(u9) then
			return v16
		end
	end
	return nil
end
local u18 = false
local u19 = nil
v11.OnClientEvent:Connect(function(p20)

	if u18 then
		return
	else
		u18 = true
		local v21 = u17("ReviveFrame")
		if v21 and v21:IsA("GuiObject") then
			local v22 = u17("ReviveText")
			if v22 and v22:IsA("TextLabel") then
				v22.Text = "Revive to level " .. tostring(p20) .. " ?"
			end
			v21.Visible = true
			local u23 = false
			local v24 = u17("ReviveButton")
			if v24 and v24:IsA("GuiButton") then
				u19 = v24.MouseButton1Click:Connect(function()

					if not u23 then
						u23 = true
						u12:FireServer()
					end
				end)
			end
			task.delay(5, function()

				if u19 then
					u19:Disconnect()
					u19 = nil
				end
				local v25 = u17("ReviveFrame")
				if v25 and v25:IsA("GuiObject") then
					v25.Visible = false
				end
				u18 = false
			end)
		else
			u18 = false
		end
	end
end)
v3.PromptProductPurchaseFinished:Connect(function(p26, p27, p28)

	if p26 == u8.UserId then
		if p27 == u14 then
			if not p28 then
				local v29 = u17("ReviveFrame")
				if v29 and v29:IsA("GuiObject") then
					v29.Visible = false
				end
				u18 = false
			end
		end
	else
		return
	end
end)
v13.OnClientEvent:Connect(function()

	if u19 then
		u19:Disconnect()
		u19 = nil
	end
	local v30 = u17("ReviveFrame")
	if v30 and v30:IsA("GuiObject") then
		v30.Visible = false
	end
	u18 = false
	local v31 = u7.SOUNDS.BUY
	local v32 = Instance.new("Sound")
	v32.SoundId = v31.ID
	v32.Volume = v31.Volume
	v32.Parent = u4
	v32:Play()
	u6:AddItem(v32, 5)
end)