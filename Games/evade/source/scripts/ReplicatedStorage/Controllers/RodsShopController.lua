---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("TweenService")
local v3 = v1:WaitForChild("Packages")
local v4 = v1:WaitForChild("Controllers")
local v5 = v1:WaitForChild("Classes")
local v6 = v1:WaitForChild("Utils")
local v7 = v1:WaitForChild("Datas")
local v8 = v1:WaitForChild("Shared")
local v9 = require(v3.Net)
local v10 = require(v3.Trove)
local v_u_11 = require(v4.InterfaceController)
require(v4.CameraController)
local v_u_12 = require(v5.AnimatedButton)
local v_u_13 = require(v3.Synchronizer)
local v_u_14 = require(v6.NumberUtils)
local v_u_15 = require(v7.RodsShopItems)
local v_u_16 = require(v4.NotificationController)
local v_u_17 = require(v4.SoundController)
local v_u_18 = require(v8.Updates)
local v_u_19 = v9:RemoteFunction("RodsShopService/RequestBuy")
local v_u_20 = v9:RemoteFunction("RodsShopService/RequestEquip")
local v_u_21 = v9:RemoteEvent("RodsShopService/UpdateOwnedRods")
local v_u_22 = v9:RemoteEvent("RodsShopService/UpdateEquippedRod")
local v_u_23 = v2.LocalPlayer
local v24 = v_u_23.PlayerGui
local v_u_25 = {
	["Starter Rod"] = true
}
local v_u_26 = "Starter Rod"
local v_u_27 = v24:WaitForChild("RodsShop"):WaitForChild("RodsShop")
local v_u_28 = v_u_27.Content.Items
local v_u_29 = v_u_28.UIListLayout.Template
local v_u_30 = v_u_27.Header.Close
local v_u_31 = nil
local v_u_32 = v10.new()
local v33 = {}
local function v_u_52()
	-- upvalues: (copy) v_u_32, (copy) v_u_13, (copy) v_u_23, (copy) v_u_15, (copy) v_u_29, (ref) v_u_26, (copy) v_u_25, (copy) v_u_14, (copy) v_u_12, (copy) v_u_20, (copy) v_u_19, (copy) v_u_16, (copy) v_u_17, (copy) v_u_28
	v_u_32:Destroy()
	local v_u_34 = v_u_13:Get(v_u_23)
	if v_u_34 then
		for v_u_35, v_u_36 in pairs(v_u_15) do
			if v_u_36.Currency == "Coins" then
				local v37 = v_u_32:Clone(v_u_29)
				local v38 = v37.ItemInformation
				local v39 = v38.ItemName
				local v40 = v38.ItemDescription
				local v41 = v37.ItemImage
				local v_u_42 = v37.Buy
				local v_u_43 = v_u_42.Price
				local v_u_44 = v37.Locked
				local v_u_45 = v_u_44.Txt
				v37.Name = v_u_35
				v39.Text = v_u_35
				v40.Text = v_u_36.Description
				v41.Image = v_u_36.Icon
				v37.Luck.Text = ("[%*x Cast Luck]"):format(v_u_36.Luck)
				v37.LayoutOrder = v_u_36.LayoutOrder or 0
				v_u_32:Add(v_u_34:OnChanged("Rebirth", function()
					-- upvalues: (copy) v_u_44, (copy) v_u_45, (copy) v_u_42, (copy) v_u_36, (copy) v_u_34
					v_u_44.Visible = true
					v_u_45.Visible = true
					v_u_42.Visible = true
					if v_u_36.RebirthRequired then
						if (v_u_34:Get("Rebirth") or 0) >= v_u_36.RebirthRequired then
							v_u_44.Visible = false
						else
							v_u_45.Text = "YOU NEED " .. v_u_36.RebirthRequired .. " REBIRTHS"
							v_u_42.Visible = false
						end
					else
						v_u_44.Visible = false
						v_u_45.Visible = false
						return
					end
				end))
				v_u_44.Visible = true
				v_u_45.Visible = true
				v_u_42.Visible = true
				if v_u_36.RebirthRequired then
					if (v_u_34:Get("Rebirth") or 0) >= v_u_36.RebirthRequired then
						v_u_44.Visible = false
					else
						v_u_45.Text = "YOU NEED " .. v_u_36.RebirthRequired .. " REBIRTHS"
						v_u_42.Visible = false
					end
				else
					v_u_44.Visible = false
					v_u_45.Visible = false
				end
				local v_u_46 = v_u_32:Extend()
				local function v51()
					-- upvalues: (copy) v_u_46, (copy) v_u_34, (copy) v_u_36, (copy) v_u_43, (ref) v_u_26, (copy) v_u_35, (ref) v_u_25, (ref) v_u_14, (copy) v_u_42, (ref) v_u_12, (ref) v_u_20, (ref) v_u_19, (ref) v_u_16, (ref) v_u_17
					v_u_46:Clean()
					local _ = (v_u_34:Get("Coins") or 0) >= v_u_36.Price
					v_u_43.Text = v_u_26 == v_u_35 and "OWNED" or (v_u_25[v_u_35] and "EQUIP" or "$ " .. v_u_14:ToString(v_u_36.Price, 2))
					if v_u_26 == v_u_35 then
						v_u_42.ImageColor3 = Color3.fromRGB(138, 138, 138)
					else
						v_u_42.ImageColor3 = Color3.fromRGB(255, 255, 255)
						local v47 = v_u_46:Add(v_u_12.new(v_u_42))
						v47:Animate()
						v_u_46:Add(v47.OnActivated:Connect(function()
							-- upvalues: (ref) v_u_25, (ref) v_u_35, (ref) v_u_20, (ref) v_u_19, (ref) v_u_16, (ref) v_u_17
							local v48
							if v_u_25[v_u_35] then
								v48 = v_u_20
							else
								v48 = v_u_19
							end
							local v49, v50 = v48:InvokeServer(v_u_35)
							if v49 then
								v_u_16:Success(v50)
								v_u_17:PlaySound("Sounds.Sfx.Success")
							else
								v_u_16:Error(v50)
								v_u_17:PlaySound("Sounds.Sfx.Error")
							end
						end))
					end
				end
				v_u_32:Add(v_u_34:OnChanged("Coins", v51))
				v51()
				v37.Visible = not v_u_36.IsEnabled and true or v_u_36.IsEnabled()
				v37.Parent = v_u_28
			end
		end
	end
