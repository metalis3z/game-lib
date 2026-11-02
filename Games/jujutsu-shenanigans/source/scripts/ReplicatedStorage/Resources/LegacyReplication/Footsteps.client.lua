-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Value_0 = script:WaitForChild("playa").Value;
local l_TweenService_0 = game:GetService("TweenService");
local v2 = l_Value_0:WaitForChild("Humanoid", 1);
local v3 = l_Value_0:WaitForChild("HumanoidRootPart", 1);
local v4 = false;
if game.Players.LocalPlayer.Name == l_Value_0.Name then
    v4 = true;
end;
local function v5()
    return Random.new():NextNumber(-0.075, 0.075);
end;
local _ = tick();
local function v11(v7)
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundGroup = game:GetService("SoundService").Sounds;
    l_Sound_0.Played:connect(function()
        l_Sound_0.Ended:connect(function()
            game:GetService("Debris"):AddItem(l_Sound_0, 0);
        end);
    end);
    for v9, v10 in pairs(v7) do
        l_Sound_0[v9] = v10;
    end;
    return l_Sound_0;
end;
local v12 = Random.new();
local function _(v13, v14, v15)
    if not v14 and v13 then
        v14 = v13;
        v13 = 1;
    end;
    if not v14 and not v13 then
        v13 = 0;
        v14 = 1;
    end;
    if not v15 then
        return v12:NextNumber(v13, v14);
    else
        return v12:NextInteger(v13, v14);
    end;
end;
local v17 = false;
local _ = function(...)
    local v18 = ({
        ...
    })[1];
    v17 = true;
    for _ = 1, v18.times do
        game:service("TweenService"):Create(v2, TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CameraOffset = Vector3.new(Random.new():NextNumber(-0.075, 0.075), Random.new():NextNumber(-0.075, 0.075), v5())
        }):Play();
        wait();
    end;
    game:service("TweenService"):Create(v2, TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CameraOffset = Vector3.new()
    }):Play();
    spawn(function()
        wait(0.03);
        v17 = false;
    end);
