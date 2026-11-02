-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Packages.Trove)
local v1 = {}

local function showHighlight(v2) -- line 11
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "AreaEggHover"
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = v2
    Highlight.Parent = v2
    return Highlight
end

function v1.Bind(v3, v4, v5) -- line 22 | captures: TweenService, t
    t.strict(t.instanceIsA("Model"))(v3)
    t.strict(t.Instance)(v4)
    local Highlight
    v5:Connect(v4.PromptShown, function() -- line 28 | captures: Highlight, v3, TweenService
        if Highlight ~= nil then
            Highlight:Destroy()
        end
        local Highlight_2 = Instance.new("Highlight")
        Highlight_2.Name = "AreaEggHover"
        Highlight_2.FillTransparency = 1
        Highlight_2.OutlineTransparency = 1
        Highlight_2.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight_2.Adornee = v3
        Highlight_2.Parent = v3
        Highlight = Highlight_2
        local v6 = TweenInfo.new(0.15)
        TweenService:Create(Highlight, v6, { OutlineTransparency = 0 }):Play()
    end)
    v5:Connect(v4.PromptHidden, function() -- line 45 | captures: Highlight, TweenService
        local Highlight_2 = Highlight
        Highlight = nil
        if Highlight_2 == nil then
            return
        end
        local v7 = TweenInfo.new(0.12)
        local v8 = TweenService:Create(Highlight_2, v7, { OutlineTransparency = 1 })
        v8.Completed:Once(function() -- line 53 | captures: Highlight_2
            Highlight_2:Destroy()
        end)
        v8:Play()
    end)
end

return v1
