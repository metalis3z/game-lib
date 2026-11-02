-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = game.Players.LocalPlayer
local v_u_2 = {}
local v_u_3 = {}
local v_u_4 = {}
local v_u_5 = game:GetService("UserInputService")
local v_u_6 = game:GetService("GuiService")
game:GetService("GamepadService")
game:GetService("TweenService")
local v_u_7 = game.Players.LocalPlayer.PlayerGui:WaitForChild("InputContext")
local v_u_8 = v_u_7:WaitForChild("GameplayContext")
local v_u_9 = v_u_7:WaitForChild("EmoteContext")
require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
local v_u_10 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local v_u_11 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local v_u_12 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"))
local v_u_13 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Misc"):WaitForChild("PlayEmote")
local v_u_14 = script.Parent:WaitForChild("EmoteWindow")
local v15 = v_u_14:WaitForChild("EmoteContainer")
v15:WaitForChild("VerticalNavigation")
local v_u_16 = v15:WaitForChild("EmotePages")
local v_u_17 = v_u_16:WaitForChild("Avatar Emotes")
local v_u_18 = v_u_16:WaitForChild("Game Emotes")
local v_u_19 = v_u_14:WaitForChild("EmoteNavigation")
local v_u_20 = { v_u_17, v_u_18 }
local v_u_21 = v_u_16:WaitForChild("Game Emotes"):WaitForChild("Row1"):WaitForChild("EmoteFrame")
local v_u_22 = script:WaitForChild("RowFrame")
local v_u_23 = false
local v_u_24 = nil
local v_u_25 = 8
local v_u_26 = v_u_21.AbsoluteSize.X
local v_u_27 = {
	[v_u_17] = 0,
	[v_u_18] = 0
}
local v_u_28 = 1
TweenInfo.new(0.2, Enum.EasingStyle.Sine)
local function v_u_29()
	-- upvalues: (ref) v_u_23, (copy) v_u_14, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_16, (copy) v_u_7
	v_u_23 = not v_u_23
	v_u_14.Visible = v_u_23
	v_u_9.Enabled = v_u_23
	if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
		if v_u_23 then
			v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
			return
		end
		v_u_6.SelectedObject = nil
		v_u_7.GameplayContext.Emotes:Fire(false)
	end
end
local function v_u_38()
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_12, (ref) v_u_28, (ref) v_u_25, (copy) v_u_21, (copy) v_u_5, (ref) v_u_23, (copy) v_u_14, (copy) v_u_9, (copy) v_u_6, (copy) v_u_16, (copy) v_u_7, (copy) v_u_13, (copy) v_u_18, (copy) v_u_22, (copy) v_u_27
	for _, v_u_30 in v_u_10.Emotes.Owned do
		if not v_u_4[v_u_30] then
			local v31 = v_u_12:GetItemInfo(v_u_30, "Emotes")
			if v31 then
				local v32 = (v_u_28 - 1) / v_u_25
				local v33 = math.floor(v32) + 1
				local v34 = (v_u_28 - 1) % v_u_25 + 1
				local v35 = v_u_21:Clone()
				v35.Name = "Emote" .. v34
				v35:SetAttribute("EmoteName", v_u_30)
				v35.EmoteName.Text = v31.Name or v_u_30
				v35.EmoteIcon.Image = v_u_12:GetItemImage(v31)
				v35.Hotkey.KeyLabel.Text = v34
				v35.Hotkey.Visible = v_u_5.KeyboardEnabled
				v35.LayoutOrder = v_u_28
				v35.PlayButton.Activated:Connect(function()
					-- upvalues: (copy) v_u_30, (ref) v_u_23, (ref) v_u_14, (ref) v_u_9, (ref) v_u_5, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7, (ref) v_u_13
					local v36 = v_u_30
					v_u_23 = false
					v_u_14.Visible = v_u_23
					v_u_9.Enabled = v_u_23
					if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
						if v_u_23 then
							v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
						else
							v_u_6.SelectedObject = nil
							v_u_7.GameplayContext.Emotes:Fire(false)
						end
					end
					v_u_13:Fire(v36)
				end)
				local v37 = v_u_18:FindFirstChild("Row" .. v33)
				if not v37 then
					v37 = v_u_22:Clone()
					v37.Name = "Row" .. v33
					v37.Parent = v_u_18
				end
				v37.LayoutOrder = v33
				v_u_27[v_u_18] = v33
				v35.Parent = v37
				v_u_4[v_u_30] = v35
				v_u_28 = v_u_28 + 1
			end
		end
	end
