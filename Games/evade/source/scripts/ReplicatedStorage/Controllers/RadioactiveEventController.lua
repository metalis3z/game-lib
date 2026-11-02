---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("TweenService")
local v5 = v_u_1:WaitForChild("Controllers")
local v_u_6 = require(v5.InterfaceController)
require(v5.ShopController)
local v_u_7 = require(v5.NotificationController)
require(v5.SoundController)
local v8 = v_u_1:WaitForChild("Packages")
local v_u_9 = require(v8.Observers)
local v_u_10 = require(v8.Synchronizer)
local v_u_11 = require(v8.Timer)
require(v8.Trove)
local v12 = require(v8.Net)
local v13 = v_u_1:WaitForChild("Utils")
local v_u_14 = require(v13.TimeUtils)
local v_u_15 = require(v13.NumberUtils)
local v16 = v_u_1:WaitForChild("Datas")
local v_u_17 = require(v16.RadioactiveSpinWheel)
local v_u_18 = require(v16.Shop)
local v19 = v_u_1:WaitForChild("Classes")
local v_u_20 = require(script.RadioactiveSpinWheel)
local v_u_21 = require(v19.AnimatedButton)
local v22 = v_u_1:WaitForChild("Shared")
local v_u_23 = require(v22.Marketplace)
local v_u_24 = v3.LocalPlayer
local v_u_25 = v_u_24.PlayerGui:WaitForChild("RadioactiveWheel").RadioactiveWheel
local v_u_26 = nil
local v_u_27 = false
local v_u_28 = v12:RemoteEvent("ShopService/Purchase")
local v_u_29 = v12:RemoteEvent("RadioactiveEventService/Spin")
v12:RemoteFunction("RadioactiveEventService/RequestBuy")
local v_u_30 = false
local v31 = {}
local function v_u_50(p32, p33)
	-- upvalues: (copy) v_u_10, (copy) v_u_24, (ref) v_u_30, (copy) v_u_25, (ref) v_u_27, (copy) v_u_2, (copy) v_u_4, (copy) v_u_17, (copy) v_u_18, (copy) v_u_15, (copy) v_u_7
	local v34 = v_u_10:Wait(v_u_24)
	if not v_u_30 then
		v_u_30 = true
		local v_u_35 = v_u_25.Wheel
		local v36 = v_u_35:FindFirstChild("Spinning")
		local v37 = v_u_27 and 1 or 0.8
		if v36 then
			v36.Looped = true
			v36.Volume = v37
			v36:Play()
		end
		local v38 = (p32 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60
		local v39 = v38 + (v_u_27 and 1 or 9) * 360
		local v40 = v_u_27 and 0.5 or 5
		local v_u_41 = nil
		local v43 = v_u_2.PostSimulation:Connect(function()
			-- upvalues: (copy) v_u_35, (ref) v_u_41, (ref) v_u_25, (ref) v_u_4
			debug.profilebegin("RadioactiveEventController:ResultAnimation")
			local v42 = (v_u_35.Rotation + 30) / 60 // 1
			if v_u_41 ~= v42 then
				v_u_41 = v42
				v_u_25.Tick.Rotation = -40
				v_u_4:Create(v_u_25.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					["Rotation"] = 0
				}):Play()
			end
			debug.profileend()
		end)
		local v44 = v_u_4:Create(v_u_35, TweenInfo.new(v40, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Rotation"] = v39
		})
		if v36 then
			v_u_4:Create(v36, TweenInfo.new(v40, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Volume"] = 0
			}):Play()
		end
		v44:Play()
		v44.Completed:Wait()
		v43:Disconnect()
		v_u_35.Rotation = v38
		if v36 then
			v36:Stop()
			v36.Volume = v37
		end
		local v45 = p33 == true and v_u_17.AltRewards[p32] or v_u_17.Rewards[p32]
		local v46
		if v45.Type == "Cash-Pack" then
			local v47 = v_u_18[v45.Index]
			if not v_u_18 then
				return false
			end
			local v48 = v47.Value or 0
			local v49 = v34:Get("Rebirth") or 0
			if v49 > 0 then
				v48 = v48 * (v49 <= 1 and 1.5 or v49)
			end
			v46 = ("$%*"):format((v_u_15:ToString(v48, 2)))
		else
			v46 = v45.Display
		end
		v_u_7:Success((("You received %*!"):format(v46)))
		v_u_30 = false
	end
