-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_ProfileFrame_0 = require(script.Parent.Parent:WaitForChild("Handlers"):WaitForChild("ProfileFrame"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = l_Knit_0.CreateController({
    Name = "StatsController"
});
v5.KnitInit = function(v6) --[[ Line: 13 ]] --[[ Name: KnitInit ]]
    v6.PlayerGui = nil;
    v6.ProfileFrameGui = nil;
    v6.ProfileFrameObject = nil;
end;
v5.KnitStart = function(v7) --[[ Line: 19 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v7.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v7:_initProfileFrame();
end;
v5._findProfileFrame = function(v8) --[[ Line: 24 ]] --[[ Name: _findProfileFrame ]]
    local l_ScreenFrames_0 = v8.PlayerGui:FindFirstChild("ScreenFrames");
    if not l_ScreenFrames_0 then
        return nil;
    else
        local l_ProfileFrame_1 = l_ScreenFrames_0:FindFirstChild("ProfileFrame");
        if l_ProfileFrame_1 and l_ProfileFrame_1:IsA("Frame") then
            return l_ProfileFrame_1;
        else
            return nil;
        end;
    end;
end;
v5._initProfileFrame = function(v11) --[[ Line: 38 ]] --[[ Name: _initProfileFrame ]]
    -- upvalues: l_ProfileFrame_0 (copy)
    local v12 = v11:_findProfileFrame();
    if not v12 then
        warn("[StatsController] Could not find PlayerGui.ScreenFrames.ProfileFrame");
        return;
    else
        v11.ProfileFrameGui = v12;
        if v11.ProfileFrameObject then
            v11.ProfileFrameObject:Destroy();
            v11.ProfileFrameObject = nil;
        end;
        v11.ProfileFrameObject = l_ProfileFrame_0.new(v12);
        v11.ProfileFrameObject:Init();
        return;
    end;
end;
v5.GetProfileFrameObject = function(v13) --[[ Line: 56 ]] --[[ Name: GetProfileFrameObject ]]
    return v13.ProfileFrameObject;
end;
return v5;