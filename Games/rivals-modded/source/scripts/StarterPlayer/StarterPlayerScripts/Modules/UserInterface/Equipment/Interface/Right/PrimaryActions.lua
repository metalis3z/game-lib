-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local EquipmentMetricActionSlot = Players.LocalPlayer.PlayerScripts.UserInterface.EquipmentMetricActionSlot;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.Frame = v3.Right.Container:WaitForChild("PrimaryActions");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.ContractsFrame = v3.Container:WaitForChild("Contracts");
    v3.ContractsButton = v3.ContractsFrame:WaitForChild("Button");
    v3.DuelHistoryFrame = v3.Container:WaitForChild("DuelHistory");
    v3.DuelHistoryButton = v3.DuelHistoryFrame:WaitForChild("Button");
    v3.MapsFrame = v3.Container:WaitForChild("Maps");
    v3.MapsButton = v3.MapsFrame:WaitForChild("Button");
    v3.CollectionFrame = v3.Container:WaitForChild("Collection");
    v3.CollectionButton = v3.CollectionFrame:WaitForChild("Button");
    v3.CareerFrame = v3.Container:WaitForChild("Career");
    v3.CareerButton = v3.CareerFrame:WaitForChild("Button");
    v3.CareerIcon = v3.CareerFrame:WaitForChild("Icon");
    v3.WeaponFrame = v3.Container:WaitForChild("Weapon");
    v3.WeaponButton = v3.WeaponFrame:WaitForChild("Button");
    v3.WeaponTitle = v3.WeaponFrame:WaitForChild("Title");
    v3.WeaponIcon = v3.WeaponFrame:WaitForChild("Icon");
    v3._last_state = nil;
    v3._back_to_weapon = nil;
    v3._metric_action_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SetMetricActionVisible(p4, p5, p6) -- Line: 53
    if not p4._metric_action_slots[p5] then
        return;
    end;

    local v7 = p4._metric_action_slots[p5];

    if p6 then
        p6 = p4:_IsMetricActionVisible(p5);
    end;

    v7.Visible = p6;
    p4:_UpdateVisibility();
end;

