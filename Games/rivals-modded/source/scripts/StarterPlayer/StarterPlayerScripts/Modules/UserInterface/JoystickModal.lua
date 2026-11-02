-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "JoystickModal");
    v2:_Init();

    return v2;
end;

function u1._Update(p3) -- Line: 29
    -- upvalues: Pages (copy)
    p3.Frame.Visible = Pages.PageSystem.CurrentPage ~= nil;
end;

function u1._Init(u4) -- Line: 33
    -- upvalues: Pages (copy)
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 34
        -- upvalues: u4 (copy)
        u4:_Update();
    end);
    u4:_Update();
end;

return u1._new();