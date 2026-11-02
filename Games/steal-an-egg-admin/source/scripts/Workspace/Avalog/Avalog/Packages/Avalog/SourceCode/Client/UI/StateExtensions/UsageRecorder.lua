-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local States = require(script.Parent.Parent.States)
local client = require(Parent.SourceCode.Shared.Zap.client)
local v1 = Fusion.scoped(Fusion)
local v2 = {}

function v2.Start(v3) -- line 14 | captures: Fusion, States, client, v1
    v1:Observer(States.Open):onChange(function() -- line 15 | captures: Fusion, States, client
        client.RecordMenuToggle.Fire(Fusion.peek(States.Open))
    end)
end

function v2.Destroy(v4) -- line 20
end

return v2
