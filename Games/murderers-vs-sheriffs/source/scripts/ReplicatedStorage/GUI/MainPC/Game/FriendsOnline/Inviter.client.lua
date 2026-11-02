-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_SocialService_0 = game:GetService("SocialService");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
Instance.new("ExperienceInviteOptions").PromptMessage = "Invite a friend!";
local function _(v2) --[[ Line: 10 ]] --[[ Name: canSendGameInvite ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 11 ]]
        return l_SocialService_0:CanSendGameInviteAsync(v2);
    end);
    return l_status_0 and l_result_0;
end;
script.Parent.Title.Invite.Activated:Connect(function() --[[ Line: 17 ]] --[[ Name: openInvites ]]
    local l_l_LocalPlayer_0_0 = l_LocalPlayer_0;
    local l_l_l_LocalPlayer_0_0_0 = l_l_LocalPlayer_0_0 --[[ copy: 1 -> 4 ]];
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 11 ]]
        return l_SocialService_0:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_0_0);
    end);
    if l_status_1 and l_result_1 then
        l_l_LocalPlayer_0_0, l_status_1 = pcall(function() --[[ Line: 20 ]]
            l_SocialService_0:PromptGameInvite(l_LocalPlayer_0);
        end);
    end;
end);