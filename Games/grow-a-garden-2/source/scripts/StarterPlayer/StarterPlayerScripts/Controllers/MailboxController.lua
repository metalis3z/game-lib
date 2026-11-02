--credit to leon games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local AnimatedGradient = require(ReplicatedStorage.SharedModules.AnimatedGradient)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)
local MailboxFlags = require(ReplicatedStorage.SharedModules.Flags.MailboxFlags)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local MailboxItemCatalog = require(script.MailboxItemCatalog)
local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = nil
local v4 = false
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v5 = nil
local v6 = nil
local v7 = nil
local t6 = {}
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = "Send"
local v30 = 0
local v31 = nil
local v32 = nil
local v33 = nil
local t7 = {}
local v34 = false
local v35 = 0
local t8 = {}
local v36 = false
local t9 = {}

local function trackSession(p1) --[[ trackSession | Line: 122 | Upvalues: t2 (copy) ]]
	table.insert(t2, p1)

	return p1
end

local function trackPersistent(p1) --[[ trackPersistent | Line: 127 | Upvalues: t3 (copy) ]]
	table.insert(t3, p1)

	return p1
end

local function clearSession() --[[ clearSession | Line: 132 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		pcall(function() --[[ Line: 134 | Upvalues: v2 (copy) ]]
			v2:Disconnect()
		end)
	end

	table.clear(t2)
end

local function setFlagTransparency(p1, p2) --[[ setFlagTransparency | Line: 143 ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Transparency = p2
		end
	end
end

local function applyMailboxVisuals(p1) --[[ applyMailboxVisuals | Line: 152 | Upvalues: v36 (ref), setFlagTransparency (copy) ]]
	local Notification = p1:FindFirstChild("Notification")
	local v1 = if Notification then Notification:FindFirstChildWhichIsA("BillboardGui") else Notification

	if v1 then
		v1.Enabled = v36
	end

	local FlagUp = p1:FindFirstChild("FlagUp")
	local FlagDown = p1:FindFirstChild("FlagDown")

	setFlagTransparency(FlagUp, if v36 then 0 else 1)
	setFlagTransparency(FlagDown, if v36 then 1 else 0)
end

local function applyAllMailboxVisuals() --[[ applyAllMailboxVisuals | Line: 165 | Upvalues: t9 (copy), applyMailboxVisuals (copy) ]]
	for v1 in t9 do
		if v1.Parent then
			applyMailboxVisuals(v1)

			continue
		end

		t9[v1] = nil
	end
end

local function trackMailbox(p1) --[[ trackMailbox | Line: 175 | Upvalues: t9 (copy), applyMailboxVisuals (copy), t3 (copy) ]]
	if not t9[p1] then
		t9[p1] = true
		applyMailboxVisuals(p1)

		local v1 = p1.DescendantAdded:Connect(function() --[[ Line: 180 | Upvalues: applyMailboxVisuals (ref), p1 (copy) ]]
			applyMailboxVisuals(p1)
		end)

		table.insert(t3, v1)

		local v3 = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 183 | Upvalues: t9 (ref), p1 (copy) ]]
			if p2 ~= nil then
				return
			end

			t9[p1] = nil
		end)

		table.insert(t3, v3)
	end
end

local function findLocalPlot() --[[ findLocalPlot | Line: 190 | Upvalues: LocalPlayer (copy) ]]
	local Gardens = workspace:FindFirstChild("Gardens")

	if not Gardens then
		return nil
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 ~= nil then
		local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

		if v2 then
			return v2
		end
	end

	for v3, v4 in Gardens:GetChildren() do
		if v4:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
			return v4
		end
	end

	return nil
end

local function discoverLocalMailboxes() --[[ discoverLocalMailboxes | Line: 206 | Upvalues: findLocalPlot (copy), trackMailbox (copy), t3 (copy) ]]
	local v1 = findLocalPlot()

	if not v1 then
		return
	end

	for v2, v3 in v1:GetDescendants() do
		if v3:IsA("Model") and v3.Name == "GreyMailBox" then
			trackMailbox(v3)
		end
	end

	local v4 = v1.DescendantAdded:Connect(function(p1) --[[ Line: 215 | Upvalues: trackMailbox (ref) ]]
		if not p1:IsA("Model") or p1.Name ~= "GreyMailBox" then
			return
		end

		trackMailbox(p1)
	end)

	table.insert(t3, v4)
end

local function applyHeaderNotificationVisuals() --[[ applyHeaderNotificationVisuals | Line: 222 | Upvalues: v21 (ref), v36 (ref) ]]
	if not v21 then
		return
	end

	v21.Visible = v36
end

local function setHasMail(p1) --[[ setHasMail | Line: 228 | Upvalues: v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref) ]]
	if v36 == p1 then
		return
	end

	v36 = p1

	for v1 in t9 do
		if v1.Parent then
			applyMailboxVisuals(v1)

			continue
		end

		t9[v1] = nil
	end

	if not v21 then
		return
	end

	v21.Visible = p1
end

local function recomputeHasMail() --[[ recomputeHasMail | Line: 235 | Upvalues: t4 (ref), t5 (ref), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref) ]]
	local v1 = false

	for v2 in t4 do
		v1 = true

		break
	end

	if not v1 then
		for v3 in t5 do
			v1 = true

			break
		end
	end

	if v36 == v1 then
		return
	end

	v36 = v1

	for v4 in t9 do
		if v4.Parent then
			applyMailboxVisuals(v4)

			continue
		end

		t9[v4] = nil
	end

	if not v21 then
		return
	end

	v21.Visible = v1
end

local function clearChildrenExcept(p1, p2) --[[ clearChildrenExcept | Line: 254 ]]
	for v1, v2 in p1:GetChildren() do
		if not (p2[v2] or (v2:IsA("UIGridLayout") or (v2:IsA("UIListLayout") or (v2:IsA("UIPadding") or (v2:IsA("UISizeConstraint") or v2:IsA("UIAspectRatioConstraint")))))) then
			v2:Destroy()
		end
	end
end

local function v37(p1, p2) --[[ setAllTextLabels | Line: 268 | Upvalues: v37 (copy) ]]
	if p1:IsA("TextLabel") or (p1:IsA("TextButton") or p1:IsA("TextBox")) then
		p1.Text = p2
	end

	for v1, v2 in p1:GetChildren() do
		if v2:IsA("TextLabel") or (v2:IsA("TextButton") or v2:IsA("TextBox")) then
			v2.Text = p2
		end

		v37(v2, p2)
	end
end

local function setLabelChain(p1, p2) --[[ setLabelChain | Line: 280 ]]
	if p1:IsA("TextLabel") or p1:IsA("TextButton") then
		p1.Text = p2
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("TextLabel") or v2:IsA("TextButton") then
			v2.Text = p2
		end
	end
end

local function updateInfoLabel() --[[ updateInfoLabel | Line: 292 | Upvalues: v28 (ref), v29 (ref), t4 (ref), t5 (ref), setLabelChain (copy), v31 (ref), v30 (ref), t7 (copy) ]]
	if not v28 then
		return
	end

	if v29 == "Receive" then
		if next(t4) == nil and next(t5) == nil then
			v28.Visible = true
			setLabelChain(v28, "You dont have any mail")
		else
			v28.Visible = false
		end
	elseif v29 == "Send" and (v31 ~= nil and (v30 == 0 and next(t7) == nil)) then
		v28.Visible = true
		setLabelChain(v28, "You dont have anything to send")
	else
		v28.Visible = false
	end
end

