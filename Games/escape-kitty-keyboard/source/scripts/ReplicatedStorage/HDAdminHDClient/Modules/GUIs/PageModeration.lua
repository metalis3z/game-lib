

local u1 = {}
local u2 = _G.HDAdminMain
local u3 = u2.gui.MainFrame.Pages.Moderation
local u4 = u2.warnings.BuyFrame
local _ = u2.warnings.UnBan
local u5 = {
	["ranks"] = u3.Ranks,
	["serverRanks"] = u3["Server Ranks"],
	["banland"] = u3.Banland
}
local u6 = {
	["rankTitle"] = u5.ranks.TemplateRankTitle,
	["rankItem"] = u5.ranks.TemplateRankItem,
	["space"] = u5.ranks.TemplateSpace,
	["admin"] = u5.serverRanks.TemplateAdmin,
	["ban"] = u5.banland.TemplateBan,
	["banTitle"] = u5.banland.TemplateTitle
}
local u7 = {
	{ "friends", u2.ownerName .. "\'s Friends", "For friends of the Owner" },
	{ "freeadmin", "Free Admin", "For everyone" },
	{ "vipserverowner", "VIP Server Owner", "For VIP Server owners" },
	{ "vipserverplayer", "VIP Server Player", "For VIP Server players" }
}
function u1.SetupRanks(_) 

	u1:CreateRanks()
