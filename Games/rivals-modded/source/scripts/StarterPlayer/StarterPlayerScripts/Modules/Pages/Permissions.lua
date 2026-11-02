-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PermissionsPlayersCard = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsPlayersCard");
local PermissionsPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsPlayerSlot");
local PermissionsRoleLabel = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsRoleLabel");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.PageContainer = v3.PageFrame:WaitForChild("Container");
    v3.CloseButton = v3.PageContainer:WaitForChild("Close");
    v3.WaitingFrame = v3.PageContainer:WaitForChild("Waiting");
    v3.WaitingDotsFrame = v3.WaitingFrame:WaitForChild("Dots");
    v3.List = v3.PageContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.InfoButton = v3.Container:WaitForChild("Header"):WaitForChild("Info");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3._permissions_datas = {};
    v3._add_role_dropdown_slot = nil;
    v3._players_cards = {};
    v3._player_slots = {};
    v3._generate_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 51
    -- upvalues: Page (copy)
    Page.Open(p4, ...);
    p4:_ClearNewPlayerBox();
    p4:_CloseAddRoleDropdown();
    task.spawn(p4._FetchPermissionsDatas, p4);
end;

function u1.Close(p5, ...) -- Line: 58
    -- upvalues: Page (copy)
    p5:_CloseAddRoleDropdown();
    Page.Close(p5, ...);
end;

function u1._CloseAddRoleDropdown(p6) -- Line: 67
    if p6._add_role_dropdown_slot then
        p6._add_role_dropdown_slot:Destroy();
        p6._add_role_dropdown_slot = nil;
    end;
end;

function u1._ClearNewPlayerBox(p7) -- Line: 74
    for _, v in pairs(p7._players_cards) do
        v.Container.PermissionsNewPlayerSlot.Container.Lookup.Box.Text = "";
    end;
end;

function u1._GetHighestValueTeam(p8, p9) -- Line: 80
    -- upvalues: PermissionsLibrary (copy)
    local v10 = (-1 / 0);
    local v11 = nil;

    for _, v in pairs(p9) do
        local TeamName = PermissionsLibrary.Roles[v].TeamName;
        local TeamValue = PermissionsLibrary.Teams[TeamName].TeamValue;

        if v10 < TeamValue then
            v11 = TeamName;
            v10 = TeamValue;
        end;
    end;

    return v11;
end;

function u1._GetManageableRoles(p12, p13) -- Line: 97
    -- upvalues: PermissionsLibrary (copy), PlayerDataController (copy), Utility (copy)
    local ManageableRoles = PermissionsLibrary:GetManageableRoles(PlayerDataController:Get("PermissionsRoles"));

    if p13 then
        for i = #ManageableRoles, 1, -1 do
            local v14;

            if table.find(p13, ManageableRoles[i]) then
                table.remove(ManageableRoles, i);
                v14 = i;
            else
                v14 = i;
            end;
        end;
    end;

    table.sort(ManageableRoles, function(p15, p16) -- Line: 108
        -- upvalues: PermissionsLibrary (ref), Utility (ref)
        local TeamValue = PermissionsLibrary.Teams[PermissionsLibrary.Roles[p15].TeamName].TeamValue;
        local TeamValue2 = PermissionsLibrary.Teams[PermissionsLibrary.Roles[p16].TeamName].TeamValue;

        if TeamValue ~= TeamValue2 then
            return TeamValue2 < TeamValue;
        end;

        local RoleValue = PermissionsLibrary.Roles[p15].RoleValue;
        local RoleValue2 = PermissionsLibrary.Roles[p16].RoleValue;

        if RoleValue == RoleValue2 then
            return Utility:StringLessThan(PermissionsLibrary.Roles[p15].DisplayName, PermissionsLibrary.Roles[p16].DisplayName);
        end;

        return RoleValue2 < RoleValue;
    end);
    local v17 = {};

    for i, v in pairs(ManageableRoles) do
        v17[i] = PermissionsLibrary.Roles[v].DisplayName;
    end;

    return v17;
end;

function u1._RoleManagement(p18, u19, u20) -- Line: 135
    -- upvalues: ReplicatedStorage (copy)
    if not (u19 and u20) then
        return;
    end;

    p18:_SetWaitingFrameVisible(true);
    local success, result = pcall(function() -- Line: 142
        -- upvalues: ReplicatedStorage (ref), u19 (copy), u20 (copy)
        return ReplicatedStorage.Remotes.Permissions.RoleManagement:InvokeServer(u19, u20);
    end);

    if not success then
        warn("Failed to manage role, error:", result);
    end;

    p18:_SetWaitingFrameVisible(false);
