-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Entry = script:WaitForChild("Entry");
local Gui = script:WaitForChild("Gui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy), Gui (copy)
    local v3 = setmetatable({}, u1);
    v3.Root = p2;
    v3.ScreenGui = Gui:Clone();
    v3._entry_to_children = {};
    v3._entry_to_parent = {};
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 30
    p4.ScreenGui:Destroy();
    p4._entry_to_children = nil;
    p4._entry_to_parent = nil;
    p4.Root = nil;
end;

function u1._GetTabString(p5, p6) -- Line: 41
    return string.rep(" <font transparency=\"0.75\">|</font>  ", p6);
end;

function u1._ColorBasedOnType(p7, p8, p9) -- Line: 45
    if typeof(p9) == "string" then
        return "<font color=\"rgb(0,255,0)\">" .. p8 .. "</font>";
    end;

    if typeof(p9) == "number" then
        return "<font color=\"rgb(255,198,0)\">" .. p8 .. "</font>";
    end;

    if typeof(p9) == "boolean" then
        return "<font color=\"rgb(8,123,255)\">" .. p8 .. "</font>";
    end;

    if typeof(p9) == "Instance" then
        return p9.ClassName .. ": <font color=\"rgb(0,255,0)\">\"" .. p8 .. "\"</font>";
    end;

    return p8;
end;

function u1._DeleteDescendants(p10, p11) -- Line: 59
    for _, v in pairs(p10._entry_to_children[p11] or {}) do
        p10:_DeleteDescendants(v);
        p10._entry_to_children[v] = nil;
        p10._entry_to_parent[v] = nil;
        v:Destroy();
    end;
end;

function u1._CreateEntry(u12, p13) -- Line: 68
    -- upvalues: Entry (copy)
    local u14 = Entry:Clone();
    u12._entry_to_children[u14] = {};
    u12._entry_to_parent[u14] = p13;

    if p13 then
        table.insert(u12._entry_to_children[p13], u14);
    end;

    u14.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 77, Name: update_size
        -- upvalues: u14 (copy), u12 (copy)
        u14.Size = UDim2.new(0, math.max(u14.Title.TextBounds.X, u12.ScreenGui.MainFrame.List.AbsoluteCanvasSize.X), u14.Size.Y.Scale, u14.Size.Y.Offset);
    end);
    u14.Size = UDim2.new(0, math.max(u14.Title.TextBounds.X, u12.ScreenGui.MainFrame.List.AbsoluteCanvasSize.X), u14.Size.Y.Scale, u14.Size.Y.Offset);

    return u14;
end;

function u1._Generate(u15, p16, u17, p18) -- Line: 87
    -- upvalues: Utility (copy)
    local v19 = {};

    for i in pairs(p16) do
        table.insert(v19, i);
    end;

    table.sort(v19, function(p20, p21) -- Line: 94
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(tostring(p20), (tostring(p21)));
    end);
    local v22 = p18 and (p18.LayoutOrder or 0) or 0;

    for i in pairs(u15._entry_to_children) do
        if v22 < i.LayoutOrder then
            i.LayoutOrder = i.LayoutOrder + (#v19 + (p18 and 1 or 0));
        end;
    end;

    for i, v in pairs(v19) do
        local u23 = p16[v];
        local v24 = typeof(u23) == "table";
        local v25;

        if v24 then
            v25 = next(u23) ~= nil;
        else
            v25 = v24;
        end;

        local u26 = u15:_GetTabString(u17);
        local v27;

        if typeof(v) == "string" then
            v27 = "\"" .. v .. "\"";
        else
            v27 = tostring(v);
        end;

        local u28 = u15:_ColorBasedOnType(v27, v);
        local v29;

        if typeof(u23) == "string" then
            v29 = "\"" .. u23 .. "\"";
        else
            v29 = tostring(u23);
        end;

        local v30 = u15:_ColorBasedOnType(v29, u23);
        local u31 = u15:_CreateEntry(p18);
        u31.Title.Text = string.format("%s[%s] = %s;", u26, u28, v24 and "{}" or v30);
        u31.LayoutOrder = v22 + i;
        u31.Parent = u15.ScreenGui.MainFrame.List.Container;

        if v25 then
            local u32 = false;

            local function update_text() -- Line: 125
                -- upvalues: u31 (copy), u26 (copy), u28 (copy), u32 (ref)
                u31.Title.Text = string.format("%s[%s] = %s", u26, u28, u32 and "{" or "{...};");
            end;

            u31.Title.Text = string.format("%s[%s] = %s", u26, u28, u32 and "{" or "{...};");
            u31.Button.MouseButton1Click:Connect(function() -- Line: 131
                -- upvalues: u32 (ref), u31 (copy), u26 (copy), u28 (copy), u15 (copy), u23 (copy), u17 (copy)
                u32 = not u32;
                u31.Title.Text = string.format("%s[%s] = %s", u26, u28, u32 and "{" or "{...};");

                if u32 then
                    u15:_Generate(u23, u17 + 1, u31);

                    return;
                end;

                u15:_DeleteDescendants(u31);
            end);
        end;
    end;

    if p18 then
        local v33 = u15:_CreateEntry(p18);
        v33.Title.Text = u15:_GetTabString(u17 - 1) .. "};";
        v33.LayoutOrder = v22 + #v19 + 1;
        v33.Parent = u15.ScreenGui.MainFrame.List.Container;
    end;
end;

function u1._UpdateList(p34) -- Line: 152
    p34.ScreenGui.MainFrame.List.CanvasSize = UDim2.new(0, p34.ScreenGui.MainFrame.List.Container.Layout.AbsoluteContentSize.X, 0, p34.ScreenGui.MainFrame.List.Container.Layout.AbsoluteContentSize.Y);
end;

function u1._UpdateSize(p35) -- Line: 156
    p35.ScreenGui.MainFrame.List.Container.Size = UDim2.new(0, p35.ScreenGui.MainFrame.AbsoluteSize.X, 0, p35.ScreenGui.MainFrame.AbsoluteSize.Y);
end;

function u1._Init(u36) -- Line: 160
    u36.ScreenGui.MainFrame.Top.Button.MouseButton1Click:Connect(function() -- Line: 161
        -- upvalues: u36 (copy)
        u36:Destroy();
    end);
    u36.ScreenGui.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 165
        -- upvalues: u36 (copy)
        u36:_UpdateSize();
    end);
    u36.ScreenGui.MainFrame.List.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 169
        -- upvalues: u36 (copy)
        u36:_UpdateList();
    end);
    u36:_Generate(u36.Root, 0, nil);
    u36:_UpdateSize();
    u36:_UpdateList();
end;

return u1;