function u1.CreateMetricAction(u8, u9, p10, p11, p12) -- Line: 62
    -- upvalues: EquipmentMetricActionSlot (copy), ButtonEffect (copy)
    local v13 = EquipmentMetricActionSlot:Clone();
    v13.Icon.Image = p10;
    v13.Title.Text = p11;
    v13.Description.Text = p12;
    v13.Name = u9;
    v13.Visible = false;
    v13.Parent = u8.Container;
    u8._metric_action_slots[u9] = v13;
    v13.Button.MouseButton1Click:Connect(function() -- Line: 72
        -- upvalues: u8 (copy), u9 (copy)
        u8.Right:SetMetricCardVisible(u9, true);
    end);
    ButtonEffect:Add(v13.Button, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

function u1.OnStateChanged(p14) -- Line: 79
    task.defer(p14._UpdateInformation, p14);
end;

function u1.OnOpen(p15) -- Line: 83
    p15:_UpdateInformation(true);
end;

function u1._IsMetricActionVisible(p16, p17) -- Line: 91
    -- upvalues: PlayerDataController (copy)
    local v18 = p16.Right.Interface.Equipment:IsCareerPageOpen();
    local WeaponData = PlayerDataController:GetWeaponData((p16.Right.Interface.Equipment:GetSelectedWeapon()));
    local v19;

    if p17 == "Performance" then
        if WeaponData == nil then
            return v18;
        end;

        v19 = true;
    else
        if p17 == "Overview" then
            return WeaponData ~= nil;
        end;

        if #p17 >= 7 and string.sub(p17, 1, 7) == "season_" then
            return v18;
        end;

        v19 = true;
    end;

    return v19;
end;

function u1._UpdateInformation(p20, p21) -- Line: 102
    -- upvalues: PlayerDataController (copy), ItemLibrary (copy), WeaponStatusHandler (copy)
    local v22 = p20.Right.Interface.Equipment:IsCareerPageOpen();
    local WeaponData = PlayerDataController:GetWeaponData((p20.Right.Interface.Equipment:GetSelectedWeapon()));
    local StateID = p20.Right.Interface.Equipment:GetStateID();

    if p21 or StateID ~= p20._last_state then
        p20._last_state = StateID;
        local v23;

        if v22 then
            v23 = p20._back_to_weapon;
        else
            v23 = nil;
        end;

        p20._back_to_weapon = v23;
        p20.Right:ResetMetricCards();
    end;

    local v24 = ItemLibrary.Items[p20._back_to_weapon];
    p20.WeaponIcon.Image = v24 and (v24.Image or "") or "";
    p20.WeaponTitle.Text = p20._back_to_weapon or "";
    WeaponStatusHandler:ClearStatusElements(p20.WeaponTitle);

    if v24 then
        v24 = v24.Status;
    end;

    WeaponStatusHandler:ApplyItemStatusToText(p20.WeaponTitle, v24);
    local v25;

    if v22 then
        v25 = p20._back_to_weapon;
    else
        v25 = v22;
    end;

    p20.WeaponFrame.Visible = v25;
    p20.CareerFrame.Visible = false;
    p20.ContractsFrame.Visible = WeaponData;
    p20.DuelHistoryFrame.Visible = v22;
    p20.MapsFrame.Visible = v22;
    p20.CollectionFrame.Visible = v22;
    p20:_UpdateVisibility();
end;

function u1._UpdateVisibility(p26) -- Line: 131
    local v27 = p26.ContractsFrame.Visible or (p26.DuelHistoryFrame.Visible or p26.MapsFrame.Visible or (p26.CollectionFrame.Visible or p26.CareerFrame.Visible));
    local v28 = false;

    for _, v in pairs(p26._metric_action_slots) do
        v28 = v28 or v.Visible;
    end;

    p26.Frame.Visible = v27 or v28;
end;

function u1._UpdateSize(p29) -- Line: 142
    p29.Frame.Size = UDim2.new(1, 0, 0, p29.Layout.AbsoluteContentSize.Y);
end;

function u1._Setup(p30) -- Line: 146
    -- upvalues: CONSTANTS (copy), Players (copy)
    p30.CareerIcon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, Players.LocalPlayer.UserId);
end;

function u1._Init(u31) -- Line: 150
    -- upvalues: Pages (copy), PlayerDataController (copy), ButtonEffect (copy)
    u31.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 151
        -- upvalues: u31 (copy)
        u31:_UpdateSize();
    end);
    u31.ContractsButton.MouseButton1Click:Connect(function() -- Line: 155
        -- upvalues: Pages (ref), u31 (copy)
        Pages.PageSystem:OpenPage("Contracts");
        Pages.PageSystem:WaitForPage("Contracts"):SetWeapon(u31.Right.Interface.Equipment:GetSelectedWeapon());
    end);
    u31.DuelHistoryButton.MouseButton1Click:Connect(function() -- Line: 160
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("DuelHistory");
    end);
    u31.MapsButton.MouseButton1Click:Connect(function() -- Line: 164
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Maps");
    end);
    u31.CollectionButton.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Collection");
    end);
    u31.CareerButton.MouseButton1Click:Connect(function() -- Line: 172
        -- upvalues: u31 (copy)
        u31._back_to_weapon = u31.Right.Interface.Equipment:GetSelectedWeapon();
        u31.Right.Interface.Equipment:OpenCareerPage(true);
    end);
    u31.WeaponButton.MouseButton1Click:Connect(function() -- Line: 177
        -- upvalues: u31 (copy)
        u31.Right.Interface.Equipment:SelectWeapon(u31._back_to_weapon);
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 181
        -- upvalues: u31 (copy)
        u31:_UpdateInformation();
    end);
    u31:_Setup();
    u31:_UpdateSize();
    u31:_UpdateVisibility();
    u31:CreateMetricAction("Overview", "rbxassetid://18404346057", "Overview", "View weapon metrics");
    u31:CreateMetricAction("Performance", "rbxassetid://17336063541", "Statistics", "See lifetime data");
    ButtonEffect:Add(u31.ContractsButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u31.DuelHistoryButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u31.MapsButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u31.CollectionButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u31.CareerButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u31.WeaponButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1;