end;

function u1._GetNewUserID(p21, p22) -- Line: 153
    local string_sub_ret = string.sub(p21._players_cards[p22].Container.PermissionsNewPlayerSlot.Container.Lookup.Box.Text, 2);

    return tonumber(string_sub_ret);
end;

function u1._AddRoleDropdown(u23, p24, u25, p26) -- Line: 157
    -- upvalues: DropdownSlot (copy), PermissionsLibrary (copy)
    u23:_CloseAddRoleDropdown();
    u23._add_role_dropdown_slot = DropdownSlot.new(p24, u23:_GetManageableRoles(p26));
    u23._add_role_dropdown_slot.Selected:Connect(function(p27) -- Line: 162
        -- upvalues: PermissionsLibrary (ref), u25 (copy), u23 (copy)
        local PermissionsRoleNameFromDisplayName = PermissionsLibrary:GetPermissionsRoleNameFromDisplayName(p27);
        u23:_RoleManagement(tonumber(u25) or u23:_GetNewUserID(u25), PermissionsRoleNameFromDisplayName);
    end);
end;

function u1._Generate(u28) -- Line: 170
    -- upvalues: PermissionsLibrary (copy), ComplianceController (copy), PermissionsPlayerSlot (copy), CONSTANTS (copy), ButtonEffect (copy), Utility (copy), PermissionsRoleLabel (copy), PlayerDataController (copy)
    u28:_CloseAddRoleDropdown();
    u28:_ClearNewPlayerBox();

    for _, v in pairs(u28._player_slots) do
        v:Destroy();
    end;

    u28._player_slots = {};
    u28._generate_hash = u28._generate_hash + 1;
    local _generate_hash = u28._generate_hash;

    local function get_highest_team_name(p29) -- Line: 185
        -- upvalues: PermissionsLibrary (ref)
        local v30 = (-1 / 0);
        local v31 = nil;

        for _, v in pairs(p29) do
            local TeamName = PermissionsLibrary.Roles[v].TeamName;
            local TeamValue = PermissionsLibrary.Teams[TeamName].TeamValue;

            if v30 < TeamValue then
                v31 = TeamName;
                v30 = TeamValue;
            end;
        end;

        return v31;
    end;

    local function get_highest_role_name(p32) -- Line: 202
        -- upvalues: PermissionsLibrary (ref)
        local v33 = (-1 / 0);
        local v34 = nil;

        for _, v in pairs(p32) do
            local v35 = PermissionsLibrary.Roles[v];

            if v33 < v35.RoleValue then
                v33 = v35.RoleValue;
                v34 = v;
            end;
        end;

        return v34;
    end;

    local v36 = {};
    local v37 = {};

    for i, v in pairs(u28._permissions_datas and (u28._permissions_datas.Players or {}) or {}) do
        local v38 = tonumber(i);
        local v39 = {
            v38,
            get_highest_team_name(v.Roles),
            get_highest_role_name(v.Roles),
            v
        };
        table.insert(v36, v39);
        table.insert(v37, v38);
    end;

    local UserInfos = ComplianceController:GetUserInfos(v37);

    if u28._generate_hash ~= _generate_hash then
        return;
    end;

    table.sort(v36, function(p40, p41) -- Line: 230
        -- upvalues: PermissionsLibrary (ref)
        local v42 = p40[2] and (PermissionsLibrary.Teams[p40[2]].TeamValue or -1) or -1;
        local v43 = p41[2] and (PermissionsLibrary.Teams[p41[2]].TeamValue or -1) or -1;

        if v42 ~= v43 then
            return v43 < v42;
        end;

        local v44 = p40[3] and (PermissionsLibrary.Roles[p40[3]].RoleValue or -1) or -1;
        local v45 = p41[3] and (PermissionsLibrary.Roles[p41[3]].RoleValue or -1) or -1;

        if v44 == v45 then
            return (p40[4].AddedTimestamp or (1 / 0)) < (p41[4].AddedTimestamp or (1 / 0));
        end;

        return v45 < v44;
    end);

    for _, v in pairs(v36) do
        local table_unpack_ret, v46, _, u47 = table.unpack(v);

        if #u47.Roles ~= 0 then
            local v48 = UserInfos[tostring(table_unpack_ret)];
            local v49 = v48 and v48.DisplayName and (v48.DisplayName or "• • •") or "• • •";
            local v50 = v48 and (v48.Username and "@" .. v48.Username) or "• • •";
            local u51 = PermissionsPlayerSlot:Clone();
            u51.Container.DisplayName.Text = v49;
            u51.Container.Username.Text = v50;
            u51.Container.UserId.Text = "#" .. table_unpack_ret;
            u51.Container.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, table_unpack_ret);
            u51.Parent = u28._players_cards[v46].Container;
            table.insert(u28._player_slots, u51);
            ButtonEffect:Add(u51.Container.Roles.Add, true);
            u51.Container.Roles.Add.MouseButton1Click:Connect(function() -- Line: 271
                -- upvalues: u28 (copy), u47 (copy), Utility (ref), u51 (copy), table_unpack_ret (copy)
                if #u28:_GetManageableRoles(u47.Roles) == 0 then
                    Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

                    return;
                end;

                u28:_AddRoleDropdown(u51.Container.Roles.Add.DropdownContainer, table_unpack_ret, u47.Roles);
            end);

            for _, v2 in pairs(u47.Roles) do
                local v52 = PermissionsLibrary.Roles[v2];
                local u53 = PermissionsRoleLabel:Clone();
                u53.Display.Title.Text = v52.DisplayName;
                u53.Background.ImageColor3 = v52.Color or Color3.fromRGB(255, 255, 255);
                u53.LayoutOrder = -(PermissionsLibrary.Teams[v52.TeamName].TeamValue * 10000 + v52.RoleValue);
                u53.Parent = u51.Container.Roles;
                ButtonEffect:Add(u53, true);
                u53.MouseButton1Click:Connect(function() -- Line: 290
                    -- upvalues: PermissionsLibrary (ref), v2 (copy), PlayerDataController (ref), Utility (ref), u28 (copy), table_unpack_ret (copy)
                    if PermissionsLibrary:CanManageRole(v2, PlayerDataController:Get("PermissionsRoles")) then
                        u28:_RoleManagement(table_unpack_ret, v2);

                        return;
                    end;

                    Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
                end);
                local Title = u53.Display.Title;
                Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 301, Name: update
                    -- upvalues: u53 (copy), Title (copy)
                    u53.Size = UDim2.new(0.1, Title.TextBounds.X, 0.1, 0);
                end);
                u53.Size = UDim2.new(0.1, Title.TextBounds.X, 0.1, 0);
            end;

            local Layout = u51.Container.Roles.Layout;
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 311, Name: update
                -- upvalues: u51 (copy), Layout (copy)
                u51.Size = UDim2.new(0.24, 0, 0.085, Layout.AbsoluteContentSize.Y);
            end);
            u51.Size = UDim2.new(0.24, 0, 0.085, Layout.AbsoluteContentSize.Y);
        end;
    end;
