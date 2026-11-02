-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Modules = require(script.Parent.Parent.Modules);
local SoundController = require(Modules.Controllers.SoundController);

return {
    Setup = function(p1) -- Line: 5, Name: Setup
        -- upvalues: SoundController (copy)
        local v2 = {};
        local Button = p1.Button;
        local Callback = p1.Callback;
        local OnHover = p1.OnHover;
        local OnUnhover = p1.OnUnhover;
        table.insert(v2, Button.MouseEnter:Connect(function() -- Line: 13
            -- upvalues: SoundController (ref), OnHover (copy), Button (copy)
            SoundController.PlaySound("HOVER");

            if OnHover then
                OnHover(Button);
            end;
        end));

        if OnUnhover then
            table.insert(v2, Button.MouseLeave:Connect(function() -- Line: 22
                -- upvalues: OnUnhover (copy), Button (copy)
                OnUnhover(Button);
            end));
            OnUnhover(Button);
        end;

        table.insert(v2, Button.Activated:Connect(function() -- Line: 28
            -- upvalues: SoundController (ref), Callback (copy)
            SoundController.PlaySound("CLICK");

            if Callback then
                Callback();
            end;
        end));
    end
};