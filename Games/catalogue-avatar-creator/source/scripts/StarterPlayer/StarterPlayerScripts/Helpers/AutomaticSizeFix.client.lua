-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local u1 = {};

local function updateSize(p2, p3, p4) -- Line: 7
    local Size = p2.Size;

    if p4 == "Y" then
        local Y = p3.Y;

        if math.abs(Size.Y.Offset - Y) <= 1 then
            return;
        end;

        p2.Size = UDim2.new(Size.X.Scale, Size.X.Offset, 0, Y);

        return;
    end;

    local X = p3.X;

    if math.abs(Size.X.Offset - X) <= 1 then
        return;
    end;

    p2.Size = UDim2.new(0, X, Size.Y.Scale, Size.Y.Offset);
end;

local function instanceAdded(u5) -- Line: 20
    -- upvalues: updateSize (copy), u1 (copy)
    local u6 = u5:FindFirstChildOfClass("UIListLayout") or u5:FindFirstChildOfClass("UIGridLayout");

    if not u6 then
        return warn("couldnt get layoutobject for scrollingframe", u5.Name);
    end;

    local Name = u5.AutomaticSize.Name;
    u5.AutomaticSize = Enum.AutomaticSize.None;
    updateSize(u5, u6.AbsoluteContentSize, Name);
    u1[u5] = u6:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 28
        -- upvalues: updateSize (ref), u5 (copy), u6 (copy), Name (copy)
        updateSize(u5, u6.AbsoluteContentSize, Name);
    end);
end;

CollectionService:GetInstanceAddedSignal("AutomaticSizeFix"):Connect(instanceAdded);
CollectionService:GetInstanceRemovedSignal("AutomaticSizeFix"):Connect(function(p7) -- Line: 33, Name: instanceRemoved
    -- upvalues: u1 (copy)
    if u1[p7] then
        u1[p7]:Disconnect();
        u1[p7] = nil;
    end;
end);

for _, v in CollectionService:GetTagged("AutomaticSizeFix") do
    instanceAdded(v);
end;