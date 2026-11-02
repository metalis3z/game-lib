-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_RunService_0 = game:GetService("RunService");
v0.IsChatActive = false;
v0.ChatWindowToggled = Instance.new("BindableEvent");
v0.SetChatWindowVisible = function(_, v3) --[[ Line: 7 ]] --[[ Name: SetChatWindowVisible ]]
    game.StarterGui:SetCore("ChatActive", v3);
end;
v0.SetWindowTransparent = function(_) --[[ Line: 11 ]] --[[ Name: SetWindowTransparent ]]
    game:GetService("TextChatService").ChatWindowConfiguration.BackgroundTransparency = 0.3;
end;
v0.SetWindowOpaque = function(_) --[[ Line: 15 ]] --[[ Name: SetWindowOpaque ]]
    game:GetService("TextChatService").ChatWindowConfiguration.BackgroundTransparency = 0;
end;
l_RunService_0.PreSimulation:Connect(function() --[[ Line: 19 ]]
    -- upvalues: v0 (copy)
    local l_IsChatActive_0 = v0.IsChatActive;
    local v7 = game.StarterGui:GetCore("ChatActive") == true;
    if l_IsChatActive_0 ~= v7 then
        v0.ChatWindowToggled:Fire(v7);
    end;
    v0.IsChatActive = v7;
end);
return v0;