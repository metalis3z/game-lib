

local u1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("Players")
local u4 = game:GetService("MarketplaceService")
local u5 = require(v2:WaitForChild("ClientState"))
local u6 = require(v2:WaitForChild("Config"))
local u7 = require(v2:WaitForChild("EventsConfig"))
local u8 = v2:WaitForChild("Remotes")
local v9 = {}
local u10 = false
local u11 = Color3.fromHex("3cff00")
local u12 = Color3.fromHex("ffffff")
local function u19(p13, p14, p15) 

	local v16 = table.find(p14, p13) ~= nil
	local trailData = u6.TRAILS[p13]
	if not trailData then
		for _, v in ipairs(u7.Trails or {}) do
			if v.Key == p13 then
				trailData = v
				break
			end
		end
	end
	local isGamepassOnly = trailData and (trailData.Price == 0 or trailData.Price == nil) and trailData.Gamepass and trailData.Gamepass > 0
	for _, v17 in ipairs(u1:GetTagged(p13)) do
		local v18 = v17:GetAttribute("Action")
		if v18 == "BuyWins" then
			v17.Visible = not v16 and not isGamepassOnly
		elseif v18 == "BuyGamepass" or (v18 == "BuyCurrency" or v18 == "BuyGoldenEggs") then
			v17.Visible = not v16
		elseif v18 == "Equip" then
			v17.Visible = v16
			v17.BackgroundColor3 = p15 == p13 and u11 or u12
		elseif v18 == "TextEquip" and (v17:IsA("TextLabel") or v17:IsA("TextButton")) then
			if p15 == p13 then
				v17.Text = "Equipped"
				v17.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				v17.Text = "Equip"
				v17.TextColor3 = Color3.fromRGB(200, 200, 200)
			end
		end
	end
end
function v9.UpdateDisplay(_) 

	local v20 = u5:Get()
	local v21 = v20.OwnedTrails or {}
	local v22 = v20.EquippedTrail or "None"
	for v23, _ in pairs(u6.TRAILS) do
		u19(v23, v21, v22)
	end
	for _, v24 in ipairs(u7.Trails or {}) do
		u19(v24.Key, v21, v22)
	end
end
function v9.InitLogic(u25) 

	if not u10 then
		u10 = true
		local function v27(p26) 

			if not p26:GetAttribute("IsConnectedClose") then
				p26:SetAttribute("IsConnectedClose", true)
				p26.MouseButton1Click:Connect(function()

					u5:CloseCurrentModal()
				end)
			end
		end
		for _, v28 in ipairs(u1:GetTagged("TrailsCloseBtn")) do
			if not v28:GetAttribute("IsConnectedClose") then
				v28:SetAttribute("IsConnectedClose", true)
				v28.MouseButton1Click:Connect(function()

					u5:CloseCurrentModal()
				end)
			end
		end
		u1:GetInstanceAddedSignal("TrailsCloseBtn"):Connect(v27)
		local function v47(u29) 

			for _, u30 in ipairs(u1:GetTagged(u29)) do
				if u30:IsA("GuiButton") then
					if not u30:GetAttribute("IsConnected") then
						u30:SetAttribute("IsConnected", true)
						u30.MouseButton1Click:Connect(function()

							local v31 = u30:GetAttribute("Action")
							if v31 == "BuyWins" then
								local v32, v33 = u8.BuyTrail:InvokeServer(u29, "Wins")
								if not v32 then
									warn("[TrailSystem] " .. tostring(v33))
									return
								end
							elseif v31 == "BuyCurrency" or v31 == "BuyGoldenEggs" then
								local v34, v35 = u8.BuyTrail:InvokeServer(u29, "Currency")
								if not v34 then
									warn("[TrailSystem] " .. tostring(v35))
									return
								end
							elseif v31 == "BuyGamepass" then
								local v36 = u6.TRAILS[u29]
								if not v36 then
									for _, v37 in ipairs(u7.Trails or {}) do
										if v37.Key == u29 then
											v36 = v37
											break
										end
									end
								end
								if v36 and (v36.Gamepass and v36.Gamepass > 0) then
									u4:PromptGamePassPurchase(u3.LocalPlayer, v36.Gamepass)
									return
								end
							elseif v31 == "Equip" then
								u8.EquipTrail:FireServer(u29)
							end
						end)
					end
				end
			end
			u1:GetInstanceAddedSignal(u29):Connect(function(u38)

				if u38:IsA("GuiButton") then
					local u39 = u29
					if not u38:GetAttribute("IsConnected") then
						u38:SetAttribute("IsConnected", true)
						u38.MouseButton1Click:Connect(function()

							local v40 = u38:GetAttribute("Action")
							if v40 == "BuyWins" then
								local v41, v42 = u8.BuyTrail:InvokeServer(u39, "Wins")
								if not v41 then
									warn("[TrailSystem] " .. tostring(v42))
									return
								end
							elseif v40 == "BuyCurrency" or v40 == "BuyGoldenEggs" then
								local v43, v44 = u8.BuyTrail:InvokeServer(u39, "Currency")
								if not v43 then
									warn("[TrailSystem] " .. tostring(v44))
									return
								end
							elseif v40 == "BuyGamepass" then
								local v45 = u6.TRAILS[u39]
								if not v45 then
									for _, v46 in ipairs(u7.Trails or {}) do
										if v46.Key == u39 then
											v45 = v46
											break
										end
									end
								end
								if v45 and (v45.Gamepass and v45.Gamepass > 0) then
									u4:PromptGamePassPurchase(u3.LocalPlayer, v45.Gamepass)
									return
								end
							elseif v40 == "Equip" then
								u8.EquipTrail:FireServer(u39)
							end
						end)
					end
					u25:UpdateDisplay()
				end
			end)
		end
		for v48, _ in pairs(u6.TRAILS) do
			v47(v48)
		end
		for _, v49 in ipairs(u7.Trails or {}) do
			v47(v49.Key)
		end
		u25:UpdateDisplay()
	end
end
function v9.OnClose(_) 
 end
return v9