-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local t = require(ReplicatedStorage.Packages.t)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local SetLabelWithShadow = require(ReplicatedStorage.Shared.Utils.Layout).SetLabelWithShadow
local v1 = 0
local v2 = 0
local v3 = 1
local v4, NumberValue
local v5 = 0
local CashCollect = SoundService.CashCollect
local MoneyChange = ReplicatedStorage.Assets.MoneyChange
local Money = Hud.Get("Money")
local MoneyValue = Hud.Get("MoneyValue")

local function playCashCollectSound() -- line 28 | captures: v2, v3, SettingsCmds, CashCollect
    if not SettingsCmds.Allows("SFX") then
        return
    end
    if tick() - v2 > 2 or v3 >= 3 then
        v3 = 1
    end
    v2 = tick()
    CashCollect.TimePosition = 0
    CashCollect.PlaybackSpeed = v3
    CashCollect:Play()
    v3 += 0.07
end

local function createMoneyChangeClone() -- line 43 | captures: MoneyChange
    local v6 = MoneyChange:Clone()
    local Label = v6.Label
    local UIScale = v6.UIScale
    local UIStroke = Label.UIStroke
    local More = Label.More
    local Less = Label.Less
    local Icon = v6.Icon
    Label.TextTransparency = 1
    UIStroke.Transparency = 1
    UIScale.Scale = 0
    Icon.ImageTransparency = 1
    return v6, Label, UIScale, UIStroke, Icon, More, Less
end

local function getTransparencyProperty(v7) -- line 57
    if v7:IsA("ImageLabel") or v7:IsA("ImageButton") then
        return "ImageTransparency"
    end
    if v7:IsA("TextLabel") or v7:IsA("TextButton") then
        return "TextTransparency"
    end
    if v7:IsA("UIStroke") then
        return "Transparency"
    end
    return nil
end

local function animateNotification(v8, v9, v10, v11, v12) -- line 69 | captures: Debris, Tween, getTransparencyProperty
    Tween(v9, { TextTransparency = 0.25 }, { 0.5 })
    Tween(v11, { Transparency = 0.25 }, { 0.5 })
    local v13 = {
        0.5,
        Enum.EasingStyle.Back
    }
    Tween(v10, { Scale = 1 }, v13)
    for v14, v15 in ipairs(v12) do
        local v16 = getTransparencyProperty(v15)
        if v16 then
            if v16 == "ImageTransparency" then
                v15.ImageTransparency = 1
            elseif v16 == "TextTransparency" then
                v15.TextTransparency = 1
            elseif v16 == "Transparency" then
                v15.Transparency = 1
            end
            local v17 = {}
            v17[v16] = 0
            Tween(v15, v17, { 0.5 })
        end
    end
    task.delay(1, function() -- line 91 | captures: v8, v9, v11, v12, Debris, Tween, getTransparencyProperty
        Tween(v9, { TextTransparency = 1 }, { 0.75 })
        Tween(v11, { Transparency = 1 }, { 0.75 })
        for v18, v19 in ipairs(v12) do
            local v20 = getTransparencyProperty(v19)
            if v20 then
                local v21 = {}
                v21[v20] = 1
                Tween(v19, v21, { 0.75 })
            end
        end
        Debris:AddItem(v8, 0.75)
    end)
end

local function spawnFloatingMoney(v22, v23) -- line 106 | captures: Simple, MoneyChange, Money, animateNotification
    local v24 = v22 < 0
    local v25 = if v24 then "-" else "+"
    local v26 = MoneyChange:Clone()
    local Label = v26.Label
    local UIScale = v26.UIScale
    local UIStroke = Label.UIStroke
    local More = Label.More
    local Less = Label.Less
    local Icon = v26.Icon
    Label.TextTransparency = 1
    UIStroke.Transparency = 1
    UIScale.Scale = 0
    Icon.ImageTransparency = 1
    if More and More:IsA("UIGradient") then
        More.Enabled = not v24
    end
    if Less and Less:IsA("UIGradient") then
        Less.Enabled = v24
    end
    local v27 = math.abs(v22)
    local v28 = math.round(v27)
    Label.Text = v25 .. "$" .. Simple.FormatCompact(v28, ".#")
    Icon.Visible = false
    v26.ZIndex = 10
    v26.Parent = Money
    animateNotification(v26, Label, UIScale, UIStroke, {})
end

local function displayMoneyChange(v29, v30, v31) -- line 142 | captures: playCashCollectSound, spawnFloatingMoney
    if v29 ~= 0 then
        if v29 > 0 and v31 ~= false then
            playCashCollectSound()
        end
        spawnFloatingMoney(v29, v30)
    end
end

local function updateMoneyLabels(v32) -- line 151 | captures: t, SetLabelWithShadow, MoneyValue
    t.strict(t.string)(v32)
    SetLabelWithShadow(MoneyValue, v32)
end

local function formatMoneyText(v33) -- line 156 | captures: AddCommas, Simple
    if v33 <= 99999 then
        return "$" .. AddCommas((math.round(v33)))
    end
    local v34 = math.round(v33)
    return "$" .. Simple.FormatCompact(v34, ".#")
end

local function cancelMoneyLabelTween() -- line 163 | captures: v4, NumberValue
    if v4 then
        v4:Cancel()
        v4 = nil
    end
    if NumberValue then
        NumberValue:Destroy()
        NumberValue = nil
    end
end

