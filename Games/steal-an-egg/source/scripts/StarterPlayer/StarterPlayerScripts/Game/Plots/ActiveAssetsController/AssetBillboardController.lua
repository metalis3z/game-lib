-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Library.Types.AssetItem)

local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t

local function isHiddenByDefault(p1, p2) --[[ isHiddenByDefault | Line: 45 ]]
	local v1 = p1

	while v1 ~= nil and v1 ~= p2 do
		if v1:IsA("GuiObject") and not v1.Visible then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function addChannel(p1, p2, p3) --[[ addChannel | Line: 57 ]]
	if not (p2 >= 1) then
		table.insert(p1, {
			Original = p2,
			Apply = p3
		})
	end
end

local function addTextLabelChannels(p1, p2) --[[ addTextLabelChannels | Line: 67 ]]
	local TextTransparency = p2.TextTransparency

	local function f1(p1) --[[ Line: 68 | Upvalues: p2 (copy) ]]
		p2.TextTransparency = p1
	end

	if not (TextTransparency >= 1) then
		table.insert(p1, {
			Original = TextTransparency,
			Apply = f1
		})
	end

	local TextStrokeTransparency = p2.TextStrokeTransparency

	local function f2(p1) --[[ Line: 71 | Upvalues: p2 (copy) ]]
		p2.TextStrokeTransparency = p1
	end

	if not (TextStrokeTransparency >= 1) then
		table.insert(p1, {
			Original = TextStrokeTransparency,
			Apply = f2
		})
	end
end

local function addTextButtonChannels(p1, p2) --[[ addTextButtonChannels | Line: 76 ]]
	local TextTransparency = p2.TextTransparency

	local function f1(p1) --[[ Line: 77 | Upvalues: p2 (copy) ]]
		p2.TextTransparency = p1
	end

	if not (TextTransparency >= 1) then
		table.insert(p1, {
			Original = TextTransparency,
			Apply = f1
		})
	end

	local TextStrokeTransparency = p2.TextStrokeTransparency

	local function f2(p1) --[[ Line: 80 | Upvalues: p2 (copy) ]]
		p2.TextStrokeTransparency = p1
	end

	if not (TextStrokeTransparency >= 1) then
		table.insert(p1, {
			Original = TextStrokeTransparency,
			Apply = f2
		})
	end
end

local function addTextBoxChannels(p1, p2) --[[ addTextBoxChannels | Line: 85 ]]
	local TextTransparency = p2.TextTransparency

	local function f1(p1) --[[ Line: 86 | Upvalues: p2 (copy) ]]
		p2.TextTransparency = p1
	end

	if not (TextTransparency >= 1) then
		table.insert(p1, {
			Original = TextTransparency,
			Apply = f1
		})
	end

	local TextStrokeTransparency = p2.TextStrokeTransparency

	local function f2(p1) --[[ Line: 89 | Upvalues: p2 (copy) ]]
		p2.TextStrokeTransparency = p1
	end

	if not (TextStrokeTransparency >= 1) then
		table.insert(p1, {
			Original = TextStrokeTransparency,
			Apply = f2
		})
	end
end

local function addImageLabelChannel(p1, p2) --[[ addImageLabelChannel | Line: 94 ]]
	local ImageTransparency = p2.ImageTransparency

	local function f1(p13) --[[ Line: 95 | Upvalues: p2 (copy) ]]
		p2.ImageTransparency = p13
	end

	if not (ImageTransparency >= 1) then
		table.insert(p1, {
			Original = ImageTransparency,
			Apply = f1
		})
	end
end

local function addImageButtonChannel(p1, p2) --[[ addImageButtonChannel | Line: 100 ]]
	local ImageTransparency = p2.ImageTransparency

	local function f1(p13) --[[ Line: 101 | Upvalues: p2 (copy) ]]
		p2.ImageTransparency = p13
	end

	if not (ImageTransparency >= 1) then
		table.insert(p1, {
			Original = ImageTransparency,
			Apply = f1
		})
	end
end

