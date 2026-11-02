-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_CurrentRoundClient_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CurrentRoundClient"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v5 = {
    Enum.KeyCode.Q, 
    Enum.KeyCode.ButtonL1
};
local v6 = {
    Enum.KeyCode.E, 
    Enum.KeyCode.ButtonR1
};
local v7 = {};
local v8 = nil;
v0.SpectateStarted = script:WaitForChild("SpectateStarted");
v0.SpectateCancelled = script:WaitForChild("SpectateCancelled");
v0.SpectateTargetChanged = script:WaitForChild("SpectateTargetChanged");
local function _(v9) --[[ Line: 20 ]] --[[ Name: getPlayerRoundData ]]
    return l_CurrentRoundClient_0.PlayerData[v9.Name];
end;
local function _(v11) --[[ Line: 25 ]] --[[ Name: playerIsAlive ]]
    local v12 = l_CurrentRoundClient_0.PlayerData[v11.Name];
    if not v12 then
        return false;
    else
        return v12.Dead ~= true;
    end;
end;
local function _(v14) --[[ Line: 34 ]] --[[ Name: isPlayerSpectatable ]]
    if v14 == nil then
        return false;
    elseif v14.Parent == nil then
        return false;
    elseif not v14.Character then
        return false;
    elseif not v14.Character:FindFirstChildOfClass("Humanoid") then
        return false;
    else
        local v15 = l_CurrentRoundClient_0.PlayerData[v14.Name];
        if not (not not v15 and v15.Dead ~= true) then
            return false;
        else
            return true;
        end;
    end;
end;
local function _() --[[ Line: 60 ]] --[[ Name: resetCamera ]]
    if not l_LocalPlayer_0.Character then
        l_CurrentCamera_0.CameraSubject = nil;
        return;
    else
        local l_Humanoid_0 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_0 then
            l_CurrentCamera_0.CameraSubject = nil;
            return;
        else
            l_CurrentCamera_0.CameraSubject = l_Humanoid_0;
            return;
        end;
    end;
end;
local function _() --[[ Line: 76 ]] --[[ Name: unbindSpectateKeybind ]]
    l_ContextActionService_0:UnbindAction("SpectateLeft");
    l_ContextActionService_0:UnbindAction("SpectateRight");
end;
local function _() --[[ Line: 82 ]] --[[ Name: cancelSpectate ]]
    isSpectating = false;
    if not l_LocalPlayer_0.Character then
        l_CurrentCamera_0.CameraSubject = nil;
    else
        local l_Humanoid_1 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_1 then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            l_CurrentCamera_0.CameraSubject = l_Humanoid_1;
        end;
    end;
    l_ContextActionService_0:UnbindAction("SpectateLeft");
    l_ContextActionService_0:UnbindAction("SpectateRight");
    v0.SpectateCancelled:Fire();
end;
local function v26() --[[ Line: 90 ]] --[[ Name: updateCameraFocus ]]
    if not isSpectating then
        return;
    elseif v8 == nil then
        isSpectating = false;
        if not l_LocalPlayer_0.Character then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            local l_Humanoid_2 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_2 then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                l_CurrentCamera_0.CameraSubject = l_Humanoid_2;
            end;
        end;
        l_ContextActionService_0:UnbindAction("SpectateLeft");
        l_ContextActionService_0:UnbindAction("SpectateRight");
        v0.SpectateCancelled:Fire();
        return;
    elseif not v8.Character then
        isSpectating = false;
        if not l_LocalPlayer_0.Character then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            local l_Humanoid_3 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_3 then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                l_CurrentCamera_0.CameraSubject = l_Humanoid_3;
            end;
        end;
        l_ContextActionService_0:UnbindAction("SpectateLeft");
        l_ContextActionService_0:UnbindAction("SpectateRight");
        v0.SpectateCancelled:Fire();
        return;
    else
        local l_Humanoid_4 = v8.Character:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_4 then
            isSpectating = false;
            if not l_LocalPlayer_0.Character then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                local l_Humanoid_5 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
                if not l_Humanoid_5 then
                    l_CurrentCamera_0.CameraSubject = nil;
                else
                    l_CurrentCamera_0.CameraSubject = l_Humanoid_5;
                end;
            end;
            l_ContextActionService_0:UnbindAction("SpectateLeft");
            l_ContextActionService_0:UnbindAction("SpectateRight");
            v0.SpectateCancelled:Fire();
            return;
        else
            l_CurrentCamera_0.CameraSubject = l_Humanoid_4;
            v0.SpectateTargetChanged:Fire(v8);
            return;
        end;
    end;
end;
v0.CancelSpectate = function(_) --[[ Line: 116 ]] --[[ Name: CancelSpectate ]]
    isSpectating = false;
    if not l_LocalPlayer_0.Character then
        l_CurrentCamera_0.CameraSubject = nil;
    else
        local l_Humanoid_6 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_6 then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            l_CurrentCamera_0.CameraSubject = l_Humanoid_6;
        end;
    end;
    l_ContextActionService_0:UnbindAction("SpectateLeft");
    l_ContextActionService_0:UnbindAction("SpectateRight");
    v0.SpectateCancelled:Fire();
