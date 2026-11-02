-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local SeasonController = require(Players.LocalPlayer.PlayerScripts.Controllers.SeasonController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Countdown");
    v3.Title = v3.Frame:WaitForChild("Title");
    v3._thread = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 28
    p4:_Update();
end;

function u1.Close(p5) -- Line: 32
    p5:_Cleanup();
end;

function u1._Cleanup(p6) -- Line: 40
    if p6._thread then
        task.cancel(p6._thread);
        p6._thread = nil;
    end;
end;

function u1._Update(u7) -- Line: 47
    -- upvalues: SeasonController (copy)
    u7.Frame.Visible = SeasonController:GetTimeRemaining() ~= nil;

    if not u7.Frame.Visible then
        return;
    end;

    u7:_Cleanup();
    u7._thread = task.spawn(function() -- Line: 56
        -- upvalues: u7 (copy), SeasonController (ref)
        while true do
            u7.Title.Text = SeasonController:GetCountdownText() .. " — Your final ELO determines your Ranked season rewards!";
            wait(1);
        end;
    end);
end;

function u1._Init(p8) -- Line: 64
end;

return u1;