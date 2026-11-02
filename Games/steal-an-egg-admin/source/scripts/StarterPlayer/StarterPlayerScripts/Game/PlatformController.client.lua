-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local v1 = Log.new()

local function resolvePlatform() -- line 12 | captures: UserInputService
    local PreferredInput = UserInputService.PreferredInput
    if PreferredInput == Enum.PreferredInput.Gamepad then
        return "Console"
    end
    if PreferredInput == Enum.PreferredInput.Touch then
        return "Mobile"
    end
    return "Desktop"
end

local function publishPlatform() -- line 22 | captures: UserInputService, ClientGlobals, PlatformSignals, v1
    local PreferredInput = UserInputService.PreferredInput
    local v2
    if PreferredInput == Enum.PreferredInput.Gamepad then
        v2 = "Console"
    elseif PreferredInput == Enum.PreferredInput.Touch then
        v2 = "Mobile"
    else
        v2 = "Desktop"
    end
    if ClientGlobals.Platform == v2 then
        return
    end
    ClientGlobals.Platform = v2
    local v3 = v2 == "Console"
    ClientGlobals.Console = v3
    local v4 = v2 == "Mobile"
    ClientGlobals.Mobile = v4
    local v5 = v2 == "Desktop"
    ClientGlobals.Desktop = v5
    PlatformSignals.Changed:Fire(v2)
    v1:AtInfo():Log((("Preferred platform changed to %*"):format(v2)))
end

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(publishPlatform)
ClientGlobals.Platform = ""
publishPlatform()
