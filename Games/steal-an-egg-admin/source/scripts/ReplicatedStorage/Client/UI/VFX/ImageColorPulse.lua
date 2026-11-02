-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    fromScale = 0.9,
    toScale = 1.15,
    restScale = 1,
    sharedScaleAttribute = "ButtonFXOwned"
}
local v2 = Log.new()
local v3 = {}

function v3.Start(v4, v5, v6) -- line 13 | captures: TweenService, t, v2
    t.strict(t.instanceIsA("GuiButton"))(v4)
    t.strict(t.Color3)(v5)
    t.strict(t.TweenInfo)(v6)
    local ImageColor3 = v4.ImageColor3
    local UIScale = Instance.new("UIScale")
    UIScale.Parent = v4
    UIScale.Scale = 0.9
    local v7 = {}
    v7[1] = TweenService:Create(UIScale, v6, { Scale = 1.15 })
    v7[2] = TweenService:Create(v4, v6, { ImageColor3 = v5 })
    for v8, v9 in v7 do
        v9:Play()
    end
    v2:AtTrace():Log("image pulse running")
    local v10 = false
    return function() -- line 36 | captures: v10, v4, ImageColor3, UIScale, v7, v2
        if v10 then
            return
        end
        v10 = true
        for v11, v12 in v7 do
            v12:Cancel()
        end
        v4.ImageColor3 = ImageColor3
        UIScale.Scale = 1
        if not UIScale:GetAttribute("ButtonFXOwned") then
            UIScale:Destroy()
        end
        v2:AtTrace():Log("image pulse stopped")
    end
end

return v3
