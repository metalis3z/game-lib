-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1/0)))
local MoneyPiles = require(script.Parent.MoneyPiles)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v2 = {}

v2.__index = v2
v2.__class = "OfflineMoneyClaimVisual"

local v3 = Color3.new(1, 1, 1)
local Assets = ReplicatedStorage.Assets
local ClaimArea = Assets.Models.ClaimArea
local BasePart = ClaimArea:IsA("BasePart")
assert(BasePart, "ReplicatedStorage.Assets.Models.ClaimArea must be a BasePart")
local OfflineCash = Assets.Billboards.OfflineCash
local BillboardGui = OfflineCash:IsA("BillboardGui")
assert(BillboardGui, "ReplicatedStorage.Assets.Billboards.OfflineCash must be a BillboardGui")

function v2.new(v4, v5, v6) -- line 26 | captures: t, v1, MoneyPiles, Trove, v2, ClaimArea, OfflineCash
    t.strict(v1)(v4)
    t.strict(t.instanceIsA("BasePart"))(v5)
    t.strict(t.Instance)(v6)
    local v7 = {}
    local v8 = setmetatable(v7, v2)
    local v9 = Trove.new()
    local Model = Instance.new("Model")
    Model.Name = "LocalOfflineMoneyClaim"
    Model.Parent = v6
    local v10 = ClaimArea:Clone()
    v10.Name = "OfflineMoneyClaimArea"
    v10.CFrame = v5.CFrame + Vector3.new(0, 0.20000000298023224, 0)
    v10.Anchored = true
    v10.CanCollide = false
    v10.CanTouch = false
    v10.CanQuery = false
    v10.Parent = Model
    local v11 = MoneyPiles.new(v10, Model)
    local v12 = OfflineCash:Clone()
    v12.Name = "OfflineMoneyClaimBillboard"
    v12.AlwaysOnTop = true
    v12.Parent = v10
    v12.Enabled = true
    local Money = v12.Money
    local v13 = Money and Money:IsA("TextLabel")
    assert(v13, "OfflineCash.Money must be a TextLabel")
    v8._trove = v9
    v8._amount = v4
    v8._rootModel = Model
    v8._claimArea = v10
    v8._generatedMoney = v11
    v8._billboard = v12
    v8._billboardBaseSize = v12.Size
    v8._billboardPulseTween = nil
    v8._billboardTextBlinkTween = nil
    v8._billboardPulseActive = false
    v8._moneyLabel = Money
    v8._moneyLabelBaseTextColor = v8._moneyLabel.TextColor3
    v9:Add(Model)
    v9:Add(function() -- line 71 | captures: v11
        v11:Destroy()
    end)
    v9:Add(v11.BillboardAdorneeChanged:Connect(function() -- line 74 | captures: v8
        v8:_syncBillboardAdornee()
    end))
    v8:Update(v4, v5)
    return v8
end

function v2._formatMoney(v14) -- line 80 | captures: Simple
    local v15 = math.max(v14, 0)
    return "$" .. Simple.FormatCompact(v15, "precision-integer")
end

local function _scaleBillboardSize(v16, v17) -- line 84
    local v18 = v16.X.Scale * v17
    local v19 = v16.X.Offset * v17
    local v20 = math.round(v19)
    local new = UDim2.new
    local v21 = v16.Y.Scale * v17
    local v22 = v16.Y.Offset * v17
    return new(v18, v20, v21, (math.round(v22)))
end

v2._scaleBillboardSize = _scaleBillboardSize

local function _stopBillboardPulse(v23) -- line 89
    v23._billboardPulseActive = false
    local _billboardPulseTween = v23._billboardPulseTween
    if _billboardPulseTween then
        _billboardPulseTween:Cancel()
        v23._billboardPulseTween = nil
    end
    local _billboardTextBlinkTween = v23._billboardTextBlinkTween
    if _billboardTextBlinkTween then
        _billboardTextBlinkTween:Cancel()
        v23._billboardTextBlinkTween = nil
    end
    v23._billboard.Size = v23._billboardBaseSize
    v23._moneyLabel.TextColor3 = v23._moneyLabelBaseTextColor
