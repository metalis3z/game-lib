-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedClass = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ReplicatedClass"));
local SparseCodec = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("SparseCodec"));
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

-- The server packs tables with gaps in their keys (EquippedEmotes) so a remote does not cut
-- them short; every value that arrives passes through here on its way in.
function u1.Set(p0, p1, p2)
    ReplicatedClass.Set(p0, p1, SparseCodec.Decode(p2));
end;

function u1.new(p2) -- Line: 9
    -- upvalues: ReplicatedClass (copy), u1 (copy)
    -- ReplicatedClass.new stores the first snapshot before this class's Set exists on the
    -- object, so that snapshot is unpacked here.
    if type(p2) == "table" and type(p2.Data) == "table" then
        for i, v in pairs(p2.Data) do
            p2.Data[i] = SparseCodec.Decode(v);
        end;
    end;

    local v3 = ReplicatedClass.new(p2, true);
    local v4 = setmetatable(v3, u1);
    v4:_Init();

    return v4;
end;

function u1._Init(p5) -- Line: 27
end;

return u1;