end;

function u1._SetWaitingFrameVisible(p54, p55) -- Line: 320
    p54.WaitingFrame.Visible = p55;

    if p54.WaitingFrame then
        p54.WaitingDotsFrame:AddTag("UILoadingDots");

        return;
    end;

    p54.WaitingDotsFrame:RemoveTag("UILoadingDots");
end;

function u1._SetPermissionsDatas(p56, p57) -- Line: 330
    p56._permissions_datas = p57 or {};
    p56:_Generate();
end;

function u1._FetchPermissionsDatas(p58) -- Line: 335
    -- upvalues: ReplicatedStorage (copy)
    p58:_CloseAddRoleDropdown();
    p58:_ClearNewPlayerBox();
    p58:_SetWaitingFrameVisible(true);
    local success, result = pcall(function() -- Line: 340
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.Permissions.FetchPermissions:InvokeServer();
    end);

    if success then
        if not result then
            warn("Fetching permissions returned nothing!");
        end;
    else
        warn("Failed to fetch permissions, error:", result);
    end;

    p58:_SetPermissionsDatas(success and result);
    p58:_SetWaitingFrameVisible(false);
end;

function u1._UpdateLayouts(p59) -- Line: 354
    p59.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p59.PageFrame.AbsoluteSize.Y * 0.125);
    p59.List.Position = UDim2.new(0.5, 9, 0, p59.PageFrame.AbsoluteSize.Y * 0.125);
    p59.List.Size = UDim2.new(0.85, 0, 0, p59.PageFrame.AbsoluteSize.Y * 0.75);
    p59.List.CanvasSize = UDim2.new(0, 0, 0, p59.Layout.AbsoluteContentSize.Y);
