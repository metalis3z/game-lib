-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)

local function scaleForViewport(v1) -- line 9
    local v2 = v1.Y / 1080
    return (math.clamp(v2, 0.33, 2))
end

local CurrentCamera = Workspace.CurrentCamera
local v3 = CurrentCamera ~= nil
assert(v3, "ViewportSize requires Workspace.CurrentCamera")
local ViewportSize = CurrentCamera.ViewportSize
local ViewportSize_2 = ViewportSize
local v4 = ViewportSize.Y / 1080
local v5 = math.clamp(v4, 0.33, 2)
local v6, v7
local v8 = {
    Changed = Signal.new(),
    Get = function() -- Get | line 22 | captures: ViewportSize_2
        return ViewportSize_2
    end,
    ReadScale = function() -- ReadScale | line 25 | captures: v5
        return v5
    end
}

local function publish() -- line 29 | captures: ViewportSize_2, v5, v6, Workspace, v8
    v6 = nil
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        local ViewportSize = CurrentCamera.ViewportSize
        if ViewportSize ~= ViewportSize_2 then
            ViewportSize_2 = ViewportSize
            local v9 = ViewportSize.Y / 1080
            v5 = math.clamp(v9, 0.33, 2)
            v8.Changed:Fire(ViewportSize, v5)
        end
    end
end

local function schedulePublish() -- line 43 | captures: v6, publish
    if v6 ~= nil then
        task.cancel(v6)
    end
    v6 = task.defer(publish)
end

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line 50 | captures: v6, v7, Workspace, publish, schedulePublish
    if v7 ~= nil then
        v7:Disconnect()
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        v7 = nil
    else
        v7 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(schedulePublish)
        if v6 ~= nil then
            task.cancel(v6)
        end
        v6 = task.defer(publish)
    end
end)

if v7 ~= nil then
    v7:Disconnect()
end
local CurrentCamera_2 = Workspace.CurrentCamera

if CurrentCamera_2 ~= nil then
    CurrentCamera_2:GetPropertyChangedSignal("ViewportSize")
    if v6 ~= nil then
        task.cancel(v6)
    end
end
return v8
