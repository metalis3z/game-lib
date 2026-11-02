-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 12
    -- upvalues: Prompt (copy), u1 (copy)
    local v4 = Prompt.new(script.Name);
    local v5 = setmetatable(v4, u1);
    v5.CloseButton = v5.PromptFrame:WaitForChild("Close");
    v5.List = v5.PromptFrame:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.Layout = v5.Container:WaitForChild("Layout");
    v5._description_template = v5.Container:WaitForChild("Description");
    v5._title_template = v5.Container:WaitForChild("Title");
    v5:_Init();

    return v5;
end;

function u1._Update(p6) -- Line: 38
    p6.List.CanvasSize = UDim2.new(0, 0, 0, p6.Layout.AbsoluteContentSize.Y);
end;

function u1._Setup(p7) -- Line: 42
    -- upvalues: PermissionsLibrary (copy), Utility (copy)
    p7._description_template.Parent = nil;
    p7._title_template.Parent = nil;
    local v8 = {};

    for i in pairs(PermissionsLibrary.Roles) do
        table.insert(v8, i);
    end;

    table.sort(v8, function(p9, p10) -- Line: 52
        -- upvalues: PermissionsLibrary (ref), Utility (ref)
        local TeamValue = PermissionsLibrary.Teams[PermissionsLibrary.Roles[p9].TeamName].TeamValue;
        local TeamValue2 = PermissionsLibrary.Teams[PermissionsLibrary.Roles[p10].TeamName].TeamValue;

        if TeamValue ~= TeamValue2 then
            return TeamValue2 < TeamValue;
        end;

        local RoleValue = PermissionsLibrary.Roles[p9].RoleValue;
        local RoleValue2 = PermissionsLibrary.Roles[p10].RoleValue;

        if RoleValue == RoleValue2 then
            return Utility:StringLessThan(PermissionsLibrary.Roles[p9].DisplayName, PermissionsLibrary.Roles[p10].DisplayName);
        end;

        return RoleValue2 < RoleValue;
    end);
    local u11 = tick() + 3;
    local v12 = 0;

    for _, v in pairs(v8) do
        v12 = v12 + 1;
        local v13 = PermissionsLibrary.Roles[v];
        local v14 = p7._title_template:Clone();
        v14.Text = v13.DisplayName;
        v14.TextColor3 = v13.Color;
        v14.LayoutOrder = v12;
        v14.Parent = p7.Container;

        for _, v2 in pairs(v13.PermissionNames) do
            v12 = v12 + 1;
            local v15 = PermissionsLibrary.Permissions[v2];
            local u16 = p7._description_template:Clone();
            u16.Container.Guide.Text = " • " .. v15.DisplayName .. " — " .. v15.Description;
            u16.Description.Text = u16.Container.Guide.Text;
            u16.LayoutOrder = v12;
            u16.Parent = p7.Container;

            local function update() -- Line: 93
                -- upvalues: u16 (copy), u11 (copy)
                local math_ceil_ret = math.ceil(u16.Container.Guide.TextBounds.X / u16.Description.AbsoluteSize.X);
                local v17 = math_ceil_ret > 5 and tick() < u11 and 1 or math_ceil_ret;
                u16.Size = UDim2.new(0.975, 0, v17 * 0.04, 0);
            end;

            u16.Container.Guide:GetPropertyChangedSignal("TextBounds"):Connect(update);
            u16.Description:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
            update();
        end;
    end;
end;

function u1._Init(u18) -- Line: 110
    -- upvalues: ButtonEffect (copy)
    u18.CloseButton.MouseButton1Click:Connect(function() -- Line: 111
        -- upvalues: u18 (copy)
        u18:CloseRequest();
    end);
    u18.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 115
        -- upvalues: u18 (copy)
        u18:_Update();
    end);
    u18:_Setup();
    u18:_Update();
    ButtonEffect:Add(u18.CloseButton);
end;

return u1;