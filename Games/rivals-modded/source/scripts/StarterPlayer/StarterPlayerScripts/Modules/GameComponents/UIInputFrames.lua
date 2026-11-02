-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._UpdateElement(p3, p4) -- Line: 27
    -- upvalues: ControlsController (copy)
    p4:WaitForChild("MouseKeyboard").Visible = ControlsController.CurrentControls == "MouseKeyboard";
    p4:WaitForChild("Gamepad").Visible = ControlsController.CurrentControls == "Gamepad";
    p4:WaitForChild("Touch").Visible = ControlsController.CurrentControls == "Touch";
end;

function u1._UpdateAllElements(p5) -- Line: 33
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("UIInputFrame")) do
        p5:_UpdateElement(v);
    end;
end;

function u1._Init(u6) -- Line: 39
    -- upvalues: CollectionService (copy), ControlsController (copy)
    CollectionService:GetInstanceAddedSignal("UIInputFrame"):Connect(function(p7) -- Line: 40
        -- upvalues: u6 (copy)
        u6:_UpdateElement(p7);
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 44
        -- upvalues: u6 (copy)
        u6:_UpdateAllElements();
    end);
    task.spawn(u6._UpdateAllElements, u6);
end;

return u1._new();