local function buildGiftClone(p1, p2) --[[ buildGiftClone | Line: 323 | Upvalues: v5 (ref), v6 (ref), MailboxItemCatalog (copy), t (copy), setLabelChain (copy), t2 (copy) ]]
	if not (v5 and v6) then
		return nil
	end

	if typeof(p2) == "table" and p2.Kind == "GuildReward" then
		local v1 = MailboxItemCatalog.BuildGuildRewardVisual(v6, p1, p2, function() --[[ Line: 338 | Upvalues: t (ref), p1 (copy), p2 (copy) ]]
			t:_claimGift(p1, p2, nil)
		end)

		if v1 then
			return v1
		end
	end

	local v2 = v5:Clone()

	v2.Name = "Gift_" .. p1
	v2.Visible = true

	local Interior = v2:FindFirstChild("Interior")

	if not Interior then
		return nil
	end

	local TopFrame = Interior:FindFirstChild("TopFrame")
	local v4 = string.format("From @%s!", (tostring(p2.FromName or "?")))

	if TopFrame then
		local SentPlayerNameTextLabel1 = TopFrame:FindFirstChild("SentPlayerNameTextLabel1")

		if SentPlayerNameTextLabel1 then
			setLabelChain(SentPlayerNameTextLabel1, v4)
		end

		local SubjectLine1 = TopFrame:FindFirstChild("SubjectLine1")

		if SubjectLine1 then
			setLabelChain(SubjectLine1, v4)
		end

		local SentPlayerImageLabel = TopFrame:FindFirstChild("SentPlayerImageLabel")

		if SentPlayerImageLabel and SentPlayerImageLabel:IsA("ImageLabel") then
			task.spawn(function() --[[ Line: 376 | Upvalues: MailboxItemCatalog (ref), p2 (copy), v2 (copy), SentPlayerImageLabel (copy) ]]
				local v1 = MailboxItemCatalog.GetHeadshot(p2.From or 0)

				if v1 == "" or not v2.Parent then
					return
				end

				SentPlayerImageLabel.Image = v1
			end)
		end
	end

	local Note = p2.Note

	if typeof(Note) ~= "string" or Note == "" then
		Note = "Here is a gift!"
	end

	local NoteTextlabel = Interior:FindFirstChild("NoteTextlabel")

	if NoteTextlabel then
		setLabelChain(NoteTextlabel, Note)
	end

	local Claim = Interior:FindFirstChild("Claim")

	if not (Claim and Claim:IsA("GuiButton")) then
		v2.Parent = v6

		return v2
	end

	local v52 = Claim.MouseButton1Click:Connect(function() --[[ Line: 396 | Upvalues: t (ref), p1 (copy), p2 (copy), Claim (copy) ]]
		t:_claimGift(p1, p2, Claim)
	end)

	table.insert(t2, v52)
	v2.Parent = v6

	return v2
end

local function buildInviteClone(p1, p2) --[[ buildInviteClone | Line: 405 | Upvalues: v7 (ref), v5 (ref), v6 (ref), MailboxItemCatalog (copy), t (copy) ]]
	local v1 = v7 or v5

	if v1 and v6 then
		return MailboxItemCatalog.BuildInviteVisual(v1, v6, p1, p2, function() --[[ Line: 417 | Upvalues: t (ref), p1 (copy) ]]
			t:_respondInvite(p1, true)
		end, function() --[[ Line: 418 | Upvalues: t (ref), p1 (copy) ]]
			t:_respondInvite(p1, false)
		end)
	end

	return nil
end

local function rebuildReceive() --[[ rebuildReceive | Line: 422 | Upvalues: t4 (ref), t5 (ref), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref), v6 (ref), v5 (ref), buildInviteClone (copy), buildGiftClone (copy), updateInfoLabel (copy) ]]
	local v1 = false

	for v2 in t4 do
		v1 = true

		break
	end

	if not v1 then
		for v3 in t5 do
			v1 = true

			break
		end
	end

	if v36 ~= v1 then
		v36 = v1

		for v4 in t9 do
			if v4.Parent then
				applyMailboxVisuals(v4)

				continue
			end

			t9[v4] = nil
		end

		if v21 then
			v21.Visible = v1
		end
	end

	if not (v6 and v5) then
		return
	end

	for v52, v62 in v6:GetChildren() do
		local v7 = v62.Name

		if string.sub(v7, 1, 5) == "Gift_" or string.sub(v7, 1, 7) == "Invite_" then
			v62:Destroy()
		end
	end

	local t = {}

	for v8, v9 in t4 do
		local t2 = {
			kind = "Gift",
			id = v8
		}

		t2.sortAt = tonumber(v9.SentAt) or 0
		t2.payload = v9
		table.insert(t, t2)
	end

	for v10, v11 in t5 do
		local t2 = {
			kind = "Invite",
			id = v10
		}

		t2.sortAt = tonumber(v11.ReceivedAt or v11.ExpiresAt) or 0
		t2.payload = v11
		table.insert(t, t2)
	end

	table.sort(t, function(p1, p2) --[[ Line: 462 ]]
		return p1.sortAt > p2.sortAt
	end)

	for v13, v14 in t do
		if v14.kind == "Invite" then
			buildInviteClone(v14.id, v14.payload)

			continue
		end

		buildGiftClone(v14.id, v14.payload)
	end

	updateInfoLabel()
end

function t._respondInvite(p1, p2, p3) --[[ _respondInvite | Line: 477 | Upvalues: t6 (copy), v6 (ref), t5 (ref), t4 (ref), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref), Networking (copy), NotificationController (copy) ]]
	if t6[p2] then
		return
	end

	t6[p2] = true

	local v1 = v6 and v6:FindFirstChild("Invite_" .. p2)

	if v1 then
		v1:Destroy()
	end

	t5[p2] = nil

	local v2 = false

	for v3 in t4 do
		v2 = true

		break
	end

	if not v2 then
		for v4 in t5 do
			v2 = true

			break
		end
	end

	if v36 ~= v2 then
		v36 = v2

		for v5 in t9 do
			if v5.Parent then
				applyMailboxVisuals(v5)

				continue
			end

			t9[v5] = nil
		end

		if v21 then
			v21.Visible = v2
		end
	end

	task.spawn(function() --[[ Line: 490 | Upvalues: Networking (ref), p2 (copy), p3 (copy), t6 (ref), NotificationController (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 491 | Upvalues: Networking (ref), p2 (ref), p3 (ref) ]]
			return Networking.Guild.RespondInvite:Fire(p2, p3)
		end)

		t6[p2] = nil

		if not ok then
			NotificationController:CreateNotification("Try again")

			return
		end

		if result then
			if not p3 then
				return
			end

			NotificationController:CreateNotification("Joined guild!")
		else
			if not result2 or result2 == "" then
				return
			end

			NotificationController:CreateNotification(result2)
		end
	end)
end
function t._claimGift(p1, p2, p3, p4) --[[ _claimGift | Line: 511 | Upvalues: t8 (copy), Networking (copy), NotificationController (copy), MailboxItemCatalog (copy), v6 (ref), t4 (ref), t5 (ref), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref) ]]
	if t8[p2] then
		return
	end

	t8[p2] = true

	if p4 then
		if p4:IsA("TextButton") or p4:IsA("ImageButton") then
			p4.AutoButtonColor = false
		end

		p4.Active = false
	end

	task.spawn(function() --[[ Line: 525 | Upvalues: Networking (ref), p2 (copy), t8 (ref), p4 (copy), NotificationController (ref), p3 (copy), MailboxItemCatalog (ref), v6 (ref), t4 (ref), t5 (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 526 | Upvalues: Networking (ref), p2 (ref) ]]
			return Networking.Mailbox.Claim:Fire(p2)
		end)

		t8[p2] = nil

		if p4 then
			p4.Active = true
		end

		if not ok then
			NotificationController:CreateNotification("Try again")

			return
		end

		if result then
			local Items = p3.Items

			if typeof(Items) == "table" and #Items > 0 then
				for i, v in ipairs(Items) do
					local v2, _ = MailboxItemCatalog.Resolve(v.Category, v.ItemName, v.Pet or v.Fruit)

					NotificationController:CreateNotification(string.format("x%d %s", v.Count or 1, v2))
				end
			else
				local v4, _ = MailboxItemCatalog.Resolve(p3.Category, p3.ItemName, p3.Payload)

				NotificationController:CreateNotification(string.format("x1 %s", v4))
			end

			local v5 = v6 and v6:FindFirstChild("Gift_" .. p2)

			if v5 then
				v5:Destroy()
			end

			t4[p2] = nil

			local v62 = false

			for v7 in t4 do
				v62 = true

				break
			end

			if not v62 then
				for v8 in t5 do
					v62 = true

					break
				end
			end

			if v36 == v62 then
				return
			end

			v36 = v62

			for v9 in t9 do
				if v9.Parent then
					applyMailboxVisuals(v9)

					continue
				end

				t9[v9] = nil
			end

			if not v21 then
				return
			end

			v21.Visible = v62
		else
			if not result2 or result2 == "" then
				return
			end

			NotificationController:CreateNotification(result2)
		end
	end)
