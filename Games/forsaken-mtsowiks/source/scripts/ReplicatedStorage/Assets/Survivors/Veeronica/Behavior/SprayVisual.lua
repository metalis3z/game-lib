-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Actors);
local _ = require(l_ReplicatedStorage_0.Modules.Statuses);
local v8 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
local v9 = {};
local v10 = {};
v10.__index = v10;
local function _(v11) --[[ Line: 34 ]] --[[ Name: __displayWarn ]]
    warn((("[Veeronica/SprayVisual]: %*"):format(v11)));
end;
local function _(v13, v14, v15) --[[ Line: 38 ]] --[[ Name: __changeProperty ]]
    if v13[v14] ~= v15 then
        v13[v14] = v15;
    end;
end;
v10.getObject = function(v17) --[[ Line: 44 ]] --[[ Name: getObject ]]
    -- upvalues: v9 (copy)
    return v9[v17];
end;
v10.new = function(v18, v19) --[[ Line: 48 ]] --[[ Name: new ]]
    -- upvalues: v10 (copy), v8 (copy), v4 (copy), v3 (copy), l_RunService_0 (copy)
    local v20 = setmetatable({}, v10);
    local v21 = v18.Player == game.Players.LocalPlayer;
    v20.Root = v19;
    v20.Owner = v18.Player;
    v20.IsLocal = v21;
    v20.Maid = v8.new();
    v20.Model = v20:Create(v18);
    v20.Range = v18.Config.VandalismRange;
    v20.Width = v18.Config.VandalismWidth;
    v20.LastProgression = v19:GetAttribute("Progression") or 0;
    v20.LastProgressionChange = 0;
    v20.Sounds = {};
    for _, v23 in ipairs({
        "Progression", 
        "Wiping", 
        "Completed", 
        "Destroyed"
    }) do
        local v24 = v18.Config.Sounds[("Spray%*"):format(v23)];
        if v24 then
            v20.Sounds[v23] = if typeof(v24) == "table" then v4:CopyTable(v24) else v24;
        else
            local v25 = ("Failed to cache sound %*!"):format(v23);
            warn((("[Veeronica/SprayVisual]: %*"):format(v25)));
        end;
    end;
    if v21 then
        v20.IndicationBeam = v20:CreateIndicationBeam(v18);
        v20.ProgressBar = v20:CreateProgressBar(v18);
        v20.RangeIndicator = v20:CreateRangeIndicator(v18);
        v20:ToggleBeam(true);
        v20:ToggleInRange(true);
    end;
    local v26 = v3:Play(v20.Sounds.Progression, {
        Looped = true, 
        Parent = v20.Model
    });
    local v27 = v3:Play(v20.Sounds.Wiping, {
        Looped = true, 
        Parent = v20.Model
    });
    v20.Maid:Add(l_RunService_0.PreRender:Connect(function() --[[ Line: 89 ]]
        -- upvalues: v20 (copy), v27 (copy), v26 (copy)
        if os.clock() - v20.LastProgressionChange < 0.05 then
            return;
        else
            local l_v27_0 = v27;
            if l_v27_0.Playing ~= false then
                l_v27_0.Playing = false;
            end;
            l_v27_0 = v26;
            if l_v27_0.Playing ~= false then
                l_v27_0.Playing = false;
            end;
            return;
        end;
    end));
    v20.Maid:Add(v19:GetAttributeChangedSignal("Progression"):Connect(function() --[[ Line: 95 ]]
        -- upvalues: v19 (copy), v20 (copy), v26 (copy), v27 (copy)
        local v29 = v19:GetAttribute("Progression") or 1;
        if v29 - v20.LastProgression > 0 then
            local l_v26_0 = v26;
            if l_v26_0.Playing ~= true then
                l_v26_0.Playing = true;
            end;
            l_v26_0 = v27;
            if l_v26_0.Playing ~= false then
                l_v26_0.Playing = false;
            end;
        elseif v29 - v20.LastProgression < 0 then
            local l_v27_1 = v27;
            if l_v27_1.Playing ~= true then
                l_v27_1.Playing = true;
            end;
            l_v27_1 = v26;
            if l_v27_1.Playing ~= false then
                l_v27_1.Playing = false;
            end;
        end;
        v20:ProgressionChanged(v29);
        v20.LastProgression = v29;
        v20.LastProgressionChange = os.clock();
    end));
    v20.Maid:Add(v19:GetAttributeChangedSignal("Completed"):Connect(function() --[[ Line: 112 ]]
        -- upvalues: v19 (copy), v3 (ref), v20 (copy)
        if v19:GetAttribute("Completed") then
            v3:Play(v20.Sounds.Completed, {
                Parent = v20.Model
            });
            v20:OnCompleted();
            return;
        else
            v20:OnUncompleted();
            return;
        end;
    end));
    v20.Maid:Add(v26);
    v20.Maid:Add(v27);
    v18.SprayVisuals[v19] = v20;
    return v20;
