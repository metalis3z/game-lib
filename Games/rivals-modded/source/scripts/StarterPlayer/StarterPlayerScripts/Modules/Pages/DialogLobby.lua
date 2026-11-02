-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DialogPage = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"):WaitForChild("DialogPage"));
local u1 = setmetatable({}, DialogPage);
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: DialogPage (copy), u1 (copy)
    local v2 = DialogPage.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3._npc_name = nil;
    v3:_Init();

    return v3;
end;

function u1.SetNPCName(p4, p5) -- Line: 23
    p4._npc_name = p5;
    p4:_UpdateFetch();
end;

function u1._UpdateFetch(p6) -- Line: 32
    -- upvalues: ReplicatedStorage (copy)
    if not p6._npc_name then
        return;
    end;

    task.defer(p6._FetchDialog, p6, ReplicatedStorage.Remotes.Misc.FetchDialogLobby, p6._npc_name);
end;

function u1._Init(u7) -- Line: 40
    u7:HookDialogActionKey("OpenCreditsPage", function() -- Line: 41
        -- upvalues: u7 (copy)
        u7.OpenPage:Fire("Credits");
    end);
end;

return u1._new();