end
function u1.CreateRanks(_) 

	coroutine.wrap(function()

		local v8 = u2.signals.RetrieveRanksInfo:InvokeServer()
		local v9 = v8.PermRanks
		local v10 = v8.Ranks
		local v11 = v8.Permissions
		local v12 = {}
		local v13 = {}
		for _, v14 in pairs(v10) do
			local v15 = {
				v14[1],
				v14[2],
				{}
			}
			table.insert(v12, 1, v15)
		end
		for v16, v17 in pairs(v12) do
			v13[v17[1]] = v16
		end
		for v18, v19 in pairs(v11) do
			if v18 == "owner" and v13[5] then
				local v20 = v12[v13[5]][3]
				local v21 = { u2.ownerName, "Owner", u2:GetModule("cf"):GetUserImage(u2.ownerId) }
				table.insert(v20, v21)
			elseif v18 == "specificusers" then
				for v22, v23 in pairs(v19) do
					if #v22 > 1 then
						local v24 = v12[v13[v23]]
						local v25 = { v22, "Specific User", u2:GetModule("cf"):GetUserImage(u2:GetModule("cf"):GetUserId(v22)) }
						local v26 = v24[3]
						table.insert(v26, v25)
					end
				end
				for _, v27 in pairs(v9) do
					if not v27.RemoveRank then
						local v28 = v12[v13[v27.Rank]]
						if v28 then
							local v29 = {
								u2:GetModule("cf"):GetName(v27.UserId),
								"PermRank",
								u2:GetModule("cf"):GetUserImage(v27.UserId),
								v27
							}
							local v30 = v28[3]
							table.insert(v30, v29)
						end
					end
				end
			elseif v18 == "assets" then
				for v31, v32 in pairs(v19) do
					local v33 = v12[v13[v32.Rank]]
					if v33 then
						local v34 = {
							v32.Name,
							"Asset",
							u2:GetModule("cf"):GetAssetImage(v31),
							tonumber(v31),
							v32.PriceInRobux
						}
						local v35 = v33[3]
						table.insert(v35, v34)
					end
				end
			elseif v18 == "groups" then
				for v36, v37 in pairs(v19) do
					for v38, v39 in pairs(v37.Roles) do
						if v39.Rank then
							local v40 = v12[v13[v39.Rank]]
							if v40 then
								local v41 = {
									v37.Name .. " | " .. v38,
									"Group",
									v37.EmblemUrl,
									(tonumber(v36))
								}
								local v42 = v40[3]
								table.insert(v42, v41)
							end
						end
					end
				end
			elseif u7[v18] then
				local v43 = u7[v18]
				local v44 = v11[v43[1]]
				if v44 > 0 then
					local v45 = v12[v13[v44]]
					if v45 then
						local v46 = {}
						local v47 = v43[2]
						local v48 = v43[3]
						local v49 = string.upper
						local v50 = v43[1]
						v46 = {
	v47,
	v48,
	v49((string.sub(v50,
	1,
	1)))
}
						local v51 = v45[3]
						table.insert(v51, v46)
					end
				end
			end
		end
		local v52 = u2.pdata.Rank >= (u2.commandRanks.permrank or 4)
		u2:GetModule("cf"):ClearPage(u5.ranks)
		local v53 = 0
		for _, v54 in pairs(v12) do
			local v55 = v54[1]
			local u56 = v54[2]
			local v57 = v54[3]
			v53 = v53 + 1
			local v58 = u6.rankTitle:Clone()
			v58.Name = "Label" .. v53
			v58.RankIdFrame.TextLabel.Text = v55
			v58.RankName.Text = u56
			v58.Visible = true
			v58.Parent = u5.ranks
			for _, v59 in pairs(v57) do
				v53 = v53 + 1
				local u60 = v59[1]
				local u61 = v59[2]
				local u62 = v59[3]
				local v63 = u6.rankItem:Clone()
				v63.Name = "Label" .. v53
				v63.ItemTitle.Text = u60
				v63.ItemDesc.Text = u61
				if #tostring(u62) == 1 then
					v63.ItemIcon.Text = u62
					v63.ItemIcon.Visible = true
					v63.ItemImage.Visible = false
				else
					if tonumber(u62) then
						u62 = "rbxassetid://" .. u62
					end
					v63.ItemImage.Image = tostring(u62)
				end
				v63.Unlock.Visible = false
				v63.ViewMore.Visible = false
				local v64
				if u61 == "Gamepass" or u61 == "Asset" then
					local u65 = v59[4]
					local u66 = v59[5]
					v63.ItemImage.BackgroundTransparency = 1
					v63.Unlock.Visible = true
					v63.Unlock.MouseButton1Down:Connect(function()

						u4.ProductName.Text = u60
						u4.ProductImage.Image = u62
						u4.PurchaseToUnlock.TextLabel.Text = u56
						u4.InGame.TextLabel.Text = u2.gameName
						u4.MainButton.Price.Text = (u66 or 0) .. " "
						u4.MainButton.ProductId.Value = u65
						u4.MainButton.ProductType.Value = u61
						u2:GetModule("cf"):ShowWarning("BuyFrame")
					end)
					v64 = 0.4
				elseif u61 == "PermRank" then
					local u67 = v59[4]
					if v52 then
						local v68 = v63.ViewMore
						v68.Visible = true
						v68.MouseButton1Down:Connect(function()

							u2:GetModule("cf"):ShowPermRankedUser({ u60, u67.UserId, u67.RankedBy })
						end)
						v64 = 0.6
					else
						v64 = 0.6
					end
				else
					v64 = 0.7
				end
				v63.ItemTitle.Size = UDim2.new(v64, 0, v63.ItemTitle.Size.Y.Scale, 0)
				v63.ItemDesc.Size = UDim2.new(v64, 0, v63.ItemDesc.Size.Y.Scale, 0)
				v63.Visible = true
				v63.Parent = u5.ranks
			end
		end
		if v53 >= 2 then
			for _ = 1, 2 do
				local v69 = u5.ranks.Label1
				local v70 = u5.ranks["Label" .. v53]
				u5.ranks.CanvasSize = UDim2.new(0, 0, 0, v70.AbsolutePosition.Y + v70.AbsoluteSize.Y - v69.AbsolutePosition.Y)
			end
		end
	end)()
