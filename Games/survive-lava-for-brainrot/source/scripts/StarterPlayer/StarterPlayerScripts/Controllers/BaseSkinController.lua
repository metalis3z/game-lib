-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("MarketplaceService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v4 = v3.Remotes.BaseSkins
local v_u_5 = v4.BuyBaseSkin
local v_u_6 = v4.EquipBaseSkin
local v_u_7 = v2.LocalPlayer
local v_u_8 = v_u_7:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("BaseSkins")
local v_u_9 = v_u_8:WaitForChild("Content")
local v_u_10 = v_u_9:WaitForChild("Template"):Clone()
local v_u_11 = require(v3.Icon)
local v_u_12 = require(v3.Shared.FormatNumber)
local v_u_13 = require(v3.Registries.BaseSkinRegistry)
local v_u_14 = require(v3.Registries.BrainrotRegistry)
local v_u_15 = require(v3.Registries.UpdateConfig)
local v_u_16 = require(v3.Modules.DataController)
local v_u_17 = require(script.Parent.UIController)
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = 0
function v_u_18.LoadSkins(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_19, (copy) v_u_13, (copy) v_u_10, (copy) v_u_12, (copy) v_u_5, (copy) v_u_6, (copy) v_u_1, (copy) v_u_7, (copy) v_u_18
	for _, v21 in v_u_9:GetChildren() do
		if v21:IsA("GuiObject") then
			v21:Destroy()
		end
	end
	for v22, v_u_23 in v_u_19 do
		local v_u_24 = v_u_13[v_u_23]
		if v_u_24 then
			local v25 = v_u_10:Clone()
			v25.Name = v_u_23
			v25.LayoutOrder = v22
			v25.DisplayName.Text = v_u_23
			v25.Icon.Image = v_u_24.Icon
			v25.Buttons.CashButton.Display.Text = ("$%*"):format((v_u_12(v_u_24.Price or 0)))
			v25.Buttons.RobuxButton:SetAttribute("ProductId", v_u_24.ProductId)
			v25.Parent = v_u_9
			v25.Buttons.CashButton.Activated:Connect(function()
				-- upvalues: (ref) v_u_5, (copy) v_u_23
				v_u_5:FireServer(v_u_23)
			end)
			v25.Buttons.EquipButton.Activated:Connect(function()
				-- upvalues: (ref) v_u_6, (copy) v_u_23
				v_u_6:FireServer(v_u_23)
			end)
			if v_u_24.GamePassId then
				local v27, v28 = pcall(function()
					-- upvalues: (ref) v_u_1, (copy) v_u_24
					local v26 = v_u_1:GetProductInfoAsync(v_u_24.GamePassId, Enum.InfoType.GamePass)
					if v26 then
						return v26.PriceInRobux
					end
				end)
				v25.Buttons.RobuxButton.PriceText.Text = not v27 and "ERROR" or v_u_12(v28)
				v25.Buttons.RobuxButton.Activated:Connect(function()
					-- upvalues: (ref) v_u_1, (ref) v_u_7, (copy) v_u_24
					v_u_1:PromptGamePassPurchase(v_u_7, v_u_24.GamePassId)
				end)
			end
		end
	end
	v_u_18:Render()
end
function v_u_18.Render(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_9, (copy) v_u_13, (ref) v_u_20
	local v29 = v_u_16:GetPlayerDataAsync()
	if v29 then
		local v30 = v29.EquippedBaseSkin
		local v31 = v29.BaseSkins
		for _, v32 in v_u_9:GetChildren() do
			if v32:IsA("GuiObject") then
				local v33 = v32.Name
				local v34 = v_u_13[v33]
				if v34 then
					local v35 = v33 == v30
					local v36 = v31[v33]
					local v37 = v34.GamePassId ~= nil
					local v38 = v34.ProductId ~= nil
					local v39 = v34.Price ~= nil
					local v40 = v34.Completion ~= nil
					local v41 = not v40 and true or v36
					local v42 = v32.Buttons.CashButton
					if v39 then
						v39 = not v36
					end
					v42.Visible = v39
					local v43 = v32.Buttons.RobuxButton
					if v37 or v38 then
						v38 = not v36
					end
					v43.Visible = v38
					v32.Buttons.EquipButton.Visible = v36
					v32.Checkmark.Visible = v35
					local v44 = v32.Lock
					local v45
					if v40 then
						v45 = not v36
					else
						v45 = v40
					end
					v44.Visible = v45
					v32.Buttons.Visible = v36 or not v40
					local v46 = v32.ProgressBar
					local v47
					if v40 then
						v47 = not v36
					else
						v47 = v40
					end
					v46.Visible = v47
					local v48 = v32.DisplayName
					local v49
					if v35 or not v41 then
						v49 = Color3.fromRGB(170, 170, 170)
					else
						v49 = Color3.fromRGB(255, 255, 255)
					end
					v48.TextColor3 = v49
					local v50 = v32.Icon
					local v51
					if v35 or not v41 then
						v51 = Color3.fromRGB(170, 170, 170)
					else
						v51 = Color3.fromRGB(255, 255, 255)
					end
					v50.ImageColor3 = v51
					local v52
					if v35 or not v41 then
						v52 = Color3.fromRGB(180, 90, 160)
					else
						v52 = Color3.fromRGB(255, 138, 216)
					end
					v32.BackgroundColor3 = v52
					v32.Buttons.EquipButton.Display.Text = v35 and "Equipped!" or "Equip!"
					if v40 and not v36 then
						local v53 = #(v29.Index[v34.Completion.Mutation] or {}) / v_u_20 / (v34.Completion.Percentage / 100)
						local v54 = math.clamp(v53, 0, 1)
						local v55 = v34.Completion.Mutation
						local v56 = v54 * 100
						local v57 = ("%* Index: %*%%"):format(v55, (math.round(v56)))
						v32.ProgressBar.Progress.Size = UDim2.fromScale(v54, 1)
						v32.ProgressBar.ProgressLabel.Text = v57
					end
				end
			end
		end
	end
end
function v_u_18.Init(_)
	-- upvalues: (copy) v_u_14, (ref) v_u_20, (copy) v_u_13, (copy) v_u_19, (copy) v_u_11, (copy) v_u_18, (copy) v_u_17, (copy) v_u_8, (copy) v_u_16, (copy) v_u_15
	for _ in v_u_14 do
		v_u_20 = v_u_20 + 1
	end
	for v58 in v_u_13 do
		local v59 = v_u_19
		table.insert(v59, v58)
	end
	table.sort(v_u_19, function(p60, p61)
		-- upvalues: (ref) v_u_13
		return v_u_13[p60].Index < v_u_13[p61].Index
	end)
	local v_u_62 = v_u_11.new():setLabel("Base Skins"):setRight(true):setOrder(0):bindEvent("deselected", function()
		-- upvalues: (ref) v_u_18, (ref) v_u_17, (ref) v_u_8
		v_u_18:Render()
		v_u_17:OpenFrame(v_u_8)
	end):oneClick()
	v_u_16:GetPathSignal(v_u_16.PathBuilder.EquippedBaseSkin):Connect(function()
		-- upvalues: (ref) v_u_18
		v_u_18:Render()
	end)
	v_u_16:GetPathSignal(v_u_16.PathBuilder.BaseSkins["*"]):Connect(function()
		-- upvalues: (ref) v_u_18
		v_u_18:Render()
	end)
	v_u_16:GetPathSignal(v_u_16.PathBuilder.Index["@"]):Connect(function()
		-- upvalues: (ref) v_u_17, (ref) v_u_8, (ref) v_u_18
		if v_u_17:IsFrameOpen(v_u_8) then
			v_u_18:Render()
		end
	end)
	v_u_18:LoadSkins()
	task.spawn(function()
		-- upvalues: (ref) v_u_15, (copy) v_u_62
		while true do
			local v63 = workspace:GetServerTimeNow()
			local v64
			if v_u_15.UpdateName == "FuseMachine" then
				if v_u_15.UpdateTime <= v63 then
					v64 = true
				else
					v64 = false
				end
			else
				v64 = true
			end
			v_u_62:setEnabled(v64)
			task.wait(1)
		end
	end)
end
return v_u_18