end

local function showTab(p1) --[[ showTab | Line: 570 | Upvalues: v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), t (copy), updateInfoLabel (copy) ]]
	v29 = p1

	if v18 then
		v18.Visible = p1 == "Receive"
	end

	if v15 then
		v15.Visible = p1 == "Send"
	end

	if v19 then
		v19.Visible = p1 == "Send"
	end

	if v20 then
		v20.Visible = p1 == "Receive"
	end

	if p1 == "Send" then
		t:_resetToPlayerList()
	end

	updateInfoLabel()
end

local t10 = {}

local function buildSendTemplate(p1, p2, p3, p4) --[[ buildSendTemplate | Line: 591 | Upvalues: v8 (ref), v9 (ref), t10 (copy), setLabelChain (copy), MailboxItemCatalog (copy), t2 (copy), t (copy) ]]
	if not (v8 and v9) then
		return nil
	end

	if t10[p1] and t10[p1].Parent then
		return t10[p1]
	end

	local v1 = v8:Clone()

	v1.Name = p4 .. "_" .. tostring(p1)
	v1.Visible = true

	local Button = v1:FindFirstChild("Button")

	if not (Button and Button:IsA("GuiButton")) then
		v1:Destroy()

		return nil
	end

	local HoverFrame = Button:FindFirstChild("HoverFrame")

	if HoverFrame and HoverFrame:IsA("GuiObject") then
		HoverFrame.Visible = false
	end

	local PlayerDisplayName1 = Button:FindFirstChild("PlayerDisplayName1")

	if PlayerDisplayName1 then
		setLabelChain(PlayerDisplayName1, p2)
	end

	local PlayerUsername = Button:FindFirstChild("PlayerUsername")

	if PlayerUsername and (PlayerUsername:IsA("TextLabel") or PlayerUsername:IsA("TextButton")) then
		PlayerUsername.Text = "@" .. p3
	end

	local PlayerDisplay = Button:FindFirstChild("PlayerDisplay")

	if PlayerDisplay then
		local PlayerImage = PlayerDisplay:FindFirstChild("PlayerImage")

		if PlayerImage and PlayerImage:IsA("ImageLabel") then
			task.spawn(function() --[[ Line: 627 | Upvalues: MailboxItemCatalog (ref), p1 (copy), v1 (copy), PlayerImage (copy) ]]
				local v12 = MailboxItemCatalog.GetHeadshot(p1)

				if v12 == "" or not v1.Parent then
					return
				end

				PlayerImage.Image = v12
			end)
		end
	end

	table.insert(t2, (Button.MouseEnter:Connect(function() --[[ Line: 636 | Upvalues: HoverFrame (copy) ]]
		if not (HoverFrame and HoverFrame:IsA("GuiObject")) then
			return
		end

		HoverFrame.Visible = true
	end)))
	table.insert(t2, (Button.MouseLeave:Connect(function() --[[ Line: 641 | Upvalues: HoverFrame (copy) ]]
		if not (HoverFrame and HoverFrame:IsA("GuiObject")) then
			return
		end

		HoverFrame.Visible = false
	end)))

	local v6 = Button.MouseButton1Click:Connect(function() --[[ Line: 646 | Upvalues: t (ref), p1 (copy), p2 (copy) ]]
		t:_pickRecipient(p1, p2)
	end)

	table.insert(t2, v6)
	v1.Parent = v9
	t10[p1] = v1

	return v1
end

local function clearPlayerList() --[[ clearPlayerList | Line: 655 | Upvalues: v9 (ref), v8 (ref), clearChildrenExcept (copy), t10 (copy), v32 (ref) ]]
	if v9 and v8 then
		clearChildrenExcept(v9, {
			[v8] = true
		})
		table.clear(t10)
		v32 = nil
	end
end

local function populatePlayerList() --[[ populatePlayerList | Line: 662 | Upvalues: v9 (ref), v8 (ref), clearChildrenExcept (copy), t10 (copy), v32 (ref), Players (copy), LocalPlayer (copy), buildSendTemplate (copy), v3 (ref) ]]
	if v9 and v8 then
		clearChildrenExcept(v9, {
			[v8] = true
		})
		table.clear(t10)
		v32 = nil
	end

	for v1, v2 in Players:GetPlayers() do
		if v2 ~= LocalPlayer then
			buildSendTemplate(v2.UserId, v2.DisplayName, v2.Name, "Server")
		end
	end

	task.spawn(function() --[[ Line: 670 | Upvalues: Players (ref), LocalPlayer (ref), v3 (ref), t10 (ref), buildSendTemplate (ref) ]]
		local ok, result = pcall(function() --[[ Line: 671 | Upvalues: Players (ref), LocalPlayer (ref) ]]
			return Players:GetFriendsAsync(LocalPlayer.UserId)
		end)

		if not (ok and result) then
			return
		end

		local count = 0

		repeat
			if not (count < 30) then
				break
			end

			for v1, v2 in result:GetCurrentPage() do
				if not (v3 and v3.Enabled) then
					return
				end

				if count >= 30 then
					break
				end

				local Id = v2.Id

				if Id and (Id ~= LocalPlayer.UserId and not t10[Id]) then
					buildSendTemplate(Id, v2.DisplayName or v2.Username, v2.Username, "Friend")
					count = count + 1
				end
			end
		until result.IsFinished or not pcall(function() --[[ Line: 690 | Upvalues: result (copy) ]]
			result:AdvanceToNextPageAsync()
		end)
	end)
end

local function isValidUsernameLocal(p1) --[[ isValidUsernameLocal | Line: 700 ]]
	if #p1 < 3 or #p1 > 20 then
		return false
	end

	return string.match(p1, "^[%w_]+$") ~= nil
end

local function onSearchFocusLost(p1) --[[ onSearchFocusLost | Line: 705 | Upvalues: v10 (ref), Networking (copy), v3 (ref), v31 (ref), v32 (ref), buildSendTemplate (copy) ]]
	if not v10 then
		return
	end

	local v2 = string.gsub(v10.Text or "", "^%s*@?(.-)%s*$", "%1")

	if v2 == "" then
		return
	end

	if if #v2 < 3 or #v2 > 20 then false elseif string.match(v2, "^[%w_]+$") == nil then false else true then
		task.spawn(function() --[[ Line: 712 | Upvalues: Networking (ref), v2 (copy), v3 (ref), v31 (ref), v32 (ref), buildSendTemplate (ref) ]]
			local ok, result, result2 = pcall(function() --[[ Line: 713 | Upvalues: Networking (ref), v2 (ref) ]]
				return Networking.Mailbox.LookupPlayer:Fire(v2)
			end)

			if not ok or (typeof(result) ~= "number" or result <= 0) then
				return
			end

			if not (v3 and v3.Enabled) then
				return
			end

			if v31 then
				return
			end

			if v32 then
				v32:Destroy()
				v32 = nil
			end

			local v22, v33

			if result2 == "" or not result2 then
				v22 = v2
				v33 = result
			else
				v33 = result
				v22 = result2
			end

			local v4 = buildSendTemplate(v33, v22, v2, "Search")

			if not v4 then
				return
			end

			v32 = v4
			v4.LayoutOrder = -1
		end)
	end
