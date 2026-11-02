-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Chat_0 = game:GetService("Chat");
l_Chat_0.BubbleChatEnabled = true;
l_Chat_0:SetBubbleChatSettings({
    BackgroundColor3 = Color3.fromRGB(25, 25, 25), 
    TextColor3 = Color3.fromRGB(250, 250, 250), 
    LocalPlayerStudsOffset = Vector3.new(0, 0.6000000238418579, 0, 0)
});
local _ = function()
    local v2, v3 = xpcall(function()
        return game:GetService("StarterGui"):GetCore("TopbarEnabled");
    end, function(_)
        return true;
    end);
    return v2 and v3;
end;
shared.ResetButton = function(_)

end;
shared.SetCore = function(v6, v7, v8)
    if not shared.BackpackVisibility then
        return ;
    else
        if not v8 then
            for v9 = 0, 6 do
                if v9 ~= v7 then
                    if v9 ~= 2 then
                        game.StarterGui:SetCoreGuiEnabled(v9, v6);
                    else
                        game.StarterGui:SetCoreGuiEnabled(v9, false);
                    end;
                end;
            end;
        end;
        game.StarterGui:SetCoreGuiEnabled(2, false);
        shared.BackpackVisibility(v6);
        if shared.settopbar then
            shared.settopbar(v6, false);
        end;
        return ;
    end;
end;