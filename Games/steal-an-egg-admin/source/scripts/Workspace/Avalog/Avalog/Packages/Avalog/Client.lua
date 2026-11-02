-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SourceCode = script.Parent.SourceCode
local Parent = script.Parent.Parent
local Client = SourceCode.Client
local States = require(SourceCode.Client.UI.States)
local Fusion = require(Parent.Fusion)
local Bootloader = require(Parent.Bootloader)
local Config = require(script.Parent.Config)
local ServiceProvider = require(Client.ServiceProvider)
local LocalAvatar = require(Client.Avatar.LocalAvatar)

local function GetModules() -- line 12 | captures: Client
    local v1 = {}
    for v2, v3 in ipairs(Client:GetChildren()) do
        if v3:IsA("ModuleScript") then
            table.insert(v1, v3)
        end
    end
    return v1
end

local v4 = {
    Started = false,
    Config = Config,
    _Bootloader = Bootloader((GetModules())),
    _ServiceProvider = ServiceProvider
}

function v4.Start(v5) -- line 39 | captures: LocalAvatar, v4
    local v6 = not v5.Started
    assert(v6, "Avalog already started.")
    v5.Started = true
    v4._ServiceProvider:Setup({ AvatarManager = LocalAvatar })
    v4._Bootloader:Initialize()
    v4._Bootloader:Start()
end

function v4.Configure(v7, v8) -- line 56 | captures: v4
    v4.Config:Update(v8)
end

function v4.ToggleOpen(v9) -- line 63 | captures: States, Fusion
    States.Open:set(not Fusion.peek(States.Open))
end

function v4.SetOpen(v10, v11) -- line 72 | captures: States
    States.Open:set(v11)
end

return v4
