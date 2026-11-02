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
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 21
    -- upvalues: DialogPage (copy), ReplicatedStorage (copy)
    DialogPage.Open(p4, ...);
    task.defer(p4._FetchDialog, p4, ReplicatedStorage.Remotes.Misc.FetchDialogShadyChicken);
end;

function u1._Init(p5) -- Line: 30
end;

return u1._new();