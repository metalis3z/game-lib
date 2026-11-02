-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SocialService_0 = game:GetService("SocialService");
local v2 = require(l_ReplicatedStorage_0.Packages.Net):RemoteEvent("RSVPService/Prompt");
return {
    Start = function(_) --[[ Line: 11 ]] --[[ Name: Start ]]
        -- upvalues: v2 (copy), l_SocialService_0 (copy)
        v2.OnClientEvent:Connect(function(v4) --[[ Line: 12 ]]
            -- upvalues: l_SocialService_0 (ref)
            l_SocialService_0:PromptRsvpToEventAsync((tostring(v4)));
        end);
    end
};