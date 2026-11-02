-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules.BaseMatchmakingQueueSlot.MatchmakingQueueSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Queues");
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 26
end;

function u1.Close(p5) -- Line: 30
end;

function u1._Generate(u6, p7) -- Line: 38
    -- upvalues: Utility (copy), MatchmakingQueueSlot (copy)
    local v8 = Utility:WaitForChildRecursive(u6.Frame, p7, 3);

    if not v8 then
        return;
    end;

    MatchmakingQueueSlot.new(p7, v8).QueueStatus:Connect(function(p9) -- Line: 47
        -- upvalues: u6 (copy)
        if p9 == "Success" then
            u6.Page.Closed:Fire();

            return;
        end;

        u6.Page.PromptSystem:Open("ErrorMessage", "Whoops!", p9 or "Server failed to respond, please try again");
    end);
end;

function u1._Setup(p10) -- Line: 56
    -- upvalues: SeasonLibrary (copy)
    for _, v in pairs(SeasonLibrary.CurrentSeason.RankedQueues) do
        task.defer(p10._Generate, p10, v[1]);
    end;
end;

function u1._Init(p11) -- Line: 62
    p11:_Setup();
end;

return u1;