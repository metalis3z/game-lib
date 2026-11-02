-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._chat_bubble_mover = Instance.new("Part");
    v3._chat_bubble_mover_weld = nil;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6) -- Line: 21
end;

function u1.Destroy(p7) -- Line: 25
    if p7._chat_bubble_mover then
        p7._chat_bubble_mover:Destroy();
    end;
end;

function u1._Update(u8) -- Line: 35
    if u8._destroyed then
        return;
    end;

    local u9 = u8.ClientFighterCharacter.ClientFighter:Get("IsMatchmaking");

    if u9 and u8._chat_bubble_mover.Parent or not (u9 or u8._chat_bubble_mover.Parent) then
        return;
    end;

    pcall(function() -- Line: 48
        -- upvalues: u8 (copy), u9 (copy)
        u8._chat_bubble_mover.Parent = u9 and u8.ClientFighterCharacter.RootPart or nil;
    end);

    if u9 then
        if u8._chat_bubble_mover_weld then
            u8._chat_bubble_mover_weld:Destroy();
        end;

        u8._chat_bubble_mover.CFrame = u8.ClientFighterCharacter.RootPart.CFrame + Vector3.new(0, 5, 0);
        u8._chat_bubble_mover_weld = Instance.new("WeldConstraint");
        u8._chat_bubble_mover_weld.Part0 = u8.ClientFighterCharacter.RootPart;
        u8._chat_bubble_mover_weld.Part1 = u8._chat_bubble_mover;
        u8._chat_bubble_mover_weld.Parent = u8._chat_bubble_mover;
    end;
end;

function u1._SafeUpdate(p10) -- Line: 67
    task.defer(p10._Update, p10);
end;

function u1._Setup(p11) -- Line: 71
    p11._chat_bubble_mover.CanCollide = false;
    p11._chat_bubble_mover.CanTouch = false;
    p11._chat_bubble_mover.CanQuery = false;
    p11._chat_bubble_mover.Massless = true;
    p11._chat_bubble_mover.Transparency = 1;
    p11._chat_bubble_mover.Size = Vector3.new(1, 1, 1);
end;

function u1._Init(u12) -- Line: 80
    u12.ClientFighterCharacter:AddConnection(u12.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsMatchmaking"):Connect(function() -- Line: 81
        -- upvalues: u12 (copy)
        u12:_SafeUpdate();
    end));
    u12:_Setup();
    u12:_SafeUpdate();
end;

return u1;