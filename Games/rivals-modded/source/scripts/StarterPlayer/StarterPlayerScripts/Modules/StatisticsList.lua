-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local StatisticParentSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StatisticParentSlot");
local StatisticChildSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StatisticChildSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 17
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5._parent = p2;
    v5._layout_order = p3;
    v5._expand_all_statistics = p4;
    v5._statistic_slots = {};
    v5._dependent_statistic_slots = {};
    v5:_Init();

    return v5;
end;

function u1.Clear(p6) -- Line: 35
    for _, v in pairs(p6._statistic_slots) do
        v:Destroy();
    end;

    p6._statistic_slots = {};
    p6._dependent_statistic_slots = {};
end;

function u1.Generate(u7, u8, u9, u10) -- Line: 45
    -- upvalues: StatisticsLibrary (copy), PlayerDataController (copy), StatisticChildSlot (copy), StatisticParentSlot (copy), ItemLibrary (copy), WeaponStatusHandler (copy), UILibrary (copy), ButtonEffect (copy)
    u7:Clear();
    local StatisticsDirectoryInfo = StatisticsLibrary:GetStatisticsDirectoryInfo(u9);
    local v11 = u8 and StatisticsLibrary:GetCareerStatistics(PlayerDataController:GetUnlockedWeapons());

    if not v11 then
        if StatisticsDirectoryInfo[2][u10] then
            v11 = StatisticsDirectoryInfo[2][u10].DataNames or nil;
        else
            v11 = nil;
        end;
    end;

    if v11 then
        local u12 = 0;

        local function generate(p13, p14) -- Line: 60
            -- upvalues: u7 (copy), StatisticsLibrary (ref), u8 (copy), PlayerDataController (ref), u9 (copy), u10 (copy), StatisticChildSlot (ref), StatisticParentSlot (ref), u12 (ref), ItemLibrary (ref), WeaponStatusHandler (ref), generate (copy), UILibrary (ref)
            if u7._statistic_slots[p13] then
                return;
            end;

            local v15 = StatisticsLibrary.Info[p13];
            local v16;

            if u8 then
                v16 = PlayerDataController:GetStatistic(p13);
            else
                v16 = PlayerDataController:GetDirectoryStatistic(u9, u10, p13);
            end;

            local v17 = (p13 == "StatisticFavoriteWeapon" or (p13 == "StatisticFavoriteWeaponPrimary" or (p13 == "StatisticFavoriteWeaponSecondary" or p13 == "StatisticFavoriteWeaponMelee"))) and true or p13 == "StatisticFavoriteWeaponUtility";

            if v15.OnlyDisplayNonZero and (not v16 or v16 == 0) then
                return;
            end;

            local v18 = (v15.ParentDataName and StatisticChildSlot or StatisticParentSlot):Clone();
            v18.TitleContainer.Title.Text = v15.DisplayName;
            v18.TitleContainer.Position = v15.ParentDataName and UDim2.new(0.125, 0, 0.5, 0) or UDim2.new(0.0625, 0, 0.5, 0);
            v18.Value.Text = v15.IsStatisticFolder and "" or v15.TostringFunction(v16);
            v18.Value.Size = (v17 or p13 == "StatisticFavoriteMap") and UDim2.new(0.35, 0, 1, 0) or v18.Value.Size;
            v18.LayoutOrder = u7._layout_order + p14;
            v18.Visible = not v15.IsStatisticFolder and (u7._expand_all_statistics or (not v15.ParentDataName or u8));
            v18.Parent = u7._parent;
            u7._statistic_slots[p13] = v18;
            u12 = u12 + 1;

            if v17 and ItemLibrary.Items[v16] then
                WeaponStatusHandler:ApplyItemStatusToText(v18.Value, ItemLibrary.Items[v16].Status);
            end;

            if v15.ParentDataName then
                u7._dependent_statistic_slots[v15.ParentDataName] = u7._dependent_statistic_slots[v15.ParentDataName] or {};
                table.insert(u7._dependent_statistic_slots[v15.ParentDataName], v18);
                generate(v15.ParentDataName, p14 - 1);
            else
                v18.Arrow.Visible = false;
            end;

            UILibrary:ScrollingTextLabel(v18.TitleContainer, v18.TitleContainer.Title, v18.Value);
        end;

        for i, v in pairs(v11) do
            generate(v, i * 2);
        end;

        for i, v in pairs(u7._dependent_statistic_slots) do
            u7._statistic_slots[i].Visible = true;
            local u19 = u7._statistic_slots[i];
            local u20 = false;

            local function set_visible(p21) -- Line: 110
                -- upvalues: u20 (ref), u19 (copy), v (copy)
                u20 = p21;
                u19.Arrow.Image = u20 and "rbxassetid://17654601337" or "rbxassetid://17654548862";

                for _, v2 in pairs(v) do
                    v2.Visible = u20;
                end;
            end;

            u19.Button.MouseButton1Click:Connect(function() -- Line: 119
                -- upvalues: u20 (ref), u19 (copy), v (copy)
                u20 = not u20;
                u19.Arrow.Image = u20 and "rbxassetid://17654601337" or "rbxassetid://17654548862";

                for _, v2 in pairs(v) do
                    v2.Visible = u20;
                end;
            end);
            u20 = u7._expand_all_statistics or u8;
            u19.Arrow.Image = u20 and "rbxassetid://17654601337" or "rbxassetid://17654548862";

            for _, v2 in pairs(v) do
                v2.Visible = u20;
            end;

            u19.Arrow.Visible = true;
            ButtonEffect:Add(u19.Button, true, {
                TargetElement = u19.Arrow
            });
        end;

        return u12 > 0;
    end;
end;

function u1._Init(p22) -- Line: 136
end;

return u1;