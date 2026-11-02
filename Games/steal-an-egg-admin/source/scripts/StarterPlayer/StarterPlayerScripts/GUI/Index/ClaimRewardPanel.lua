-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(script.Parent.Types.Interface)
local v1 = Color3.fromRGB(60, 255, 0)
local v2 = Color3.fromRGB(136, 255, 0)
local v3 = Color3.fromRGB(190, 255, 180)
local v4 = {}
local Color, Color_2

local function applyClaimableLook(v5, v6) -- line 17 | captures: Color, Color_2, v1, v2, v3
    local UIGradient = v5:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        if Color == nil then
            Color = UIGradient.Color
        end
        if v6 then
            local ClaimableColorStart = v5:GetAttribute("ClaimableColorStart")
            local ClaimableColorEnd = v5:GetAttribute("ClaimableColorEnd")
            local v7 = ClaimableColorStart or v1
            local v8 = ClaimableColorEnd or v2
            UIGradient.Color = ColorSequence.new(v7, v8)
        else
            UIGradient.Color = Color
        end
    end
    local UIStrokeClr = v5:FindFirstChild("UIStrokeClr")
    local v9
    if UIStrokeClr == nil then
        v9 = true
    elseif UIStrokeClr:IsA("UIStroke") then
        if Color_2 == nil then
            Color_2 = UIStrokeClr.Color
        end
        v9 = false
    else
        v9 = true
    end
    if v9 then
        return
    end
    if v6 then
        UIStrokeClr.Color = v5:GetAttribute("ClaimableStrokeColor") or v3
    else
        UIStrokeClr.Color = Color_2
    end
end

function v4.Render(v10, v11, v12, v13) -- line 56 | captures: Color, Color_2, t, AssetItems, Simple, applyClaimableLook
    t.strict(t.boolean)(v12)
    t.strict(t.boolean)(v13)
    local Claim = v10.Claim
    Claim.Active = v13
    if v11 == nil then
        Claim.TextLabel.Text = "CLAIM!"
        local UIGradient = Claim:FindFirstChildOfClass("UIGradient")
        if UIGradient ~= nil then
            if Color == nil then
                Color = UIGradient.Color
            end
            UIGradient.Color = Color
        end
        local UIStrokeClr = Claim:FindFirstChild("UIStrokeClr")
        local v14
        if UIStrokeClr == nil then
            v14 = true
        elseif UIStrokeClr:IsA("UIStroke") then
            if Color_2 == nil then
                Color_2 = UIStrokeClr.Color
            end
            v14 = false
        else
            v14 = true
        end
        if v14 then
            return
        end
        UIStrokeClr.Color = Color_2
    else
        local v15 = AssetItems.IndexSpeedReward(v11.Category)
        v10.Rewards.SpeedReward.TextLabel.Text = "+" .. Simple.FormatCompact(v15, ".#")
        local v16 = AssetItems.IndexMoneyReward(v11.Category)
        v10.Rewards.MoneyReward.TextLabel.Text = "$" .. Simple.FormatCompact(v16, ".#")
        local v17 = if v12 then "CLAIMED!" else "CLAIM!"
        Claim.TextLabel.Text = v17
        applyClaimableLook(Claim, v13)
    end
end

return v4
