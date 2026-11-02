-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local function v3(v0) --[[ Line: 1 ]] --[[ Name: CreatePointPart ]]
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Transparency = 1;
    l_Part_0.Anchored = true;
    l_Part_0.Size = Vector3.new(1, 1, 1, 0);
    l_Part_0.CanCollide = false;
    l_Part_0.CanQuery = false;
    l_Part_0.CFrame = CFrame.new(v0);
    local _ = Instance.new("Attachment", l_Part_0);
    game.Debris:AddItem(l_Part_0, 1);
    l_Part_0.Parent = game.Workspace;
    return l_Part_0;
end;
local v4 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local l_TweenService_0 = game:GetService("TweenService");
return function(v7, v8, v9, v10) --[[ Line: 23 ]]
    -- upvalues: v3 (copy), l_TweenService_0 (copy), v4 (copy), v5 (copy)
    local v11 = nil;
    if typeof(v8) == "Vector3" then
        v11 = v8;
    elseif v8:IsA("BasePart") then
        v11 = v8.Position;
    elseif v8:IsA("Attachment") then
        v11 = v8.WorldPosition;
    else
        return;
    end;
    local v12 = v3(v11);
    local v13 = v3(v9);
    local v14 = nil;
    local l_CustomBeam_0 = v7:FindFirstChild("CustomBeam");
    if l_CustomBeam_0 then
        v14 = l_CustomBeam_0:Clone();
    else
        v14 = Instance.new("Beam");
        v14.Width0 = 0.2;
        v14.Width1 = 0.2;
        v14.LightEmission = 0.5;
        v14.LightInfluence = 0;
        v14.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), 
            NumberSequenceKeypoint.new(0.202, 0.95), 
            NumberSequenceKeypoint.new(1, 0.6)
        });
    end;
    v14.Attachment0 = v12.Attachment;
    v14.Attachment1 = v13.Attachment;
    v14.FaceCamera = true;
    v14.Parent = v12;
    if v10 then
        local v16 = script:WaitForChild("Sparks"):Clone();
        v16.Color = ColorSequence.new(v10.Color);
        v16.Parent = v13;
        v16:Emit(7);
    end;
    wait(0.03);
    l_TweenService_0:Create(v14, v4, {
        Width0 = 0
    }):Play();
    l_TweenService_0:Create(v14, v5, {
        Width1 = 0
    }):Play();
end;