end

local function onSearchTextChanged() --[[ onSearchTextChanged | Line: 735 | Upvalues: v32 (ref) ]]
	if not v32 then
		return
	end

	v32:Destroy()
	v32 = nil
end

local function totalSelected() --[[ totalSelected | Line: 746 | Upvalues: t7 (copy) ]]
	local sum = 0

	for v1, v2 in t7 do
		sum = sum + v2.Selected
	end

	return sum
end

local function updateCanSendFrame() --[[ updateCanSendFrame | Line: 754 | Upvalues: v24 (ref), t7 (copy) ]]
	if not v24 then
		return
	end

	local sum = 0

	for v2, v3 in t7 do
		sum = sum + v3.Selected
	end

	v24.Visible = if sum == 0 then true else false
end

local t11 = {}

local function isGiftableInventoryEntry(p1, p2, p3) --[[ isGiftableInventoryEntry | Line: 761 | Upvalues: MailboxItemCatalog (copy), t11 (copy) ]]
	if not MailboxItemCatalog.IsGiftable(p1) then
		return false
	end

	if p1 == "HarvestedFruits" then
		return if typeof(p3) == "table" then p3.Id ~= nil else false
	end

	-- MODDED: las pets se regalan como stack contado (este juego las guarda como
	-- conteo, no como instancias). Caen a la regla numérica de abajo (count > 0).

	return if typeof(p3) == "number" then p3 > 0 else false
end

local function getClickableButtons(p1) --[[ getClickableButtons | Line: 779 ]]
	local t = { p1 }

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("GuiButton") then
			table.insert(t, v2)
		end
	end

	return t
end

local function applyPetVisualStyle(p1, p2, p3) --[[ applyPetVisualStyle | Line: 796 | Upvalues: PetTypes (copy), AnimatedGradient (copy) ]]
	if not p1 then
		return
	end

	if if p2 == "Pets" and typeof(p3) == "table" then p3.Type == PetTypes.Rainbow else false then
		AnimatedGradient:AddRainbowColor(p1, "ImageColor3")
	else
		AnimatedGradient:Remove(p1)
		p1.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
	end
end

local function formatTileAmount(p1, p2, p3) --[[ formatTileAmount | Line: 812 ]]
	if p1 == "Pets" then
		return ""
	end

	return "x" .. tostring(p2)
end

local function bindInventoryTile(p1, p2, p3, p4, p5, p6, p7, p8) --[[ bindInventoryTile | Line: 819 | Upvalues: applyPetVisualStyle (copy), setLabelChain (copy), getClickableButtons (copy), TweenService (copy), v2 (copy), t (copy), t2 (copy), v1 (copy) ]]
	p1.Visible = true

	local Frame = p1:FindFirstChild("Frame")

	if not Frame then
		return
	end

	local Button = Frame:FindFirstChild("Button")

	if not (Button and Button:IsA("GuiButton")) then
		return
	end

	local ItemImage = Button:FindFirstChild("ItemImage")

	if ItemImage and ItemImage:IsA("ImageLabel") then
		ItemImage.Image = p6
		applyPetVisualStyle(ItemImage, p3, p8)
	end

	local AmountTextLabel1 = Button:FindFirstChild("AmountTextLabel1")

	if AmountTextLabel1 then
		setLabelChain(AmountTextLabel1, if p3 == "Pets" then "" else "x" .. tostring(p7))
	end

	local SendFlash = Button:FindFirstChild("SendFlash")

	if SendFlash and SendFlash:IsA("Frame") then
		SendFlash.BackgroundTransparency = 1
	end

	local v3 = getClickableButtons(Button)

	local function onClick(p1) --[[ onClick | Line: 848 | Upvalues: SendFlash (copy), TweenService (ref), v2 (ref), t (ref), p2 (copy), p3 (copy), p4 (copy), p8 (copy) ]]
		if SendFlash then
			SendFlash.BackgroundTransparency = 0.25
			TweenService:Create(SendFlash, v2, {
				BackgroundTransparency = 0.75
			}):Play()
		end

		t:_addToSend(p2, p3, p4, p8)
	end

	for v4, v5 in v3 do
		table.insert(t2, (v5.MouseButton1Click:Connect(function() --[[ Line: 857 | Upvalues: onClick (copy), v5 (copy) ]]
			onClick(v5)
		end)))

		if SendFlash then
			local v8 = v5.MouseEnter:Connect(function() --[[ Line: 861 | Upvalues: TweenService (ref), SendFlash (copy), v1 (ref) ]]
				TweenService:Create(SendFlash, v1, {
					BackgroundTransparency = 0.75
				}):Play()
			end)

			table.insert(t2, v8)

			local v10 = v5.MouseLeave:Connect(function() --[[ Line: 864 | Upvalues: TweenService (ref), SendFlash (copy), v1 (ref) ]]
				TweenService:Create(SendFlash, v1, {
					BackgroundTransparency = 1
				}):Play()
			end)

			table.insert(t2, v10)
		end
	end
end

local function rebuildInventory() --[[ rebuildInventory | Line: 871 | Upvalues: v12 (ref), v11 (ref), v30 (ref), updateInfoLabel (copy), clearChildrenExcept (copy), PlayerStateClient (copy), MailboxItemCatalog (copy), isGiftableInventoryEntry (copy), t7 (copy), bindInventoryTile (copy) ]]
	if not (v12 and v11) then
		v30 = 0
	else
		clearChildrenExcept(v12, {
			[v11] = true
		})

		local count = 0
		local v1 = PlayerStateClient:GetLocalReplica()

		if v1 then
			local v2 = v1.Data and v1.Data.Inventory

			if typeof(v2) == "table" then
				for v3, v4 in MailboxItemCatalog.Categories do
					local v5 = v2[v4]

					if typeof(v5) == "table" then
						if v4 == "HarvestedFruits" then -- MODDED: Pets ahora va por la rama contada
							for v6, v7 in v5 do
								if isGiftableInventoryEntry(v4, v6, v7) then
									local v8 = v4 .. ":" .. v6
									local v10 = 1 - (t7[v8] and t7[v8].Selected or 0)

									if not (v10 <= 0) then
										local v112, v122 = MailboxItemCatalog.Resolve(v4, v6, v7)
										local v13 = v11:Clone()

										v13.Name = "Inv_" .. v8
										v13.Parent = v12
										bindInventoryTile(v13, v8, v4, v6, v112, v122, v10, v7)
										count = count + 1
									end
								end
							end

							continue
						end

						for v14, v15 in v5 do
							if isGiftableInventoryEntry(v4, v14, v15) then
								local v16 = v4 .. ":" .. v14
								local v18 = v15 - (t7[v16] and t7[v16].Selected or 0)

								if not (v18 <= 0) then
									local v19, v20 = MailboxItemCatalog.Resolve(v4, v14, nil)
									local v21 = v11:Clone()

									v21.Name = "Inv_" .. v16
									v21.Parent = v12
									bindInventoryTile(v21, v16, v4, v14, v19, v20, v18, nil)
									count = count + 1
								end
							end
						end
					end
				end
			end
		end

		v30 = count
	end

	updateInfoLabel()
end

