

local u1 = _G.HDAdminMain
local u2 = {}
local v3 = u1.gui.MainFrame.Pages.Boost.Buy.Banner
local v4 = v3.Buttons
local u5 = v4.Unlock
local u6 = v4.Unlocked
local u7 = u5.TextLabel
local u8 = v3.Fade.Discount
local u9 = u8.Counter
local u10 = u5.Discount
local u11 = false
local u12 = nil
local u13 = true
function u2.UpdateBoostStatus(_, p14) 

	u1:GetModule("ChatHandler"):DecideWelcomePrompt(p14)
end
function u2.OfferOnClose(_) 

	if u12 == nil and u13 then
		u13 = false
		u2:CheckOffer(false, true)
		task.delay(0.2, function()

			u13 = true
		end)
	end
end
function u2.CheckOffer(_, p15, p16) 

	local u17 = false
	local v18, v19 = pcall(function()

		return u1.signals.RetrieveOfferStartTime:InvokeServer(u17)
	end)
	if v18 then
		u12 = v19
	else
		v19 = nil
	end
	local u20 = v19 or 0
	local u21 = nil
	local function u28() 

		local v22 = os.time()
		local u23 = u20 + 900 - v22
		local v24
		if v22 - u20 <= 900 then
			v24 = not u6.Visible
		else
			v24 = false
		end
		u21 = v24
		u8.Visible = u21
		u10.Visible = u21
		u7.Text = u21 and 479 or 599
		if u21 and not u11 then
			task.spawn(function()

				u11 = true
				for v25 = u23, 0, -1 do
					local v26 = string.format
					local v27 = v25 / 60
					u9.Text = "<b>" .. v26("%02i:%02i", math.floor(v27), v25 % 60) .. "</b>"
					if u6.Visible then
						break
					end
					task.wait(1)
				end
				u8.Visible = false
				u10.Visible = false
				u7.Text = 599
			end)
		end
	end
	u28()
	local v29 = nil
	if not u6.Visible then
		v29 = p15 == true and (u21 or u20 == 0) and "Get 20% off more commands. Click to view." or (p15 == false and (u21 or (u20 == 0 or p16 == true)) and "Get 20% off Chat Commands. Click to view." or ((p16 == true or typeof(p15) == "boolean") and "Unlock bonus Chat Commands. Click to view." or v29))
	end
	if v29 then
		local v33 = { "CallFunctionSpecialOnClick", function()

				local u30 = true
				local v31, v32 = pcall(function()

					return u1.signals.RetrieveOfferStartTime:InvokeServer(u30)
				end)
				if v31 then
					u12 = v32
				else
					v32 = nil
				end
				u20 = v32
				u28()
				u1:GetModule("GUIs"):ShowSpecificPage("Boost", "Buy", nil, nil, nil, true)
			end }
		u1:GetModule("Notices"):Notice("Notice", "System", v29, v33)
	end
end
task.defer(function(p34) 

	local v35 = p34 or u1.modules.cf:HasBooster()
	u5.Visible = not v35
	u6.Visible = v35
	local v36 = u1:GetModule("ChatHandler")
	if v35 then
		v36:GenerateChatCommands()
	end
	if p34 then
		u2:UpdateBoostStatus(v35)
	end
end)
task.defer(u2.UpdateBoostStatus)
task.defer(u2.CheckOffer)
u5.MouseButton1Down:Connect(function()

	u1.modules.cf:PromptGamepass(u1.player, "Booster")
end)
u1.marketplaceService.PromptGamePassPurchaseFinished:Connect(function(p37, p38, p39)

	if p37 == u1.player and (p38 == u1.products.Booster or p38 == u1.products.Donor) and p39 then
		u5.Visible = false
		u6.Visible = true
		u1:GetModule("ChatHandler"):GenerateChatCommands()
		u2:UpdateBoostStatus(true)
	end
end)
u1.marketplaceService.PromptBulkPurchaseFinished:Connect(function(p40, p41, p42)

	if p40 == u1.player and p41 == Enum.MarketplaceBulkPurchasePromptStatus.Completed then
		local v43 = u1.accessories.Booster
		local v44 = tostring(v43)
		local v45 = u1.accessories.Booster2
		local v46 = tostring(v45)
		local v47 = p42.Items
		local v48 = false
		if v47 then
			for _, v49 in pairs(v47) do
				local v50 = v49.id
				local v51 = tostring(v50)
				if (v51 == v44 or v51 == v46) and v49.status == Enum.MarketplaceItemPurchaseStatus.Success then
					v48 = v51
					break
				end
			end
		end
		if v48 then
			u5.Visible = false
			u6.Visible = true
			u1:GetModule("ChatHandler"):GenerateChatCommands()
			u2:UpdateBoostStatus(true)
			u1.signals.BulkPurchaseFinished:FireServer(v48)
			u1:GetModule("Notices"):Notice("Notice", "System", "Successfully purchased Chat Command! Click to use.", { "OpenCommands", "Booster" })
		end
	end
end)
local v52 = v4.View.TextButton
function u2.ShowBoostCommands(_) 

	u1:GetModule("GUIs"):ShowSpecificPage("Commands", "Commands", "Boost", "Buy")
	u1:GetModule("PageCommands"):SetSearchText("Booster")
end
v52.MouseButton1Down:Connect(function()

	u2:ShowBoostCommands()
end)
return u2