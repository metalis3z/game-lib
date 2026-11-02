-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Events = script.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local ActivityKeys = require(ReplicatedStorage:WaitForChild("ActivityKeys"));
local InterfaceController = require(script.Parent:WaitForChild("InterfaceController"));
local ContentPageController = require(script.Parent:WaitForChild("ContentPageController"));
local ActivityAction = Remotes:WaitForChild("ActivityAction");
local template = script:WaitForChild("template");
local u1 = {};
local u2 = false;
local u3 = true;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = {};

local function computeLocalActivityKey() -- Line: 61
    -- upvalues: u3 (ref), ContentPageController (copy), ActivityKeys (copy), InterfaceController (copy)
    if not u3 then
        return "AFK";
    end;

    local Current = ContentPageController.Current;

    if Current and Current.Type then
        local v8 = "ContentPage_" .. Current.Type;

        if ActivityKeys[v8] ~= nil then
            return v8;
        end;
    end;

    local OpenStack = InterfaceController.OpenStack;

    for i = #OpenStack, 1, -1 do
        local v9 = OpenStack[i];

        if ActivityKeys[v9] ~= nil then
            return v9;
        end;
    end;

    return nil;
end;

local function pushActivity() -- Line: 87
    -- upvalues: computeLocalActivityKey (copy), u4 (ref), ActivityAction (copy)
    local v10 = computeLocalActivityKey();

    if v10 == u4 then
        return;
    end;

    u4 = v10;
    ActivityAction:FireServer(v10);
end;

local function setLabelFromKey(p11, p12) -- Line: 98
    -- upvalues: ActivityKeys (copy)
    local StatusLabel = p11:FindFirstChild("StatusLabel");

    if not StatusLabel then
        return;
    end;

    local v13;

    if typeof(p12) == "string" then
        v13 = ActivityKeys[p12] or nil;
    else
        v13 = nil;
    end;

    StatusLabel.Text = v13 or "";
    p11.Enabled = v13 ~= nil;
end;

local function detachBillboard(p14) -- Line: 106
    -- upvalues: u5 (copy), u7 (copy)
    local v15 = u5[p14];

    if v15 then
        v15:Destroy();
        u5[p14] = nil;
    end;

    local v16 = u7[p14];

    if v16 then
        for _, v in v16 do
            v:Disconnect();
        end;

        u7[p14] = nil;
    end;
end;

local function isStaffTagBillboard(p17) -- Line: 119
    local v18 = p17:IsA("BillboardGui") and p17.Name == "StaffTag";

    return v18;
end;

local function updateStackOffset(p19) -- Line: 123
    -- upvalues: u5 (copy)
    local v20 = u5[p19];

    if not v20 or v20.Parent == nil then
        return;
    end;

    local v21 = false;

    for _, child in v20.Parent:GetChildren() do
        local v22 = child:IsA("BillboardGui") and child.Name == "StaffTag";

        if v22 and child.Enabled then
            v21 = true;
            break;
        end;
    end;

    v20.StudsOffset = v21 and Vector3.new(0, 2.55, 0) or Vector3.new(0, 1.9, 0);
end;

