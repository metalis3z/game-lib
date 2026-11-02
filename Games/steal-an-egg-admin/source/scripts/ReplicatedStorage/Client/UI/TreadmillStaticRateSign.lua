-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

function v1.Apply(v2, v3, v4) -- line 10 | captures: AddCommas, t
    t.strict(t.Instance)(v2)
    t.strict(t.Color3)(v3)
    t.strict(t.number)(v4)
    local SpeedPerSecond = v2.SpeedPerSecond
    local BasePart = SpeedPerSecond:IsA("BasePart")
    local v5 = ("Treadmill \"%*\" SpeedPerSecond must be a BasePart"):format(v2.Name)
    assert(BasePart, v5)
    local BillboardGui = SpeedPerSecond.BillboardGui
    local BillboardGui_2 = BillboardGui:IsA("BillboardGui")
    local v6 = ("Treadmill \"%*\" SpeedPerSecond.BillboardGui must be a BillboardGui"):format(v2.Name)
    assert(BillboardGui_2, v6)
    local TextLabel = BillboardGui.Frame.TextLabel
    local TextLabel_2 = TextLabel:IsA("TextLabel")
    local v7 = ("Treadmill \"%*\" SpeedPerSecond.BillboardGui.Frame.TextLabel must be a TextLabel"):format(v2.Name)
    assert(TextLabel_2, v7)
    TextLabel.TextColor3 = v3
    TextLabel.Text = ("+%*/step"):format((AddCommas(v4)))
    return BillboardGui
end

return v1