end
function v33.Start(_)
	-- upvalues: (ref) v_u_31, (copy) v_u_11, (copy) v_u_27, (copy) v_u_30, (copy) v_u_13, (copy) v_u_23, (copy) v_u_18, (copy) v_u_52, (copy) v_u_21, (copy) v_u_25, (copy) v_u_22, (ref) v_u_26
	v_u_31 = v_u_11:Register("RodsShop", v_u_27, "TopQuint")
	v_u_31:AttachCloseButton(v_u_30)
	v_u_31:Close()
	v_u_13:WaitAndCall(v_u_23, function(_)
		-- upvalues: (ref) v_u_18, (ref) v_u_52
		v_u_18.OnUpdateEnabled:Connect(function()
			-- upvalues: (ref) v_u_52
			v_u_52()
		end)
		v_u_18.OnUpdateDisabled:Connect(function()
			-- upvalues: (ref) v_u_52
			v_u_52()
		end)
		v_u_52()
	end)
	v_u_21.OnClientEvent:Connect(function(p53)
		-- upvalues: (ref) v_u_25, (ref) v_u_52
		table.clear(v_u_25)
		for v54, v55 in p53 do
			v_u_25[v54] = v55
		end
		v_u_52()
	end)
	v_u_22.OnClientEvent:Connect(function(p56)
		-- upvalues: (ref) v_u_26, (ref) v_u_52
		v_u_26 = p56
		v_u_52()
	end)
	v_u_21:FireServer()
end
return v33
