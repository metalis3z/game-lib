-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1

local v2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function v1.new(v3) -- line 9 | captures: Trove, v1
    local Home = v3:FindFirstChild("Home")
    local v4 = Home ~= nil
    assert(v4, "YourBase.Home must exist")
    local ImageButton = Home:IsA("ImageButton")
    assert(ImageButton, "YourBase.Home must be an ImageButton")
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    v6._activeTween = nil
    v6._home = Home
    v6._revision = 0
    v6._trove = Trove.new()
    v6._visible = nil
    v6._yourBase = v3
    return v6
end

function v1.SetVisible(v7, v8) -- line 24 | captures: TweenService, v2
    if v7._visible == v8 then
        return
    end
    v7._visible = v8
    v7._revision += 1
    local _revision = v7._revision
    v7._trove:Clean()
    if v8 then
        v7._yourBase.Enabled = true
    end
    local v9 = {}
    if v8 then
        v9.ImageTransparency = 0
    else
        v9.ImageTransparency = 1
    end
    local v10 = TweenService:Create(v7._home, v2, v9)
    v7._activeTween = v10
    v7._trove:Add(function() -- line 45 | captures: v7, v10
        if v7._activeTween == v10 then
            v10:Cancel()
            v7._activeTween = nil
        end
    end)
    v7._trove:Add(v10.Completed:Connect(function(v11) -- line 51 | captures: v7, v8, _revision, v10
        if not (v7._revision == _revision and v7._activeTween == v10) then
            return
        end
        v7._activeTween = nil
        if v11 == Enum.PlaybackState.Completed and not v8 then
            v7._yourBase.Enabled = false
        end
    end))
    v10:Play()
end

local function Destroy(v12) -- line 62
    v12._revision += 1
    v12._trove:Destroy()
end

v1.Destroy = Destroy
return v1
