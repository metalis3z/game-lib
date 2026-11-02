-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Frameworks_0 = l_ReplicatedStorage_0:WaitForChild("Frameworks");
local l_Notifications_0 = require(l_Frameworks_0:WaitForChild("Notifications"));
local v4 = l_Knit_0.CreateController({
    Name = "GlobalMessageController"
});
v4.KnitStart = function(v5) --[[ Line: 11 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v5.GlobalMessageService = l_Knit_0.GetService("GlobalMessageService");
    if v5.GlobalMessageService and v5.GlobalMessageService.GlobalMessageReceived then
        v5.GlobalMessageService.GlobalMessageReceived:Connect(function(v6) --[[ Line: 15 ]]
            -- upvalues: v5 (copy)
            v5:_onGlobalMessage(v6);
        end);
    end;
end;
v4._onGlobalMessage = function(_, v8) --[[ Line: 21 ]] --[[ Name: _onGlobalMessage ]]
    -- upvalues: l_Notifications_0 (copy)
    if typeof(v8) ~= "table" then
        return;
    else
        local v9 = v8.SenderDisplayName or v8.SenderName or "Admin";
        local v10 = tonumber(v8.SenderUserId) or 0;
        local v11 = tostring(v8.Message or "");
        if v11 == "" then
            return;
        else
            l_Notifications_0.GlobalMessage(v9, v10, v11);
            return;
        end;
    end;
end;
return v4;