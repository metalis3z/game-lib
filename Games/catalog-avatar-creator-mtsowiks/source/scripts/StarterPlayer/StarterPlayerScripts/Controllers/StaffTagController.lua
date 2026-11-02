-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local _ = Players.LocalPlayer;
local StaffTag = script:WaitForChild("StaffTag");
local u1 = {
    Admin = {
        Text = "Administrator",
        Color = Color3.fromRGB(247, 183, 51)
    },
    Mod = {
        Text = "Moderator",
        Color = Color3.fromRGB(79, 168, 255)
    }
};
local u2 = {};
local u3 = {};
local u4 = {};

local function detachBillboard(p5) -- Line: 41
    -- upvalues: u2 (copy), u4 (copy)
    local v6 = u2[p5];

    if v6 then
        v6:Destroy();
        u2[p5] = nil;
    end;

    local v7 = u4[p5];

    if v7 then
        v7:Disconnect();
        u4[p5] = nil;
    end;
end;

local function attachBillboard(u8, u9) -- Line: 54
    -- upvalues: u2 (copy), u4 (copy), u1 (copy), StaffTag (copy), attachBillboard (copy)
    local v10 = u2[u8];

    if v10 then
        v10:Destroy();
        u2[u8] = nil;
    end;

    local v11 = u4[u8];

    if v11 then
        v11:Disconnect();
        u4[u8] = nil;
    end;

    local v12 = u8:GetAttribute("StaffRole");
    local v13;

    if typeof(v12) == "string" then
        v13 = u1[v12] or nil;
    else
        v13 = nil;
    end;

    if not v13 then
        return;
    end;

    local Head = u9:WaitForChild("Head", 10);

    if not Head then
        return;
    end;

    if u8.Character ~= u9 then
        return;
    end;

    if u8:GetAttribute("StaffRole") ~= v12 then
        return;
    end;

    local v14 = StaffTag:Clone();
    local RoleLabel = v14:FindFirstChild("RoleLabel");

    if RoleLabel then
        RoleLabel.Text = v13.Text;
        RoleLabel.BackgroundColor3 = v13.Color;
    end;

    v14.Adornee = Head;
    v14.Enabled = true;
    v14.Parent = Head;
    u2[u8] = v14;
    u4[u8] = u9.ChildAdded:Connect(function(p15) -- Line: 81
        -- upvalues: Head (copy), attachBillboard (ref), u8 (copy), u9 (copy)
        if p15.Name == "Head" and p15 ~= Head then
            task.spawn(attachBillboard, u8, u9);
        end;
    end);
end;

local function refresh(p16) -- Line: 88
    -- upvalues: attachBillboard (copy), u2 (copy), u4 (copy)
    local Character = p16.Character;

    if Character and p16:GetAttribute("StaffRole") ~= nil then
        task.spawn(attachBillboard, p16, Character);

        return;
    end;

    local v17 = u2[p16];

    if v17 then
        v17:Destroy();
        u2[p16] = nil;
    end;

    local v18 = u4[p16];

    if v18 then
        v18:Disconnect();
        u4[p16] = nil;
    end;
end;

local function watchPlayer(u19) -- Line: 97
    -- upvalues: u3 (copy), attachBillboard (copy), u2 (copy), u4 (copy)
    if u3[u19] then
        return;
    end;

    local v20 = {};
    u3[u19] = v20;
    local v21 = u19:GetAttributeChangedSignal("StaffRole");
    table.insert(v20, v21:Connect(function() -- Line: 103
        -- upvalues: u19 (copy), attachBillboard (ref), u2 (ref), u4 (ref)
        local v22 = u19;
        local Character = v22.Character;

        if Character and v22:GetAttribute("StaffRole") ~= nil then
            task.spawn(attachBillboard, v22, Character);

            return;
        end;

        local v23 = u2[v22];

        if v23 then
            v23:Destroy();
            u2[v22] = nil;
        end;

        local v24 = u4[v22];

        if v24 then
            v24:Disconnect();
            u4[v22] = nil;
        end;
    end));
    local v25 = u19:GetPropertyChangedSignal("Character");
    table.insert(v20, v25:Connect(function() -- Line: 108
        -- upvalues: u19 (copy), attachBillboard (ref), u2 (ref), u4 (ref)
        local v26 = u19;
        local Character = v26.Character;

        if Character and v26:GetAttribute("StaffRole") ~= nil then
            task.spawn(attachBillboard, v26, Character);

            return;
        end;

        local v27 = u2[v26];

        if v27 then
            v27:Destroy();
            u2[v26] = nil;
        end;

        local v28 = u4[v26];

        if v28 then
            v28:Disconnect();
            u4[v26] = nil;
        end;
    end));
    local Character = u19.Character;

    if Character and u19:GetAttribute("StaffRole") ~= nil then
        task.spawn(attachBillboard, u19, Character);

        return;
    end;

    local v29 = u2[u19];

    if v29 then
        v29:Destroy();
        u2[u19] = nil;
    end;

    local v30 = u4[u19];

    if v30 then
        v30:Disconnect();
        u4[u19] = nil;
    end;
end;

Players.PlayerAdded:Connect(watchPlayer);
Players.PlayerRemoving:Connect(function(p31) -- Line: 117
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    local v32 = u2[p31];

    if v32 then
        v32:Destroy();
        u2[p31] = nil;
    end;

    local v33 = u4[p31];

    if v33 then
        v33:Disconnect();
        u4[p31] = nil;
    end;

    local v34 = u3[p31];

    if v34 then
        for _, v in v34 do
            v:Disconnect();
        end;

        u3[p31] = nil;
    end;
end);
local v35 = {};

for _, v in Players:GetPlayers() do
    watchPlayer(v);
end;

return v35;