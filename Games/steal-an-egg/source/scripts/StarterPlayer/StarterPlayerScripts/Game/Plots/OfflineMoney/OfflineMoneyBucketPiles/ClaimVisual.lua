-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local MoneyPiles = require(script.Parent.MoneyPiles)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "OfflineMoneyClaimVisual"

local v1 = Color3.new(255/255, 255/255, 255/255)
local Assets = ReplicatedStorage.Assets
local ClaimArea = Assets.Models.ClaimArea

assert(ClaimArea:IsA("BasePart"), "ReplicatedStorage.Assets.Models.ClaimArea must be a BasePart")

local OfflineCash = Assets.Billboards.OfflineCash

assert(OfflineCash:IsA("BillboardGui"), "ReplicatedStorage.Assets.Billboards.OfflineCash must be a BillboardGui")
function t.new(p1, p2, p3) --[[ new | Line: 58 | Upvalues: Asserts (copy), t (copy), Trove (copy), ClaimArea (copy), MoneyPiles (copy), OfflineCash (copy) ]]
	Asserts.finiteNonNegative(p1)
	Asserts.BasePart(p2)
	Asserts.Instance(p3)

	local v2 = setmetatable({}, t)
	local v3 = Trove.new()
	local LocalOfflineMoneyClaim = Instance.new("Model")

	LocalOfflineMoneyClaim.Name = "LocalOfflineMoneyClaim"
	LocalOfflineMoneyClaim.Parent = p3

	local OfflineMoneyClaimArea = ClaimArea:Clone()

	OfflineMoneyClaimArea.Name = "OfflineMoneyClaimArea"
	OfflineMoneyClaimArea.CFrame = p2.CFrame + Vector3.new(0, 0.2, 0)
	OfflineMoneyClaimArea.Anchored = true
	OfflineMoneyClaimArea.CanCollide = false
	OfflineMoneyClaimArea.CanTouch = false
	OfflineMoneyClaimArea.CanQuery = false
	OfflineMoneyClaimArea.Parent = LocalOfflineMoneyClaim

	local v4 = MoneyPiles.new(OfflineMoneyClaimArea, LocalOfflineMoneyClaim)
	local OfflineMoneyClaimBillboard = OfflineCash:Clone()

	OfflineMoneyClaimBillboard.Name = "OfflineMoneyClaimBillboard"
	OfflineMoneyClaimBillboard.AlwaysOnTop = true
	OfflineMoneyClaimBillboard.Parent = OfflineMoneyClaimArea
	OfflineMoneyClaimBillboard.Enabled = true

	local Money = OfflineMoneyClaimBillboard.Money

	assert(if Money then Money:IsA("TextLabel") else Money, "OfflineCash.Money must be a TextLabel")
	v2._trove = v3
	v2._amount = p1
	v2._rootModel = LocalOfflineMoneyClaim
	v2._claimArea = OfflineMoneyClaimArea
	v2._generatedMoney = v4
	v2._billboard = OfflineMoneyClaimBillboard
	v2._billboardBaseSize = OfflineMoneyClaimBillboard.Size
	v2._billboardPulseTween = nil
	v2._billboardTextBlinkTween = nil
	v2._billboardPulseActive = false
	v2._moneyLabel = Money
	v2._moneyLabelBaseTextColor = v2._moneyLabel.TextColor3
	v3:Add(LocalOfflineMoneyClaim)
	v3:Add(function() --[[ Line: 102 | Upvalues: v4 (copy) ]]
		v4:Destroy()
	end)
	v3:Add(v4.BillboardAdorneeChanged:Connect(function() --[[ Line: 105 | Upvalues: v2 (copy) ]]
		v2:_syncBillboardAdornee()
	end))
	v2:Update(p1, p2)

	return v2
end
function t._formatMoney(p1) --[[ _formatMoney | Line: 118 | Upvalues: Simple (copy) ]]
	return "$" .. Simple.FormatCompact(math.max(p1, 0), "precision-integer")
end
function t._scaleBillboardSize(p1, p2) --[[ _scaleBillboardSize | Line: 122 ]]
	return UDim2.new(p1.X.Scale * p2, math.round(p1.X.Offset * p2), p1.Y.Scale * p2, (math.round(p1.Y.Offset * p2)))
