-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Featured, time of decompilation: Fri Feb 13 19:21:22 2026 ]]
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_CoverPhoto_0 = script.Parent:WaitForChild("CoverPhoto");
local l_EventPhoto_0 = script.Parent:WaitForChild("EventPhoto");
local l_BasePhoto_0 = script.Parent:WaitForChild("BasePhoto");
local v5 = nil;
local function v7() --[[ Line: 13 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_EventInfoService_0 (copy), l_EventPhoto_0 (copy), l_BasePhoto_0 (copy), l_CoverPhoto_0 (copy), v5 (ref), l_WindowService_0 (copy)
    local l_l_EventInfoService_0_MainEvent_0 = l_EventInfoService_0:GetMainEvent();
    if l_l_EventInfoService_0_MainEvent_0 and l_l_EventInfoService_0_MainEvent_0.EventStartInfo and l_l_EventInfoService_0_MainEvent_0.EventStartInfo.UI and l_l_EventInfoService_0_MainEvent_0.EventStartInfo.UI.ShopCover then
        l_EventPhoto_0.Image = l_l_EventInfoService_0_MainEvent_0.EventStartInfo.UI.ShopCover;
        l_EventPhoto_0.Visible = true;
        l_BasePhoto_0.Visible = false;
        l_CoverPhoto_0.Visible = false;
        if v5 then
            v5:Disconnect();
        end;
        v5 = l_EventPhoto_0:WaitForChild("BuyItem").Activated:Connect(function() --[[ Line: 24 ]]
            -- upvalues: l_WindowService_0 (ref)
            l_WindowService_0:ToggleFrame("CurrentEvent");
        end);
        return;
    elseif l_CoverPhoto_0.Visible then
        l_EventPhoto_0.Visible = false;
        l_BasePhoto_0.Visible = false;
        l_CoverPhoto_0:WaitForChild("BuyItem").Activated:Connect(function() --[[ Line: 31 ]]
            -- upvalues: l_WindowService_0 (ref)
            l_WindowService_0:ToggleFrame(nil);
        end);
        return;
    else
        l_EventPhoto_0.Visible = false;
        l_CoverPhoto_0.Visible = false;
        l_BasePhoto_0.Visible = true;
        return;
    end;
end;
l_EventInfoService_0:OnEventStarted(v7);
v7();