local function bindSendingTile(p1, p2, p3, p4, p5, p6, p7) --[[ bindSendingTile | Line: 941 | Upvalues: applyPetVisualStyle (copy), setLabelChain (copy), t2 (copy), t (copy) ]]
	p1.Visible = true

	local Frame = p1:FindFirstChild("Frame")

	if not Frame then
		return
	end

	local Button = Frame:FindFirstChild("Button")

	if not (Button and Button:IsA("GuiButton")) then
		return
	end

	local ItemImage = Button:FindFirstChild("ItemImage")

	if ItemImage and ItemImage:IsA("ImageLabel") then
		ItemImage.Image = p4
		applyPetVisualStyle(ItemImage, p6, p7)
	end

	local AmountTextLabel1 = Button:FindFirstChild("AmountTextLabel1")

	if AmountTextLabel1 then
		setLabelChain(AmountTextLabel1, if p6 == "Pets" then "" else "x" .. tostring(p5))
	end

	local RemoveHoverFrame = Button:FindFirstChild("RemoveHoverFrame")

	if RemoveHoverFrame and RemoveHoverFrame:IsA("GuiObject") then
		RemoveHoverFrame.Visible = false
		table.insert(t2, (Button.MouseEnter:Connect(function() --[[ Line: 962 | Upvalues: RemoveHoverFrame (copy) ]]
			RemoveHoverFrame.Visible = true
		end)))
		table.insert(t2, (Button.MouseLeave:Connect(function() --[[ Line: 965 | Upvalues: RemoveHoverFrame (copy) ]]
			RemoveHoverFrame.Visible = false
		end)))
	end

	local v7 = Button.MouseButton1Click:Connect(function() --[[ Line: 970 | Upvalues: t (ref), p2 (copy) ]]
		t:_removeFromSend(p2)
	end)

	table.insert(t2, v7)
end

local function rebuildSending() --[[ rebuildSending | Line: 975 | Upvalues: v14 (ref), v13 (ref), clearChildrenExcept (copy), t7 (copy), MailboxItemCatalog (copy), bindSendingTile (copy), v24 (ref) ]]
	if not (v14 and v13) then
		return
	end

	clearChildrenExcept(v14, {
		[v13] = true
	})

	for v1, v2 in t7 do
		if not (v2.Selected <= 0) then
			local v3, v4 = MailboxItemCatalog.Resolve(v2.Category, v2.ItemKey, v2.EntryValue)
			local v5 = v13:Clone()

			v5.Name = "Send_" .. v1
			v5.Parent = v14
			bindSendingTile(v5, v1, v3, v4, v2.Selected, v2.Category, v2.EntryValue)
		end
	end

	if not v24 then
		return
	end

	local sum = 0

	for v7, v8 in t7 do
		sum = sum + v8.Selected
	end

	v24.Visible = if sum == 0 then true else false
end

function t._addToSend(p1, p2, p3, p4, p5) --[[ _addToSend | Line: 991 | Upvalues: t7 (copy), NotificationController (copy), rebuildInventory (copy), rebuildSending (copy) ]]
	local sum = 0

	for v1, v2 in t7 do
		sum = sum + v2.Selected
	end

	if sum >= 20 then
		NotificationController:CreateNotification(string.format("Up to %d items per gift", 20))

		return
	end

	local v3 = t7[p2]

	if not v3 then
		local t = {
			Selected = 0,
			Category = p3,
			ItemKey = p4,
			EntryValue = p5
		}

		t7[p2] = t
		v3 = t
	end

	v3.Selected = v3.Selected + 1
	rebuildInventory()
	rebuildSending()
end
function t._removeFromSend(p1, p2) --[[ _removeFromSend | Line: 1008 | Upvalues: t7 (copy), rebuildInventory (copy), rebuildSending (copy) ]]
	local v1 = t7[p2]

	if not v1 then
		return
	end

	v1.Selected = v1.Selected - 1

	if v1.Selected <= 0 then
		t7[p2] = nil
	end

	rebuildInventory()
	rebuildSending()
end

local function clearSelected() --[[ clearSelected | Line: 1019 | Upvalues: t7 (copy), rebuildSending (copy), rebuildInventory (copy) ]]
	table.clear(t7)
	rebuildSending()
	rebuildInventory()
end

function t._resetToPlayerList(p1) --[[ _resetToPlayerList | Line: 1029 | Upvalues: v31 (ref), v16 (ref), v17 (ref), t7 (copy), rebuildSending (copy), rebuildInventory (copy), v25 (ref), v10 (ref), populatePlayerList (copy), updateInfoLabel (copy) ]]
	v31 = nil

	if v16 then
		v16.Visible = false
	end

	if v17 then
		v17.Visible = true
	end

	table.clear(t7)
	rebuildSending()
	rebuildInventory()

	if v25 then
		v25.Text = ""
	end

	if v10 then
		v10.Text = ""
	end

	populatePlayerList()
	updateInfoLabel()
end
function t._pickRecipient(p1, p2, p3) --[[ _pickRecipient | Line: 1040 | Upvalues: v31 (ref), v17 (ref), v16 (ref), v27 (ref), setLabelChain (copy), v26 (ref), MailboxItemCatalog (copy), v3 (ref), t7 (copy), rebuildSending (copy), rebuildInventory (copy), v25 (ref), updateInfoLabel (copy) ]]
	v31 = {
		userId = p2,
		displayName = p3
	}

	if v17 then
		v17.Visible = false
	end

	if v16 then
		v16.Visible = true
	end

	if v27 then
		setLabelChain(v27, "Send to " .. p3)
	end

	if v26 then
		task.spawn(function() --[[ Line: 1050 | Upvalues: MailboxItemCatalog (ref), p2 (copy), v3 (ref), v26 (ref) ]]
			local v1 = MailboxItemCatalog.GetHeadshot(p2)

			if v1 == "" or not (v3 and v3.Enabled) then
				return
			end

			v26.Image = v1
		end)
	end

	table.clear(t7)
	rebuildSending()
	rebuildInventory()

	if v25 then
		v25.Text = ""
	end

	rebuildInventory()
	rebuildSending()
	updateInfoLabel()
end

local function sendBatch() --[[ sendBatch | Line: 1065 | Upvalues: v34 (ref), v31 (ref), t7 (copy), v35 (ref), v25 (ref), v22 (ref), Networking (copy), NotificationController (copy), t (copy) ]]
	if v34 then
		return
	end

	if not v31 then
		return
	end

	local sum = 0

	for v1, v2 in t7 do
		sum = sum + v2.Selected
	end

	if sum == 0 then
		return
	end

	local v3 = os.clock()

	if v3 - v35 < 1.5 then
		return
	end

	v35 = v3

	local t2 = {}

	for v4, v5 in t7 do
		if not (v5.Selected <= 0) then
			table.insert(t2, {
				Category = v5.Category,
				ItemKey = v5.ItemKey,
				Count = v5.Selected
			})
		end
	end

	if #t2 == 0 then
		return
	end

	local v6 = if v25 then v25.Text or "" else ""
	local userId = v31.userId

	v34 = true

	if v22 then
		v22.Active = false
	end

	task.spawn(function() --[[ Line: 1091 | Upvalues: Networking (ref), userId (copy), t2 (copy), v6 (copy), v34 (ref), v22 (ref), NotificationController (ref), t (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 1092 | Upvalues: Networking (ref), userId (ref), t2 (ref), v6 (ref) ]]
			return Networking.Mailbox.SendBatch:Fire(userId, t2, v6)
		end)

		v34 = false

		if v22 then
			v22.Active = true
		end

		if not ok then
			NotificationController:CreateNotification("Try again")

			return
		end

		if result then
			NotificationController:CreateNotification(if result2 == "" or not result2 then "Gift sent!" else result2)
			t:_resetToPlayerList()
		else
			NotificationController:CreateNotification(if result2 == "" or not result2 then "Could not send gift" else result2)
		end
	end)
end