local function captureFadeChannels(p1) --[[ captureFadeChannels | Line: 106 | Upvalues: isHiddenByDefault (copy), addTextLabelChannels (copy), addTextButtonChannels (copy), addTextBoxChannels (copy) ]]
	local t = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if not isHiddenByDefault(v, p1) then
			if v:IsA("GuiObject") then
				local BackgroundTransparency = v.BackgroundTransparency

				local function f1(p1) --[[ Line: 114 | Upvalues: v (copy) ]]
					v.BackgroundTransparency = p1
				end

				if not (BackgroundTransparency >= 1) then
					table.insert(t, {
						Original = BackgroundTransparency,
						Apply = f1
					})
				end

				if v:IsA("TextLabel") then
					addTextLabelChannels(t, v)
				elseif v:IsA("TextButton") then
					addTextButtonChannels(t, v)
				elseif v:IsA("TextBox") then
					addTextBoxChannels(t, v)
				elseif v:IsA("ImageLabel") then
					local ImageTransparency = v.ImageTransparency

					local function f2(p13) --[[ Line: 95 | Upvalues: v (copy) ]]
						v.ImageTransparency = p13
					end

					if not (ImageTransparency >= 1) then
						table.insert(t, {
							Original = ImageTransparency,
							Apply = f2
						})
					end
				elseif v:IsA("ImageButton") then
					local ImageTransparency = v.ImageTransparency

					local function f3(p13) --[[ Line: 101 | Upvalues: v (copy) ]]
						v.ImageTransparency = p13
					end

					if not (ImageTransparency >= 1) then
						table.insert(t, {
							Original = ImageTransparency,
							Apply = f3
						})
					end
				end

				if v:IsA("CanvasGroup") then
					local GroupTransparency = v.GroupTransparency

					local function f4(p1) --[[ Line: 132 | Upvalues: v (copy) ]]
						v.GroupTransparency = p1
					end

					if not (GroupTransparency >= 1) then
						table.insert(t, {
							Original = GroupTransparency,
							Apply = f4
						})
					end
				end

				continue
			end

			if v:IsA("UIStroke") then
				local Transparency = v.Transparency

				local function f5(p1) --[[ Line: 138 | Upvalues: v (copy) ]]
					v.Transparency = p1
				end

				if not (Transparency >= 1) then
					table.insert(t, {
						Original = Transparency,
						Apply = f5
					})
				end
			end
		end
	end

	return t
end

local function resolveTransparency(p1, p2) --[[ resolveTransparency | Line: 147 ]]
	return 1 - p2 * (1 - p1)
end

local function applyFadeAlpha(p1) --[[ applyFadeAlpha | Line: 151 ]]
	for i, v in ipairs(p1.Channels) do
		v.Apply(1 - p1.Alpha * (1 - v.Original))
	end
end

local function applyEntryTargetVisible(p1) --[[ applyEntryTargetVisible | Line: 158 ]]
	local v1 = p1.RangeVisible and (if p1.SuppressCount <= 0 then true else false)

	p1.TargetVisible = v1

	if not v1 then
		return
	end

	p1.Billboard.Enabled = true
end

local function setEntryRangeVisible(p1, p2) --[[ setEntryRangeVisible | Line: 166 ]]
	p1.RangeVisible = p2

	local v1 = p1.RangeVisible and (if p1.SuppressCount <= 0 then true else false)

	p1.TargetVisible = v1

	if not v1 then
		return
	end

	p1.Billboard.Enabled = true
end

local function stepEntryFade(p1, p2) --[[ stepEntryFade | Line: 171 | Upvalues: applyFadeAlpha (copy) ]]
	local v1 = if p1.TargetVisible then 1 else 0

	if p1.Alpha ~= v1 then
		local v2 = p2 / 0.2

		if p1.Alpha < v1 then
			p1.Alpha = math.min(p1.Alpha + v2, v1)
		else
			p1.Alpha = math.max(p1.Alpha - v2, v1)
		end

		applyFadeAlpha(p1)
	end

	if p1.TargetVisible then
		p1.Billboard.Enabled = true

		return
	end

	if not (p1.Alpha <= 0) then
		return
	end

	p1.Billboard.Enabled = false
