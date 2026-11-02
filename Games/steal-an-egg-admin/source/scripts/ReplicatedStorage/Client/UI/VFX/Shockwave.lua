-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local OverlayRoot = require(script.Parent.OverlayRoot)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = {
    baseScale = 15,
    seconds = 1,
    startTransparency = 0,
    easing = "Sine",
    direction = "Out",
    template = ReplicatedStorage.Assets.UI.OTHER.Shockwave.Pulse
}

local function centreOf(v2) -- line 18
    local AbsolutePosition = v2.AbsolutePosition
    local AbsoluteSize = v2.AbsoluteSize
    return UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2)
end

return function(v3, v4, v5, v6) -- line 23 | captures: RunService, OverlayRoot, Tween, v1
    local v7 = {}
    v7[1] = v4 or v1.seconds
    v7[2] = v1.easing
    v7[3] = v1.direction
    local v8 = v1.baseScale * (v6 or 1)
    local v9 = v1.template:Clone()
    v9.UIScale.Scale = 0
    v9.Size = UDim2.fromOffset(v3.AbsoluteSize.X, v3.AbsoluteSize.Y)
    local AbsolutePosition = v3.AbsolutePosition
    local AbsoluteSize = v3.AbsoluteSize
    v9.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2)
    v9.Parent = OverlayRoot()
    task.spawn(function() -- line 40 | captures: v5, v7, v8, v9, Tween, v1
        local v10 = v5 or v1.startTransparency
        v9.ImageTransparency = v10
        Tween(v9, { ImageTransparency = 1 }, v7)
        Tween(v9.UIScale, { Scale = v8 }, v7).Completed:Wait()
        v9:Destroy()
    end)
    task.spawn(function() -- line 50 | captures: v3, v9, RunService
        while v9.Parent do
            local AbsolutePosition = v3.AbsolutePosition
            local AbsoluteSize = v3.AbsoluteSize
            v9.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2)
            RunService.RenderStepped:Wait()
        end
    end)
    return v9
end
