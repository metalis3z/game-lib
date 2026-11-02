-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = require(v2:WaitForChild("ClientState"))
local v5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v6 = v2:WaitForChild("BonusUpdate")
local u7 = { "XP", "Wins" }
local u8 = {
	["XP"] = {
		["icon"] = "\226\154\161",
		["label"] = "XP",
		["color"] = Color3.fromRGB(100, 200, 255)
	},
	["Wins"] = {
		["icon"] = "\240\159\143\134",
		["label"] = "Wins",
		["color"] = Color3.fromRGB(255, 215, 0)
	}
}
local v9 = Instance.new("ScreenGui")
v9.Name = "BonusDisplayGUI"
v9.ResetOnSpawn = false
v9.DisplayOrder = 50
v9.Parent = v5
local u10 = Instance.new("Frame", v9)
u10.Name = "BonusContainer"
u10.Size = UDim2.new(0.15, 0, 0.12, 0)
u10.Position = UDim2.new(1, -15, 1, -15)
u10.AnchorPoint = Vector2.new(1, 1)
u10.BackgroundTransparency = 1
u10.BorderSizePixel = 0
local v11 = Instance.new("UIListLayout", u10)
v11.Padding = UDim.new(0, 6)
v11.HorizontalAlignment = Enum.HorizontalAlignment.Right
v11.VerticalAlignment = Enum.VerticalAlignment.Bottom
v11.SortOrder = Enum.SortOrder.Name
local u12 = {}
local u13 = {}
local u14 = false
local function u21(p15) -- name: formatTime
	if p15 <= 0 then
		return "0:00"
	else
		local v16 = p15 / 3600
		local v17 = math.floor(v16)
		local v18 = p15 % 3600 / 60
		local v19 = math.floor(v18)
		local v20 = p15 % 60
		if v17 > 0 then
			return string.format("%d:%02d:%02d", v17, v19, v20)
		else
			return string.format("%d:%02d", v19, v20)
		end
	end
end
local function u28(p22) -- name: createBonusLabel
	-- upvalues: (copy) u8, (copy) u10, (copy) u3
	local v23 = u8[p22]
	if not v23 then
		return nil
	end
	local v24 = Instance.new("Frame")
	v24.Name = "Bonus_" .. p22
	v24.Size = UDim2.new(1, 0, 0.45, 0)
	v24.BackgroundTransparency = 1
	v24.BorderSizePixel = 0
	v24.Parent = u10
	local v25 = Instance.new("TextLabel", v24)
	v25.Name = "BonusText"
	v25.Size = UDim2.new(1, -16, 1, 0)
	v25.Position = UDim2.new(0, 8, 0, 0)
	v25.BackgroundTransparency = 1
	v25.Text = ""
	v25.TextColor3 = v23.color
	v25.TextScaled = true
	v25.Font = Enum.Font.GothamBold
	v25.TextXAlignment = Enum.TextXAlignment.Right
	Instance.new("UITextSizeConstraint", v25).MaxTextSize = 20
	local v26 = Instance.new("UIStroke", v25)
	v26.Thickness = 2
	v26.Color = Color3.fromRGB(0, 0, 0)
	local v27 = Instance.new("UIScale", v24)
	v27.Scale = 0
	u3:Create(v27, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		["Scale"] = 1
	}):Play()
	return v24
end
local function u32(p29) -- name: removeBonusLabel
	-- upvalues: (copy) u13, (copy) u3
	local u30 = u13[p29]
	if u30 then
		local v31 = u30:FindFirstChildOfClass("UIScale")
		if v31 then
			u3:Create(v31, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Scale"] = 0
			}):Play()
			task.delay(0.35, function()
				-- upvalues: (copy) u30
				if u30 and u30.Parent then
					u30:Destroy()
				end
			end)
		else
			u30:Destroy()
		end
		u13[p29] = nil
	end
end
local function u40() -- name: updateDisplay
	-- upvalues: (copy) u7, (copy) u12, (copy) u8, (copy) u13, (copy) u28, (copy) u21, (copy) u32
	local v33 = os.time()
	for _, v34 in ipairs(u7) do
		local v35 = u12[v34]
		local v36 = u8[v34]
		if v35 and v33 < v35.endTime then
			if not (u13[v34] and u13[v34].Parent) then
				u13[v34] = u28(v34)
			end
			local v37 = v35.endTime - v33
			local v38 = u13[v34]
			if v38 then
				local v39 = v38:FindFirstChild("BonusText")
				if v39 then
					v39.Text = v36.icon .. " " .. v36.label .. " x" .. v35.mult .. "  " .. u21(v37)
				end
			end
		else
			if u13[v34] then
				u32(v34)
			end
			u12[v34] = nil
		end
	end
end
local function u44() -- name: syncClientState
	-- upvalues: (copy) u12, (copy) u4
	local v41 = os.time()
	local v42 = u12.XP
	local v43 = u12.Wins
	u4:Update({
		["BonusXPMultiplier"] = v42 and v41 < v42.endTime and (v42.mult or 1) or 1,
		["BonusWinsMultiplier"] = v43 and (v41 < v43.endTime and v43.mult) or 1
	})
end
v6.OnClientEvent:Connect(function(p45)
	-- upvalues: (copy) u7, (copy) u12, (copy) u32, (copy) u44, (copy) u40, (ref) u14
	if type(p45) == "table" then
		for _, v46 in ipairs(u7) do
			if p45[v46] then
				local v47 = p45[v46]
				u12[v46] = {
					["mult"] = v47.mult,
					["endTime"] = os.time() + (v47.remaining or 0)
				}
			elseif u12[v46] then
				u12[v46] = nil
				u32(v46)
			end
		end
		u44()
		u40()
		if not u14 then
			u14 = true
			task.spawn(function()
				-- upvalues: (ref) u12, (ref) u40, (ref) u44, (ref) u14
				-- failed to decompile
			end)
		end
	else
		return
	end
end)