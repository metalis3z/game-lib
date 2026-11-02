-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait(11);
local l_TrainingAreasData_0 = _G.TrainingAreasData;
if not l_TrainingAreasData_0 then
    repeat
        task.wait(0.3);
    until _G.TrainingAreasData;
    l_TrainingAreasData_0 = _G.TrainingAreasData;
end;
local v1 = require(game.ReplicatedStorage.Signals);
local v2 = workspace.Map:WaitForChild("Chest", 20):WaitForChild("Hitbox", 20):WaitForChild("Attachment", 20);
local v3 = {
    {
        name = "Fire Bath", 
        req = 100000000
    }, 
    {
        name = "Dark Lava", 
        req = 1000000000000000
    }, 
    {
        name = "Ancient Ruins", 
        req = 1.0E20
    }, 
    {
        name = "Electra Field", 
        req = 1.0E26
    }, 
    {
        name = "Divine Realm", 
        req = 1.0E30
    }, 
    {
        name = "Frost Heaven", 
        req = 1.0E35
    }, 
    {
        name = "Fallen Star", 
        req = 1.0E40
    }
};
for v4, v5 in pairs(l_TrainingAreasData_0) do
    local v6 = v3[v4];
    if v6 then
        v5.req = v6.req;
    end;
end;
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v11 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v12 = l_ReplicatedStorage_0:WaitForChild("Communication"):WaitForChild("Request Tutorial Data");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
while l_LocalPlayer_0:GetAttribute("Aura") == nil do
    task.wait(0.2);