end;
v10.Destroy = function(v32) --[[ Line: 129 ]] --[[ Name: Destroy ]]
    -- upvalues: v3 (copy)
    if v32.Dead then
        return;
    else
        v32.Dead = true;
        local l_v32_Actor_0 = v32:GetActor();
        if l_v32_Actor_0 and l_v32_Actor_0.SprayVisuals then
            l_v32_Actor_0.SprayVisuals[v32.Root] = nil;
        else
            warn("Failed to remove cached SprayVisual!");
        end;
        v3:Play(v32.Sounds.Destroyed, {
            Parent = v32.Model
        });
        task.spawn(v32.ToggleBeam, v32, false);
        task.spawn(v32.OnDestroyed, v32);
        v32.Maid:Destroy();
        table.clear(v32);
        return;
    end;
end;
v10.Create = function(v34, v35) --[[ Line: 152 ]] --[[ Name: Create ]]
    local v36 = if v35 and v35.Player and v35.Player.Name == "ffPrankster" then {
        "rbxassetid://83450503791840"
    } else if math.random(1, 25000) == 1 then v35.Config.VandalismRareSprayImages else v35.Config.VandalismSprayImages;
    local v37 = v35.Config.VandalismPreset:Clone();
    v37.ImageBeam.Texture = v36[math.random(#v36)];
    v37.ImageBeam.Width0 = 3;
    v37.ImageBeam.Width1 = 3;
    v37.ImageBeam.Brightness = 0;
    v37.Name = ("%*Spray"):format(v35.Player.Name);
    v37.Parent = workspace.Map.Ingame;
    v37.CFrame = v34.Root:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0);
    v37.Name = "GraffitiCL";
    assert(v37 and v37:IsA("BasePart"), "SprayVisual must be a BasePart!");
    return v37;
end;
v10.CreateIndicationBeam = function(v38, v39) --[[ Line: 171 ]] --[[ Name: CreateIndicationBeam ]]
    if not v39.Rig or not v39.Rig:FindFirstChild("Torso") then
        warn("[Veeronica/SprayVisual]: Failed to find torso for indication beam!");
        return;
    else
        local v40 = v39.Config.VandalismSprayBeam:Clone();
        v40.Enabled = false;
        v40.Attachment0 = v38.Model.AttachmentMain;
        v40.Attachment1 = v39.Rig.Torso.BodyBackAttachment;
        v40.Parent = v38.Model;
        return v40;
    end;
end;
v10.CreateProgressBar = function(v41, _) --[[ Line: 186 ]] --[[ Name: CreateProgressBar ]]
    local v43 = script.BillboardGui:Clone();
    v43.Parent = v41.Model;
    v43.StudsOffset = Vector3.new(0, 0, 0.05000000074505806, 0);
    return v43;
end;
v10.CreateRangeIndicator = function(v44, _) --[[ Line: 194 ]] --[[ Name: CreateRangeIndicator ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local v46 = l_ReplicatedStorage_0.Assets.Instances.Nothingburger:Clone();
    v46.Size = vector.create(v44.Width, v44.Width, v44.Range);
    v46.Parent = v44.Model;
    v46.CFrame = v44.Root:GetPivot() * CFrame.new(0, 0, v44.Range / 2 + 1);
    v46.Transparency = 1;
    v46.Name = "SprayRangeIndicator";
    return v46;
end;
v10.OnDestroyed = function(v47) --[[ Line: 206 ]] --[[ Name: OnDestroyed ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_Model_0 = v47.Model;
    if l_Model_0 then
        local v49 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local l_ImageBeam_0 = l_Model_0.ImageBeam;
        local l_AttachmentBottom_0 = l_Model_0.AttachmentBottom;
        l_TweenService_0:Create(l_ImageBeam_0, v49, {
            Width0 = 0, 
            Width1 = 0, 
            Brightness = -0.5
        }):Play();
        l_TweenService_0:Create(l_AttachmentBottom_0, v49, {
            Position = Vector3.new(0, -2.5, 0, 0), 
            Orientation = Vector3.new(50, 0, 90, 0)
        });
        if v47.RangeIndicator then
            l_TweenService_0:Create(v47.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end;
        v47:ToggleBeam(false);
        game.Debris:AddItem(l_Model_0, 2);
        return;
    else
        warn("what is happpening");
        return;
    end;
end;
v10.ToggleInRange = function(v52, v53) --[[ Line: 229 ]] --[[ Name: ToggleInRange ]]
    v52.RangeIndicator.Color = if v53 then Color3.new(0, 1, 0) else Color3.new(1, 0, 0);
end;
v10.ToggleBeam = function(v54, v55) --[[ Line: 233 ]] --[[ Name: ToggleBeam ]]
    if not v54.IndicationBeam then
        return;
    else
        v54.IndicationBeam.Enabled = v55;
        v54:ToggleBar(v55 and not v54.Completed);
        return;
    end;
end;
v10.ToggleBar = function(v56, v57) --[[ Line: 240 ]] --[[ Name: ToggleBar ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v56.ProgressBar then
        return;
    else
        local v58 = TweenInfo.new(0.35);
        l_TweenService_0:Create(v56.ProgressBar.Background, v58, {
            BackgroundTransparency = v57 and 0.35 or 1
        }):Play();
        l_TweenService_0:Create(v56.ProgressBar.Outline, v58, {
            BackgroundTransparency = v57 and 0.35 or 1
        }):Play();
        l_TweenService_0:Create(v56.ProgressBar.Background.Bar, v58, {
            BackgroundTransparency = v57 and 0.35 or 1
        }):Play();
        return;
    end;
end;
v10.UpdateBeam = function(v59, v60) --[[ Line: 250 ]] --[[ Name: UpdateBeam ]]
    if not v59.IndicationBeam then
        return;
    else
        local _ = v59:GetActor();
        local v62 = {
            IN = Color3.fromRGB(13, 255, 0), 
            INBAD = Color3.fromRGB(255, 204, 0), 
            OUT = Color3.fromRGB(255, 46, 46)
        };
        local v63 = v60 and (if v59.Completed then v62.IN else v62.INBAD) or v62.OUT;
        v59.IndicationBeam.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v63), 
            ColorSequenceKeypoint.new(1, v63)
        });
        return;
    end;
end;
v10.ProgressionChanged = function(v64, v65) --[[ Line: 265 ]] --[[ Name: ProgressionChanged ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(math.clamp(v65 / 100, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local l_Model_1 = v64.Model;
    local l_ImageBeam_1 = l_Model_1.ImageBeam;
    local _ = l_Model_1.AttachmentBottom;
    l_TweenService_0:Create(l_ImageBeam_1, TweenInfo.new(0.08), {
        Brightness = l_l_TweenService_0_Value_0 / 2 + 0.5, 
        Width0 = l_l_TweenService_0_Value_0 * 2 + 3, 
        Width1 = l_l_TweenService_0_Value_0 * 2 + 3
    }):Play();
    local v70 = if v64.IsLocal then 0.5 - l_l_TweenService_0_Value_0 * 0.5 else 0.9 - l_l_TweenService_0_Value_0 * 0.2;
    l_ImageBeam_1.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, v70), 
        NumberSequenceKeypoint.new(1, v70)
    });
    if v64 and v64.ProgressBar and v64.ProgressBar:FindFirstChild("Background") then
        l_TweenService_0:Create(v64.ProgressBar.Background.Bar, TweenInfo.new(0.05), {
            Size = UDim2.fromScale(l_l_TweenService_0_Value_0, 1)
        }):Play();
    end;
end;
v10.OnCompleted = function(v71) --[[ Line: 288 ]] --[[ Name: OnCompleted ]]
    -- upvalues: l_TweenService_0 (copy)
    v71.Completed = true;
    if v71.RangeIndicator then
        l_TweenService_0:Create(v71.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0.8
        }):Play();
    end;
    v71:ToggleBar(false);
    v71.Model.ImageBeam.LightEmission = 2;
    l_TweenService_0:Create(v71.Model.ImageBeam, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        LightEmission = 0
    }):Play();
end;
v10.OnUncompleted = function(v72) --[[ Line: 300 ]] --[[ Name: OnUncompleted ]]
    -- upvalues: l_TweenService_0 (copy)
    v72.Complete = false;
    v72:ToggleBar(true);
    if v72.RangeIndicator then
        l_TweenService_0:Create(v72.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();
    end;
end;
v10.GetActor = function(v73) --[[ Line: 309 ]] --[[ Name: GetActor ]]
    -- upvalues: v6 (copy)
    return v6.CurrentActors[v73.Owner];
end;
return v10;