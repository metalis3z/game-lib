-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local PortalModel = require(script:WaitForChild("PortalModel"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 8
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._portal_models = {};
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 22
    for _, v in pairs(p3._portal_models) do
        v:Update(p4);
    end;
end;

function u1._ObjectRemoved(p5, p6) -- Line: 32
    if p5._portal_models[p6] then
        p5._portal_models[p6]:Destroy();
        p5._portal_models[p6] = nil;
    end;
end;

function u1._ObjectAdded(p7, p8) -- Line: 39
    -- upvalues: PortalModel (copy)
    p7:_ObjectRemoved(p8);
    local v9 = PortalModel.new(p8);
    p7._portal_models[p8] = v9;
end;

function u1._Init(u10) -- Line: 46
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("PortalModel"):Connect(function(p11) -- Line: 47
        -- upvalues: u10 (copy)
        u10:_ObjectRemoved(p11);
    end);
    CollectionService:GetInstanceAddedSignal("PortalModel"):Connect(function(p12) -- Line: 51
        -- upvalues: u10 (copy)
        u10:_ObjectAdded(p12);
    end);

    for _, v in pairs(CollectionService:GetTagged("PortalModel")) do
        task.spawn(u10._ObjectAdded, u10, v);
    end;
end;

return u1._new();