end;
local v14 = l_LocalPlayer_0:WaitForChild("PlayerGui", 20):WaitForChild("Tutorial", 20);
local v15 = v14:WaitForChild("Canvas", 20);
local v16 = v14:WaitForChild("Arrow", 20);
local function _() --[[ Line: 81 ]] --[[ Name: IsChestReady ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Chest_FirstClaimReadyAt");
    if typeof(l_l_LocalPlayer_0_Attribute_0) ~= "number" then
        return false;
    else
        return l_l_LocalPlayer_0_Attribute_0 <= workspace:GetServerTimeNow();
    end;
end;
local function _() --[[ Line: 90 ]] --[[ Name: HasClaimedFirstChest ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true;
end;
local l_Beam_0 = script:WaitForChild("Beam");
local v21 = workspace:WaitForChild("RebirthPad", 1e999):WaitForChild("TouchPart", 1e999):WaitForChild("Attachment", 1e999);
local v22 = workspace:WaitForChild("Training Areas", 1e999);
local function _(v23) --[[ Line: 107 ]] --[[ Name: GetZoneAttachment ]]
    -- upvalues: v22 (copy)
    return (v22:WaitForChild(v23, 1e999):WaitForChild("AreaHitbox", 1e999):WaitForChild("Attachment", 1e999));
end;
local function _() --[[ Line: 118 ]] --[[ Name: GetAura ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Aura") or 0;
end;
local function v28(v26, v27) --[[ Line: 122 ]] --[[ Name: WaitForAuraAtLeast ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    while (l_LocalPlayer_0:GetAttribute("Aura") or 0) < v26 do
        if v27 then
            v27();
        end;
        task.wait(0.25);
    end;
end;
local function _(v29, v30) --[[ Line: 131 ]] --[[ Name: FadeCanvas ]]
    -- upvalues: l_TweenService_0 (copy), v15 (copy)
    local v31 = l_TweenService_0:Create(v15, TweenInfo.new(v30, Enum.EasingStyle.Quad), {
        GroupTransparency = v29
    });
    v31:Play();
    v31.Completed:Wait();
end;
local function v34(v33) --[[ Line: 139 ]] --[[ Name: WaitForAttributeTrue ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    while not l_LocalPlayer_0:GetAttribute(v33) do
        task.wait(0.1);
    end;
end;
local v35 = {};
local v36 = false;
local v37 = nil;
local function _(v38) --[[ Line: 153 ]] --[[ Name: NotifyAreaUnlocked ]]
    -- upvalues: v11 (copy)
    v11.New(string.upper(v38) .. " UNLOCKED", "SuccessNotification");
end;
local function v50(v40) --[[ Line: 157 ]] --[[ Name: StartAreaUnlockNotifier ]]
    -- upvalues: v36 (ref), l_LocalPlayer_0 (copy), v3 (copy), v35 (copy), v11 (copy), v37 (ref)
    if v36 then
        return;
    else
        v36 = true;
        local v41 = v40 or {};
        local v42 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
        local function v48(v43) --[[ Line: 167 ]] --[[ Name: CheckAuraCrossing ]]
            -- upvalues: v3 (ref), v41 (copy), v35 (ref), v42 (ref), v11 (ref)
            for _, v45 in ipairs(v3) do
                local v46 = v45.name:gsub("%s+", "");
                if v41[v46] and not v35[v46] and v42 < v45.req and v45.req <= v43 then
                    v35[v46] = true;
                    local l_name_0 = v45.name;
                    v11.New(string.upper(l_name_0) .. " UNLOCKED", "SuccessNotification");
                end;
            end;
            v42 = v43;
        end;
        v37 = l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 182 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v48 (copy)
            local v49 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
            v48(v49);
        end);
        return;
    end;
end;
local v51 = nil;
local function _() --[[ Line: 194 ]] --[[ Name: StopArrow ]]
    -- upvalues: v51 (ref), v16 (copy)
    if v51 then
        v51:Disconnect();
        v51 = nil;
    end;
    v16.Visible = false;
end;
local function v65(v53) --[[ Line: 217 ]] --[[ Name: CreateBeamController ]]
    -- upvalues: l_Beam_0 (copy), l_RunService_0 (copy), l_LocalPlayer_0 (copy)
    local v54 = l_Beam_0:Clone();
    v54.Attachment1 = v53;
    v54.Enabled = true;
    v54.Parent = workspace;
    local v59 = {
        beam = v54, 
        targetAttachment = v53, 
        alive = true, 
        _scaleConn = nil, 
        _charConn = nil, 
        _hrpAttachment = nil, 
        AttachToCharacter = function(v55, v56) --[[ Line: 231 ]] --[[ Name: AttachToCharacter ]]
            if not v55.alive then
                return;
            else
                local l_Torso_0 = v56:FindFirstChild("Torso");
                if not l_Torso_0 or not l_Torso_0:IsA("BasePart") then
                    l_Torso_0 = v56:WaitForChild("HumanoidRootPart", 10);
                end;
                if not l_Torso_0 then
                    return;
                else
                    if v55._hrpAttachment and v55._hrpAttachment.Parent then
                        v55._hrpAttachment:Destroy();
                    end;
                    local l_Attachment_0 = Instance.new("Attachment");
                    l_Attachment_0.Name = "TutorialBeamAttachment";
                    l_Attachment_0.Parent = l_Torso_0;
                    v55._hrpAttachment = l_Attachment_0;
                    v55.beam.Attachment0 = l_Attachment_0;
                    return;
                end;
            end;
        end
    };
    v59._scaleConn = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 259 ]]
        -- upvalues: v59 (copy)
        if not v59.alive then
            return;
        elseif not v59.beam.Parent then
            return;
        else
            local l_Attachment0_0 = v59.beam.Attachment0;
            local l_Attachment1_0 = v59.beam.Attachment1;
            if not l_Attachment0_0 or not l_Attachment1_0 then
                return;
            else
                local l_Magnitude_0 = (l_Attachment1_0.WorldPosition - l_Attachment0_0.WorldPosition).Magnitude;
                v59.beam.TextureLength = l_Magnitude_0 * 0.4;
                return;
            end;
        end;
    end);
    v59._charConn = l_LocalPlayer_0.CharacterAdded:Connect(function(v63) --[[ Line: 279 ]]
        -- upvalues: v59 (copy)
        v59:AttachToCharacter(v63);
    end);
    if l_LocalPlayer_0.Character then
        v59:AttachToCharacter(l_LocalPlayer_0.Character);
    else
        v59:AttachToCharacter(l_LocalPlayer_0.CharacterAdded:Wait());
    end;
    v59.Destroy = function(v64) --[[ Line: 289 ]] --[[ Name: Destroy ]]
        if not v64.alive then
            return;
        else
            v64.alive = false;
            if v64._scaleConn then
                v64._scaleConn:Disconnect();
                v64._scaleConn = nil;
            end;
            if v64._charConn then
                v64._charConn:Disconnect();
                v64._charConn = nil;
            end;
            if v64._hrpAttachment and v64._hrpAttachment.Parent then
                v64._hrpAttachment:Destroy();
                v64._hrpAttachment = nil;
            end;
            if v64.beam then
                v64.beam.Enabled = false;
                v64.beam.Attachment0 = nil;
                v64.beam.Attachment1 = nil;
                v64.beam:Destroy();
            end;
            return;
        end;
    end;
    return v59;
end;
local function _() --[[ Line: 322 ]] --[[ Name: ZoneUnlocked ]]
    -- upvalues: v1 (copy)
    v1.PlayRewardFX:Fire();
end;
local function _() --[[ Line: 330 ]] --[[ Name: Stage_Rebirth ]]
    -- upvalues: l_LocalPlayer_0 (copy), v65 (copy), v21 (copy), v1 (copy), v34 (copy)
    while (l_LocalPlayer_0:GetAttribute("Aura") or 0) < 1000 do
        task.wait(0.25);
    end;
    local v67 = v65(v21);
    v1.PlayRewardFX:Fire();
    v34("Tutorial_GotRebirth");
    v67:Destroy();
end;
local function v72() --[[ Line: 342 ]] --[[ Name: Stage_FirstChestClaim ]]
    -- upvalues: l_LocalPlayer_0 (copy), v65 (copy), v2 (copy), v1 (copy), v12 (copy)
    if l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true then
        return;
    else
        local v69 = v65(v2);
        v1.PlayRewardFX:Fire();
        local v70 = os.clock();
        while not (l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true) do
            if os.clock() - v70 > 6 then
                local v71 = v12:InvokeServer();
                if not v71 or not v71.ClaimedFirstChest then
                    v70 = os.clock();
                else
                    break;
                end;
            end;
            task.wait(0.1);
        end;
        v69:Destroy();
        return;
    end;
end;
local function v81(v73) --[[ Line: 368 ]] --[[ Name: Stage_EnterZone ]]
    -- upvalues: l_LocalPlayer_0 (copy), v22 (copy), v65 (copy), v1 (copy), v12 (copy)
    local v74 = v73:gsub("%s+", "");
    local v75 = "Tutorial_EnteredZone_" .. v74;
    if l_LocalPlayer_0:GetAttribute(v75) then
        return;
    else
        local v76 = v22:WaitForChild(v73, 1e999):WaitForChild("AreaHitbox", 1e999):WaitForChild("Attachment", 1e999);
        local v77 = v65(v76);
        v1.PlayRewardFX:Fire();
        local v78 = os.clock();
        while not l_LocalPlayer_0:GetAttribute(v75) do
            if os.clock() - v78 > 6 then
                local v79 = v12:InvokeServer();
                local v80 = v79 and v79.Zones;
                if not v80 or not v80[v74] then
                    v78 = os.clock();
                else
                    break;
                end;
            end;
            task.wait(0.1);
        end;
        v77:Destroy();
        return;
    end;
end;
local v82 = false;
local function v85() --[[ Line: 403 ]] --[[ Name: TryDoChestStage ]]
    -- upvalues: v82 (ref), l_LocalPlayer_0 (copy), v72 (copy)
    if v82 then
        return;
    elseif l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true then
        return;
    else
        local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("Chest_FirstClaimReadyAt");
        if not (typeof(l_l_LocalPlayer_0_Attribute_1) == "number" and l_l_LocalPlayer_0_Attribute_1 <= workspace:GetServerTimeNow()) then
            return;
        else
            v82 = true;
            local v84;
            v84, l_l_LocalPlayer_0_Attribute_1 = pcall(function() --[[ Line: 418 ]]
                -- upvalues: v72 (ref)
                v72();
            end);
            v82 = false;
            if not v84 then
                warn("[Tutorial Chest] crashed:", l_l_LocalPlayer_0_Attribute_1);
            end;
            return;
        end;
    end;
end;
local function v92() --[[ Line: 433 ]] --[[ Name: RunTutorial ]]
    -- upvalues: v12 (copy), v50 (copy), v14 (copy), v16 (copy), l_LocalPlayer_0 (copy), v65 (copy), v21 (copy), v1 (copy), v34 (copy), v85 (copy), v3 (copy), v28 (copy), v81 (copy)
    local v86 = v12:InvokeServer();
    local v87 = v86 and v86.Zones or {};
    v50(v87);
    v14.Enabled = true;
    v16.Visible = false;
    if not v86 or not v86.GotRebirth then
        while (l_LocalPlayer_0:GetAttribute("Aura") or 0) < 1000 do
            task.wait(0.25);
        end;
        local v88 = v65(v21);
        v1.PlayRewardFX:Fire();
        v34("Tutorial_GotRebirth");
        v88:Destroy();
        task.wait(0.25);
    end;
    v85();
    for _, v90 in ipairs(v3) do
        if not v87[v90.name:gsub("%s+", "")] then
            v28(v90.req, v85);
            v85();
            v81(v90.name);
            task.wait(0.25);
            v85();
        end;
    end;
    if not (l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true) then
        while true do
            local l_l_LocalPlayer_0_Attribute_2 = l_LocalPlayer_0:GetAttribute("Chest_FirstClaimReadyAt");
            if not (typeof(l_l_LocalPlayer_0_Attribute_2) == "number" and l_l_LocalPlayer_0_Attribute_2 <= workspace:GetServerTimeNow()) and not (l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true) then
                task.wait(0.25);
            else
                break;
            end;
        end;
        v85();
    end;
    v14.Enabled = false;
end;
task.spawn(function() --[[ Line: 472 ]]
    -- upvalues: v92 (copy), v14 (copy), v51 (ref), v16 (copy)
    local l_status_0, l_result_0 = pcall(v92);
    if not l_status_0 then
        warn("[Tutorial] crashed:", l_result_0);
        v14.Enabled = false;
        if v51 then
            v51:Disconnect();
            v51 = nil;
        end;
        v16.Visible = false;
    end;
end);