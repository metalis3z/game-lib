-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
game:GetService("StarterGui");
local u1 = {};

local function updateScrollingFrame(p2, p3, p4) -- Line: 9
    local CanvasSize = p2.CanvasSize;

    if p4 == "Y" then
        if math.abs(CanvasSize.Y.Offset - p3.Y) <= 5 then
            return;
        end;

        p2.CanvasSize = UDim2.new(CanvasSize.X.Scale, CanvasSize.X.Offset, 0, p3.Y);

        return;
    end;

    if math.abs(CanvasSize.X.Offset - p3.X) <= 5 then
        return;
    end;

    p2.CanvasSize = UDim2.new(0, p3.X, CanvasSize.Y.Scale, CanvasSize.Y.Offset);
end;

local function instanceAdded(u5)
    if u1[u5] or not u5:IsA("ScrollingFrame") then
        return;
    end;

    local u6 = u5:FindFirstChildOfClass("UIListLayout") or u5:FindFirstChildOfClass("UIGridLayout");

    if not u6 then
        return warn("couldnt get layoutobject for scrollingframe", u5.Name);
    end;

    local Name = u5.AutomaticCanvasSize.Name;
    local state = {
        applying = false,
        pending = false
    };
    u1[u5] = state;
    u5.AutomaticCanvasSize = Enum.AutomaticSize.None;

    local function scheduleUpdate()
        if u1[u5] ~= state or state.applying or state.pending then
            return;
        end;

        state.pending = true;
        task.defer(function()
            if u1[u5] ~= state or not u5:IsDescendantOf(game) then
                return;
            end;

            state.pending = false;
            state.applying = true;
            updateScrollingFrame(u5, u6.AbsoluteContentSize, Name);
            task.defer(function()
                if u1[u5] == state then
                    state.applying = false;
                end;
            end);
        end);
    end;

    state.connection = u6:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(scheduleUpdate);
    scheduleUpdate();
end;

CollectionService:GetInstanceAddedSignal("ScrollingFrameAutomaticSizeFix"):Connect(instanceAdded);
CollectionService:GetInstanceRemovedSignal("ScrollingFrameAutomaticSizeFix"):Connect(function(p7)
    local state = u1[p7];

    if state then
        if state.connection then
            state.connection:Disconnect();
        end;

        u1[p7] = nil;
    end;
end);

for _, v in CollectionService:GetTagged("ScrollingFrameAutomaticSizeFix") do
    instanceAdded(v);
end;