end
function u1.CreateServerRanks(_) 

	coroutine.wrap(function()

		local v71 = u2.signals.RetrieveServerRanks:InvokeServer()
		local v72 = {}
		local v73 = {}
		for _, v74 in pairs(u2.settings.Ranks) do
			local v75 = {
				v74[1],
				v74[2],
				{}
			}
			table.insert(v72, 1, v75)
		end
		for v76, v77 in pairs(v72) do
			v73[v77[1]] = v76
		end
		for _, v78 in pairs(v71) do
			local v79 = v78.Player
			local v80 = v78.RankId
			local v81 = v78.RankType
			local v82 = v72[v73[v80]]
			if v82 then
				local v83 = v82[3]
				table.insert(v83, { v79, v81 })
			end
		end
		for _, v84 in pairs(v72) do
			local v85 = v84[3]
			table.sort(v85, function(p86, p87)
				return p86[2] < p87[2]
			end)
		end
		u2:GetModule("cf"):ClearPage(u5.serverRanks)
		local v88 = {}
		for v89, v90 in pairs(u2.rankTypes) do
			v88[v90] = v89
		end
		local v91 = 0
		for _, v92 in pairs(v72) do
			local _ = v92[1]
			local v93 = v92[2]
			local v94 = v92[3]
			for _, v95 in pairs(v94) do
				v91 = v91 + 1
				local v96 = v95[1]
				local v97 = v88[v95[2]]
				local v98 = u6.admin:Clone()
				v98.Name = "Label" .. v91
				v98.PlrName.Text = v96.Name
				v98.PlrRank.Text = v93 .. " (" .. v97 .. ")"
				v98.PlayerImage.Image = u2:GetModule("cf"):GetUserImage(v96.UserId)
				v98.BackgroundColor3 = u2:GetModule("cf"):GetLabelBackgroundColor(v91)
				v98.Visible = true
				v98.Parent = u5.serverRanks
			end
		end
		u5.serverRanks.CanvasSize = UDim2.new(0, 0, 0, v91 * u6.admin.AbsoluteSize.Y)
	end)()
end
local u99 = true
function u1.CreateBanland(_) 

	coroutine.wrap(function()

		if u99 then
			u99 = false
			local v100 = 0
			if u2.pdata.Rank < u2.settings.ViewBanland then
				u2:GetModule("cf"):ClearPage(u5.banland)
				local v101 = u6.banTitle:Clone()
				v101.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
				v101.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				v101.TextLabel.Text = "Must be rank \'" .. u2:GetModule("cf"):GetRankName(u2.settings.ViewBanland) .. "\' or higher to view the Banland"
				v101.Name = "TitleLabel"
				v101.Visible = true
				v101.Parent = u5.banland
			else
				local v102 = u2.signals.RetrieveBanland:InvokeServer()
				local v103 = u2.pdata.Rank >= (u2.commandRanks.directban or 4)
				u2:GetModule("cf"):ClearPage(u5.banland)
				local v104 = { "Current Server", "All Servers" }
				for v105, v106 in pairs(v102) do
					if #v106 > 0 then
						local v107 = u6.banTitle:Clone()
						v107.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
						v107.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						v107.TextLabel.Text = v104[v105]
						v107.Name = "TitleLabel"
						v100 = v100 + u6.banTitle.AbsoluteSize.Y
						v107.Visible = true
						v107.Parent = u5.banland
					end
					for v108, u109 in pairs(v106) do
						local u110 = u109.UserId
						if u110 > 0 then
							v100 = v100 + u6.ban.AbsoluteSize.Y
							local v111 = u109.SettingsBan
							local u112 = u6.ban:Clone()
							u112.Name = "BanLabel"
							u112.PlrName.Text = u2:GetModule("cf"):GetName(u110)
							local v113 = u109.BanTime
							local v114
							if tonumber(v113) then
								v114 = u2:GetModule("cf"):GetBanDateString(os.date("*t", v113))
							else
								v114 = v111 and "Auto Settings Ban" or "Infinite"
							end
							u112.BanLength.Text = v114
							u112.PlayerImage.Image = u2:GetModule("cf"):GetUserImage(u110)
							u112.BackgroundColor3 = u2:GetModule("cf"):GetLabelBackgroundColor(v108)
							local v115 = u112.ViewMore
							if v103 and not v111 then
								v115.Visible = true
								v115.MouseButton1Down:Connect(function()

									u2:GetModule("cf"):ShowBannedUser({
										u112.PlrName.Text,
										u110,
										u109.Reason,
										u109.BannedBy
									})
								end)
							else
								v115.Visible = false
							end
							u112.Visible = true
							u112.Parent = u5.banland
						end
					end
				end
			end
			u5.banland.CanvasSize = UDim2.new(0, 0, 0, v100)
			u99 = true
		end
	end)()
end
function u1.UpdatePages(_) 

	u1:CreateServerRanks()
	u1:CreateBanland()
	u1:CreateRanks()
end
spawn(function()

	while wait(20) do
		if u3.Visible and u2.gui.MainFrame.Visible then
			u1:UpdatePages()
		end
	end
end)
return u1