local function attachBillboardToCharacter(u23, u24) -- Line: 136
    -- upvalues: u2 (ref), LocalPlayer (copy), u5 (copy), u7 (copy), template (copy), ActivityKeys (copy), updateStackOffset (copy), attachBillboardToCharacter (copy)
    if not u2 then
        return;
    end;

    if u23 == LocalPlayer then
        return;
    end;

    local v25 = u5[u23];

    if v25 then
        v25:Destroy();
        u5[u23] = nil;
    end;

    local v26 = u7[u23];

    if v26 then
        for _, v in v26 do
            v:Disconnect();
        end;

        u7[u23] = nil;
    end;

    local Head = u24:WaitForChild("Head", 10);

    if not Head then
        return;
    end;

    if u23.Character ~= u24 then
        return;
    end;

    if not u2 then
        return;
    end;

    local v27 = template:Clone();
    v27.Adornee = Head;
    v27.Parent = Head;
    local v28 = u23:GetAttribute("CurrentActivity");
    local StatusLabel = v27:FindFirstChild("StatusLabel");

    if StatusLabel then
        local v29;

        if typeof(v28) == "string" then
            v29 = ActivityKeys[v28] or nil;
        else
            v29 = nil;
        end;

        StatusLabel.Text = v29 or "";
        v27.Enabled = v29 ~= nil;
    end;

    u5[u23] = v27;
    local u30 = {};
    u7[u23] = u30;

    local function watchSibling(p31) -- Line: 157
        -- upvalues: u30 (copy), updateStackOffset (ref), u23 (copy)
        local v32 = p31:IsA("BillboardGui") and p31.Name == "StaffTag";

        if v32 then
            local v33 = p31:GetPropertyChangedSignal("Enabled");
            table.insert(u30, v33:Connect(function() -- Line: 159
                -- upvalues: updateStackOffset (ref), u23 (ref)
                updateStackOffset(u23);
            end));
            updateStackOffset(u23);
        end;
    end;

    table.insert(u30, Head.ChildAdded:Connect(watchSibling));
    table.insert(u30, Head.ChildRemoved:Connect(function(p34) -- Line: 166
        -- upvalues: updateStackOffset (ref), u23 (copy)
        local v35 = p34:IsA("BillboardGui") and p34.Name == "StaffTag";

        if v35 then
            updateStackOffset(u23);
        end;
    end));

    for _, child in Head:GetChildren() do
        watchSibling(child);
    end;

    updateStackOffset(u23);
    table.insert(u30, u24.ChildAdded:Connect(function(p36) -- Line: 179
        -- upvalues: Head (copy), attachBillboardToCharacter (ref), u23 (copy), u24 (copy)
        if p36.Name == "Head" and p36 ~= Head then
            task.spawn(attachBillboardToCharacter, u23, u24);
        end;
    end));
end;

local function disconnectPlayerWatchers(p37) -- Line: 186
    -- upvalues: u6 (copy)
    local v38 = u6[p37];

    if not v38 then
        return;
    end;

    for _, v in v38 do
        if v then
            v:Disconnect();
        end;
    end;

    u6[p37] = nil;
end;

local function watchPlayer(u39) -- Line: 195
    -- upvalues: LocalPlayer (copy), u6 (copy), u5 (copy), ActivityKeys (copy), attachBillboardToCharacter (copy), u7 (copy)
    if u39 == LocalPlayer then
        return;
    end;

    if u6[u39] then
        return;
    end;

    local v40 = {};
    u6[u39] = v40;
    local v41 = u39:GetAttributeChangedSignal("CurrentActivity");
    table.insert(v40, v41:Connect(function() -- Line: 202
        -- upvalues: u5 (ref), u39 (copy), ActivityKeys (ref)
        local v42 = u5[u39];

        if v42 then
            local v43 = u39:GetAttribute("CurrentActivity");
            local StatusLabel = v42:FindFirstChild("StatusLabel");

            if not StatusLabel then
                return;
            end;

            local v44;

            if typeof(v43) == "string" then
                v44 = ActivityKeys[v43] or nil;
            else
                v44 = nil;
            end;

            StatusLabel.Text = v44 or "";
            v42.Enabled = v44 ~= nil;
        end;
    end));

    local function onCharacterChanged() -- Line: 212
        -- upvalues: u39 (copy), attachBillboardToCharacter (ref), u5 (ref), u7 (ref)
        local Character = u39.Character;

        if Character then
            task.spawn(attachBillboardToCharacter, u39, Character);

            return;
        end;

        local v45 = u39;
        local v46 = u5[v45];

        if v46 then
            v46:Destroy();
            u5[v45] = nil;
        end;

        local v47 = u7[v45];

        if v47 then
            for _, v in v47 do
                v:Disconnect();
            end;

            u7[v45] = nil;
        end;
    end;

    local v48 = u39:GetPropertyChangedSignal("Character");
    table.insert(v40, v48:Connect(onCharacterChanged));

    if u39.Character then
        task.spawn(attachBillboardToCharacter, u39, u39.Character);
    end;