end
function t._stopBillboardPulse(p1) --[[ _stopBillboardPulse | Line: 131 ]]
	p1._billboardPulseActive = false

	local _billboardPulseTween = p1._billboardPulseTween

	if _billboardPulseTween then
		_billboardPulseTween:Cancel()
		p1._billboardPulseTween = nil
	end

	local _billboardTextBlinkTween = p1._billboardTextBlinkTween

	if _billboardTextBlinkTween then
		_billboardTextBlinkTween:Cancel()
		p1._billboardTextBlinkTween = nil
	end

	p1._billboard.Size = p1._billboardBaseSize
	p1._moneyLabel.TextColor3 = p1._moneyLabelBaseTextColor
end
function t._syncBillboardPulse(p1) --[[ _syncBillboardPulse | Line: 148 | Upvalues: TweenService (copy), t (copy), v1 (copy) ]]
	if not (p1._billboard.Enabled and (if p1._amount > 0 then true else false)) then
		p1:_stopBillboardPulse()

		return
	end

	if not p1._billboardPulseActive then
		p1._billboardPulseActive = true
		p1._billboard.Size = p1._billboardBaseSize
		p1._moneyLabel.TextColor3 = p1._moneyLabelBaseTextColor

		local v2 = TweenService:Create(p1._billboard, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true), {
			Size = t._scaleBillboardSize(p1._billboardBaseSize, 1.75)
		})
		local v3 = TweenService:Create(p1._moneyLabel, TweenInfo.new(0.6400000000000001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {
			TextColor3 = v1
		})

		p1._billboardPulseTween = v2
		p1._billboardTextBlinkTween = v3
		v2:Play()
		v3:Play()
	end
end
function t._syncBillboardAdornee(p1) --[[ _syncBillboardAdornee | Line: 183 | Upvalues: OfflineCash (copy) ]]
	p1._billboard.AlwaysOnTop = true

	local v1 = p1._generatedMoney:GetBillboardAdornee()

	if v1 then
		p1._billboard.Adornee = v1
		p1._billboard.StudsOffset = OfflineCash.StudsOffset
	else
		p1._billboard.Adornee = p1._claimArea
		p1._billboard.StudsOffset = Vector3.new(0, 6, 0)
	end
end
function t._syncBillboardText(p1) --[[ _syncBillboardText | Line: 195 | Upvalues: t (copy) ]]
	p1._moneyLabel.RichText = true
	p1._moneyLabel.Text = ("OFFLINE CLAIM! <br/>%*"):format((t._formatMoney(p1._amount)))
end
function t.Update(p1, p2, p3) --[[ Update | Line: 204 | Upvalues: Asserts (copy) ]]
	Asserts.finiteNonNegative(p2)
	Asserts.BasePart(p3)
	p1._amount = p2
	p1._claimArea.CFrame = p3.CFrame + Vector3.new(0, 0.2, 0)
	p1._generatedMoney:UpdateInstant(p2, true)
	p1:_syncBillboardText()
	p1:_syncBillboardAdornee()
	p1._billboard.Enabled = p2 > 0
	p1:_syncBillboardPulse()
end
function t.SetBillboardEnabled(p1, p2) --[[ SetBillboardEnabled | Line: 217 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)
	p1._billboard.Enabled = if p2 then if p1._amount > 0 then true else false else p2
	p1:_syncBillboardPulse()
end
function t.ContainsWorldPosition(p1, p2) --[[ ContainsWorldPosition | Line: 223 | Upvalues: Asserts (copy) ]]
	Asserts.Vector3(p2)

	local v1 = p1._claimArea.CFrame:PointToObjectSpace(p2)
	local v2 = p1._claimArea.Size * 0.5

	if p1._claimArea:IsA("Part") and p1._claimArea.Shape == Enum.PartType.Cylinder then
		local v3 = math.abs(v1.X) < v2.X
		local v4 = math.min(v2.Y, v2.Z)

		return if v3 then v1.Y * v1.Y + v1.Z * v1.Z < v4 * v4 else v3
	end

	return if math.abs(v1.X) < v2.X then math.abs(v1.Z) < v2.Z else false
end
function t.PlayClaim(p1) --[[ PlayClaim | Line: 240 ]]
	p1._billboard.Enabled = false
	p1:_stopBillboardPulse()
	p1._generatedMoney:PlayCollectReset()
end
function t.Destroy(p1) --[[ Destroy | Line: 246 ]]
	p1:_stopBillboardPulse()
	p1._trove:Destroy()
end

return t