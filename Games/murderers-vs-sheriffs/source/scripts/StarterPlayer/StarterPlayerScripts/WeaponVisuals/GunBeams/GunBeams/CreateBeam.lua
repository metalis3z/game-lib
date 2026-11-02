-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local function v3(v0) --[[ Line: 1 ]] --[[ Name: CreatePointPart ]]
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Transparency = 1;
    l_Part_0.Anchored = true;
    l_Part_0.CanCollide = false;
    l_Part_0.CFrame = CFrame.new(v0);
    local _ = Instance.new("Attachment", l_Part_0);
    game.Debris:AddItem(l_Part_0, 1);
    l_Part_0.Parent = game.Workspace;
    return l_Part_0;
end;
local v4 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local l_TweenService_0 = game:GetService("TweenService");
return function(v7, v8) --[[ Line: 21 ]]
    -- upvalues: v3 (copy), l_TweenService_0 (copy), v4 (copy), v5 (copy)
    local v9 = v3(v7.Position);
    local v10 = v3(v8);
    local v11 = nil;
    local l_CustomBeam_0 = v7:FindFirstChild("CustomBeam");
    if l_CustomBeam_0 then
        v11 = l_CustomBeam_0:Clone();
    else
        v11 = Instance.new("Beam");
        v11.Width0 = 0.2;
        v11.Width1 = 0.2;
        v11.LightEmission = 0.5;
        v11.LightInfluence = 0;
        v11.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), 
            NumberSequenceKeypoint.new(0.202, 0.95), 
            NumberSequenceKeypoint.new(1, 0.6)
        });
    end;
    v11.Attachment0 = v9.Attachment;
    v11.Attachment1 = v10.Attachment;
    v11.FaceCamera = true;
    v11.Parent = v9;
    wait(0.03);
    l_TweenService_0:Create(v11, v4, {
        Width0 = 0
    }):Play();
    l_TweenService_0:Create(v11, v5, {
        Width1 = 0
    }):Play();
end;