end

v2._stopBillboardPulse = _stopBillboardPulse

function v2._syncBillboardPulse(v24) -- line 104 | captures: TweenService, v2, v3
    if v24._billboard.Enabled and v24._amount > 0 then
        if not v24._billboardPulseActive then
            v24._billboardPulseActive = true
            v24._billboard.Size = v24._billboardBaseSize
            v24._moneyLabel.TextColor3 = v24._moneyLabelBaseTextColor
            local v25 = TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
            local v26 = TweenService:Create(v24._billboard, v25, { Size = v2._scaleBillboardSize(v24._billboardBaseSize, 1.75) })
            local v27 = TweenInfo.new(0.6400000000000001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)
            local v28 = TweenService:Create(v24._moneyLabel, v27, { TextColor3 = v3 })
            v24._billboardPulseTween = v26
            v24._billboardTextBlinkTween = v28
            v26:Play()
            v28:Play()
        end
    else
        v24:_stopBillboardPulse()
    end
end

function v2._syncBillboardAdornee(v29) -- line 128 | captures: OfflineCash
    v29._billboard.AlwaysOnTop = true
    local v30 = v29._generatedMoney:GetBillboardAdornee()
    if v30 then
        v29._billboard.Adornee = v30
        v29._billboard.StudsOffset = OfflineCash.StudsOffset
    else
        v29._billboard.Adornee = v29._claimArea
        v29._billboard.StudsOffset = Vector3.new(0, 6, 0)
    end
end

function v2._syncBillboardText(v31) -- line 139 | captures: v2
    v31._moneyLabel.RichText = true
    v31._moneyLabel.Text = ("OFFLINE CLAIM! <br/>%*"):format((v2._formatMoney(v31._amount)))
end

function v2.Update(v32, v33, v34) -- line 143 | captures: t, v1
    t.strict(v1)(v33)
    t.strict(t.instanceIsA("BasePart"))(v34)
    v32._amount = v33
    v32._claimArea.CFrame = v34.CFrame + Vector3.new(0, 0.20000000298023224, 0)
    v32._generatedMoney:UpdateInstant(v33, true)
    v32:_syncBillboardText()
    v32:_syncBillboardAdornee()
    local v35 = v33 > 0
    v32._billboard.Enabled = v35
    v32:_syncBillboardPulse()
end

function v2.SetBillboardEnabled(v36, v37) -- line 157 | captures: t
    t.strict(t.boolean)(v37)
    local v38 = v37 and v36._amount > 0
    v36._billboard.Enabled = v38
    v36:_syncBillboardPulse()
end

function v2.ContainsWorldPosition(v39, v40) -- line 167 | captures: t
    t.strict(t.Vector3)(v40)
    local v41 = v39._claimArea.CFrame:PointToObjectSpace(v40)
    local v42 = v39._claimArea.Size * 0.5
    if v39._claimArea:IsA("Part") and v39._claimArea.Shape == Enum.PartType.Cylinder then
        local X = v41.X
        local v43 = math.abs(X) < v42.X
        local Y = v42.Y
        local Z = v42.Z
        local v44 = math.min(Y, Z)
        local v45 = v41.Y * v41.Y + v41.Z * v41.Z
        return v43 and v45 < v44 * v44
    end
    local X = v41.X
    if math.abs(X) < v42.X then
        local Z = v41.Z
        return math.abs(Z) < v42.Z
    end
    return false
end

local function PlayClaim(v46) -- line 192
    v46._billboard.Enabled = false
    v46:_stopBillboardPulse()
    v46._generatedMoney:PlayCollectReset()
end

v2.PlayClaim = PlayClaim

local function Destroy(v47) -- line 197
    v47:_stopBillboardPulse()
    v47._trove:Destroy()
end

v2.Destroy = Destroy
return v2