local function clampNoteText() --[[ clampNoteText | Line: 1117 | Upvalues: v25 (ref) ]]
	if not v25 then
		return
	end

	local Text = v25.Text

	if utf8.len(Text) and utf8.len(Text) > 100 then
		utf8.offset(Text, 101)

		local v1 = utf8.offset(Text, 101)

		if v1 then
			v25.Text = string.sub(Text, 1, v1 - 1)
		else
			v25.Text = string.sub(Text, 1, 100)
		end
	else
		if not (#Text > 400) then
			return
		end

		v25.Text = string.sub(Text, 1, 100)
	end
end

local function bindNoteTextBox() --[[ bindNoteTextBox | Line: 1135 | Upvalues: v25 (ref), clampNoteText (copy), t3 (copy) ]]
	if v25 then
		v25.PlaceholderText = "Add a note (optional)"
		v25.ClearTextOnFocus = false
		table.insert(t3, (v25:GetPropertyChangedSignal("Text"):Connect(clampNoteText)))
	end
end

local function findExitButton(p1) --[[ findExitButton | Line: 1146 ]]
	local ExitButton = p1:FindFirstChild("ExitButton", true)

	if ExitButton and ExitButton:IsA("GuiButton") then
		return ExitButton
	end

	return nil
end

local function bindExitButton(p1) --[[ bindExitButton | Line: 1154 | Upvalues: GuiController (copy), t3 (copy) ]]
	local t = {}

	local function tryBind(p1) --[[ tryBind | Line: 1157 | Upvalues: t (copy), GuiController (ref) ]]
		if not t[p1] then
			t[p1] = p1.MouseButton1Click:Connect(function() --[[ Line: 1159 | Upvalues: GuiController (ref) ]]
				if not GuiController:IsOpen("MailboxUI") then
					return
				end

				GuiController:Close()
			end)
		end
	end

	local ExitButton = p1:FindFirstChild("ExitButton", true)
	local v1 = if ExitButton and ExitButton:IsA("GuiButton") then ExitButton else nil

	if v1 and not t[v1] then
		t[v1] = v1.MouseButton1Click:Connect(function() --[[ Line: 1159 | Upvalues: GuiController (ref) ]]
			if not GuiController:IsOpen("MailboxUI") then
				return
			end

			GuiController:Close()
		end)
	end

	local v2 = p1.DescendantAdded:Connect(function(p1) --[[ Line: 1171 | Upvalues: t (copy), GuiController (ref) ]]
		if p1.Name ~= "ExitButton" or not p1:IsA("GuiButton") then
			return
		end

		if t[p1] then
			return
		end

		t[p1] = p1.MouseButton1Click:Connect(function() --[[ Line: 1159 | Upvalues: GuiController (ref) ]]
			if not GuiController:IsOpen("MailboxUI") then
				return
			end

			GuiController:Close()
		end)
	end)

	table.insert(t3, v2)
end

local function resolveRefs(p1) --[[ resolveRefs | Line: 1178 | Upvalues: v28 (ref), v19 (ref), v20 (ref), v21 (ref), v36 (ref), v18 (ref), v5 (ref), v6 (ref), v7 (ref), v15 (ref), v16 (ref), v27 (ref), v26 (ref), v25 (ref), v22 (ref), v23 (ref), v24 (ref), v12 (ref), v11 (ref), v14 (ref), v13 (ref), v17 (ref), v9 (ref), v8 (ref), v10 (ref) ]]
	local Frame = p1:WaitForChild("Frame", 10)

	if not Frame then
		return
	end

	local Info = Frame:FindFirstChild("Info")

	if Info and Info:IsA("TextLabel") then
		v28 = Info
	end

	local Header = Frame:WaitForChild("Header", 5)

	if Header then
		v19 = Header:FindFirstChild("ToggleButtonSend")
		v20 = Header:FindFirstChild("ToggleButtonRecieve")

		if v19 then
			local Text = v19:FindFirstChild("Text")
			local v1 = if Text then Text:FindFirstChild("Notification") else Text

			if v1 and v1:IsA("Frame") then
				v21 = v1
			end
		end

		if v21 then
			v21.Visible = v36
		end
	end

	v18 = Frame:FindFirstChild("RecieveFrame")

	if v18 then
		v5 = v18:FindFirstChild("GiftTemplate")
		v6 = v18

		if v5 then
			v5.Visible = false
		end

		v7 = v18:FindFirstChild("GuildInviteTemplate")

		if v7 then
			v7.Visible = false
		end
	end

	v15 = Frame:FindFirstChild("SendingFrame")

	if not v15 then
		return
	end

	v16 = v15:FindFirstChild("ItemSendFrame")

	if v16 then
		v27 = v16:FindFirstChild("Sending")
		v26 = v16:FindFirstChild("PlayerImage")
		v25 = v16:FindFirstChild("NoteTextBox")
		v22 = v16:FindFirstChild("SendButton")
		v23 = v16:FindFirstChild("CancelButton")

		if v22 then
			v24 = v22:FindFirstChild("CanSendFrame")
		end

		local ScrollingFrames = v16:FindFirstChild("ScrollingFrames")

		if ScrollingFrames then
			v12 = ScrollingFrames:FindFirstChild("InventoryFrame")

			if v12 then
				v11 = v12:FindFirstChild("ItemFrameTemplate")

				if v11 then
					v11.Visible = false
				end
			end

			v14 = ScrollingFrames:FindFirstChild("SendingFrame")

			if v14 then
				v13 = v14:FindFirstChild("ItemFrameTemplate")

				if v13 then
					v13.Visible = false
				end
			end
		end
	end

	v17 = v15:FindFirstChild("SelectPlayerFrame")

	if not v17 then
		return
	end

	v9 = v17:FindFirstChild("PlayerList")

	if v9 then
		v8 = v9:FindFirstChild("SendTemplate")

		if v8 then
			v8.Visible = false
		end
	end

	local Topbar = v17:FindFirstChild("Topbar")

	if not Topbar then
		return
	end

	v10 = Topbar:FindFirstChild("SearchBox")
end

local function bindChrome(p1) --[[ bindChrome | Line: 1260 | Upvalues: v4 (ref), resolveRefs (copy), bindExitButton (copy), v25 (ref), clampNoteText (copy), t3 (copy), updateInfoLabel (copy), v19 (ref), v29 (ref), v18 (ref), v15 (ref), v20 (ref), t (copy), v23 (ref), v22 (ref), sendBatch (copy), v10 (ref), onSearchFocusLost (copy), onSearchTextChanged (copy) ]]
	if v4 then
		return
	end

	v4 = true
	resolveRefs(p1)
	bindExitButton(p1)

	if v25 then
		v25.PlaceholderText = "Add a note (optional)"
		v25.ClearTextOnFocus = false
		table.insert(t3, (v25:GetPropertyChangedSignal("Text"):Connect(clampNoteText)))
	end

	updateInfoLabel()

	if v19 then
		local v3 = v19.MouseButton1Click:Connect(function() --[[ Line: 1272 | Upvalues: v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), updateInfoLabel (ref) ]]
			v29 = "Receive"

			if v18 then
				v18.Visible = true
			end

			if v15 then
				v15.Visible = false
			end

			if v19 then
				v19.Visible = false
			end

			if v20 then
				v20.Visible = true
			end

			updateInfoLabel()
		end)

		table.insert(t3, v3)
	end

	if v20 then
		local v5 = v20.MouseButton1Click:Connect(function() --[[ Line: 1275 | Upvalues: v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), t (ref), updateInfoLabel (ref) ]]
			v29 = "Send"

			if v18 then
				v18.Visible = false
			end

			if v15 then
				v15.Visible = true
			end

			if v19 then
				v19.Visible = true
			end

			if v20 then
				v20.Visible = false
			end

			t:_resetToPlayerList()
			updateInfoLabel()
		end)

		table.insert(t3, v5)
	end

	if v23 then
		local v7 = v23.MouseButton1Click:Connect(function() --[[ Line: 1279 | Upvalues: t (ref) ]]
			t:_resetToPlayerList()
		end)

		table.insert(t3, v7)
	end

	if v22 then
		table.insert(t3, (v22.MouseButton1Click:Connect(sendBatch)))
	end

	if v10 then
		table.insert(t3, (v10.FocusLost:Connect(onSearchFocusLost)))
		table.insert(t3, (v10:GetPropertyChangedSignal("Text"):Connect(onSearchTextChanged)))
	end

	v29 = "Send"

	if v18 then
		v18.Visible = false
	end

	if v15 then
		v15.Visible = true
	end

	if v19 then
		v19.Visible = true
	end

	if v20 then
		v20.Visible = false
	end

	t:_resetToPlayerList()
	updateInfoLabel()
