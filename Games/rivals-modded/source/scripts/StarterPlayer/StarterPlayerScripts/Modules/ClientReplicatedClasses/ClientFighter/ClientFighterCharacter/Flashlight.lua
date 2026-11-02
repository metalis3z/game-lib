-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._destroyed = false;
    v3._part = nil;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6) -- Line: 21
    if not p4._part then
        return;
    end;

    local v7;

    if p6.IsActuallyFirstPerson then
        v7 = workspace.CurrentCamera.CFrame;
    elseif p4.ClientFighterCharacter.Head then
        v7 = p4.ClientFighterCharacter.Head.CFrame;
    elseif p4.ClientFighterCharacter.RootPart then
        v7 = p4.ClientFighterCharacter.RootPart.CFrame;
    else
        v7 = p4._part.CFrame;
    end;

    p4._part.CFrame = v7;
end;

function u1.Destroy(p8) -- Line: 32
    p8._destroyed = true;

    if p8._part then
        p8._part:Destroy();
    end;
end;

function u1._Verify(p9) -- Line: 44
    if p9._destroyed or not p9.ClientFighterCharacter:IsInWorld() then
        return;
    end;

    local v10 = p9.ClientFighterCharacter:Get("CameraFlashlightEnabled");

    if not v10 or p9._part then
        if not v10 and p9._part then
            p9._part:Destroy();
            p9._part = nil;
        end;

        return;
    end;

    p9._part = Instance.new("Part");
    p9._part.Size = Vector3.new(0, 0, 0);
    p9._part.Transparency = 1;
    p9._part.CanCollide = false;
    p9._part.CanTouch = false;
    p9._part.CanQuery = false;
    p9._part.Anchored = true;
    p9._part.Name = "CameraFlashlight";
    p9._part.Parent = workspace;
    local SpotLight = Instance.new("SpotLight");
    SpotLight.Range = 48;
    SpotLight.Brightness = 3;
    SpotLight.Shadows = true;
    SpotLight.Parent = p9._part;
    p9:Update(nil, nil);
end;

function u1._Init(u11) -- Line: 75
    u11.ClientFighterCharacter:GetDataChangedSignal("CameraFlashlightEnabled"):Connect(function() -- Line: 76
        -- upvalues: u11 (copy)
        u11:_Verify();
    end);
    u11.ClientFighterCharacter.EnteredWorld:Connect(function() -- Line: 80
        -- upvalues: u11 (copy)
        u11:_Verify();
    end);
    u11:_Verify();
end;

return u1;