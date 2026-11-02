-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SourceCode = script.Parent.SourceCode
local Parent = script.Parent.Parent
local Server = SourceCode.Server
local Config = require(script.Parent.Config)
local Bootloader = require(Parent.Bootloader)

local function GetModules() -- line 8 | captures: Server
    local v1 = {}
    for v2, v3 in ipairs(Server:GetChildren()) do
        if v3:IsA("ModuleScript") then
            table.insert(v1, v3)
        end
    end
    return v1
end

local v4 = {
    Started = false,
    Config = Config,
    Bootloader = Bootloader((GetModules()))
}

function v4.Start(v5) -- line 34 | captures: v4
    local v6 = not v5.Started
    assert(v6, "Avalog already started.")
    v5.Started = true
    v4.Bootloader:Initialize()
    v4.Bootloader:Start()
end

function v4.Configure(v7, v8) -- line 47 | captures: v4
    v4.Config:Update(v8)
end

return v4
