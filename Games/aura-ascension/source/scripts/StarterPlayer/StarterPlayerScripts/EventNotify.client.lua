-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_SocialService_0 = game:GetService("SocialService");
local l_ExperienceNotificationService_0 = game:GetService("ExperienceNotificationService");
local _ = game:GetService("RunService");
local function v5() --[[ Line: 8 ]] --[[ Name: promptExperienceNotifications ]]
    -- upvalues: l_ExperienceNotificationService_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 9 ]]
        -- upvalues: l_ExperienceNotificationService_0 (ref)
        return l_ExperienceNotificationService_0:CanPromptOptInAsync();
    end);
    if l_status_0 and l_result_0 then
        pcall(function() --[[ Line: 14 ]]
            -- upvalues: l_ExperienceNotificationService_0 (ref)
            l_ExperienceNotificationService_0:PromptOptIn();
        end);
    end;
end;
local function _() --[[ Line: 20 ]] --[[ Name: promptEventRsvp ]]
    -- upvalues: l_SocialService_0 (copy)
    pcall(function() --[[ Line: 21 ]]
        -- upvalues: l_SocialService_0 (ref)
        l_SocialService_0:PromptRsvpToEventAsync("3998239861189509805");
    end);
end;
local function _() --[[ Line: 26 ]] --[[ Name: alreadyGoing ]]
    -- upvalues: l_SocialService_0 (copy)
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 27 ]]
        -- upvalues: l_SocialService_0 (ref)
        return l_SocialService_0:GetEventRsvpStatusAsync("3998239861189509805");
    end);
    return l_status_1 and l_result_1 == Enum.RsvpStatus.Going;
end;
task.delay(210, function() --[[ Line: 34 ]]
    -- upvalues: l_SocialService_0 (copy), v5 (copy)
    local l_status_2, l_result_2 = pcall(function() --[[ Line: 27 ]]
        -- upvalues: l_SocialService_0 (ref)
        return l_SocialService_0:GetEventRsvpStatusAsync("3998239861189509805");
    end);
    if l_status_2 and l_result_2 == Enum.RsvpStatus.Going then
        return;
    else
        pcall(function() --[[ Line: 21 ]]
            -- upvalues: l_SocialService_0 (ref)
            l_SocialService_0:PromptRsvpToEventAsync("3998239861189509805");
        end);
        v5();
        return;
    end;
end);