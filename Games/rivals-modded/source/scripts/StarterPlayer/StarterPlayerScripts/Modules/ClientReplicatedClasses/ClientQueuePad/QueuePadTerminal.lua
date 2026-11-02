-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientQueuePad = p2;
    v3._model = v3.ClientQueuePad:Get("Model"):WaitForChild("Visuals"):WaitForChild("Terminal");
    v3._proximity_prompt = v3._model:WaitForChild("Prompt"):WaitForChild("ProximityPrompt");
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 27
end;

function u1._Setup(p5) -- Line: 35
    -- upvalues: CONSTANTS (copy), Players (copy)
    p5._proximity_prompt.ObjectText = p5.ClientQueuePad:Get("Model").Name;
    p5._proximity_prompt.MaxActivationDistance = 8;

    if not CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId) then
        task.defer(p5._model.Destroy, p5._model);
    end;
end;

function u1._Init(u6) -- Line: 44
    -- upvalues: Pages (copy)
    u6._proximity_prompt.Triggered:Connect(function() -- Line: 45
        -- upvalues: Pages (ref), u6 (copy)
        Pages.PageSystem:OpenPage("EditQueuePad", true);
        Pages.PageSystem:WaitForPage("EditQueuePad"):SetQueuePad(u6.ClientQueuePad);
    end);
    u6:_Setup();
end;

return u1;