end

local function v38() --[[ attachReplicaListener | Line: 1297 | Upvalues: v33 (ref), PlayerStateClient (copy), v38 (copy), v3 (ref), v16 (ref), rebuildInventory (copy) ]]
	if v33 then
		return
	end

	local v1 = PlayerStateClient:GetLocalReplica()

	if v1 then
		v33 = v1:OnChange(function(p1, p2) --[[ Line: 1306 | Upvalues: v3 (ref), v16 (ref), rebuildInventory (ref) ]]
			if not (v3 and v3.Enabled) then
				return
			end

			if not (v16 and v16.Visible) then
				return
			end

			if typeof(p2) ~= "table" or p2[1] ~= "Inventory" then
				return
			end

			rebuildInventory()
		end)
	else
		PlayerStateClient:OnLocalReplica(function() --[[ Line: 1301 | Upvalues: v38 (ref) ]]
			v38()
		end)
	end
end

local function fetchInbox() --[[ fetchInbox | Line: 1315 | Upvalues: Networking (copy), t4 (ref), rebuildReceive (copy) ]]
	local ok, result = pcall(function() --[[ Line: 1316 | Upvalues: Networking (ref) ]]
		return Networking.Mailbox.OpenInbox:Fire()
	end)

	if not ok or typeof(result) ~= "table" then
		return
	end

	t4 = result
	rebuildReceive()
end

local v39 = nil
local v40 = 0

local function startInboxPoll() --[[ startInboxPoll | Line: 1336 | Upvalues: v39 (ref), v40 (ref), Networking (copy), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref), t4 (ref), rebuildReceive (copy) ]]
	if not v39 then
		v40 = v40 + 1

		local v1 = v40
		local v2 = 30
		local v3 = 0
		local v4 = nil

		v39 = task.spawn(function() --[[ Line: 1343 | Upvalues: v40 (ref), v1 (copy), v2 (ref), Networking (ref), v4 (ref), v3 (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref), t4 (ref), rebuildReceive (ref) ]]
			while v40 == v1 do
				task.wait(v2)

				if v40 ~= v1 then
					break
				end

				local ok, result = pcall(function() --[[ Line: 1347 | Upvalues: Networking (ref) ]]
					return Networking.Mailbox.IndexProbe:Fire()
				end)

				if not ok then
					continue
				end

				local v12 = tonumber(result) or 0

				if v4 == nil or v12 ~= v4 then
					v3 = 0
					v2 = 30
					v4 = v12

					local v22 = v12 > 0

					if v36 ~= v22 then
						v36 = v22

						for v32 in t9 do
							if v32.Parent then
								applyMailboxVisuals(v32)

								continue
							end

							t9[v32] = nil
						end

						if v21 then
							v21.Visible = v22
						end
					end

					local ok2, result2 = pcall(function() --[[ Line: 1316 | Upvalues: Networking (ref) ]]
						return Networking.Mailbox.OpenInbox:Fire()
					end)

					if ok2 and typeof(result2) == "table" then
						t4 = result2
						rebuildReceive()
					end

					continue
				end

				v3 = v3 + 1

				if not (v3 >= 5) then
					continue
				end

				v2 = math.min(v2 * 2, 120)
			end
		end)
	end
end

local function stopInboxPoll() --[[ stopInboxPoll | Line: 1370 | Upvalues: v40 (ref), v39 (ref) ]]
	v40 = v40 + 1
	v39 = nil
end

local function onMailboxOpened() --[[ onMailboxOpened | Line: 1375 | Upvalues: v38 (copy), fetchInbox (copy), v39 (ref), v40 (ref), Networking (copy), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref), t4 (ref), rebuildReceive (copy), v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), t (copy), updateInfoLabel (copy) ]]
	v38()
	task.spawn(fetchInbox)

	if not v39 then
		v40 = v40 + 1

		local v1 = v40
		local v2 = 30
		local v3 = 0
		local v4 = nil

		v39 = task.spawn(function() --[[ Line: 1343 | Upvalues: v40 (ref), v1 (copy), v2 (ref), Networking (ref), v4 (ref), v3 (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref), t4 (ref), rebuildReceive (ref) ]]
			while v40 == v1 do
				task.wait(v2)

				if v40 ~= v1 then
					break
				end

				local ok, result = pcall(function() --[[ Line: 1347 | Upvalues: Networking (ref) ]]
					return Networking.Mailbox.IndexProbe:Fire()
				end)

				if not ok then
					continue
				end

				local v12 = tonumber(result) or 0

				if v4 == nil or v12 ~= v4 then
					v3 = 0
					v2 = 30
					v4 = v12

					local v22 = v12 > 0

					if v36 ~= v22 then
						v36 = v22

						for v32 in t9 do
							if v32.Parent then
								applyMailboxVisuals(v32)

								continue
							end

							t9[v32] = nil
						end

						if v21 then
							v21.Visible = v22
						end
					end

					local ok2, result2 = pcall(function() --[[ Line: 1316 | Upvalues: Networking (ref) ]]
						return Networking.Mailbox.OpenInbox:Fire()
					end)

					if ok2 and typeof(result2) == "table" then
						t4 = result2
						rebuildReceive()
					end

					continue
				end

				v3 = v3 + 1

				if not (v3 >= 5) then
					continue
				end

				v2 = math.min(v2 * 2, 120)
			end
		end)
	end

	v29 = "Send"

	if v18 then
		v18.Visible = false
	end

	if v15 then
		v15.Visible = true
	end

	if v19 then
		v19.Visible = true
	end

	if v20 then
		v20.Visible = false
	end

	t:_resetToPlayerList()
	updateInfoLabel()
end

local function onMailboxClosed() --[[ onMailboxClosed | Line: 1384 | Upvalues: clearSession (copy), v40 (ref), v39 (ref), v31 (ref), v32 (ref), t10 (copy), t7 (copy), rebuildSending (copy), rebuildInventory (copy), v25 (ref), v10 (ref) ]]
	clearSession()
	v40 = v40 + 1
	v39 = nil
	v31 = nil
	v32 = nil
	table.clear(t10)
	table.clear(t7)
	rebuildSending()
	rebuildInventory()

	if v25 then
		v25.Text = ""
	end

	if not v10 then
		return
	end

	v10.Text = ""
end