local function setMoneyLabelValue(v35) -- line 173 | captures: t, AddCommas, Simple, SetLabelWithShadow, MoneyValue
    local v36
    if v35 <= 99999 then
        v36 = "$" .. AddCommas((math.round(v35)))
    else
        local v37 = math.round(v35)
        v36 = "$" .. Simple.FormatCompact(v37, ".#")
    end
    t.strict(t.string)(v36)
    SetLabelWithShadow(MoneyValue, v36)
end

local function tweenMoneyLabelValue(v38, v39) -- line 185 | captures: v4, NumberValue, t, AddCommas, Simple, Tween, SetLabelWithShadow, MoneyValue, setMoneyLabelValue
    if v4 then
        v4:Cancel()
        v4 = nil
    end
    if NumberValue then
        NumberValue:Destroy()
        NumberValue = nil
    end
    local NumberValue_2 = Instance.new("NumberValue")
    NumberValue_2.Value = v38
    NumberValue = NumberValue_2
    local v40
    if v38 <= 99999 then
        v40 = "$" .. AddCommas((math.round(v38)))
    else
        local v41 = math.round(v38)
        v40 = "$" .. Simple.FormatCompact(v41, ".#")
    end
    t.strict(t.string)(v40)
    SetLabelWithShadow(MoneyValue, v40)
    NumberValue_2.Changed:Connect(setMoneyLabelValue)
    local v42 = { Value = v39 }
    local v43 = Tween(NumberValue_2, v42, {
        0.45,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    })
    v4 = v43
    v43.Completed:Once(function(v44) -- line 211 | captures: v39, NumberValue_2, v43, v4, NumberValue, t, AddCommas, Simple, SetLabelWithShadow, MoneyValue
        if v4 ~= v43 then
            return
        end
        v4 = nil
        NumberValue = nil
        if v44 == Enum.PlaybackState.Completed then
            local v45
            if v39 <= 99999 then
                v45 = "$" .. AddCommas((math.round(v39)))
            else
                local v46 = math.round(v39)
                v45 = "$" .. Simple.FormatCompact(v46, ".#")
            end
            t.strict(t.string)(v45)
            SetLabelWithShadow(MoneyValue, v45)
        end
        NumberValue_2:Destroy()
    end)
end

local function updateMoney(v47) -- line 233 | captures: v1, v4, NumberValue, v5, t, AddCommas, Save, Simple, SetLabelWithShadow, MoneyValue, playCashCollectSound, spawnFloatingMoney, tweenMoneyLabelValue
    local v48 = Save.Get()
    if not v48 then
        return
    end
    local Money = v48.Money
    local v49 = v47 and v47.forceUpdate
    if Money == v1 then
        if v49 then
            if v4 then
                v4:Cancel()
                v4 = nil
            end
            if NumberValue then
                NumberValue:Destroy()
                NumberValue = nil
            end
            local v50 = if Money <= 99999 then "$" .. AddCommas((math.round(Money))) else "$" .. Simple.FormatCompact(math.round(Money), ".#")
            t.strict(t.string)(v50)
            SetLabelWithShadow(MoneyValue, v50)
            v1 = Money
        end
    else
        if not v49 and v1 < Money then
            local v51 = if NumberValue then NumberValue.Value else v1
            tweenMoneyLabelValue(v51, Money)
        else
            if v4 then
                v4:Cancel()
                v4 = nil
            end
            if NumberValue then
                NumberValue:Destroy()
                NumberValue = nil
            end
            local v52
            if Money <= 99999 then
                v52 = "$" .. AddCommas((math.round(Money)))
            else
                local v53 = math.round(Money)
                v52 = "$" .. Simple.FormatCompact(v53, ".#")
            end
            t.strict(t.string)(v52)
            SetLabelWithShadow(MoneyValue, v52)
        end
        if not v49 then
            local v54 = Money - v1
            if v54 > 0 and v5 > 0 then
                local v55 = v5
                local v56 = math.min(v54, v55)
                v54 -= v56
                v5 -= v56
            end
            if v54 ~= 0 then
                local v57 = v54 > 0
                if v47 and v47.allowPositiveAnimation ~= nil then
                    local allowPositiveAnimation = v47.allowPositiveAnimation
                end
                if not v57 and v54 ~= 0 then
                    if v54 > 0 then
                        playCashCollectSound()
                    end
                    spawnFloatingMoney(v54, nil)
                end
            end
        end
        v1 = Money
    end
end

task.spawn(function() -- line 335 | captures: Save, updateMoney
    if not Save.IsLocalDataLoaded() then
        Save.ProfileReady:Wait()
    end
    updateMoney({ forceUpdate = true })
end)
Save.FieldChanged:Connect(function(v58) -- line 341 | captures: updateMoney
    if v58 == "Money" then
        updateMoney({ allowPositiveAnimation = false })
    end
end)
Remotes.PenRoster.CoinsGathered.OnClientEvent:Connect(function(v59, v60) -- line 346 | captures: v5, playCashCollectSound, spawnFloatingMoney
    if not v59 or v60 then
        return
    end
    local v61 = 0
    local v62 = false
    for v63, v64 in ipairs(v59) do
        if v64 then
            local amount = v64.amount
            if typeof(amount) == "number" then
                local amount = v64.amount
                v61 += math.max(amount, 0)
                local v65 = v64.playSound ~= false and not v62
                local amount_2 = v64.amount
                if amount_2 ~= 0 then
                    if amount_2 > 0 and v65 ~= false then
                        playCashCollectSound()
                    end
                    spawnFloatingMoney(amount_2, v64.icon)
                end
                if v64.amount > 0 and v65 then
                    v62 = true
                end
            end
        end
    end
    if v61 > 0 then
        v5 += v61
    end
end)