end
function v31.SetupRadioactiveWheel(_)
	-- upvalues: (ref) v_u_26, (copy) v_u_6, (copy) v_u_25, (copy) v_u_10, (copy) v_u_24, (copy) v_u_17, (copy) v_u_18, (copy) v_u_15, (copy) v_u_23, (ref) v_u_30, (copy) v_u_21, (ref) v_u_27, (copy) v_u_28, (copy) v_u_29, (copy) v_u_1, (copy) v_u_14, (copy) v_u_50, (copy) v_u_11, (copy) v_u_9, (copy) v_u_20
	v_u_26 = v_u_6:Register("RadioactiveWheel", v_u_25, "TopQuint")
	v_u_26:AttachCloseButton(v_u_25.Close)
	v_u_26:Close()
	local v_u_51 = v_u_10:Wait(v_u_24)
	local function v_u_74()
		-- upvalues: (ref) v_u_25, (ref) v_u_17, (copy) v_u_51, (ref) v_u_18, (ref) v_u_15, (ref) v_u_23
		local v52 = v_u_25.Wheel
		local v53 = v52.Items
		local v54 = v52.Names
		local v55 = v52.Odds
		local v56 = {}
		for v57 = 1, #v_u_17.Rewards do
			local v58 = v_u_17.Rewards[v57]
			if v58 then
				if v58.Type == "Item" and v_u_51:Get((("Items.%*"):format(v58.Index))) then
					v58 = v_u_17.AltRewards[v57]
				end
				v56[v57] = v58.Weight
			end
		end
		local v59 = 0
		for _, v60 in v56 do
			v59 = v59 + v60
		end
		v56[5] = v56[5] + (100 - v59)
		for v61 = 1, #v_u_17.Rewards do
			local v62 = v_u_17.Rewards[v61]
			if v62 then
				if v62.Type == "Item" and v_u_51:Get((("Items.%*"):format(v62.Index))) then
					v62 = v_u_17.AltRewards[v61]
				end
				local v63 = v53:FindFirstChild(v61)
				local v64 = v54:FindFirstChild(v61)
				local v65 = v55:FindFirstChild(v61)
				local v66 = ""
				local v67
				if v62.Type == "Cash-Pack" then
					local v68 = v_u_18[v62.Index].Value
					local v69 = v_u_51:Get("Rebirth") or 0
					if v69 > 0 then
						v68 = v68 * (v69 <= 1 and 1.5 or v69)
					end
					v66 = ("$%*"):format((v_u_15:ToString(v68, 2)))
					v67 = v_u_23:GetProductInfo(v62.Index, "Product").Icon
				else
					v67 = v62.Icon
				end
				local v70 = v62.Display
				local v71 = v66 == "" and v70 and v70 or v66
				local v72 = v56[v61] * 100
				local v73 = ("%*%%"):format(math.floor(v72) / 100)
				v63.Image = v67
				v64.Text = v71
				v65.Text = v73
			end
		end
	end
	v_u_74()
	v_u_51:OnDictionaryInserted("Items", function(_, p75)
		-- upvalues: (ref) v_u_17, (ref) v_u_30, (copy) v_u_74
		local v76 = false
		for v77 = 1, #v_u_17.Rewards do
			local v78 = v_u_17.Rewards[v77]
			if v78.Type == "Item" and p75 == v78.Index then
				v76 = true
				break
			end
		end
		if v76 then
			while v_u_30 do
				task.wait()
			end
			v_u_74()
		end
	end)
	local v_u_79 = v_u_25.FastSpin.Toggle
	local v80 = v_u_21.new(v_u_79)
	v80:Animate()
	v80.OnActivated:Connect(function()
		-- upvalues: (ref) v_u_27, (copy) v_u_79
		v_u_27 = not v_u_27
		v_u_79.Checkmark.Visible = v_u_27
	end)
	v_u_79.Checkmark.Visible = v_u_27
	for _, v_u_81 in v_u_25.Buttons:GetChildren() do
		if v_u_81:IsA("ImageButton") and v_u_81.Name ~= "Spin" then
			local v82 = v_u_21.new(v_u_81)
			v82:Animate()
			v82.OnActivated:Connect(function()
				-- upvalues: (ref) v_u_28, (copy) v_u_81
				v_u_28:FireServer(v_u_81:GetAttribute("ProductId"))
			end)
			local v83 = v_u_23:GetProductInfo(v_u_81:GetAttribute("ProductId"), "Product")
			v_u_81.RbxAmount.Text = v83.PriceInRobux
		end
	end
	local v_u_84 = v_u_25.Buttons.Spin
	local v85 = v_u_21.new(v_u_84)
	v85:Animate()
	v85.OnActivated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_29
		if v_u_30 ~= true then
			v_u_29:FireServer()
		end
	end)
	local function v_u_90()
		-- upvalues: (ref) v_u_1, (copy) v_u_51, (copy) v_u_84, (ref) v_u_14, (ref) v_u_25
		local v86 = 0
		if v_u_1:GetAttribute("RadioactiveEvent") then
			if v_u_51:Get("RadioactiveSpinWheel.LastFreeClaimed") == v_u_1:GetAttribute("RadioactiveEventLastTime") then
				v_u_84.Main.Timer.Text = ("Free Spin in %*"):format((v_u_14:D((v_u_1:GetAttribute("NextRadioactiveEvent") or 0) - workspace:GetServerTimeNow())))
			else
				v86 = v86 + 1
				v_u_84.Main.Timer.Text = "SPIN NOW"
			end
		else
			v_u_84.Main.Timer.Text = ("Free Spin in %*"):format((v_u_14:D((v_u_1:GetAttribute("NextRadioactiveEvent") or 0) - workspace:GetServerTimeNow())))
		end
		local v87 = v86 + v_u_51:Get("RadioactiveSpinWheel.Spins")
		v_u_84.Main.Spins.Text = v87 > 1 and ("Spins (%*)"):format(v87) or ("Spin (%*)"):format(v87)
		v_u_84.Main.UIGradient.Enabled = v87 <= 0
		local v88 = workspace:GetServerTimeNow() - v_u_51:Get("RadioactiveSpinWheel.LastDailyDiscount") >= 86400
		v_u_25.Buttons.Buy1.Visible = not v88
		v_u_25.Buttons.Buy1Discount.Visible = v88
		local v89 = v_u_51:Get("RadioactiveSpinWheel.PaidSpins.x3") >= 5
		v_u_25.Buttons.Buy10.Visible = v89
		v_u_25.Buttons.Buy3.Visible = not v89
	end
	v_u_29.OnClientEvent:Connect(function(p91, p92)
		-- upvalues: (copy) v_u_90, (ref) v_u_50
		task.spawn(v_u_90)
		v_u_50(p91, p92)
	end)
	v_u_11.Simple(1, v_u_90)
	v_u_9.observeTag("RadioactiveSpinWheel", function(p93)
		-- upvalues: (ref) v_u_20
		local v_u_94 = v_u_20.new(p93)
		return function()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	end)
end
function v31.Start(p95)
	p95:SetupRadioactiveWheel()
end
return v31
