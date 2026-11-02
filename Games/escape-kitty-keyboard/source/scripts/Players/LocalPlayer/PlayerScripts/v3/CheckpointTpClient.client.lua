-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("MarketplaceService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = game:GetService("SoundService")
local u6 = game:GetService("Debris")
local u7 = require(v4:WaitForChild("Config"))
local u8 = require(v4:WaitForChild("NotificationSystem"))
local u9 = require(v4:WaitForChild("ClientState"))
local u10 = v1.LocalPlayer
local u11 = u10:WaitForChild("PlayerGui")
local v12 = v4:WaitForChild("Remotes")
local u13 = v12:WaitForChild("RequestCheckpointTp")
local v14 = v12:WaitForChild("PromptCheckpointProduct")
local v15 = v12:WaitForChild("CheckpointTpSuccess")
local u16 = Color3.fromRGB(255, 80, 80)
local u17 = {}
for _, v18 in ipairs(u7.CHECKPOINTS) do
	if v18.RobuxProductId and v18.RobuxProductId ~= 0 then
		u17[v18.RobuxProductId] = true
	end
end
for _, v19 in ipairs(u7.SkipCheckpoints) do
	if v19.RobuxProductId and v19.RobuxProductId ~= 0 then
		u17[v19.RobuxProductId] = true
	end
end
for u20 = 1, #u7.CHECKPOINTS do
	local v21 = "ButtonTpCheckpoint" .. u20
	local function v23(p22) -- name: setupButton
		-- upvalues: (copy) u13, (copy) u20
		if p22:IsA("GuiButton") then
			p22.MouseButton1Click:Connect(function()
				-- upvalues: (ref) u13, (ref) u20
				u13:FireServer(u20, "wins")
			end)
		end
	end
	for _, v24 in ipairs(u2:GetTagged(v21)) do
		if v24:IsA("GuiButton") then
			v24.MouseButton1Click:Connect(function()
				-- upvalues: (copy) u13, (copy) u20
				u13:FireServer(u20, "wins")
			end)
		end
	end
	u2:GetInstanceAddedSignal(v21):Connect(v23)
end
for u25 = 1, #u7.CHECKPOINTS do
	local v26 = "DevButtonTpCheckpoint" .. u25
	local function v28(p27) -- name: setupDevButton
		-- upvalues: (copy) u13, (copy) u25
		if p27:IsA("GuiButton") then
			p27.MouseButton1Click:Connect(function()
				-- upvalues: (ref) u13, (ref) u25
				u13:FireServer(u25, "robux")
			end)
		end
	end
	for _, v29 in ipairs(u2:GetTagged(v26)) do
		if v29:IsA("GuiButton") then
			v29.MouseButton1Click:Connect(function()
				-- upvalues: (copy) u13, (copy) u25
				u13:FireServer(u25, "robux")
			end)
		end
	end
	u2:GetInstanceAddedSignal(v26):Connect(v28)
end
v14.OnClientEvent:Connect(function(p30, _)
	-- upvalues: (copy) u8, (copy) u16
	if p30 == 0 then
		u8:ShowMessage("Purchase error", u16)
	end
end)
v3.PromptProductPurchaseFinished:Connect(function(p31, p32, p33)
	-- upvalues: (copy) u10, (copy) u17, (copy) u8, (copy) u16
	if p31 == u10.UserId then
		if not p33 and u17[p32] then
			u8:ShowMessage("Purchase error", u16)
		end
	end
end)
local function u36(p34) -- name: getModalByTag
	-- upvalues: (copy) u2, (copy) u11
	for _, v35 in ipairs(u2:GetTagged(p34)) do
		if v35:IsDescendantOf(u11) then
			return v35
		end
	end
end
v15.OnClientEvent:Connect(function()
	-- upvalues: (copy) u36, (copy) u9, (copy) u7, (copy) u5, (copy) u6
	local v37 = u36("CheckpointModal")
	if v37 and u9.ActiveModal == v37 then
		u9:CloseCurrentModal()
	end
	local v38 = u7.SOUNDS.BUY
	local v39 = Instance.new("Sound")
	v39.SoundId = v38.ID
	v39.Volume = v38.Volume
	v39.Parent = u5
	v39:Play()
	u6:AddItem(v39, 5)
end)