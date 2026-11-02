

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("CollectionService")
game:GetService("RunService")
local u3 = game:GetService("Players")
local u4 = game:GetService("MarketplaceService")
local u5 = require(v1:WaitForChild("Config"))
local u6 = require(v1:WaitForChild("SoundManager"))
local u7 = require(v1:WaitForChild("ClientState"))
local v8 = v1:WaitForChild("Remotes")
local u9 = v8:WaitForChild("Rebirth")
local u10 = v8:WaitForChild("UpdateUI")
local u11 = {
	{ 1e63, "Vg" },
	{ 1e60, "Nd" },
	{ 1e57, "Od" },
	{ 1e54, "Spd" },
	{ 1e51, "Sxd" },
	{ 1e48, "Qid" },
	{ 1e45, "Qad" },
	{ 1e42, "Td" },
	{ 1e39, "Dd" },
	{ 1e36, "Ud" },
	{ 1e33, "Dc" },
	{ 1e30, "No" },
	{ 1e27, "Oc" },
	{ 1e24, "Sp" },
	{ 1e21, "Sx" },
	{ 1e18, "Qi" },
	{ 1000000000000000, "Qa" },
	{ 1000000000000, "T" },
	{ 1000000000, "B" },
	{ 1000000, "M" },
	{ 1000, "K" }
}
local function u18(p12) 

	local v13 = tonumber(p12) or 0
	for _, v14 in ipairs(u11) do
		local v15 = v14[1]
		local v16 = v14[2]
		if v15 <= v13 then
			return string.format("%.2f", v13 / v15):gsub("%.?0+$", "") .. v16
		end
	end
	local v17 = math.floor(v13)
	return tostring(v17)
end
local v19 = {}
local u20 = false
local u21 = nil
local u22 = false
local u23 = {}
local function u29() 

	local u24 = u3.LocalPlayer:WaitForChild("PlayerGui")
	local function v28(p25) 

		local v26 = u2:GetTagged(p25)
		for _, v27 in ipairs(v26) do
			if v27:IsDescendantOf(u24) then
				return v27
			end
		end
		return nil
	end
	u23.modal = v28("RebirthModal")
	u23.closeBtn = v28("RebirthCloseBtn")
	u23.rebirthBtn = v28("RebirthConfirmBtn")
	u23.currentMultText = v28("RebirthCurrentMultText")
	u23.nextMultText = v28("RebirthNextMultText")
	u23.reqLevelText = v28("RebirthReqLevelText")
	u23.progressFill = v28("RebirthBarFill")
	u23.progressText = v28("RebirthBarText")
	u23.rebirthframe = v28("RebirthFrame")
	u23.rebirthDevBtn = v28("RebirthDevProduct")
end
function v19.UpdateDisplay(_) 

	if not u23.modal then
		u29()
	end
	if u23.modal then
		local v30 = u7:Get()
		local v31 = u5.REBIRTH_TIERS
		local v32 = (v30.Rebirths or 0) + 1
		local v33 = v30.Multiplier or 1
		if #v31 < v32 then
			if u23.currentMultText then
				u23.currentMultText.Text = "x" .. u18(v33) .. " Speed"
			end
			if u23.nextMultText and u23.nextMultText.Text ~= "MAX!" then
				u23.nextMultText.Text = "MAX!"
				if u23.progressFill then
					u23.progressFill.Size = UDim2.new(1, 0, 1, 0)
				end
				if u23.rebirthBtn then
					u23.rebirthBtn.Text = "MAX"
					u23.rebirthBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
					if u23.rebirthframe then
						u23.rebirthframe.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
					end
				end
			end
			if u23.rebirthDevBtn then
				u23.rebirthDevBtn.Visible = false
			end
		else
			if u23.rebirthDevBtn then
				u23.rebirthDevBtn.Visible = true
			end
			local v34 = v31[v32]
			local v35 = v34.level
			local v36 = v34.multiplier
			if u23.currentMultText then
				u23.currentMultText.Text = "x" .. u18(v33) .. " Speed"
			end
			if u23.nextMultText then
				u23.nextMultText.Text = "x" .. u18(v36) .. " Speed"
			end
			if u23.reqLevelText then
				u23.reqLevelText.Text = "Level " .. v35
			end
			local v37 = v30.Level / v35
			local v38 = math.clamp(v37, 0, 1)
			if u23.progressFill then
				u23.progressFill.Size = UDim2.new(v38, 0, 1, 0)
			end
			if u23.progressText then
				u23.progressText.Text = "Level " .. v30.Level .. " / " .. v35
			end
			if u23.rebirthBtn then
				if v35 <= v30.Level then
					u23.rebirthBtn.Text = u22 and "WAIT..." or "Rebirth!"
					u23.rebirthBtn.BackgroundColor3 = Color3.fromRGB(200, 18, 21)
					u23.rebirthframe.BackgroundColor3 = Color3.fromRGB(200, 18, 21)
					return
				end
				u23.rebirthBtn.Text = "Need level " .. v35
				u23.rebirthBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
				u23.rebirthframe.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
			end
		end
	else
		return
	end
end
local function u46() 

	if not u20 then
		if not u23.modal then
			u29()
		end
		if u23.closeBtn then
			u23.closeBtn.MouseButton1Click:Connect(function()

				u7:CloseCurrentModal()
			end)
		end
		if u23.rebirthDevBtn then
			u23.rebirthDevBtn.MouseButton1Click:Connect(function()

				local v39 = u7:Get()
				local v40 = u5.GetRebirthProductId(v39.Rebirths or 0)
				u4:PromptProductPurchase(u3.LocalPlayer, v40)
			end)
		end
		local u41 = {
			[u5.DEV_PRODUCTS.INSTANT_REBIRTH_T1] = true,
			[u5.DEV_PRODUCTS.INSTANT_REBIRTH_T2] = true,
			[u5.DEV_PRODUCTS.INSTANT_REBIRTH_T3] = true
		}
		u4.PromptProductPurchaseFinished:Connect(function(_, p42, p43)

			if p43 and u41[p42] then
				u6:Play("BUY")
				u7:CloseCurrentModal()
			end
		end)
		if u23.rebirthBtn then
			u23.rebirthBtn.MouseButton1Click:Connect(function()

				if not u22 then
					local v44 = u7:Get()
					local v45 = u5.REBIRTH_TIERS[v44.Rebirths + 1]
					if v45 and v44.Level >= v45.level then
						u22 = true
						u9:FireServer()
						task.wait(0.2)
						u7:CloseCurrentModal()
						u22 = false
					end
				end
			end)
		end
		u20 = true
	end
end
function v19.OnClose(_) 

	if u21 then
		u21:Disconnect()
		u21 = nil
	end
	u22 = false
end
function v19.InitLogic(u47) 

	if not u23.modal then
		u29()
	end
	u46()
	u47:UpdateDisplay()
	if not u21 then
		u21 = u10.OnClientEvent:Connect(function(p48)

			if p48.Level or (p48.Rebirths or p48.Multiplier) then
				u47:UpdateDisplay()
			end
		end)
	end
end
return v19