end;

function u1._VerifyOpen(u60) -- Line: 361
    -- upvalues: PermissionsLibrary (copy), PlayerDataController (copy)
    if not PermissionsLibrary:CanViewPermissionsPage(PlayerDataController:Get("PermissionsRoles")) then
        task.defer(function() -- Line: 363
            -- upvalues: u60 (copy)
            u60.Closed:Fire();
        end);
    end;
end;

function u1._Setup(u61) -- Line: 369
    -- upvalues: PermissionsLibrary (copy), PermissionsPlayersCard (copy), CONSTANTS (copy), Utility (copy), ButtonEffect (copy)
    for i, v in pairs(PermissionsLibrary.Teams) do
        local u62 = PermissionsPlayersCard:Clone();
        u62.Container.Header.Title.Text = v.DisplayName;
        u62.Container.Header.Background.ImageColor3 = v.Color;
        u62.Container.Header.Icon.Image = v.Icon;
        u62.LayoutOrder = -v.TeamValue;
        u62.Parent = u61.Container;
        u61._players_cards[i] = u62;
        local Layout = u62.Container.Layout;
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 381, Name: update
            -- upvalues: u62 (copy), Layout (copy)
            u62.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
        end);
        u62.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);

        local function update_headshot() -- Line: 388
            -- upvalues: u61 (copy), i (copy), u62 (copy), CONSTANTS (ref)
            local v63 = u61:_GetNewUserID(i);
            u62.Container.PermissionsNewPlayerSlot.Container.Headshot.ImageColor3 = Color3.fromRGB(255, 255, 255);
            u62.Container.PermissionsNewPlayerSlot.Container.Headshot.ImageTransparency = v63 and 0 or 0.75;
            u62.Container.PermissionsNewPlayerSlot.Container.Headshot.Image = not v63 and "rbxassetid://93178222051105" or string.format(CONSTANTS.HEADSHOT_IMAGE, v63);
        end;

        u62.Container.PermissionsNewPlayerSlot.Container.Lookup.Box.FocusLost:Connect(update_headshot);
        update_headshot();
        u62.Container.PermissionsNewPlayerSlot.Container.Lookup.Box:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 399
            -- upvalues: u62 (copy), update_headshot (copy)
            if not u62.Container.PermissionsNewPlayerSlot.Container.Lookup.Box:IsFocused() then
                update_headshot();
            end;
        end);
        u62.Container.PermissionsNewPlayerSlot.Container.Roles.Add.MouseButton1Click:Connect(function() -- Line: 405
            -- upvalues: u61 (copy), i (copy), Utility (ref), u62 (copy)
            if u61:_GetNewUserID(i) and #u61:_GetManageableRoles() ~= 0 then
                u61:_AddRoleDropdown(u62.Container.PermissionsNewPlayerSlot.Container.Roles.Add.DropdownContainer, i);

                return;
            end;

            Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
        end);
        ButtonEffect:Add(u62.Container.PermissionsNewPlayerSlot.Container.Roles.Add, true);
    end;
end;

function u1._Init(u64) -- Line: 421
    -- upvalues: PlayerDataController (copy), ReplicatedStorage (copy), ButtonEffect (copy)
    u64.CloseButton.MouseButton1Click:Connect(function() -- Line: 422
        -- upvalues: u64 (copy)
        u64:CloseRequest();
    end);
    u64.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 426
        -- upvalues: u64 (copy)
        u64:_UpdateLayouts();
    end);
    u64.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 430
        -- upvalues: u64 (copy)
        u64:_UpdateLayouts();
    end);
    u64.InfoButton.MouseButton1Click:Connect(function() -- Line: 434
        -- upvalues: u64 (copy)
        u64.PromptSystem:Open("ViewPermissionsRoles");
    end);
    PlayerDataController:GetDataChangedSignal("PermissionsRoles"):Connect(function() -- Line: 438
        -- upvalues: u64 (copy)
        u64:_VerifyOpen();
    end);
    ReplicatedStorage.Remotes.Permissions.UpdatePermissions.OnClientEvent:Connect(function(p65) -- Line: 442
        -- upvalues: u64 (copy)
        u64:_SetPermissionsDatas(p65);
    end);
    u64:_Setup();
    u64:_Generate();
    u64:_UpdateLayouts();
    u64:_VerifyOpen();
    ButtonEffect:Add(u64.InfoButton);
    ButtonEffect:Add(u64.CloseButton);
end;

return u1._new();