-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local ItemUI = require(ReplicatedStorage.Library.Client.UI.ItemUI)
local BrainrotItem = require(ReplicatedStorage.Library.Items.BrainrotItem)
local Rainbow = require(ReplicatedStorage.Library.Client.GUIFX.Rainbow)
local FormatFigures = require(ReplicatedStorage.Library.Functions.FormatFigures)
local BrainrotEggIconScaleUtil = require(ReplicatedStorage.Library.Util.BrainrotEggIconScaleUtil)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Save = require(ReplicatedStorage.Library.Client.Save)
local v1 = Vector2.new(2.5, 4)
local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.08)
local v3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local Assets = ReplicatedStorage.Assets
local t = {}

t.__index = t

local function computeNormalizedOdds(p1) --[[ computeNormalizedOdds | Line: 56 ]]
	local t = {}

	if not p1 then
		return t
	end

	local sum = 0

	for i, v in ipairs(p1) do
		local v1 = v[2]

		if typeof(v1) == "number" and v1 > 0 then
			sum = sum + v1
		end
	end

	if sum <= 0 then
		return t
	end

	for i, v in ipairs(p1) do
		local v2 = v[1]
		local v3 = v[2]

		if typeof(v2) == "string" and (typeof(v3) == "number" and v3 > 0) then
			t[v2] = v3 / sum
		end
	end

	return t
end

