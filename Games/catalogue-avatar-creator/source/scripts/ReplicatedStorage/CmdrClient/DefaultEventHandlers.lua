-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("StarterGui");
local Window = require(script.Parent.CmdrInterface.Window);

return function(p1) -- Line: 4
    -- upvalues: Window (copy)
    p1:HandleEvent("Message", function(p2) -- Line: 5
        game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(("<font color=\'rgb(249, 217, 56)\'>[Announcement] %s</font>"):format(p2));
    end);
    p1:HandleEvent("AddLine", function(...) -- Line: 14
        -- upvalues: Window (ref)
        Window:AddLine(...);
    end);
end;