function t.Init(p1) --[[ Init | Line: 1395 ]] end
function t.Start(p1) --[[ Start | Line: 1398 | Upvalues: Networking (copy), t11 (copy), t3 (copy), ProximityPromptService (copy), LocalPlayer (copy), MailboxFlags (copy), NotificationController (copy), GuiController (copy), PlayerGui (copy), v3 (ref), bindChrome (copy), v38 (copy), fetchInbox (copy), v39 (ref), v40 (ref), v36 (ref), t9 (copy), applyMailboxVisuals (copy), v21 (ref), t4 (ref), rebuildReceive (copy), v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), t (copy), updateInfoLabel (copy), clearSession (copy), v31 (ref), v32 (ref), t10 (copy), t7 (copy), rebuildSending (copy), rebuildInventory (copy), v25 (ref), v10 (ref), t5 (ref), discoverLocalMailboxes (copy) ]]
	local v1 = Networking.Pets.PetEquipped.OnClientEvent:Connect(function(p1) --[[ Line: 1399 | Upvalues: t11 (ref) ]]
		if typeof(p1) == "string" then
			t11[p1] = true
		end
	end)

	table.insert(t3, v1)

	local v33 = Networking.Pets.PetUnequipped.OnClientEvent:Connect(function(p1) --[[ Line: 1403 | Upvalues: t11 (ref) ]]
		if typeof(p1) == "string" then
			t11[p1] = nil
		end
	end)

	table.insert(t3, v33)
	task.spawn(function() --[[ Line: 1407 | Upvalues: Networking (ref), t11 (ref) ]]
		local ok, result = pcall(function() --[[ Line: 1408 | Upvalues: Networking (ref) ]]
			return Networking.Pets.GetEquippedPets:Fire()
		end)

		if not ok or typeof(result) ~= "table" then
			return
		end

		for v1, v2 in result do
			if typeof(v2) == "table" and typeof(v2.Id) == "string" then
				t11[v2.Id] = true
			end
		end
	end)

	local v5 = ProximityPromptService.PromptTriggered:Connect(function(p1, p2) --[[ Line: 1420 | Upvalues: LocalPlayer (ref), MailboxFlags (ref), NotificationController (ref), GuiController (ref) ]]
		if p2 ~= LocalPlayer then
			return
		end

		if p1.Name ~= "MailboxPrompt" then
			return
		end

		if not MailboxFlags.OpenEnabled:Get() then
			NotificationController:CreateNotification("The mailbox is temporarily disabled.")

			return
		end

		if GuiController:IsOpen("MailboxUI") then
			return
		end

		GuiController:Open("MailboxUI", nil, { "HUD" })
	end)

	table.insert(t3, v5)
	MailboxFlags.OpenEnabled.Changed:Connect(function(p1) --[[ Line: 1437 | Upvalues: GuiController (ref) ]]
		if p1 then
			return
		end

		if not GuiController:IsOpen("MailboxUI") then
			return
		end

		GuiController:Close()
	end)
	task.spawn(function() --[[ Line: 1444 | Upvalues: PlayerGui (ref), v3 (ref), bindChrome (ref) ]]
		local MailboxUI = PlayerGui:WaitForChild("MailboxUI")

		if MailboxUI:IsA("ScreenGui") then
			v3 = MailboxUI
			bindChrome(MailboxUI)
		end
	end)

	local v7 = GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 1451 | Upvalues: v38 (ref), fetchInbox (ref), v39 (ref), v40 (ref), Networking (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref), t4 (ref), rebuildReceive (ref), v29 (ref), v18 (ref), v15 (ref), v19 (ref), v20 (ref), t (ref), updateInfoLabel (ref) ]]
		if not p1 or p1.Name ~= "MailboxUI" then
			return
		end

		v38()
		task.spawn(fetchInbox)

		if not v39 then
			v40 = v40 + 1

			local v1 = v40
			local v2 = 30
			local v3 = 0
			local v4 = nil

			v39 = task.spawn(function() --[[ Line: 1343 | Upvalues: v40 (ref), v1 (copy), v2 (ref), Networking (ref), v4 (ref), v3 (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref), t4 (ref), rebuildReceive (ref) ]]
				while v40 == v1 do
					task.wait(v2)

					if v40 ~= v1 then
						break
					end

					local ok, result = pcall(function() --[[ Line: 1347 | Upvalues: Networking (ref) ]]
						return Networking.Mailbox.IndexProbe:Fire()
					end)

					if not ok then
						continue
					end

					local v12 = tonumber(result) or 0

					if v4 == nil or v12 ~= v4 then
						v3 = 0
						v2 = 30
						v4 = v12

						local v22 = v12 > 0

						if v36 ~= v22 then
							v36 = v22

							for v32 in t9 do
								if v32.Parent then
									applyMailboxVisuals(v32)

									continue
								end

								t9[v32] = nil
							end

							if v21 then
								v21.Visible = v22
							end
						end

						local ok2, result2 = pcall(function() --[[ Line: 1316 | Upvalues: Networking (ref) ]]
							return Networking.Mailbox.OpenInbox:Fire()
						end)

						if ok2 and typeof(result2) == "table" then
							t4 = result2
							rebuildReceive()
						end

						continue
					end

					v3 = v3 + 1

					if not (v3 >= 5) then
						continue
					end

					v2 = math.min(v2 * 2, 120)
				end
			end)
		end

		v29 = "Send"

		if v18 then
			v18.Visible = false
		end

		if v15 then
			v15.Visible = true
		end

		if v19 then
			v19.Visible = true
		end

		if v20 then
			v20.Visible = false
		end

		t:_resetToPlayerList()
		updateInfoLabel()
	end)

	table.insert(t3, v7)

	local v9 = GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 1457 | Upvalues: clearSession (ref), v40 (ref), v39 (ref), v31 (ref), v32 (ref), t10 (ref), t7 (ref), rebuildSending (ref), rebuildInventory (ref), v25 (ref), v10 (ref) ]]
		if not p1 or p1.Name ~= "MailboxUI" then
			return
		end

		clearSession()
		v40 = v40 + 1
		v39 = nil
		v31 = nil
		v32 = nil
		table.clear(t10)
		table.clear(t7)
		rebuildSending()
		rebuildInventory()

		if v25 then
			v25.Text = ""
		end

		if not v10 then
			return
		end

		v10.Text = ""
	end)

	table.insert(t3, v9)

	local v11 = Networking.Mailbox.Updated.OnClientEvent:Connect(function(p1) --[[ Line: 1463 | Upvalues: t4 (ref), t5 (ref), rebuildReceive (ref), v36 (ref), t9 (ref), applyMailboxVisuals (ref), v21 (ref) ]]
		if typeof(p1) ~= "table" then
			t4 = {}
			t5 = {}
		else
			local v1 = typeof(p1.PendingInvites) == "table"
			local v2 = if typeof(p1.Mailbox) == "table" then true else false
			local v3 = if typeof(p1.Badge) == "number" then true else false

			if v1 then
				t5 = p1.PendingInvites
			end

			if v2 then
				t4 = p1.Mailbox
			elseif v3 then
				local v4 = if p1.Badge > 0 then true else next(t5) ~= nil

				if v36 ~= v4 then
					v36 = v4

					for v5 in t9 do
						if v5.Parent then
							applyMailboxVisuals(v5)

							continue
						end

						t9[v5] = nil
					end

					if v21 then
						v21.Visible = v4
					end
				end

				if not v1 then
					return
				end
			elseif not v1 then
				t4 = p1
			end
		end

		rebuildReceive()
	end)

	table.insert(t3, v11)

	local v13 = Networking.Guild.InvitePrompt.OnClientEvent:Connect(function(p1, p2) --[[ Line: 1519 | Upvalues: t5 (ref), rebuildReceive (ref), NotificationController (ref) ]]
		if typeof(p1) ~= "string" or typeof(p2) ~= "table" then
			return
		end

		local t = {}

		t.GuildId = tostring(p2.GuildId or "")
		t.GuildName = tostring(p2.GuildName or "")
		t.GuildTag = tostring(p2.GuildTag or "")
		t.FromUserId = tonumber(p2.FromUserId) or 0
		t.FromName = tostring(p2.FromName or "")
		t.ExpiresAt = tonumber(p2.ExpiresAt) or 0
		t.ReceivedAt = tonumber(p2.ReceivedAt) or os.time()
		t.MemberCount = tonumber(p2.MemberCount)
		t.MaxSlots = tonumber(p2.MaxSlots)
		t5[p1] = t
		rebuildReceive()
		NotificationController:CreateNotification(string.format("%s has invited you to their guild!", (tostring(p2.FromName or "Someone"))))
	end)

	table.insert(t3, v13)
	task.spawn(function() --[[ Line: 1545 | Upvalues: Networking (ref), t4 (ref), rebuildReceive (ref) ]]
		task.wait(2)

		local ok, result = pcall(function() --[[ Line: 1316 | Upvalues: Networking (ref) ]]
			return Networking.Mailbox.OpenInbox:Fire()
		end)

		if not ok or typeof(result) ~= "table" then
			return
		end

		t4 = result
		rebuildReceive()
	end)
	task.spawn(function() --[[ Line: 1551 | Upvalues: discoverLocalMailboxes (ref) ]]
		discoverLocalMailboxes()
	end)

	local v152 = LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 1554 | Upvalues: discoverLocalMailboxes (ref) ]]
		discoverLocalMailboxes()
	end)

	table.insert(t3, v152)
end

return t