end;
v0.NavigateSpectate = function(_, v30) --[[ Line: 121 ]] --[[ Name: NavigateSpectate ]]
    local v31 = table.find(v7, v8);
    if not v31 then
        isSpectating = false;
        if not l_LocalPlayer_0.Character then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            local l_Humanoid_7 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_7 then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                l_CurrentCamera_0.CameraSubject = l_Humanoid_7;
            end;
        end;
        l_ContextActionService_0:UnbindAction("SpectateLeft");
        l_ContextActionService_0:UnbindAction("SpectateRight");
        v0.SpectateCancelled:Fire();
        return;
    else
        local v33 = v31 + v30;
        if #v7 < v33 then
            v33 = 1;
        elseif v33 < 1 then
            v33 = #v7;
        end;
        local v34 = v7[v33];
        if v34 then
            v8 = v34;
            v26();
            return;
        else
            isSpectating = false;
            if not l_LocalPlayer_0.Character then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                local l_Humanoid_8 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
                if not l_Humanoid_8 then
                    l_CurrentCamera_0.CameraSubject = nil;
                else
                    l_CurrentCamera_0.CameraSubject = l_Humanoid_8;
                end;
            end;
            l_ContextActionService_0:UnbindAction("SpectateLeft");
            l_ContextActionService_0:UnbindAction("SpectateRight");
            v0.SpectateCancelled:Fire();
            return;
        end;
    end;
end;
local function v39(v36, v37, _) --[[ Line: 145 ]] --[[ Name: onSpectateKeybind ]]
    if v37 ~= Enum.UserInputState.Begin then
        return;
    elseif v36 == "SpectateLeft" then
        v0:NavigateSpectate(-1);
        return;
    else
        v0:NavigateSpectate(1);
        return;
    end;
end;
local function _() --[[ Line: 157 ]] --[[ Name: bindSpectateKeybinds ]]
    l_ContextActionService_0:BindAction("SpectateLeft", v39, false, unpack(v5));
    l_ContextActionService_0:BindAction("SpectateRight", v39, false, unpack(v6));
end;
local function _() --[[ Line: 163 ]] --[[ Name: beginSpectate ]]
    isSpectating = true;
    v0.SpectateStarted:Fire();
    if v8 == nil then
        v8 = v7[1];
    end;
    l_ContextActionService_0:BindAction("SpectateLeft", v39, false, unpack(v5));
    l_ContextActionService_0:BindAction("SpectateRight", v39, false, unpack(v6));
    v26();
end;
v0.ToggleSpectate = function(_) --[[ Line: 174 ]] --[[ Name: ToggleSpectate ]]
    if not isSpectating then
        local l_l_LocalPlayer_0_0 = l_LocalPlayer_0;
        local v44 = l_CurrentRoundClient_0.PlayerData[l_l_LocalPlayer_0_0.Name];
        if not (not not v44 and v44.Dead ~= true) then
            isSpectating = true;
            v0.SpectateStarted:Fire();
            if v8 == nil then
                v8 = v7[1];
            end;
            l_ContextActionService_0:BindAction("SpectateLeft", v39, false, unpack(v5));
            l_ContextActionService_0:BindAction("SpectateRight", v39, false, unpack(v6));
            v26();
            return;
        end;
    end;
    isSpectating = false;
    if not l_LocalPlayer_0.Character then
        l_CurrentCamera_0.CameraSubject = nil;
    else
        local l_Humanoid_9 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_9 then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            l_CurrentCamera_0.CameraSubject = l_Humanoid_9;
        end;
    end;
    l_ContextActionService_0:UnbindAction("SpectateLeft");
    l_ContextActionService_0:UnbindAction("SpectateRight");
    v0.SpectateCancelled:Fire();
end;
local function v53() --[[ Line: 183 ]] --[[ Name: onPlayerDataUpdated ]]
    local l_l_LocalPlayer_0_1 = l_LocalPlayer_0;
    local v47 = l_CurrentRoundClient_0.PlayerData[l_l_LocalPlayer_0_1.Name];
    if not not v47 and v47.Dead ~= true then
        isSpectating = false;
        if not l_LocalPlayer_0.Character then
            l_CurrentCamera_0.CameraSubject = nil;
        else
            local l_Humanoid_10 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_10 then
                l_CurrentCamera_0.CameraSubject = nil;
            else
                l_CurrentCamera_0.CameraSubject = l_Humanoid_10;
            end;
        end;
        l_ContextActionService_0:UnbindAction("SpectateLeft");
        l_ContextActionService_0:UnbindAction("SpectateRight");
        v0.SpectateCancelled:Fire();
    end;
    v7 = {};
    for _, v50 in game.Players:GetPlayers() do
        local v51;
        if v50 == nil then
            v51 = false;
        elseif v50.Parent == nil then
            v51 = false;
        elseif not v50.Character then
            v51 = false;
        elseif not v50.Character:FindFirstChildOfClass("Humanoid") then
            v51 = false;
        else
            local v52 = l_CurrentRoundClient_0.PlayerData[v50.Name];
            v51 = not not (not not v52 and v52.Dead ~= true);
        end;
        if v51 then
            table.insert(v7, v50);
        end;
    end;
    if v8 ~= nil and not table.find(v7, v8) then
        if #v7 > 0 then
            v8 = v7[math.random(1, #v7)];
        else
            v8 = nil;
        end;
    end;
    v26();
end;
for _, v55 in game.Players:GetPlayers() do
    local v56;
    if v55 == nil then
        v56 = false;
    elseif v55.Parent == nil then
        v56 = false;
    elseif not v55.Character then
        v56 = false;
    elseif not v55.Character:FindFirstChildOfClass("Humanoid") then
        v56 = false;
    else
        local v57 = l_CurrentRoundClient_0.PlayerData[v55.Name];
        v56 = not not (not not v57 and v57.Dead ~= true);
    end;
    if v56 then
        table.insert(v7, v55);
    end;
end;
l_CurrentRoundClient_0.PlayerDataChanged.Event:Connect(v53);
return v0;