end
local function v_u_58(p39)
	-- upvalues: (ref) v_u_23, (copy) v_u_14, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_16, (copy) v_u_7, (ref) v_u_24, (copy) v_u_2, (copy) v_u_3, (copy) v_u_17, (ref) v_u_25, (copy) v_u_21, (copy) v_u_22, (copy) v_u_27
	v_u_23 = false
	v_u_14.Visible = v_u_23
	v_u_9.Enabled = v_u_23
	if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
		if v_u_23 then
			v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
		else
			v_u_6.SelectedObject = nil
			v_u_7.GameplayContext.Emotes:Fire(false)
		end
	end
	v_u_24 = p39:WaitForChild("Humanoid")
	local v40 = v_u_24:GetAppliedDescription()
	for v41, v42 in v40:GetEmotes() do
		v_u_2[v41] = {
			["Image"] = ("rbxthumb://type=Asset&w=150&h=150&id=%*"):format(v42[1]),
			["Slot"] = nil
		}
	end
	for _, v43 in v40:GetEquippedEmotes() do
		local v44 = v43.Name
		if not table.find(v_u_3, v44) then
			v_u_2[v44].Slot = v43.Slot
			local v45 = v_u_3
			local v46 = v43.Slot
			table.insert(v45, v46, v44)
		end
	end
	for v47, _ in v_u_2 do
		if not table.find(v_u_3, v47) then
			local v48 = v_u_3
			table.insert(v48, v47)
		end
	end
	for _, v49 in v_u_17:GetChildren() do
		if v49:IsA("Frame") then
			v49:Destroy()
		end
	end
	for v50, v_u_51 in v_u_3 do
		local v52 = (v50 - 1) / v_u_25
		local v53 = math.floor(v52) + 1
		local v54 = (v50 - 1) % v_u_25 + 1
		local v55 = v_u_21:Clone()
		v55.Name = "Emote" .. v54
		v55:SetAttribute("EmoteName", v_u_51)
		v55.EmoteName.Text = v_u_51
		v55.EmoteIcon.Image = v_u_2[v_u_51].Image
		v55.Hotkey.KeyLabel.Text = v54
		v55.Hotkey.Visible = v_u_5.KeyboardEnabled
		v55.LayoutOrder = v54
		v55.PlayButton.Activated:Connect(function()
			-- upvalues: (copy) v_u_51, (ref) v_u_23, (ref) v_u_14, (ref) v_u_9, (ref) v_u_5, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7, (ref) v_u_24
			local v56 = v_u_51
			v_u_23 = false
			v_u_14.Visible = v_u_23
			v_u_9.Enabled = v_u_23
			if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
				if v_u_23 then
					v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
				else
					v_u_6.SelectedObject = nil
					v_u_7.GameplayContext.Emotes:Fire(false)
				end
			end
			v_u_24:PlayEmote(v56)
		end)
		local v57 = v_u_17:FindFirstChild("Row" .. v53)
		if not v57 then
			v57 = v_u_22:Clone()
			v57.Name = "Row" .. v53
			v57.Parent = v_u_17
		end
		v57.LayoutOrder = v53
		v_u_27[v_u_17] = v53
		v55.Parent = v57
		local _ = v50 + 1
	end
end
local function v_u_59()
	-- upvalues: (copy) v_u_19, (copy) v_u_5
	v_u_19:WaitForChild("SwapFrame"):WaitForChild("Container"):WaitForChild("KeycodeLabel").Visible = v_u_5.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
	v_u_19:WaitForChild("Up"):WaitForChild("Container"):WaitForChild("KeycodeLabel").Visible = v_u_5.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
	v_u_19:WaitForChild("Down"):WaitForChild("Container"):WaitForChild("KeycodeLabel").Visible = v_u_5.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
