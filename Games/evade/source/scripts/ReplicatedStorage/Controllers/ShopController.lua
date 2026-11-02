local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
game:GetService("MarketplaceService")
local v4 = v1:WaitForChild("Controllers")
local v_u_5 = require(v4.InterfaceController)
local v6 = v1:WaitForChild("Packages")
local v_u_7 = require(v1.Packages.Gradients)
local v_u_8 = require(v6.Synchronizer)
local v_u_9 = require(v6.Observers)
local v_u_10 = require(v6.FFlags)
local v11 = require(v6.Signal)
local v_u_12 = require(v6.Timer)
local v_u_13 = require(v6.Trove)
local v14 = require(v6.Net)
local v_u_15 = require(v1.Shared.Mutations)
local v16 = v1:WaitForChild("Classes")
local v_u_17 = require(v16.AnimatedButton)
local v18 = v1:WaitForChild("Utils")
local v_u_19 = require(v18.NumberUtils)
local v_u_20 = require(v18.TimeUtils)
local v21 = v1:WaitForChild("Shared")
local v_u_22 = require(v21.Animals)
local v_u_23 = require(v21.Marketplace)
local v_u_24 = require(v21.Updates)
local v_u_25 = require(v21.Policy)
local v26 = v1:WaitForChild("Datas")
local v_u_27 = require(v26.ServerLuck)
local v_u_28 = require(v26.LuckyBlocks)
local v_u_29 = require(v26.Mutations)
local v_u_30 = require(v26.Shop)
local v_u_31 = require(v1.UserGenerated.ABTests)
local v_u_32 = v_u_2.LocalPlayer
local v33 = v_u_32.PlayerGui
local v_u_34 = v33:WaitForChild("Shop").Shop
local v_u_35 = v33:WaitForChild("GiftPlayer").GiftPlayer
local v_u_36 = v_u_35:WaitForChild("Header"):WaitForChild("Close")
local v_u_37 = v_u_35:WaitForChild("Main"):WaitForChild("List")
local v_u_38 = v_u_37:WaitForChild("Template")
local v39 = v_u_34.GiftPlayerSelect
local v_u_40 = v39:WaitForChild("GiftButton")
local v_u_41 = v_u_40:WaitForChild("Txt")
local v_u_42 = v39:WaitForChild("PlayerSelected")
local v_u_43 = v_u_42:WaitForChild("PlayerImage"):WaitForChild("Headshot")
local v_u_44 = v_u_42:WaitForChild("PlayerName")
local v_u_45 = v14:RemoteEvent("ShopService/Purchase")
local v_u_46 = v_u_12.new(300)
local v_u_47 = nil
local v_u_48 = v11.new()
local v_u_49 = v11.new()
local v_u_50 = nil
local v_u_51 = {
	["GiftFrame"] = v_u_35,
	["ToggleGiftSignal"] = v_u_48
}
local function v_u_119()
	local v52 = v_u_34.Content.List.LuckyBlocksList
	local v_u_53 = v_u_34.Content.List.LuckyBlocks
	v52.Visible = false
	v_u_53.Visible = false
	local v54 = v_u_25.getPolicy(v_u_2.LocalPlayer)
	if v54 and not v54.ArePaidRandomItemsRestricted then
		v52.Visible = true
		v_u_53.Visible = true
		task.spawn(function()
			while true do
				local v55 = workspace:GetServerTimeNow()
				local v56 = v_u_10:GetInstant("LuckyBlockEndTimer", 1753545600) - v55
				v_u_53.Text = v56 <= 0 and "LUCKY BLOCKS" or ("LUCKY BLOCKS (<font color=\"#ffff00\">%*</font>)"):format((v_u_20:E(v56)))
				task.wait(1)
			end
		end)
		local function v_u_85(p_u_57, p_u_58)
			local v_u_59 = v_u_13.new()
			local v_u_60 = nil
			local function v_u_84(p61)
				p_u_57.Visible = p61
				if p61 == v_u_60 then
					return
				else
					v_u_60 = p61
					if p61 then
						local v62 = v_u_15.get()
						local v63 = {}
						for _, v64 in p_u_58.Animals do
							if (not v64.IsEnabled or v64.IsEnabled()) and v64.Chance then
								local v65 = {
									["animal"] = v64.Name,
									["chance"] = v64.Chance
								}
								table.insert(v63, v65)
							end
						end
						table.sort(v63, function(p66, p67)
							return p67.chance < p66.chance
						end)
						local v68 = p_u_57:GetAttribute("XScalar") or 1
						local v_u_69 = p_u_57.Template.Size.X.Scale * v68
						local v70 = 1 / v_u_69
						local v71 = math.ceil(v70) + 1
						local v72 = v71 / #v63
						local v73 = math.ceil(v72) * #v63
						local v_u_74 = table.create(v73)
						local v75 = 0
						for v76 = 1, v73 do
							local v77 = v63[1 + (v76 - 1) % #v63]
							local v78 = v_u_59:Clone(p_u_57.Template)
							v78.Name = tostring(v76)
							v78.LayoutOrder = v76
							v78.Chance.Text = ("%*%%"):format(v77.chance)
							v78.Visible = true
							v78.Position = UDim2.fromScale(v75, 0.5)
							v78.Parent = p_u_57
							v75 = v75 + v_u_69
							v_u_74[v76] = v78
							local v79 = v_u_22:AttachOnViewport(v77.animal, v78, true, v62)
							if v79 then
								v_u_59:Add(v79)
							end
						end
						if v71 <= #v_u_74 then
							local v_u_80 = 0.5
							if v68 > 1 then
								v_u_80 = v_u_80 * v68
							end
							v_u_59:Add(v_u_3.PreRender:Connect(function(p81)
								local v82 = v_u_69 * p81 * v_u_80
								for _, v83 in v_u_74 do
									v83.Position = v83.Position - UDim2.fromScale(v82, 0)
									if v83.Position.X.Scale <= -v_u_69 then
										v83.Position = v83.Position + UDim2.fromScale(v_u_69 * #v_u_74, 0)
									end
								end
							end))
						end
					else
						v_u_59:Clean()
					end
				end
			end
			v_u_24.OnUpdateEnabled:Connect(function()
				if p_u_57.Visible then
					v_u_84(false)
					v_u_84(true)
				end
			end)
			v_u_24.OnUpdateDisabled:Connect(function()
				if p_u_57.Visible then
					v_u_84(false)
					v_u_84(true)
				end
			end)
			v_u_50.OnClose:Connect(function()
				v_u_84(false)
			end)
			v_u_50.OnOpen:Connect(function()
				v_u_84(true)
			end)
			v_u_15.watch(function()
				if p_u_57.Visible then
					v_u_84(false)
					v_u_84(true)
				end
			end)
		end
		local function v_u_103(p_u_86, p87, p88)
			local v_u_89 = p87 or p_u_86.Name
			local v90 = v_u_28[v_u_89]
			if v90 then
				local v_u_91 = p88 or v90.ProductId
				if v_u_91 then
					for _, v92 in ipairs(p_u_86:GetChildren()) do
						if v92.Name == "Odds" then
							v_u_85(v92, v_u_28[v92:GetAttribute("LuckyBlock") or v_u_89])
						end
					end
					local v_u_93 = v_u_13.new()
					local function v_u_98()
						v_u_93:Destroy()
						if v_u_50:IsOpened() then
							local v94 = v_u_15.get()
							local v95
							if v94 then
								v95 = v_u_29[v94]
							else
								v95 = v94
							end
							if v95 then
								p_u_86.Mutation.Text = v95.DisplayWithRichText
								p_u_86.Mutation.Visible = true
							else
								p_u_86.Mutation.Visible = nil
							end
							for _, v96 in ipairs(p_u_86:GetChildren()) do
								if v96:IsA("ViewportFrame") and v96.Name == "IconViewport" then
									local v97 = v_u_22:AttachOnViewport(v96:GetAttribute("LuckyBlock") or v_u_89, v96, true, v94)
									if v97 then
										v_u_93:Add(v97)
									end
								end
							end
						end
					end
					task.spawn(v_u_98)
					v_u_50.OnClose:Connect(function()
						v_u_98()
					end)
					v_u_50.OnOpen:Connect(function()
						v_u_98()
					end)
					v_u_15.watch(function()
						task.spawn(v_u_98)
					end)
					local v99 = v_u_17.new(p_u_86.Buy)
					v99:Animate()
					v99.OnActivated:Connect(function()
						v_u_45:FireServer(v_u_91, v_u_47)
					end)
					task.spawn(function()
						local v100 = v_u_23:GetProductInfo(v_u_91, "Product")
						local v101 = p_u_86.Buy.Price
						local v102 = v100.PriceInRobux
						v101.Text = ("<font weight=\"100\">\238\128\130</font>%*"):format(v102 == 999999999 and "???" or v_u_19:Comma(v102))
					end)
				end
			else
				return
			end
		end
		for _, v104 in v52:GetChildren() do
			v_u_103(v104)
		end
		task.spawn(function()
			local festiveFrame = v_u_34.Content.List["Festive Lucky Block"]
			if not festiveFrame then return end
			for _, child in ipairs(festiveFrame:GetChildren()) do
				if child.Name == "Odds" then
					v_u_85(child, v_u_28["Premium Festive Lucky Block"])
				end
			end
			local trove = v_u_13.new()
			local function refresh()
				trove:Destroy()
				if not v_u_50:IsOpened() then return end

				local currentMutation = v_u_15.get()
				local mutationData = currentMutation and v_u_29[currentMutation]

				festiveFrame.Mutation.Visible = mutationData ~= nil
				if mutationData then
					festiveFrame.Mutation.Text = mutationData.DisplayWithRichText
				end

				for _, v in ipairs(festiveFrame:GetChildren()) do
					if v:IsA("ViewportFrame") and v.Name == "IconViewport" then
						local attach = v_u_22:AttachOnViewport(
							"Premium Festive Lucky Block",
							v,
							true,
							currentMutation
						)
						if attach then
							trove:Add(attach)
						end
					end
				end
			end

			task.spawn(refresh)
			v_u_50.OnOpen:Connect(refresh)
			v_u_50.OnClose:Connect(refresh)
			v_u_15.watch(function()
				task.spawn(refresh)
			end)

			local buy1 = v_u_17.new(festiveFrame.Buttons.Buy)
			buy1:Animate()
			buy1.OnActivated:Connect(function()
				v_u_45:FireServer(3478819642, v_u_47)
			end)

			local buy3 = v_u_17.new(festiveFrame.Buttons.Buy3)
			buy3:Animate()
			buy3.OnActivated:Connect(function()
				v_u_45:FireServer(3478819641, v_u_47)
			end)

			local buy10 = v_u_17.new(festiveFrame.Buttons.Buy10)
			buy10:Animate()
			buy10.OnActivated:Connect(function()
				v_u_45:FireServer(3478819648, v_u_47)
			end)
		end)
		task.spawn(function()
			local v_u_105 = v_u_34.Content.List.ItemsListPromo1
			v_u_103(v_u_105["Secret Lucky Block"])
			local function v106()
				v_u_105.Visible = v_u_31.GetAttribute(v_u_32, "Shop.FlyingCarpetPromo", false)
			end
			v_u_31.Loaded:Connect(v106)
			v_u_105.Visible = v_u_31.GetAttribute(v_u_32, "Shop.FlyingCarpetPromo", false)
		end)
		task.spawn(function()
			local v_u_107 = v_u_34.Content.List.ItemsListPromo2
			v_u_103(v_u_107["Secret Lucky Block"])
			local function v108()
				v_u_107.Visible = v_u_31.GetAttribute(v_u_32, "Shop.AdminPanelPromo", false)
			end
			v_u_31.Loaded:Connect(v108)
			v_u_107.Visible = v_u_31.GetAttribute(v_u_32, "Shop.AdminPanelPromo", false)
		end)
		task.spawn(function()
			local v_u_109 = v_u_34.Content.List.ItemsListPromo3
			v_u_103(v_u_109["Secret Lucky Block"])
			v_u_103(v_u_109["Secret Lucky Block x3"], "Secret Lucky Block", 3437062543)
			local function v110()
				v_u_109.Visible = v_u_31.GetAttribute(v_u_32, "Shop.SecretLuckyBlockX3Promo", false)
			end
			v_u_31.Loaded:Connect(v110)
			v_u_109.Visible = v_u_31.GetAttribute(v_u_32, "Shop.SecretLuckyBlockX3Promo", false)
		end)
		task.spawn(function()
			local v_u_111 = v_u_34.Content.List.ItemsListPromo4
			v_u_103(v_u_111["Secret Lucky Block x3"], "Secret Lucky Block", 3437062543)
			v_u_103(v_u_111["Secret Lucky Block x8"], "Secret Lucky Block", 3437979356)
			local function v112()
				v_u_111.Visible = v_u_31.GetAttribute(v_u_32, "Shop.SecretLuckyBlockX8Promo", false)
			end
			v_u_31.Loaded:Connect(v112)
			v_u_111.Visible = v_u_31.GetAttribute(v_u_32, "Shop.SecretLuckyBlockX8Promo", false)
		end)
		task.spawn(function()
			local v_u_113 = v_u_34.Content.List.ItemsListPromo5
			v_u_103(v_u_113["All Lucky Blocks"], "Secret Lucky Block", 3437989614)
			v_u_103(v_u_113["Secret Lucky Block"])
			local function v114()
				v_u_113.Visible = v_u_31.GetAttribute(v_u_32, "Shop.AllLuckyBlockPromo", false)
			end
			v_u_31.Loaded:Connect(v114)
			v_u_113.Visible = v_u_31.GetAttribute(v_u_32, "Shop.AllLuckyBlockPromo", false)
		end)
		task.spawn(function()
			local v_u_115 = v_u_34.Content.List.ItemsListPromo6
			v_u_103(v_u_115["Secret Lucky Block"])
			local function v116()
				v_u_115.Visible = v_u_31.GetAttribute(v_u_32, "Shop.LaserGunPromo", false)
			end
			v_u_31.Loaded:Connect(v116)
			v_u_115.Visible = v_u_31.GetAttribute(v_u_32, "Shop.LaserGunPromo", false)
		end)
		task.spawn(function()
			local v_u_117 = v_u_34.Content.List.ItemsListPromo7
			v_u_103(v_u_117["Secret Lucky Block"])
			local function v118()
				v_u_117.Visible = v_u_31.GetAttribute(v_u_32, "Shop.BlackholeSlapPromo", false)
			end
			v_u_31.Loaded:Connect(v118)
			v_u_117.Visible = v_u_31.GetAttribute(v_u_32, "Shop.BlackholeSlapPromo", false)
		end)
	end
end
local function v_u_126(p_u_120)
	if p_u_120 ~= v_u_32 then
		local v121 = v_u_38:Clone()
		v121.Name = p_u_120.Name
		v121.PlayerName.Text = p_u_120.Name
		local v122 = v121.PlayerImage.Headshot
		local v_u_123 = ""
		if pcall(function()
				v_u_123 = v_u_2:GetUserThumbnailAsync(p_u_120.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end) then
			v122.Image = v_u_123
		end
		local v124 = v121.Gift
		local v125 = v_u_17.new(v124)
		v125:Animate()
		v125.OnActivated:Connect(function()
			v_u_47 = p_u_120.UserId
			v_u_35.Visible = false
			v_u_41.Text = "Back"
			v_u_42.Visible = true
			v_u_44.Text = "@" .. p_u_120.Name
			v_u_43.Image = v_u_123
			v_u_48:Fire(true)
		end)
		v121.Visible = true
		v121.Parent = v_u_37
	end
end
function v_u_51.Start(_)
	v_u_50 = v_u_5:Register("Shop", v_u_34, "TopQuint")
	v_u_50:AttachCloseButton(v_u_34.Header.Close)
	v_u_50:Close()
	v_u_8:WaitAndCall(v_u_32, function(p_u_127)
		v_u_9.observeTag("CashProduct", function(p128)
			local v129 = p128.Name
			local v_u_130 = tonumber(v129)
			local v_u_131 = v_u_30[v_u_130]
			if v_u_131 then
				local v_u_132 = p128:WaitForChild("Buy", 5)
				local v_u_133 = p128:WaitForChild("Icon", 5)
				local v_u_134 = p128:WaitForChild("Amount", 5)
				if v_u_131.Icon then
					v_u_133.ScaleType = Enum.ScaleType.Fit
					v_u_133.Image = v_u_131.Icon
				end
				local function v137()
					if v_u_134 then
						local v135 = v_u_131.Value or 0
						local v136 = p_u_127:Get("Rebirth") or 0
						if v136 > 0 then
							v135 = v135 * (v136 <= 1 and 1.5 or v136)
						end
						v_u_134.Text = ("$%*"):format((v_u_19:Comma(v135)))
					end
				end
				local function v_u_142()
					local v138 = v_u_23:GetProductInfo(v_u_130, "Product")
					if v_u_132 then
						local v139 = v_u_132.Txt
						local v140
						if v138.PriceInRobux == nil then
							v140 = "Failed to load!"
						else
							local v141 = v138.PriceInRobux
							v140 = ("\238\128\130%*"):format(v141 == 999999999 and "???" or v_u_19:Comma(v141)) or "Failed to load!"
						end
						v139.Text = v140
					end
					if v_u_133 and v138.Icon then
						v_u_133.ScaleType = Enum.ScaleType.Fit
						if not v_u_131.Icon then
							v_u_133.Image = v138.Icon
						end
					end
				end
				v_u_142()
				p_u_127:OnChanged("Rebirth", v137, true)
				local v143 = v_u_17.new(v_u_132)
				v143:Animate()
				v143.OnActivated:Connect(function()
					v_u_45:FireServer(v_u_130, v_u_47)
				end)
				v_u_46.Tick:Connect(function()
					v_u_142()
				end)
			end
		end)
		v_u_9.observeTag("ItemProduct", function(p_u_144)
			local v145 = p_u_144.Name
			local v_u_146 = tonumber(v145)
			local v_u_147 = v_u_30[v_u_146]
			if v_u_147 then
				local v148 = p_u_144:WaitForChild("Buy", 5)
				local v_u_149
				if v148 then
					v_u_149 = v148:WaitForChild("Price", 5)
				else
					v_u_149 = v148
				end
				local v_u_150 = p_u_144:WaitForChild("Icon", 5)
				local v_u_151 = false
				local v_u_152 = false
				if v_u_147.Icon then
					v_u_150.ScaleType = Enum.ScaleType.Fit
					v_u_150.Image = v_u_147.Icon
				end
				local function v_u_156()
					local v153 = v_u_47 and v_u_2:GetPlayerByUserId(v_u_47) or v_u_32
					if v_u_146 == 3290152513 then
						local v154 = v153:GetAttribute("HasFlyingCarpet")
						if v154 then
							v154 = workspace:GetServerTimeNow() < v_u_10:GetInstant("HalloweenPackEndTime", 1762056000)
						end
						p_u_144.Visible = not v154
						local v155 = p_u_144.Parent:FindFirstChild("3442807551")
						if v155 then
							v155.Visible = v154
						end
					end
				end
				local function v_u_161()
					v_u_156()
					local v157 = v_u_23:GetProductInfo(v_u_146, "Product")
					if v_u_149 and (v_u_151 == false or v_u_152 == true) then
						local v158 = v_u_149
						local v159
						if v157.PriceInRobux == nil then
							v159 = "Failed to load!"
						else
							local v160 = v157.PriceInRobux
							v159 = ("\238\128\130%*"):format(v160 == 999999999 and "???" or v_u_19:Comma(v160)) or "Failed to load!"
						end
						v158.Text = v159
					end
					if v157.Icon and v_u_150 then
						v_u_150.ScaleType = Enum.ScaleType.Fit
						if not v_u_147.Icon then
							v_u_150.Image = v157.Icon
						end
					end
				end
				local v_u_162 = nil
				v_u_48:Connect(function(p163)
					if v_u_162 then
						v_u_162:Disconnect()
						v_u_162 = nil
					end
					local v164 = v_u_47
					if v164 then
						if p163 then
							v164 = v_u_2:GetPlayerByUserId(v_u_47)
						else
							v164 = p163
						end
					end
					if v164 and v_u_146 == 3290152513 then
						v_u_162 = v164:GetAttributeChangedSignal("HasFlyingCarpet"):Connect(v_u_156)
					end
					v_u_152 = p163
					if p163 or not v_u_151 then
						v_u_161()
					else
						v_u_156()
						v_u_151 = true
						v_u_149.Text = "Owned"
					end
					v_u_156()
				end)
				v_u_46.Tick:Connect(function()
					v_u_156()
					if v_u_151 == false then
						v_u_161()
					end
				end)
				p_u_127:OnDictionaryInserted("Items", function(_, p165)
					v_u_156()
					if p165 == v_u_147.Display and v_u_152 == false then
						v_u_156()
						v_u_151 = true
						v_u_149.Text = "Owned"
					end
				end)
				if p_u_127:Get((("Items.%*"):format(v_u_147.Display))) == true then
					v_u_156()
					local _ = true
					v_u_149.Text = "Owned"
				end
				v_u_161()
				v_u_156()
				local v166 = v_u_17.new(v148)
				v166:Animate()
				v166.OnActivated:Connect(function()
					v_u_45:FireServer(v_u_146, v_u_47)
				end)
			end
		end)
		v_u_9.observeTag("GamepassProduct", function(p_u_167)
			local v168 = p_u_167.Name
			local v_u_169 = tonumber(v168)
			local v_u_170 = v_u_30[v_u_169]
			if v_u_170 then
				local v171 = p_u_167:WaitForChild("Buy", 5)
				local v_u_172
				if v171 then
					v_u_172 = v171:WaitForChild("Price", 5)
				else
					v_u_172 = v171
				end
				p_u_167:WaitForChild("Icon", 5)
				local v_u_173 = false
				local v_u_174 = false
				local function v_u_179()
					local v175 = v_u_174 == true and v_u_23:GetProductInfo(p_u_167:GetAttribute("ProductId"), "Product") or v_u_23:GetProductInfo(v_u_169, "Gamepass")
					if v_u_172 and (v_u_173 == false or v_u_174) then
						local v176 = v_u_172
						local v177
						if v175.PriceInRobux == nil then
							v177 = "Failed to load!"
						else
							local v178 = v175.PriceInRobux
							v177 = ("\238\128\130%*"):format(v178 == 999999999 and "???" or v_u_19:Comma(v178)) or "Failed to load!"
						end
						v176.Text = v177
					end
				end
				v_u_48:Connect(function(p180)
					v_u_174 = p180
					if p180 or not v_u_173 then
						v_u_179()
					else
						v_u_173 = true
						v_u_172.Text = "Owned"
					end
				end)
				v_u_46.Tick:Connect(function()
					if v_u_173 == false then
						v_u_179()
					end
				end)
				p_u_127:OnDictionaryInserted("Gamepass", function(_, p181)
					if p181 == v_u_170.Display then
						v_u_173 = true
						v_u_172.Text = "Owned"
					end
				end)
				if p_u_127:Get((("Gamepass.%*"):format(v_u_170.Display))) == true then
					v_u_173 = true
					v_u_172.Text = "Owned"
				end
				v_u_179()
				local v182 = v_u_17.new(v171)
				v182:Animate()
				v182.OnActivated:Connect(function()
					if v_u_47 then
						v_u_45:FireServer(p_u_167:GetAttribute("ProductId"), v_u_47)
					else
						v_u_45:FireServer(v_u_169, v_u_47)
					end
				end)
			end
		end)
		v_u_9.observeTag("StarterPack", function(p_u_183)
			local v184 = v_u_13.new()
			local v_u_185 = v_u_30[3290334159]
			if not v_u_185 then
				return v184:WrapClean()
			end
			local v186 = p_u_183:WaitForChild("Buy", 5)
			local v_u_187
			if v186 then
				v_u_187 = v186:WaitForChild("Price", 5)
			else
				v_u_187 = v186
			end
			local v_u_188 = false
			local v_u_189 = false
			local v_u_190 = p_u_183.Parent
			if v_u_190 then
				v_u_190 = p_u_183.Parent:FindFirstChild("Title")
			end
			local function v_u_194()
				local v191 = v_u_30[3442292161]
				if v191 and (v191.Rewards and v191.Rewards.Items) and workspace:GetServerTimeNow() < v_u_10:GetInstant("HalloweenPackEndTime", 1762056000) then
					for _, v192 in v191.Rewards.Items do
						if not p_u_127:Get("Items." .. v192) and v_u_189 == false then
							p_u_183.Visible = false
							if v_u_190 then
								v_u_190.Visible = false
							end
							return
						end
					end
				end
				for _, v193 in v_u_185.Rewards.Items do
					if p_u_127:Get("Items." .. v193) == true and v_u_189 == false then
						p_u_183.Visible = false
						if v_u_190 then
							v_u_190.Visible = false
						end
						return
					end
				end
				p_u_183.Visible = true
				if v_u_190 then
					v_u_190.Visible = true
				end
			end
			v184:Add(v_u_49:Connect(v_u_194))
			v184:Add(v_u_48:Connect(function(p195)
				v_u_189 = p195
				if p195 or not v_u_188 then
					local v196 = v_u_23:GetProductInfo(3290334159, "Product")
					if v_u_187 and (v_u_188 == false or v_u_189 == true) then
						local v197 = v_u_187
						local v198
						if v196.PriceInRobux == nil then
							v198 = "Failed to load!"
						else
							local v199 = v196.PriceInRobux
							v198 = ("\238\128\130%*"):format(v199 == 999999999 and "???" or v_u_19:Comma(v199)) or "Failed to load!"
						end
						v197.Text = v198
					end
				else
					v_u_188 = true
					v_u_187.Text = "Owned"
				end
				v_u_194()
			end))
			v184:Add(v_u_46.Tick:Connect(function()
				if v_u_188 == false then
					local v200 = v_u_23:GetProductInfo(3290334159, "Product")
					if v_u_187 and (v_u_188 == false or v_u_189 == true) then
						local v201 = v_u_187
						local v202
						if v200.PriceInRobux == nil then
							v202 = "Failed to load!"
						else
							local v203 = v200.PriceInRobux
							v202 = ("\238\128\130%*"):format(v203 == 999999999 and "???" or v_u_19:Comma(v203)) or "Failed to load!"
						end
						v201.Text = v202
					end
				end
			end))
			v_u_194()
			v184:Add(p_u_127:OnDictionaryInserted("Items", v_u_194))
			local v204 = v_u_23:GetProductInfo(3290334159, "Product")
			if v_u_187 and (v_u_188 == false or v_u_189 == true) then
				local v205
				if v204.PriceInRobux == nil then
					v205 = "Failed to load!"
				else
					local v206 = v204.PriceInRobux
					v205 = ("\238\128\130%*"):format(v206 == 999999999 and "???" or v_u_19:Comma(v206)) or "Failed to load!"
				end
				v_u_187.Text = v205
			end
			local v207 = v_u_17.new(v186)
			v184:Add(v207)
			v207:Animate()
			v207.OnActivated:Connect(function()
				v_u_45:FireServer(3290334159, v_u_47)
			end)
			return v184:WrapClean()
		end)
		v_u_9.observeTag("HalloweenPack", function(p_u_208)
			local v209 = v_u_13.new()
			local v_u_210 = v_u_30[3442292161]
			if not v_u_210 then
				return v209:WrapClean()
			end
			local v_u_211 = p_u_208.Parent
			if v_u_211 then
				v_u_211 = p_u_208.Parent:FindFirstChild("HalloweenPackTitle")
			end
			local v212 = p_u_208:WaitForChild("Buy", 5)
			local v_u_213
			if v212 then
				v_u_213 = v212:WaitForChild("Price", 5)
			else
				v_u_213 = v212
			end
			local v_u_214 = false
			local v_u_215 = false
			local v_u_216 = false
			local function v_u_219()
				for _, v217 in v_u_210.Rewards.Items do
					if p_u_127:Get("Items." .. v217) == true and v_u_215 == false then
						p_u_208.Visible = false
						if v_u_211 then
							v_u_211.Visible = false
						end
						return
					end
				end
				local v218 = workspace:GetServerTimeNow() < v_u_10:GetInstant("HalloweenPackEndTime", 1762056000)
				p_u_208.Visible = v218
				if v_u_211 then
					v_u_211.Visible = v218
				end
			end
			v209:Add(v_u_48:Connect(function(p220)
				v_u_215 = p220
				if p220 or not v_u_214 then
					local v221 = v_u_23:GetProductInfo(3442292161, "Product")
					if v_u_213 and (v_u_214 == false or v_u_215 == true) then
						local v222 = v_u_213
						local v223
						if v221.PriceInRobux == nil then
							v223 = "Failed to load!"
						else
							local v224 = v221.PriceInRobux
							v223 = ("\238\128\130%*"):format(v224 == 999999999 and "???" or v_u_19:Comma(v224)) or "Failed to load!"
						end
						v222.Text = v223
					end
				else
					v_u_214 = true
					v_u_213.Text = "Owned"
				end
				v_u_219()
			end))
			v209:Add(v_u_46.Tick:Connect(function()
				if v_u_214 == false then
					local v225 = v_u_23:GetProductInfo(3442292161, "Product")
					if v_u_213 and (v_u_214 == false or v_u_215 == true) then
						local v226 = v_u_213
						local v227
						if v225.PriceInRobux == nil then
							v227 = "Failed to load!"
						else
							local v228 = v225.PriceInRobux
							v227 = ("\238\128\130%*"):format(v228 == 999999999 and "???" or v_u_19:Comma(v228)) or "Failed to load!"
						end
						v226.Text = v227
					end
				end
			end))
			v209:Add(v_u_10:OnUpdate(function()
				v_u_219()
				v_u_49:Fire()
			end))
			local v_u_229 = p_u_208:WaitForChild("Timer", 5)
			v209:Add(v_u_12.Simple(1, function()
				local v230 = v_u_10:GetInstant("HalloweenPackEndTime", 1762056000)
				local v231 = workspace:GetServerTimeNow()
				if v_u_229 then
					v_u_229.Text = ("%* left"):format((v_u_20:E(v230 - v231)))
				end
				if v230 <= v231 then
					if not v_u_216 then
						v_u_216 = true
						v_u_219()
						v_u_49:Fire()
						return
					end
				elseif v_u_216 then
					v_u_216 = false
					v_u_219()
					v_u_49:Fire()
				end
			end))
			v_u_219()
			v209:Add(p_u_127:OnDictionaryInserted("Items", v_u_219))
			local v232 = v_u_23:GetProductInfo(3442292161, "Product")
			if v_u_213 and (v_u_214 == false or v_u_215 == true) then
				local v233
				if v232.PriceInRobux == nil then
					v233 = "Failed to load!"
				else
					local v234 = v232.PriceInRobux
					v233 = ("\238\128\130%*"):format(v234 == 999999999 and "???" or v_u_19:Comma(v234)) or "Failed to load!"
				end
				v_u_213.Text = v233
			end
			local v235 = v_u_17.new(v212)
			v209:Add(v235)
			v235:Animate()
			v235.OnActivated:Connect(function()
				v_u_45:FireServer(3442292161, v_u_47)
			end)
			return v209:WrapClean()
		end)
		v_u_9.observeTag("RainbowText", function(p236)
			return v_u_7.apply(p236, "Rainbow")
		end)
		v_u_9.observeTag("ZebraText", function(p237)
			return v_u_7.apply(p237, "Zebra")
		end)
		v_u_46:Start();
		(function(p238)
			for _, v239 in p238 do
				task.defer(v_u_23.GetProductInfo, v_u_23, v239, "Product")
			end
		end)({ v_u_27[2].ProductId })
	end)
	local v240 = v_u_17.new(v_u_40)
	v240:Animate()
	v240.OnActivated:Connect(function()
		if v_u_47 then
			v_u_47 = nil
			v_u_42.Visible = false
			v_u_41.Text = "Gift Player"
			v_u_48:Fire(false)
		else
			v_u_35.Visible = not v_u_35.Visible
		end
	end)
	local v241 = v_u_17.new(v_u_36)
	v241:Animate()
	v241.OnActivated:Connect(function()
		v_u_35.Visible = false
		v_u_48:Fire(false)
	end)
	local v_u_242 = v_u_34.Content.List.ServerLuck
	v_u_8:WaitAndCall("ServerLuck", function(p_u_243)
		local v_u_244 = nil
		local v_u_245 = os.clock()
		local function v258()
			if os.clock() - v_u_245 >= 300 then
				v_u_245 = os.clock()
				v_u_244 = nil
			end
			local v246 = p_u_243:Get("EndTime")
			if v246 then
				local v247 = v246 - workspace:GetServerTimeNow()
				local v248 = math.floor(v247)
				local v249 = math.clamp(v248, 0, (1 / 0))
				if v249 <= 0 then
					v246 = nil
					v_u_244 = nil
				else
					v_u_242.Frame.Timer.Text = v_u_20:A(v249)
				end
			end
			v_u_242.Frame.Timer.Visible = v246 ~= nil
			local v250 = p_u_243:Get("Index") or 0
			local v251 = #v_u_27
			local v252 = v250 + 1
			local v253 = math.min(v252, v251)
			if v250 ~= v_u_244 then
				v_u_244 = v250
				local v254 = v251 <= v250 and "<font color=\"#FFFF00\">MAX</font>" or ("<font color=\"#FFFFFF\">%dx</font> &gt; <font color=\"#FFFF00\">%dx</font>"):format(v250 == 0 and 1 or v_u_27[v250].Multiplier, v_u_27[v253].Multiplier)
				local v255 = v_u_23:GetProductInfo(v_u_27[v253].ProductId, "Product")
				local v256 = v_u_242.Frame.Buy.Price
				local v257 = v255.PriceInRobux
				v256.Text = ("\238\128\130%*"):format(v257 == 999999999 and "???" or v_u_19:Comma(v257))
				v_u_242.Frame.LuckVector.Image = v255.Icon
				v_u_242.Frame.Pattern.Image = v255.Icon
				v_u_242.Frame.Amount.Text = v254
			end
		end
		p_u_243:OnChanged("Index", v258)
		p_u_243:OnChanged("EndTime", v258)
		v_u_12.Simple(1, v258)
		local v259 = v_u_17.new(v_u_242.Frame.Buy)
		v259:Animate()
		v259.OnActivated:Connect(function()
			local v260 = p_u_243:Get("Index") or 0
			local v261 = #v_u_27
			local v262 = v260 + 1
			v_u_45:FireServer(v_u_27[math.min(v262, v261)].ProductId)
		end)
	end)
	v_u_119()
	for _, v263 in v_u_2:GetPlayers() do
		v_u_126(v263)
	end
	v_u_2.PlayerAdded:Connect(function(p264)
		v_u_126(p264)
	end)
	v_u_2.PlayerRemoving:Connect(function(p265)
		local v266 = v_u_37:FindFirstChild(p265.Name)
		if v266 then
			v266:Destroy()
		end
	end)
	for _, v267 in v_u_34.Header.Main:GetChildren() do
		if v267:IsA("ImageButton") then
			local v_u_268 = v_u_34.Content.List:FindFirstChild(v267.Name)
			if v_u_268 then
				local v269 = v_u_17.new(v267)
				v269:Animate()
				v269.OnActivated:Connect(function()
					local v270 = v_u_34.Content.List
					local v271 = v_u_268.AbsolutePosition.Y - v270.AbsolutePosition.Y + v270.CanvasPosition.Y
					v270.CanvasPosition = Vector2.new(v270.CanvasPosition.X, v271)
				end)
			end
		end
	end
	task.spawn(function()
		local v_u_272 = v_u_30[3442292161]
		local function v_u_285()
			local v273 = v_u_50.Defaults.Size
			local v274 = v_u_31.GetAttribute(v_u_32, "Shop.OrderByPopularity", true)
			local v275 = {
				[v_u_34.Content.List.Title] = 81,
				[v_u_34.Content.List.StarterPack] = 82
			}
			local v276 = v_u_8:Get(v_u_32)
			if v276 and v_u_272 and v_u_272.Display and v276:Get((("Gamepass.%s"):format(v_u_272.Display))) == true then
				v275[v_u_34.Content.List.HalloweenPack] = 80
				v275[v_u_34.Content.List.HalloweenPackTitle] = 79
			end
			for v277, v279 in pairs(v275) do
				if not v274 then
					local v279 = nil
				end
				local v280 = v277:GetAttribute("OriginalOrder")
				if not v280 then
					v280 = v277.LayoutOrder
					v277:SetAttribute("OriginalOrder", v280)
				end
				v277.LayoutOrder = v279 or v280
			end
			local v281 = v_u_31.GetAttribute(v_u_32, "Shop.Scale", 1)
			local v282 = UDim2.new(v273.X.Scale * v281, v273.X.Offset, v273.Y.Scale * v281, v273.Y.Offset)
			if v282.X.Scale ~= v_u_50.Defaults.Size.X.Scale or v282.Y.Scale ~= v_u_50.Defaults.Size.Y.Scale then
				v_u_34.Size = v282
				v_u_50.Defaults.Size = v282
			end
			local v283 = v_u_31.GetAttribute(v_u_32, "Shop.HideLuckyBlocksTitle", false)
			v_u_34.Content.List.LuckyBlocks.Visible = not v283
			local v284 = v_u_31.GetAttribute(v_u_32, "Shop.PromoTitle", nil)
			if v284 then
				v_u_34.Content.List.PromoTitle.Text = v284
				v_u_34.Content.List.PromoTitle.Visible = true
			else
				v_u_34.Content.List.PromoTitle.Visible = false
			end
		end
		v_u_31.Loaded:Connect(v_u_285)
		v_u_285()
		v_u_8:WaitAndCall(v_u_32, function(p286)
			v_u_285()
			p286:OnDictionaryInserted("Gamepass", function(_, p287)
				if p287 == v_u_272.Display then
					v_u_285()
				end
			end)
		end)
	end)
	v_u_50.OnClose:Connect(function()
		v_u_51:RemoveGiftingTarget()
	end)
end
function v_u_51.OpenGiftingScreen(_)
	v_u_35.Visible = true
end
function v_u_51.CloseGiftingScreen(_)
	v_u_35.Visible = false
end
function v_u_51.RemoveGiftingTarget(_)
	if v_u_47 then
		v_u_47 = nil
		v_u_42.Visible = false
		v_u_41.Text = "Gift Player"
		v_u_48:Fire(false)
	end
end
function v_u_51.GetGiftingTarget(_)
	return v_u_47
end
return v_u_51