-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local Completed = Enum.PlaybackState.Completed
local v1 = {
    fadeSeconds = 0.2,
    easing = Enum.EasingStyle.Quad,
    direction = Enum.EasingDirection.Out,
    shown = { OutlineTransparency = 0 },
    hidden = { OutlineTransparency = 1 },
    restingLook = {
        FillTransparency = 1,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.fromRGB(255, 255, 255),
        OutlineColor = Color3.fromRGB(255, 255, 255)
    }
}

local function glide(v2, v3, v4) -- line 24 | captures: Tween, v1
    local v5 = {}
    v5[1] = v4 or v1.fadeSeconds
    v5[2] = v1.easing
    v5[3] = v1.direction
    return Tween(v2, v3, v5)
end

local v6 = {}

function v6.FadeIn(v7, v8, v9) -- line 36 | captures: Tween, t, v1
    t.strict(t.instanceIsA("Model"))(v7)
    t.strict(t.string)(v8)
    t.strict(t.optional(t.number))(v9)
    local Highlight = Instance.new("Highlight")
    for v10, v11 in v1.restingLook do
        Highlight[v10] = v11
    end
    Highlight.Adornee = v7
    Highlight.Name = v8
    Highlight.Parent = v7
    local v12 = {}
    v12[1] = v9 or v1.fadeSeconds
    v12[2] = v1.easing
    v12[3] = v1.direction
    Tween(Highlight, v1.shown, v12)
    return Highlight
end

function v6.FadeOut(v13, v14) -- line 64 | captures: Tween, t, Completed, v1
    local Highlight = v13:IsA("Highlight")
    assert(Highlight, "fade-out was handed something that is not a Highlight")
    t.strict(t.optional(t.number))(v14)
    local v15 = {}
    v15[1] = v14 or v1.fadeSeconds
    v15[2] = v1.easing
    v15[3] = v1.direction
    Tween(v13, v1.hidden, v15).Completed:Once(function(v16) -- line 77 | captures: v13, Completed
        if v16 == Completed then
            v13:Destroy()
        end
    end)
end

return v6
