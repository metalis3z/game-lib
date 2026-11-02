-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OverlayRoot = require(script.Parent.OverlayRoot)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = {
    seconds = 1,
    peakTransparency = 0,
    riseEasing = "Expo",
    fallEasing = "Sine",
    tint = Color3.fromRGB(255, 255, 255),
    properties = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.one / 2,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(2, 2)
    }
}
return function(v2, v3, v4, v5) -- line 23 | captures: OverlayRoot, Tween, v1
    local v6 = {}
    local v7 = {}
    v7.seconds = v2 or v1.seconds
    v7.easing = v1.riseEasing
    local v8 = {}
    v8.seconds = v3 or v1.seconds
    v8.easing = v1.fallEasing
    v6[1] = v7
    v6[2] = v8
    local v9 = {}
    v9[1] = v5 or v1.peakTransparency
    v9[2] = 1
    task.spawn(function() -- line 48 | captures: v4, v6, v9, OverlayRoot, Tween, v1
        local Frame = Instance.new("Frame")
        for v10, v11 in v1.properties do
            Frame[v10] = v11
        end
        Frame.BackgroundColor3 = v4 or v1.tint
        Frame.Parent = OverlayRoot()
        for v12, v13 in v6 do
            local v14 = v9[v12]
            if v13.seconds > 0 then
                Tween(Frame, { BackgroundTransparency = v14 }, {
                    v13.seconds,
                    v13.easing,
                    "Out"
                })
                wait(v13.seconds)
            else
                Frame.BackgroundTransparency = v14
            end
        end
        Frame:Destroy()
    end)
end