end

function t.new() --[[ new | Line: 194 | Upvalues: t (copy), Trove (copy), RunService (copy), Players (copy), ItemDisplay (copy), stepEntryFade (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._entries = {}
	v2._elapsed = 0
	v2._trove:Add(RunService.Heartbeat:Connect(function(p1) --[[ Line: 199 | Upvalues: v2 (copy), Players (ref), ItemDisplay (ref), stepEntryFade (ref) ]]
		local v1 = v2

		v1._elapsed = v1._elapsed + p1

		local v22 = v2._elapsed >= 0.15

		if v22 then
			v2._elapsed = 0
		end

		local Character = Players.LocalPlayer.Character
		local v3 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
		local v4 = if v3 == nil or not v3:IsA("BasePart") then nil else v3

		for k, v in pairs(v2._entries) do
			if v22 then
				local PrimaryPart = k.PrimaryPart

				if PrimaryPart == nil or (k.Parent == nil or v4 == nil) then
					v.RangeVisible = false

					local v5 = v.RangeVisible and (if v.SuppressCount <= 0 then true else false)

					v.TargetVisible = v5

					if v5 then
						v.Billboard.Enabled = true
					end
				else
					local v6 = PrimaryPart.Position - v4.Position

					v.RangeVisible = Vector2.new(v6.X, v6.Z).Magnitude <= ItemDisplay.GetDataBillboardMaxDistance()

					local v8 = v.RangeVisible and (if v.SuppressCount <= 0 then true else false)

					v.TargetVisible = v8

					if v8 then
						v.Billboard.Enabled = true
					end
				end
			end

			stepEntryFade(v, p1)
		end
	end))

	return v2
end
function t.Add(p1, p2, p3, p4) --[[ Add | Line: 233 | Upvalues: ItemDisplay (copy), captureFadeChannels (copy), applyFadeAlpha (copy) ]]
	local v1 = ItemDisplay.CreateDataBillboard(p2, p3.Category, p3, p4)

	assert(if v1 == nil then false else true, (("Asset model %* must expose CENTER for its data billboard"):format(p2.Name)))
	v1.MaxDistance = 100000

	local t = {
		Alpha = 0,
		RangeVisible = false,
		SuppressCount = 0,
		TargetVisible = false,
		Model = p2,
		Billboard = v1,
		Channels = captureFadeChannels(v1)
	}

	applyFadeAlpha(t)
	v1.Enabled = false
	p1._entries[p2] = t
end
function t.UpdateMoneyPerSecond(p1, p2, p3) --[[ UpdateMoneyPerSecond | Line: 256 | Upvalues: ItemDisplay (copy) ]]
	local v1 = p1._entries[p2]

	assert(if v1 == nil then false else true, (("Asset model %* must have a data billboard before its MPS can update"):format(p2.Name)))
	ItemDisplay.SetDataBillboardMoneyPerSecond(v1.Billboard, p3)
end
function t.SetSuppressed(p1, p2, p3) --[[ SetSuppressed | Line: 266 ]]
	local v1 = p1._entries[p2]

	if v1 == nil then
		return
	end

	if p3 then
		v1.SuppressCount = v1.SuppressCount + 1
	elseif v1.SuppressCount > 0 then
		v1.SuppressCount = v1.SuppressCount - 1
	end

	local v2 = v1.RangeVisible and (if v1.SuppressCount <= 0 then true else false)

	v1.TargetVisible = v2

	if not v2 then
		return
	end

	v1.Billboard.Enabled = true
end
function t.Remove(p1, p2) --[[ Remove | Line: 280 ]]
	local v1 = p1._entries[p2]

	if v1 == nil then
		return
	end

	v1.Billboard:Destroy()
	p1._entries[p2] = nil
end
function t.Destroy(p1) --[[ Destroy | Line: 288 ]]
	for k in pairs(p1._entries) do
		p1:Remove(k)
	end

	p1._trove:Destroy()
end

return t