local function clearBrainrotSlots(p1) --[[ clearBrainrotSlots | Line: 87 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("GuiObject") then
			local v1 = v:GetAttribute("_OddsSlot") == true
			local v2 = if v.Name == "BrainrotInfo" then true else false

			if v1 or (v2 or v:FindFirstChild("Chance") and v:FindFirstChild("Holder")) then
				v:Destroy()
			end
		end
	end
end

local function clearGradients(p1) --[[ clearGradients | Line: 101 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("UIGradient") then
			v:Destroy()
		end
	end
end

local function applyRainbowChance(p1) --[[ applyRainbowChance | Line: 109 | Upvalues: Rainbow (copy) ]]
	Rainbow(p1, "TextColor3")
	p1.Text = "??"
end

local function applyChanceLabel(p1, p2) --[[ applyChanceLabel | Line: 114 | Upvalues: Rainbow (copy), FormatFigures (copy) ]]
	if p2 < 0.1 then
		Rainbow(p1, "TextColor3")
		p1.Text = "??"
	else
		local v2 = math.clamp(math.pow(0.9315, p2) * 94.2467 / 100, 0, 1)
		local v3, v4, v5 = Color3.fromRGB(49, 255, 39):Lerp(Color3.fromRGB(255, 75, 39), v2):ToHSV()

		p1.TextColor3 = Color3.fromHSV(v3, v4, v5 * 2)
		p1.Text = ("%*%%"):format((FormatFigures(p2, 3, 5)))
	end
end

local function setBillboardSize(p1, p2, p3) --[[ setBillboardSize | Line: 126 | Upvalues: v1 (copy), TweenService (copy), v2 (copy) ]]
	local v12 = UDim2.fromScale(math.max(p2, 1) * v1.X, v1.Y)

	if p3 then
		p1.Size = UDim2.new()
		TweenService:Create(p1, v2, {
			Size = v12
		}):Play()
	else
		p1.Size = v12
	end

	return v12
end

local function populateOdds(p1, p2, p3, p4) --[[ populateOdds | Line: 141 | Upvalues: Save (copy), clearBrainrotSlots (copy), Assets (copy), Rarities (copy), BrainrotItem (copy), ItemUI (copy), BrainrotEggIconScaleUtil (copy), Simple (copy), applyChanceLabel (copy), clearGradients (copy) ]]
	local v1 = Save.Get()
	local Brainrots = p1.Frame.Brainrots

	clearBrainrotSlots(Brainrots)

	for i, v in ipairs(p2) do
		local v2 = v[1]

		if typeof(v2) == "string" and v2 ~= "" then
			local v3 = (p3[v2] or 0) * 100
			local v4 = Assets.UI.Eggs.BrainrotInfo:Clone()

			v4:SetAttribute("_OddsSlot", true)

			local v5 = if Rarities[v2] then nil else BrainrotItem(v2)

			if v5 then
				local v6 = Assets.UI.Eggs.Brainrot:Clone()
				local v7 = ItemUI.Create(v5, {
					NoActionMenu = true,
					NoOverlay = true,
					NoButtonFX = true,
					HideQuantity = true,
					HideStrength = true
				})
				local Icon = v7:FindFirstChild("Icon")

				if Icon and Icon:IsA("ImageLabel") then
					BrainrotEggIconScaleUtil.ApplyIconScaleToImageLabel(Icon, p4)

					if v1 and v1.Index then
						local v8 = v1.Index[v5:GetId()] ~= nil

						Icon.ImageColor3 = v8 and Color3.new(255/255, 255/255, 255/255) or Color3.new(0/255, 0/255, 0/255)
					end
				end

				v6.LayoutOrder = 9999 - v3 * 20

				local v10 = v5:Directory()

				v6.Weight.Text = Simple.FormatCompact((if v10 then v10.ModelWeight or 0 else 0) * (p4 or 1)) .. "kg"
				applyChanceLabel(v6.Chance, v3)
				v7.Parent = v6
				v6.Parent = v4.Holder
				v4.Chance.Visible = false
				v4.Name = v5:GetId()
			else
				local v12 = Rarities[v2]

				if v12 then
					local v13 = v12.DisplayName or v2
					local RarityHolder = v4:FindFirstChild("RarityHolder")
					local v14 = if RarityHolder then RarityHolder:FindFirstChild("RarityLabel") else nil
					local v15 = if v14 then v14:FindFirstChild("Label") else nil

					v4.Holder.Visible = false

					if RarityHolder and RarityHolder:IsA("GuiObject") then
						RarityHolder.Visible = true
						clearGradients(RarityHolder)

						if v12.Gradient then
							v12.Gradient:Clone().Parent = RarityHolder
						end
					end

					if v14 and v14:IsA("TextLabel") then
						v14.Text = v13
						v14.TextColor3 = v12.Color
					end

					if v15 and v15:IsA("TextLabel") then
						v15.Text = v13
						v15.TextColor3 = v12.Color
					end

					v4.Chance.Visible = true
					applyChanceLabel(v4.Chance, v3)
					v4.Name = v13
				end
			end

			v4.LayoutOrder = 1
			v4.Parent = Brainrots
		end
	end
end

local function stopSizeTween(p1) --[[ stopSizeTween | Line: 231 ]]
	local _sizeTween = p1._sizeTween

	if _sizeTween then
		_sizeTween:Cancel()
		p1._sizeTween = nil
	end

	local _sizeTweenConn = p1._sizeTweenConn

	if not _sizeTweenConn then
		return
	end

	_sizeTweenConn:Disconnect()
	p1._sizeTweenConn = nil
end

local function playShowAnimation(p1, p2) --[[ playShowAnimation | Line: 245 | Upvalues: TweenService (copy), v2 (copy) ]]
	local _sizeTween = p1._sizeTween

	if _sizeTween then
		_sizeTween:Cancel()
		p1._sizeTween = nil
	end

	local _sizeTweenConn = p1._sizeTweenConn

	if _sizeTweenConn then
		_sizeTweenConn:Disconnect()
		p1._sizeTweenConn = nil
	end

	local v1 = p1._targetSize or p2.Size

	if p1._shouldAnimate then
		p2.Enabled = true
		p2.Size = UDim2.new()

		local v22 = TweenService:Create(p2, v2, {
			Size = v1
		})

		p1._sizeTween = v22
		p1._sizeTweenConn = v22.Completed:Connect(function() --[[ Line: 262 | Upvalues: p1 (copy), v22 (copy), p2 (copy), v1 (copy) ]]
			if p1._sizeTween == v22 then
				p1._sizeTween = nil
				p1._sizeTweenConn = nil
				p2.Size = v1
			end
		end)
		v22:Play()
	else
		p2.Enabled = true
		p2.Size = v1
	end
end

local function playHideAnimation(p1, p2) --[[ playHideAnimation | Line: 274 | Upvalues: TweenService (copy), v3 (copy) ]]
	local _sizeTween = p1._sizeTween

	if _sizeTween then
		_sizeTween:Cancel()
		p1._sizeTween = nil
	end

	local _sizeTweenConn = p1._sizeTweenConn

	if _sizeTweenConn then
		_sizeTweenConn:Disconnect()
		p1._sizeTweenConn = nil
	end

	if p1._shouldAnimate then
		local v1 = p1._targetSize or p2.Size

		p2.Enabled = true

		local v2 = TweenService:Create(p2, v3, {
			Size = UDim2.new()
		})

		p1._sizeTween = v2
		p1._sizeTweenConn = v2.Completed:Connect(function() --[[ Line: 291 | Upvalues: p1 (copy), v2 (copy), p2 (copy), v1 (copy) ]]
			if p1._sizeTween ~= v2 then
				return
			end

			p1._sizeTween = nil
			p1._sizeTweenConn = nil

			if p1._visible then
				p2.Size = v1

				return
			end

			p2.Enabled = false
			p2.Size = v1
		end)
		v2:Play()
	else
		p2.Enabled = false
		p2.Size = p1._targetSize or p2.Size
	end
end

local function shouldDestroyBillboard(p1) --[[ shouldDestroyBillboard | Line: 308 ]]
	if not p1 then
		return true
	end

	if p1.dropTable and #p1.dropTable ~= 0 then
		local parent = p1.parent

		return not (parent and parent.Parent)
	end

	return true
end

function t.new(p1) --[[ new | Line: 325 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		_billboard = nil,
		_visible = false,
		_destroyed = false,
		_targetSize = nil,
		_sizeTween = nil,
		_sizeTweenConn = nil,
		_shouldAnimate = true,
		_config = p1
	}, t)

	if p1 then
		v2:Update(p1)
	end

	return v2
end
function t._destroyBillboard(p1) --[[ _destroyBillboard | Line: 344 ]]
	local _billboard = p1._billboard

	if _billboard then
		local _sizeTween = p1._sizeTween

		if _sizeTween then
			_sizeTween:Cancel()
			p1._sizeTween = nil
		end

		local _sizeTweenConn = p1._sizeTweenConn

		if _sizeTweenConn then
			_sizeTweenConn:Disconnect()
			p1._sizeTweenConn = nil
		end

		_billboard:Destroy()
		p1._billboard = nil
	end

	p1._targetSize = nil
end
function t.GetBillboard(p1) --[[ GetBillboard | Line: 354 ]]
	return p1._billboard
end
function t.SetVisible(p1, p2) --[[ SetVisible | Line: 358 | Upvalues: playShowAnimation (copy), playHideAnimation (copy) ]]
	if p1._destroyed then
		return
	end

	if p1._visible == p2 then
		return
	end

	p1._visible = p2

	local _billboard = p1._billboard

	if not _billboard then
		return
	end

	if p2 then
		playShowAnimation(p1, _billboard)
	else
		playHideAnimation(p1, _billboard)
	end
end
function t.Update(p1, p2) --[[ Update | Line: 381 | Upvalues: computeNormalizedOdds (copy), Assets (copy), populateOdds (copy), setBillboardSize (copy) ]]
	if p1._destroyed then
		return
	end

	p1._config = p2

	local v1

	if p2 and (p2.dropTable and #p2.dropTable ~= 0) then
		local parent = p2.parent

		v1 = if parent and parent.Parent then false else true
	else
		v1 = true
	end

	if v1 then
		p1:_destroyBillboard()

		return
	end

	local dropTable = p2.dropTable
	local v2 = p2.normalizedOdds or computeNormalizedOdds(dropTable)
	local _billboard = p1._billboard
	local v3 = if _billboard == nil then true else false

	if not _billboard then
		local v4 = Assets.UI.Eggs.EggInfo:Clone()

		assert(v4, "luau")
		v4.Enabled = p1._visible
		p1._billboard = v4
		_billboard = v4
	end

	assert(_billboard, "luau")

	local _sizeTween = p1._sizeTween

	if _sizeTween then
		_sizeTween:Cancel()
		p1._sizeTween = nil
	end

	local _sizeTweenConn = p1._sizeTweenConn

	if _sizeTweenConn then
		_sizeTweenConn:Disconnect()
		p1._sizeTweenConn = nil
	end

	_billboard.MaxDistance = p2.maxDistance or 75
	_billboard.StudsOffset = p2.studsOffsetWorldSpace or Vector3.new(0, 0, 0)
	_billboard.Frame.Title.Text = p2.title or "Lucky Block"

	local adornee = p2.adornee

	if adornee and adornee.Parent then
		_billboard.Adornee = adornee
	else
		_billboard.Adornee = p2.parent
	end

	_billboard.Parent = p2.parent
	populateOdds(_billboard, dropTable, v2, p2.scale)

	local v5 = if p2.animate == false then false else true

	p1._shouldAnimate = v5
	p1._targetSize = setBillboardSize(_billboard, #dropTable, v3 and v5)
	_billboard.Enabled = p1._visible
end
function t.Destroy(p1) --[[ Destroy | Line: 430 ]]
	if not p1._destroyed then
		p1._destroyed = true
		p1._config = nil
		p1:_destroyBillboard()
	end
end

return t