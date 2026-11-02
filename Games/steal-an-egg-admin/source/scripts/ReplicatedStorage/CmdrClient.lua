-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Shared = script:WaitForChild("Shared")
local v1 = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
    error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local v2 = {
    Enabled = true,
    MashToEnable = false,
    ActivationUnlocksMouse = false,
    HideOnLostFocus = true,
    PlaceName = "Cmdr",
    ReplicatedRoot = script,
    RemoteFunction = script:WaitForChild("CmdrFunction"),
    RemoteEvent = script:WaitForChild("CmdrEvent"),
    ActivationKeys = {},
    Util = v1,
    Events = {}
}
local v3 = {
    __index = function(v4, v5) -- __index | line 27
        local v6 = v4.Dispatcher[v5]
        if v6 and type(v6) == "function" then
            return function(v7, ...) -- line 33 | captures: v4, v6
                return v6(v4.Dispatcher, ...)
            end
        end
    end
}
local v8 = setmetatable(v2, v3)

v8.Registry = require(Shared.Registry)(v8)
v8.Dispatcher = require(Shared.Dispatcher)(v8)

if StarterGui:WaitForChild("Cmdr") and wait() and LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Cmdr") == nil then
    StarterGui.Cmdr:Clone().Parent = LocalPlayer.PlayerGui
end
local v9 = require(script.CmdrInterface)(v8)

function v8.SetActivationKeys(v10, v11) -- line 52 | captures: v1
    v10.ActivationKeys = v1.MakeDictionary(v11)
end

function v8.SetPlaceName(v12, v13) -- line 55 | captures: v9
    v12.PlaceName = v13
    v9.Window:UpdateLabel()
end

local function SetEnabled(v14, v15) -- line 59
    v14.Enabled = v15
end

v8.SetEnabled = SetEnabled

local function SetActivationUnlocksMouse(v16, v17) -- line 62
    v16.ActivationUnlocksMouse = v17
end

v8.SetActivationUnlocksMouse = SetActivationUnlocksMouse

function v8.Show(v18) -- line 65 | captures: v9
    if v18.Enabled then
        v9.Window:Show()
    end
end

function v8.Hide(v19) -- line 71 | captures: v9
    v9.Window:Hide()
end

function v8.Toggle(v20) -- line 74 | captures: v9
    if v20.Enabled then
        v9.Window:SetVisible(not v9.Window:IsVisible())
    else
        return v20:Hide()
    end
end

local function SetMashToEnable(v21, v22) -- line 80
    v21.MashToEnable = v22
    if v22 then
        v21:SetEnabled(false)
    end
end

v8.SetMashToEnable = SetMashToEnable

local function SetHideOnLostFocus(v23, v24) -- line 86
    v23.HideOnLostFocus = v24
end

v8.SetHideOnLostFocus = SetHideOnLostFocus

local function HandleEvent(v25, v26, v27) -- line 89
    v25.Events[v26] = v27
end

v8.HandleEvent = HandleEvent

if RunService:IsServer() == false then
    v8.Registry:RegisterTypesIn(script:WaitForChild("Types"))
    v8.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end
v8.RemoteEvent.OnClientEvent:Connect(function(v28, ...) -- line 96 | captures: v8
    if v8.Events[v28] then
        v8.Events[v28](...)
    end
end)
require(script.DefaultEventHandlers)(v8)
return v8
