-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
-- The NPCs' idle animations belong to the original game (Length 0 here); a re-uploaded id goes
-- in ServerStorage.AnimationOverrides as "Lobby_<NPC model name>".
local AnimationOverrides = require(game:GetService("ReplicatedStorage").Modules.AnimationOverrides);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 9
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._ObjectAdded(p4, p5) -- Line: 27
    while true do
        local Animation = Instance.new("Animation");
        local npc = p5.Parent;
        Animation.AnimationId = AnimationOverrides.Get("Lobby_" .. (npc and npc.Name or ""), p5:GetAttribute("IdleAnimation"));
        local success, result = pcall(p5.LoadAnimation, p5, Animation);

        if success and pcall(result.Play, result) then
            break;
        end;

        wait(1);
    end;
end;

function u1._Init(u6) -- Line: 46
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyAnimation"):Connect(function(p7) -- Line: 47
        -- upvalues: u6 (copy)
        u6:_ObjectAdded(p7);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyAnimation")) do
        task.defer(u6._ObjectAdded, u6, v);
    end;
end;

return u1._new();