end;
local v21 = {
    [Enum.Material.Grass] = {
        id = {
            7456850767, 
            7456850856, 
            7456850976
        }, 
        volume = 0.16, 
        add = 0.8, 
        default = 1
    }, 
    [Enum.Material.LeafyGrass] = {
        id = {
            7455224448, 
            7455224380, 
            7455224324
        }, 
        volume = 0.1, 
        add = 0.8, 
        default = 1
    }, 
    [Enum.Material.Mud] = {
        id = {
            7807902004, 
            7807902091, 
            7807902210
        }, 
        volume = 0.12, 
        add = 0.8, 
        default = 1
    }, 
    [Enum.Material.WoodPlanks] = {
        id = {
            7278039716, 
            7278039763, 
            7278039806
        }, 
        volume = 0.2, 
        default = 0.9, 
        add = 1
    }, 
    [Enum.Material.Slate] = {
        id = {
            7455224144, 
            7455246815, 
            7455224490
        }, 
        volume = 0.12, 
        default = 1, 
        add = 1
    }, 
    [Enum.Material.Sand] = {
        id = {
            7278083537, 
            7278083583, 
            7278083623
        }, 
        volume = 0.75, 
        default = 0.7, 
        add = 0.9
    }, 
    [Enum.Material.Ground] = {
        id = {
            6540746817, 
            549000724, 
            6441160246
        }, 
        volume = 0.3, 
        default = 0.7, 
        add = 0.9
    }
};
v21[Enum.Material.Wood] = v21[Enum.Material.WoodPlanks];
v21[Enum.Material.Concrete] = v21[Enum.Material.Slate];
v21[Enum.Material.SmoothPlastic] = v21[Enum.Material.Slate];
v21[Enum.Material.Pavement] = v21[Enum.Material.Slate];
v21[Enum.Material.Rock] = v21[Enum.Material.Slate];
v21[Enum.Material.Plastic] = v21[Enum.Material.Slate];
local l_Sound_1 = Instance.new("Sound");
l_Sound_1.RollOffMaxDistance = 50;
l_Sound_1.Volume = 0.45;
l_Sound_1.Looped = true;
l_Sound_1.Parent = v3;
local v23 = l_Sound_1:Clone();
v23.Volume = 0.35;
v23.SoundId = "rbxassetid://6659974418";
v23.Parent = v3;
local v24 = 0;
local v25 = nil;
local v26 = 0;
local v27 = 0;
local v28 = {};
local v29 = {
    ["108576704327746"] = 1, 
    ["82059769246886"] = 2, 
    ["100269405960944"] = 3, 
    ["136417996416954"] = 4
};
local _ = {};
local v31 = {
    ["76236696729225"] = 1, 
    ["74881728265554"] = 2, 
    ["71314931417141"] = 3, 
    ["85221064733128"] = 4
};
local v32 = 0;
v2.AnimationPlayed:connect(function(v33)
    local l_Animation_0 = v33.Animation;
    local v35 = "";
    if not l_Animation_0 then
        return ;
    else
        v35 = l_Animation_0.AnimationId:match("[/=](%d+)");
        local v36 = v29[v35];
        if v36 and not v28[v35] and l_Value_0:GetAttribute("Character") == "Esper" then
            local v37 = tick();
            v28[v35] = true;
            do
                local l_v37_0 = v37;
                v33:GetMarkerReachedSignal("swingreg"):Connect(function()
                    if tick() - l_v37_0 < 0.2 then
                        return ;
                    else
                        l_v37_0 = tick();
                        shared.repfire({
                            Effect = "Psychic Light", 
                            Count = v36, 
                            root = l_Value_0.PrimaryPart, 
                            char = l_Value_0
                        });
                        return ;
                    end;
                end);
            end;
        end;
        local v39 = v31[v35];
        if v39 and l_Value_0:GetAttribute("Character") == "Purple" and tick() - v32 > 0.15 then
            v32 = tick();
            shared.repfire({
                Effect = "Purple Light", 
                Count = v39, 
                root = l_Value_0.PrimaryPart, 
                char = l_Value_0
            });
        end;
        if v35 == "109683284976859" and not v4 then
            v33:Stop();
        end;
        if v35 == "135419696238243" then
            local v40 = {};
            local v41 = game.ReplicatedStorage.Emotes.Keys.BigKey["Big Key"]:Clone();
            v41:SetAttribute("EmoteProperty", true);
            table.insert(v40, v41);
            local l_m6d_0 = v41.m6d;
            l_m6d_0:SetAttribute("EmoteProperty", true);
            l_m6d_0.Name = "Handle";
            l_m6d_0.Part0 = l_Value_0.PrimaryPart;
            l_m6d_0.Part1 = v41.Key;
            l_m6d_0.Parent = l_Value_0.PrimaryPart;
            for _, v44 in pairs(v41:GetChildren()) do
                if v44:IsA("BasePart") then
                    v44.Transparency = 1;
                end;
            end;
            v41.Parent = l_Value_0.PrimaryPart;
            local v45 = game.ReplicatedStorage.Emotes.Keys.BigKey.Portal:Clone();
            v45:SetAttribute("EmoteProperty", true);
            table.insert(v40, v45);
            local l_m6d_1 = v45.m6d;
            l_m6d_1:SetAttribute("EmoteProperty", true);
            table.insert(v40, v45);
            l_m6d_1.Name = "Handle";
            l_m6d_1.Part0 = l_Value_0.PrimaryPart;
            l_m6d_1.Part1 = v45.Union;
            l_m6d_1.Parent = l_Value_0.PrimaryPart;
            v45:ScaleTo(0.01);
            v45.Parent = l_Value_0.PrimaryPart;
            local v47 = shared.sfx({
                SoundId = "rbxassetid://16720145734", 
                Parent = v45.Part, 
                Volume = 0
            });
            v47:Play();
            l_TweenService_0:Create(v47, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Volume = 1.75
            }):Play();
            local l_NumberValue_0 = Instance.new("NumberValue");
            table.insert(v40, l_NumberValue_0);
            l_NumberValue_0.Value = 0.01;
            table.insert(v40, l_NumberValue_0:GetPropertyChangedSignal("Value"):Connect(function()
                v47.RollOffMaxDistance = 200;
                v47.RollOffMinDistance = 10;
                v45:ScaleTo(l_NumberValue_0.Value);
            end));
            local l_Part_0 = v45.Part;
            l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Value = 1
            }):Play();
            local function v50()
                l_Part_0.SurfaceGui.Cover.Visible = false;
                l_TweenService_0:Create(l_Part_0.SurfaceGui.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(2.7, 0, 2.7, 0)
                }):Play();
            end;
            local v51 = {};
            local v52 = {};
            l_Part_0.Parent.glass.Transparency = 1;
            local l_v40_0 = v40 --[[ copy: 5 -> 21 ]];
            local function v64()
                for v54 = 1, 10 do
                    local v55 = l_Part_0.Parent.Union:Clone();
                    table.insert(l_v40_0, v55);
                    v55.CFrame = l_Part_0.Parent.Union.CFrame;
                    v55.Anchored = false;
                    local l_Weld_0 = Instance.new("Weld");
                    table.insert(l_v40_0, l_Weld_0);
                    l_Weld_0.Part0 = l_Part_0;
                    l_Weld_0.Part1 = v55;
                    l_Weld_0.C0 = CFrame.new() * CFrame.Angles(0, 0, 0);
                    l_Weld_0.Parent = v55;
                    v55.Parent = l_Part_0.Parent;
                    if v54 == 8 then
                        local v57 = l_Part_0.Parent.Part:Clone();
                        v57.Transparency = 1;
                        v57.Name = "Close";
                        for _ = 1, 3 do
                            local l_Sound_2 = v57:FindFirstChildOfClass("Sound");
                            if l_Sound_2 then
                                l_Sound_2:Destroy();
                            else
                                break;
                            end;
                        end;
                        v57.SurfaceGui.ImageLabel.Size = UDim2.new(2.7, 0, 2.7, 0);
                        v57.SurfaceGui.Cover.Visible = false;
                        local l_v57_0 = v57 --[[ copy: 5 -> 10 ]];
                        task.delay(0.5, function()
                            l_TweenService_0:Create(l_v57_0.SurfaceGui.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                Size = UDim2.new(0, 1, 0, 1)
                            }):Play();
                        end);
                        v57.Parent = v55;
                        local l_Weld_1 = Instance.new("Weld");
                        l_Weld_1.Part0 = v55;
                        l_Weld_1.Part1 = v57;
                        l_Weld_1.Parent = v57;
                    end;
                    l_TweenService_0:Create(l_Weld_0, TweenInfo.new(0.1 + v54 / 20, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        C0 = CFrame.new(0, -v54 / 1.5, 0)
                    }):Play();
                    table.insert(v51, {
                        l_Weld_0, 
                        v54
                    });
                    local l_CFrameValue_0 = Instance.new("CFrameValue");
                    local v63 = l_Part_0.Parent.glass:Clone();
                    v63.Transparency = 0;
                    v63.Parent = l_Part_0.Parent;
                    l_CFrameValue_0.Value = CFrame.new(-0, -0.147, 0);
                    table.insert(v52, {
                        v63, 
                        l_CFrameValue_0, 
                        v54
                    });
                    l_TweenService_0:Create(l_CFrameValue_0, TweenInfo.new(0.1 + v54 / 20, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Value = (l_Part_0.Parent.Union.CFrame * CFrame.new(0, v54 / 1.5, 0) * CFrame.new(0, -0.406677246, 0)):ToObjectSpace(l_Part_0.Parent.Union.CFrame)
                    }):Play();
                    l_TweenService_0:Create(v63, TweenInfo.new(0.1 + v54 / 20, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(4.936999797821045, 0.5199999809265137, 4.938000202178955, 0)
                    }):Play();
                end;
            end;
            local v65 = tick();
            local v66 = nil;
            do
                local l_v66_0 = v66;
                l_v66_0 = game:GetService("RunService").RenderStepped:Connect(function()
                    if not (l_Part_0 and l_Part_0.Parent and l_Part_0.Parent.Union and l_Value_0.Parent) or tick() - v65 > 15 then
                        return l_v66_0:Disconnect();
                    else
                        for _, v69 in pairs(v52) do
                            v69[1].CFrame = l_Part_0.Parent.Union.CFrame * v69[2].Value;
                        end;
                        return ;
                    end;
                end);
                table.insert(v40, l_v66_0);
                local function v77()
                    shared.sfx({
                        SoundId = "rbxassetid://16736024884", 
                        Parent = l_Part_0.Parent.Part, 
                        Volume = 2
                    }):Play();
                    for _, v71 in pairs({
                        l_Part_0.Parent.Union, 
                        l_Part_0.Parent.Part
                    }) do
                        l_TweenService_0:Create(v71, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            Size = Vector3.new(0, 0, 0, 0)
                        }):Play();
                    end;
                    for v72, v73 in pairs(v52) do
                        l_TweenService_0:Create(v73[1], TweenInfo.new(0.3 + v72 / 15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            Size = Vector3.new(0, 0, 0, 0)
                        }):Play();
                    end;
                    for v74, v75 in pairs(v51) do
                        local l_Close_0 = v75[1].Parent:FindFirstChild("Close");
                        if l_Close_0 then
                            l_TweenService_0:Create(l_Close_0, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                Size = Vector3.new()
                            }):Play();
                        end;
                        l_TweenService_0:Create(v75[1].Parent, TweenInfo.new(0.3 + v74 / 15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            Size = Vector3.new(0, 0, 0, 0)
                        }):Play();
                    end;
                end;
                local v78 = nil;
                table.insert(v40, v33:GetMarkerReachedSignal("open"):Connect(function()
                    task.delay(1.3, function()
                        v78 = shared.sfx({
                            SoundId = "rbxassetid://16720162763", 
                            Parent = l_Part_0.Parent.Part, 
                            Volume = 3
                        });
                        v78:Play();
                    end);
                    v50();
                    task.wait(0.1);
                    v64();
                    task.wait(3.25);
                    v77();
                end));
                local l_v41_0 = v41 --[[ copy: 6 -> 22 ]];
                table.insert(v40, v33:GetMarkerReachedSignal("key"):Connect(function()
                    v78.Parent = l_v41_0.Key;
                    for _, v81 in pairs(l_v41_0:GetDescendants()) do
                        if v81:IsA("BasePart") then
                            v81.Transparency = 0;
                        end;
                    end;
                end));
                table.insert(v40, v33.Stopped:connect(function()
                    for _, v83 in pairs(l_v40_0) do
                        if typeof(v83) == "RBXScriptConnection" then
                            v83:Disconnect();
                        else
                            v83:Destroy();
                        end;
                    end;
                end));
            end;
        end;
        if v35 == "76473585387076" or v35 == "118820650204678" and not v25 then
            local v84 = false;
            if v35 == "76473585387076" then
                v84 = true;
            elseif v35 == "118820650204678" then
                v25 = true;
            end;
            local v85 = nil;
            v85 = v33.KeyframeReached:connect(function(v86)
                local l_l_Value_0_Attribute_0 = l_Value_0:GetAttribute("Running");
                if v86 == "runfootstep" and not l_l_Value_0_Attribute_0 then
                    return ;
                elseif v86 ~= "runfootstep" and l_l_Value_0_Attribute_0 then
                    return ;
                elseif v86 ~= "walkfootstep" and v86 ~= "runfootstep" then
                    return ;
                else
                    local v88 = l_Value_0:FindFirstChild("DoingEmote") or l_Value_0:FindFirstChild("Freeze");
                    local l_CanWalk_0 = l_Value_0:FindFirstChild("CanWalk");
                    if v88 and v88.Name == "DoingEmote" then
                        l_CanWalk_0 = nil;
                    end;
                    if v24 > 5 and tick() - v27 > 0.125 and (not v88 or l_CanWalk_0) then
                        v27 = tick();
                        local v90 = rawget(v21, v2.FloorMaterial);
                        if v90 then
                            local _ = rawget(v90, "default") or 1;
                            local _ = rawget(v90, "add") or 0.2;
                            v26 = tick();
                            v11({
                                Volume = v90.volume, 
                                PlaybackSpeed = 1 + (l_l_Value_0_Attribute_0 and 0.35 or 0), 
                                SoundId = "rbxassetid://" .. v90.id[math.random(#v90.id)], 
                                RollOffMaxDistance = 40, 
                                Parent = v3
                            }):Play();
                        end;
                    end;
                    return ;
                end;
            end);
            do
                local l_v85_0 = v85;
                if v84 then
                    local v94 = nil;
                    do
                        local l_v94_0 = v94;
                        l_v94_0 = v33.Stopped:connect(function()
                            if l_v85_0 then
                                l_v85_0:disconnect();
                            end;
                            return l_v94_0:disconnect();
                        end);
                    end;
                end;
            end;
        end;
        return ;
    end;
end);
local _ = workspace:FindFirstChild("Ambience");
local function v98(v97)
    if not (v97 == 0) or v4 then

    end;
    v24 = v97;
end;
v2.Running:connect(v98);
l_Value_0.AttributeChanged:connect(function(v99)
    if v99 == "Running" then
        local l_v24_0 = v24;
        if not (l_v24_0 == 0) or v4 then

        end;
        v24 = l_v24_0;
    end;
end);
v2:GetPropertyChangedSignal("FloorMaterial"):connect(function()
    local l_v24_1 = v24;
    if not (l_v24_1 == 0) or v4 then

    end;
    v24 = l_v24_1;
end);
local v102 = nil;
v2.Jumping:connect(function()
    v11({
        SoundId = "rbxassetid://7005105940", 
        Parent = l_Value_0.HumanoidRootPart, 
        Volume = 0.125, 
        RollOffMaxDistance = 30
    }):Play();
    wait(0.03);
    if v102 then
        v102:disconnect();
    end;
    if v2.FloorMaterial ~= Enum.Material.Air then
        v102 = v2:GetPropertyChangedSignal("FloorMaterial"):connect(function()
            if v2.FloorMaterial ~= Enum.Material.Air then
                v11({
                    SoundId = "rbxassetid://7005105964", 
                    Parent = l_Value_0.HumanoidRootPart, 
                    Volume = 0.175, 
                    RollOffMaxDistance = 30
                }):Play();
                return v102:disconnect();
            else
                return ;
            end;
        end);
        return ;
    else
        v11({
            SoundId = "rbxassetid://7005105964", 
            Parent = l_Value_0.HumanoidRootPart, 
            Volume = 0.175, 
            RollOffMaxDistance = 30
        }):Play();
        return ;
    end;
end);
l_Value_0:GetPropertyChangedSignal("Parent"):connect(function()
    if not l_Value_0 or not l_Value_0.Parent then
        script:Destroy();
    end;
end);