end;

local function unwatchPlayer(p49) -- Line: 227
    -- upvalues: u6 (copy), u5 (copy), u7 (copy)
    local v50 = u6[p49];

    if v50 then
        for _, v in v50 do
            if v then
                v:Disconnect();
            end;
        end;

        u6[p49] = nil;
    end;

    local v51 = u5[p49];

    if v51 then
        v51:Destroy();
        u5[p49] = nil;
    end;

    local v52 = u7[p49];

    if v52 then
        for _, v in v52 do
            v:Disconnect();
        end;

        u7[p49] = nil;
    end;
end;

function u1.SetEnabled(p53) -- Line: 236
    -- upvalues: u2 (ref), Players (copy), watchPlayer (copy), u6 (copy), u5 (copy), u7 (copy)
    local v54 = p53 == true;

    if v54 == u2 then
        return;
    end;

    u2 = v54;

    if v54 then
        for _, v in Players:GetPlayers() do
            watchPlayer(v);
        end;

        return;
    end;

    for i in u6 do
        local v55 = u6[i];

        if v55 then
            for _, v in v55 do
                if v then
                    v:Disconnect();
                end;
            end;

            u6[i] = nil;
        end;
    end;

    for i in u5 do
        local v56 = u5[i];

        if v56 then
            v56:Destroy();
            u5[i] = nil;
        end;

        local v57 = u7[i];

        if v57 then
            for _, v in v57 do
                v:Disconnect();
            end;

            u7[i] = nil;
        end;
    end;

    table.clear(u6);
    table.clear(u5);
end;

InterfaceController.Changed.Event:Connect(pushActivity);
ContentPageController.Changed.Event:Connect(pushActivity);
UserInputService.WindowFocused:Connect(function() -- Line: 263
    -- upvalues: u3 (ref), computeLocalActivityKey (copy), u4 (ref), ActivityAction (copy)
    u3 = true;
    local v58 = computeLocalActivityKey();

    if v58 == u4 then
        return;
    end;

    u4 = v58;
    ActivityAction:FireServer(v58);
end);
UserInputService.WindowFocusReleased:Connect(function() -- Line: 267
    -- upvalues: u3 (ref), computeLocalActivityKey (copy), u4 (ref), ActivityAction (copy)
    u3 = false;
    local v59 = computeLocalActivityKey();

    if v59 == u4 then
        return;
    end;

    u4 = v59;
    ActivityAction:FireServer(v59);
end);
Players.PlayerAdded:Connect(function(p60) -- Line: 272
    -- upvalues: u2 (ref), watchPlayer (copy)
    if u2 then
        watchPlayer(p60);
    end;
end);
Players.PlayerRemoving:Connect(function(p61) -- Line: 278
    -- upvalues: u6 (copy), u5 (copy), u7 (copy)
    local v62 = u6[p61];

    if v62 then
        for _, v in v62 do
            if v then
                v:Disconnect();
            end;
        end;

        u6[p61] = nil;
    end;

    local v63 = u5[p61];

    if v63 then
        v63:Destroy();
        u5[p61] = nil;
    end;

    local v64 = u7[p61];

    if v64 then
        for _, v in v64 do
            v:Disconnect();
        end;

        u7[p61] = nil;
    end;
end);
task.spawn(pushActivity);
task.spawn(function() -- Line: 287
    -- upvalues: Events (copy), u1 (copy)
    local GetSetting = Events:FindFirstChild("GetSetting");

    if not GetSetting then
        return;
    end;

    while GetSetting:GetAttribute("bound") ~= true do
        task.wait(0.25);
    end;

    local v65 = GetSetting:Invoke({ "Miscellaneous", "ShowActivityAboveHead" });
    u1.SetEnabled(v65 == true);
end);

return u1;