-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent
local Skilift = require(Parent.Parent.Skilift)
local Signal = require(Parent.Parent.Signal)
local Stator = require(Parent.Parent.Stator)
local Sift = require(Parent.Parent.Sift)

local function NewPlayerDataStore(v1) -- line 9 | captures: Players, Skilift, Signal, Stator, Sift
    local v2 = {
        Store = Skilift.store(v1),
        Profiles = {},
        Loaded = Signal.new(),
        Unloaded = Signal.new()
    }

    function v2.Load(v3, v4) -- line 19 | captures: v2, Stator, Sift
        if v2.Profiles[v4] ~= nil then
            return
        end
        local v5 = {
            Session = v2.Store:load((("%*"):format(v4.UserId))),
            Data = Stator(nil, {})
        }
        v5.Session:userid(v4.UserId)
        v5.Session:updated(function(v6) -- line 31 | captures: v5, Sift
            v5.Data:Update(function() -- line 32 | captures: v6, Sift
                return Sift.Dictionary.copyDeep(v6)
            end)
        end)
        v2.Profiles[v4] = v5
        v2.Loaded:Fire(v4, v5)
    end

    function v2.Unload(v7, v8) -- line 41 | captures: v2
        local v9 = v2:Get(v8)
        if v9 == nil then
            return
        end
        v9.Session:stop()
        v2.Profiles[v8] = nil
        v2.Unloaded:Fire(v8)
    end

    function v2.Get(v10, v11) -- line 52 | captures: v2
        return v2.Profiles[v11]
    end

    function v2.Start(v12) -- line 56 | captures: v2, Players
        for v13, v14 in ipairs(Players:GetPlayers()) do
            v2:Load(v14)
        end
        Players.PlayerAdded:Connect(function(v15) -- line 61 | captures: v2
            v2:Load(v15)
        end)
        Players.PlayerRemoving:Connect(function(v16) -- line 65 | captures: v2
            v2:Unload(v16)
        end)
    end

    return v2
end

return NewPlayerDataStore
