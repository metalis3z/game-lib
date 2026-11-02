-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local v1 = {}

v1.__index = v1
v1.__class = "RequiredSpeedSign"

local v2 = Color3.fromRGB(0, 255, 0)
local v3 = Color3.fromRGB(153, 255, 0)
local v4 = Color3.fromRGB(255, 170, 0)
local v5 = Color3.fromRGB(255, 0, 0)

function v1.new(v6) -- line 17 | captures: t, Constants, v1
    t.strict(t.instanceIsA("Model"))(v6)
    local v7 = {}
    local v8 = setmetatable(v7, v1)
    local v9 = v6:WaitForChild("RequiredSpeedSign", Constants.STUDIO_YIELD_TIMEOUT)
    local v10 = v9 and v9:IsA("Model")
    local v11 = ("%*.RequiredSpeedSign must be a Model"):format((v6:GetFullName()))
    assert(v10, v11)
    local v12 = v9:WaitForChild("Main", Constants.STUDIO_YIELD_TIMEOUT)
    local v13 = v12 and v12:IsA("BasePart")
    local v14 = ("%*.Main must be a BasePart"):format((v9:GetFullName()))
    assert(v13, v14)
    local v15 = v12:WaitForChild("SurfaceGui", Constants.STUDIO_YIELD_TIMEOUT)
    local v16 = v15 and v15:IsA("SurfaceGui")
    local v17 = ("%*.SurfaceGui must be a SurfaceGui"):format((v12:GetFullName()))
    assert(v16, v17)
    local v18 = v15:WaitForChild("Info", Constants.STUDIO_YIELD_TIMEOUT)
    local v19 = v18 and v18:IsA("TextLabel")
    local v20 = ("%*.Info must be a TextLabel"):format((v15:GetFullName()))
    assert(v19, v20)
    local v21 = v15:WaitForChild("Required", Constants.STUDIO_YIELD_TIMEOUT)
    local v22 = v21 and v21:IsA("GuiObject")
    local v23 = ("%*.Required must be a GuiObject"):format((v15:GetFullName()))
    assert(v22, v23)
    local v24 = v21:WaitForChild("Speed", Constants.STUDIO_YIELD_TIMEOUT)
    local v25 = v24 and v24:IsA("TextLabel")
    local v26 = ("%*.Speed must be a TextLabel"):format((v21:GetFullName()))
    assert(v25, v26)
    v8._infoLabel = v18
    v8._speedLabel = v24
    v8:SetSlowdownTolerance(-1)
    return v8
end

function v1.SetSlowdownTolerance(v27, v28) -- line 62 | captures: t, v2, v3, v4, v5
    t.strict(t.number)(v28)
    local v29
    if v28 < 0.03 then
        v29 = v5
    elseif v28 < 0.1 then
        v29 = v4:Lerp(v3, (v28 - 0.03) / 0.07)
    elseif v28 >= 0.4 then
        v29 = v2
    else
        v29 = v3:Lerp(v2, (v28 - 0.1) / 0.30000000000000004)
    end
    v27._infoLabel.TextColor3 = v29
    v27._speedLabel.TextColor3 = v29
end

function v1.SetSpeedPowerRequirement(v30, v31) -- line 77 | captures: t, TreadmillUtil
    t.strict(t.number)(v31)
    v30._speedLabel.Text = TreadmillUtil.FormatSpeedPower(v31)
end

local function Destroy(v32) -- line 82
end

v1.Destroy = Destroy
return v1