end
(function()
	-- upvalues: (copy) v_u_21, (copy) v_u_16, (ref) v_u_23, (copy) v_u_14, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (ref) v_u_25, (copy) v_u_26, (copy) v_u_18, (copy) v_u_13, (copy) v_u_17, (ref) v_u_24, (copy) v_u_27, (copy) v_u_19, (copy) v_u_20, (copy) v_u_1, (copy) v_u_58, (copy) v_u_8, (copy) v_u_29, (copy) v_u_38, (copy) v_u_11, (copy) v_u_59
	v_u_21.Parent = script
	v_u_16["Game Emotes"].Row1:Destroy()
	v_u_23 = false
	v_u_14.Visible = v_u_23
	v_u_9.Enabled = v_u_23
	if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
		if v_u_23 then
			v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
		else
			v_u_6.SelectedObject = nil
			v_u_7.GameplayContext.Emotes:Fire(false)
		end
	end
	local v60 = v_u_16.AbsoluteSize.X / (v_u_26 + 5)
	local v61 = math.floor(v60)
	v_u_25 = math.clamp(v61, 0, 8)
	for _, v62 in v_u_9:GetChildren() do
		local v63 = v62.Name
		if string.sub(v63, 1, 5) == "Emote" then
			local v64 = v62.Name
			local v65 = string.sub(v64, 6)
			local v_u_66 = tonumber(v65)
			v62.Pressed:Connect(function()
				-- upvalues: (ref) v_u_16, (copy) v_u_66, (ref) v_u_18, (ref) v_u_23, (ref) v_u_14, (ref) v_u_9, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_13, (ref) v_u_17, (ref) v_u_24
				local v67 = v_u_16.UIPageLayout.CurrentPage
				local v68 = v67.UIPageLayout.CurrentPage["Emote" .. v_u_66]:GetAttribute("EmoteName")
				if v67 == v_u_18 then
					v_u_23 = false
					v_u_14.Visible = v_u_23
					v_u_9.Enabled = v_u_23
					if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
						if v_u_23 then
							v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
						else
							v_u_6.SelectedObject = nil
							v_u_7.GameplayContext.Emotes:Fire(false)
						end
					end
					v_u_13:Fire(v68)
				elseif v67 == v_u_17 then
					v_u_23 = false
					v_u_14.Visible = v_u_23
					v_u_9.Enabled = v_u_23
					if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
						if v_u_23 then
							v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
						else
							v_u_6.SelectedObject = nil
							v_u_7.GameplayContext.Emotes:Fire(false)
						end
					end
					v_u_24:PlayEmote(v68)
				end
			end)
		end
	end
	local function bindButton(button, func)
		if button.Pressed then
			button.Pressed:Connect(func)
		end
		if button:IsA("GuiButton") then
			button.Activated:Connect(func)
		end
	end

	local scrollRight = v_u_9:WaitForChild("ScrollRight")
	local function doScrollRight()
		v_u_16.UIPageLayout:Next()
		local currentPage = v_u_16.UIPageLayout.CurrentPage
		local innerPage = currentPage.UIPageLayout.CurrentPage
		local name = currentPage.Name
		local pageNum = innerPage.LayoutOrder
		local total = v_u_27[currentPage]
		v_u_19.Title.TextLabel.Text = ("%s (%d/%d)"):format(name, pageNum, total)
	end
	bindButton(scrollRight, doScrollRight)

	local scrollLeft = v_u_9:WaitForChild("ScrollLeft")
	local function doScrollLeft()
		v_u_16.UIPageLayout:Previous()
		local currentPage = v_u_16.UIPageLayout.CurrentPage
		local innerPage = currentPage.UIPageLayout.CurrentPage
		local name = currentPage.Name
		local pageNum = innerPage.LayoutOrder
		local total = v_u_27[currentPage]
		v_u_19.Title.TextLabel.Text = ("%s (%d/%d)"):format(name, pageNum, total)
	end
	bindButton(scrollLeft, doScrollLeft)

	local scrollUp = v_u_9:WaitForChild("ScrollUp")
	local function doScrollUp()
		v_u_16.UIPageLayout.CurrentPage.UIPageLayout:Previous()
		local currentPage = v_u_16.UIPageLayout.CurrentPage
		local innerPage = currentPage.UIPageLayout.CurrentPage
		local name = currentPage.Name
		local pageNum = innerPage.LayoutOrder
		local total = v_u_27[currentPage]
		v_u_19.Title.TextLabel.Text = ("%s (%d/%d)"):format(name, pageNum, total)
	end
	bindButton(scrollUp, doScrollUp)

	local scrollDown = v_u_9:WaitForChild("ScrollDown")
	local function doScrollDown()
		v_u_16.UIPageLayout.CurrentPage.UIPageLayout:Next()
		local currentPage = v_u_16.UIPageLayout.CurrentPage
		local innerPage = currentPage.UIPageLayout.CurrentPage
		local name = currentPage.Name
		local pageNum = innerPage.LayoutOrder
		local total = v_u_27[currentPage]
		v_u_19.Title.TextLabel.Text = ("%s (%d/%d)"):format(name, pageNum, total)
	end
	bindButton(scrollDown, doScrollDown)

	local cancelButton = v_u_9:WaitForChild("Cancel")
	local function doCancel()
		v_u_23 = false
		v_u_14.Visible = v_u_23
		v_u_9.Enabled = v_u_23
		if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
			if v_u_23 then
				v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
			else
				v_u_6.SelectedObject = nil
				v_u_7.GameplayContext.Emotes:Fire(false)
			end
		end
	end
	bindButton(cancelButton, doCancel)
	local nav = script.Parent.EmoteWindow.EmoteNavigation
	local function doSwapFrame()
		local current = v_u_16.UIPageLayout.CurrentPage
		if current == v_u_17 then
			v_u_16.UIPageLayout:Next()
		else
			v_u_16.UIPageLayout:Previous()
		end
		local newOuter = v_u_16.UIPageLayout.CurrentPage
		local newInner = newOuter.UIPageLayout.CurrentPage
		local name = newOuter.Name
		local pageNum = newInner.LayoutOrder or 1
		local total = v_u_27[newOuter] or 1
		v_u_19.Title.TextLabel.Text = ("%s (%d/%d)"):format(name, pageNum, total)
		if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
			pcall(function()
				v_u_6:Select(newOuter.UIPageLayout.CurrentPage)
			end)
		end
	end

	nav.Up.ImageButton.Activated:Connect(doScrollUp)
	nav.Down.ImageButton.Activated:Connect(doScrollDown)
	nav.SwapFrame.ImageButton.Activated:Connect(doSwapFrame)
	for _, v_u_89 in v_u_20 do
		v_u_89.InputChanged:Connect(function(p90)
			-- upvalues: (copy) v_u_89
			if p90.UserInputType == Enum.UserInputType.MouseWheel then
				if p90.Position.Z > 0 then
					v_u_89.UIPageLayout:Previous()
					return
				end
				v_u_89.UIPageLayout:Next()
			end
		end)
	end
	repeat
		task.wait()
	until v_u_1.Character ~= nil
	v_u_58(v_u_1.Character)
	v_u_1.CharacterAdded:Connect(v_u_58)
	v_u_8:WaitForChild("Emotes").Pressed:Connect(v_u_29)
	local sOption = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GameTopbar"):WaitForChild("Container"):WaitForChild("Emotes"):WaitForChild("Container"):WaitForChild("Button")
	sOption.Activated:Connect(v_u_29)
	v_u_38()
	v_u_11:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function(p91, _, _)
		-- upvalues: (ref) v_u_38
		if p91 == "Emotes" or p91 == "Toys" then
			v_u_38()
		end
	end)
	if v_u_6:IsTenFootInterface() then
		v_u_14.Position = UDim2.new(0.5, 0, 1, -100)
		v_u_14.UIScale.Scale = 1.33
	end
	v_u_59()
	v_u_5:GetPropertyChangedSignal("PreferredInput"):Connect(v_u_59)
	v_u_9:WaitForChild("Cancel").Pressed:Connect(function()
		-- upvalues: (ref) v_u_23, (ref) v_u_14, (ref) v_u_9, (ref) v_u_5, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7
		v_u_23 = false
		v_u_14.Visible = v_u_23
		v_u_9.Enabled = v_u_23
		if v_u_5.PreferredInput == Enum.PreferredInput.Gamepad then
			if v_u_23 then
				v_u_6:Select(v_u_16.UIPageLayout.CurrentPage.UIPageLayout.CurrentPage)
				return
			end
			v_u_6.SelectedObject = nil
			v_u_7.GameplayContext.Emotes:Fire(false)
		end
	end)
	v_u_19:WaitForChild("Title"):WaitForChild("TextLabel").Text = v_u_16:WaitForChild("UIPageLayout").CurrentPage.Name
	local v92 = v_u_16.UIPageLayout.CurrentPage
	local v93 = v92.UIPageLayout.CurrentPage
	local v94 = v92.Name
	local v95 = v93.LayoutOrder
	local v96 = v_u_27[v92]
	v_u_19.Title.TextLabel.Text = ("%* (%*/%*)"):format(v94, v95, v96)
end)()
