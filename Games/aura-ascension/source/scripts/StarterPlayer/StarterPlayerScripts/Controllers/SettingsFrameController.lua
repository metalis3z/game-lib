-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_SettingsFrame_0 = require(script.Parent.Parent:WaitForChild("Handlers"):WaitForChild("SettingsFrame"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = l_Knit_0.CreateController({
    Name = "SettingsFrameController"
});
v5.KnitInit = function(v6) --[[ Line: 13 ]] --[[ Name: KnitInit ]]
    v6.PlayerGui = nil;
    v6.SettingsFrameGui = nil;
    v6.SettingsFrameObject = nil;
end;
v5.KnitStart = function(v7) --[[ Line: 19 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v7.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v7:_initSettingsFrame();
end;
v5._findSettingsFrame = function(v8) --[[ Line: 24 ]] --[[ Name: _findSettingsFrame ]]
    local l_ScreenFrames_0 = v8.PlayerGui:FindFirstChild("ScreenFrames");
    if not l_ScreenFrames_0 then
        return nil;
    else
        local l_SettingsFrame_1 = l_ScreenFrames_0:FindFirstChild("SettingsFrame");
        if l_SettingsFrame_1 and l_SettingsFrame_1:IsA("Frame") then
            return l_SettingsFrame_1;
        else
            return nil;
        end;
    end;
end;
v5._initSettingsFrame = function(v11) --[[ Line: 38 ]] --[[ Name: _initSettingsFrame ]]
    -- upvalues: l_SettingsFrame_0 (copy)
    local v12 = v11:_findSettingsFrame();
    if not v12 then
        warn("[SettingsFrameController] Could not find PlayerGui.ScreenFrames.SettingsFrame");
        return;
    else
        v11.SettingsFrameGui = v12;
        if v11.SettingsFrameObject then
            v11.SettingsFrameObject:Destroy();
            v11.SettingsFrameObject = nil;
        end;
        v11.SettingsFrameObject = l_SettingsFrame_0.new(v12);
        v11.SettingsFrameObject:Init();
        return;
    end;
end;
v5.GetSettingsFrameObject = function(v13) --[[ Line: 56 ]] --[[ Name: GetSettingsFrameObject ]]
    return v13.SettingsFrameObject;
end;
return v5;