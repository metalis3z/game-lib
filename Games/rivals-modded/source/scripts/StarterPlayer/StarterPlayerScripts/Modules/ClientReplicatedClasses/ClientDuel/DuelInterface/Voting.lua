-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
require(Players.LocalPlayer.PlayerScripts.Modules.VoteBanFrame);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local WeaponSlot = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponSlot);
local MapSlot = require(Players.LocalPlayer.PlayerScripts.Modules.MapSlot);
local VoteWeaponTabButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("VoteWeaponTabButton");
local BanIcon = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BanIcon");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 29
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.VisibilityChanged = Signal.new();
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Voting");
    v3.MapsFrame = v3.Frame:WaitForChild("Maps");
    v3.MapsCenter = v3.MapsFrame:WaitForChild("MapsCenter");
    v3.MapsCenterLayout = v3.MapsCenter:WaitForChild("Layout");
    v3.MapsList = v3.MapsFrame:WaitForChild("MapsList");
    v3.MapsListContainer = v3.MapsList:WaitForChild("Container");
    v3.MapsListMaximizedFrame = v3.MapsListContainer:WaitForChild("Maximized");
    v3.MapsListMaximizedLayout = v3.MapsListMaximizedFrame:WaitForChild("Layout");
    v3.MapsListMinimizedFrame = v3.MapsListContainer:WaitForChild("Minimized");
    v3.MapsListMinimizedLayout = v3.MapsListMinimizedFrame:WaitForChild("Layout");
    v3.MapsListCentererFrame = v3.MapsListContainer:WaitForChild("Centerer");
    v3.MapsChosenEffectFrame = v3.MapsFrame:WaitForChild("ChosenEffect");
    v3.MapsArcadeModeFrame = v3.MapsFrame:WaitForChild("ArcadeMode");
    v3.MapsArcadeModeTitle = v3.MapsArcadeModeFrame:WaitForChild("Container"):WaitForChild("Title");
    v3.WeaponsFrame = v3.Frame:WaitForChild("Weapons");
    v3.WeaponsMapFrame = v3.WeaponsFrame:WaitForChild("Map");
    v3.WeaponsMapContainer = v3.WeaponsMapFrame:WaitForChild("Container");
    v3.WeaponsMapTitle = v3.WeaponsMapContainer:WaitForChild("Title");
    v3.WeaponsContainer = v3.WeaponsFrame:WaitForChild("Container");
    v3.WeaponsTabsFrame = v3.WeaponsContainer:WaitForChild("Tabs");
    v3.WeaponsList = v3.WeaponsContainer:WaitForChild("List");
    v3.WeaponsListContainer = v3.WeaponsList:WaitForChild("Container");
    v3.WeaponsListLayout = v3.WeaponsListContainer:WaitForChild("Layout");
    v3.RemainingBansFrame = v3.Frame:WaitForChild("RemainingBans");
    v3.RemainingBansContainer = v3.RemainingBansFrame:WaitForChild("Container");
    v3.RemainingBansStart = v3.RemainingBansFrame:WaitForChild("Start");
    v3.RemainingBansFinish = v3.RemainingBansFrame:WaitForChild("Finish");
    v3._destroyed = false;
    v3._generate_hash = 0;
    v3._last_vote_options_type = nil;
    v3._remaining_ban_icons_generated = false;
    v3._remaining_ban_icons_generate_hash = 0;
    v3._remaining_ban_icons = {};
    v3._map_slots = {};
    v3._map_chosen_slot = nil;
    v3._map_chosen_hash = 0;
    v3._weapon_class_selected = nil;
    v3._weapon_tab_buttons = {};
    v3._weapon_slots = {};
    v3._weapon_slots_banned = {};
    v3._weapon_ban_icons = {};
    v3._last_map_chosen_result = nil;
    v3._ban_sound_debounce = {};
    v3:_Init();

    return v3;
end;

function u1.IsOpen(p4) -- Line: 89
    return not p4._destroyed and p4.Frame.Visible;
end;

function u1.PlayMapChosenEffect(p5, p6) -- Line: 93
    -- upvalues: MapSlot (copy)
    local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
    local UDim2_new_ret2 = UDim2.new(0.5, 0, 3, 0);

    for _, v in pairs(p5._map_slots) do
        if v.Name == p6.Name then
            local v7 = v.Frame.AbsolutePosition + v.Frame.AbsoluteSize * 0.5 - p5.MapsChosenEffectFrame.AbsolutePosition;
            UDim2_new_ret2 = UDim2.new(0, v7.X, 0, v7.Y);
            UDim2_new_ret = UDim2.new(0, v.Frame.AbsoluteSize.X, 0, v.Frame.AbsoluteSize.Y);
        end;
    end;

    p5:_ClearMaps();
    p5:_ClearMapChosenEffect();
    p5._last_map_chosen_result = p6;
    p5._map_chosen_hash = p5._map_chosen_hash + 1;
    local _map_chosen_hash = p5._map_chosen_hash;
    p5._map_chosen_slot = MapSlot.new(p6.Name, true);
    p5._map_chosen_slot.Frame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p5._map_chosen_slot.Frame.Size = UDim2_new_ret;
    p5._map_chosen_slot.Frame.Position = UDim2_new_ret2;
    p5._map_chosen_slot:SetParent(p5.MapsChosenEffectFrame);
    p5._map_chosen_slot.Frame:TweenSizeAndPosition(UDim2.new(1, 0, 1, 0), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.75, true);
    p5.WeaponsMapTitle.Text = "Map: " .. p6.Name;
    p5.DuelInterface:CreateSound("rbxassetid://103035811146294", 1, 1, script, true, 5);
    wait(1.25);

    if _map_chosen_hash ~= p5._map_chosen_hash then
        return;
    end;

    p5._map_chosen_slot.Frame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quint", 0.75, true);
    wait(0.75);

    if _map_chosen_hash ~= p5._map_chosen_hash then
        return;
    end;

    p5._map_chosen_slot:Destroy();
    p5._map_chosen_slot = nil;
end;

function u1.Generate(u8) -- Line: 141
    -- upvalues: GamepadService (copy), ControlsController (copy)
    u8._generate_hash = u8._generate_hash + 1;
    local v9 = u8.DuelInterface.ClientDuel:Get("VoteOptions") and not u8.DuelInterface:IsPageOpen();
    u8.Frame.Visible = v9;
    u8.VisibilityChanged:Fire();

    if v9 then
        if not GamepadService.GamepadCursorEnabled and ControlsController.CurrentControls == "Gamepad" then
            GamepadService:EnableGamepadCursor(u8.Frame);
        end;

        task.spawn(function() -- Line: 162
            -- upvalues: u8 (copy)
            local v10 = u8.DuelInterface.ClientDuel:Get("VoteOptionsType");

            if u8._last_vote_options_type ~= v10 then
                u8._last_vote_options_type = v10;
                u8._remaining_ban_icons_generated = false;
                local v11 = u8;
                v11._remaining_ban_icons_generate_hash = v11._remaining_ban_icons_generate_hash + 0;
            end;

            if v10 ~= "Maps" then
                if v10 == "Weapons" then
                    u8:_ClearMaps();
                    u8:_GenerateWeapons();
                end;

                return;
            end;

            u8:_ClearWeapons();
            u8:_GenerateMaps();
        end);

        return;
    end;

    GamepadService:DisableGamepadCursor();
    u8._remaining_ban_icons_generated = false;
    u8._remaining_ban_icons_generate_hash = u8._remaining_ban_icons_generate_hash + 0;
    u8:_ClearMaps();
    u8:_ClearWeapons();
end;

function u1.Destroy(p12) -- Line: 181
    p12._destroyed = true;
    p12.VisibilityChanged:Destroy();
    p12:_ClearMaps();
    p12:_ClearMapChosenEffect();
    p12:_ClearWeapons();
end;

function u1._PlayBanSound(u13, u14, ...) -- Line: 195
    if u13._ban_sound_debounce[u14] then
        return;
    end;

    u13._ban_sound_debounce[u14] = true;
    task.defer(function(...) -- Line: 202
        -- upvalues: u13 (copy), u14 (copy)
        u13._ban_sound_debounce[u14] = nil;
        u13.DuelInterface:CreateSound(u14, ...);
    end, ...);
end;

function u1._ClearMapChosenEffect(p15) -- Line: 208
    p15._map_chosen_hash = p15._map_chosen_hash + 1;

    if p15._map_chosen_slot then
        p15._map_chosen_slot:Destroy();
        p15._map_chosen_slot = nil;
    end;
end;

function u1._SetWeaponClassSelected(p16, p17) -- Line: 217
    p16._weapon_class_selected = p17;
    p16:_UpdateWeapons();
end;

function u1._UpdateWeapons(p18) -- Line: 222
    -- upvalues: ItemLibrary (copy)
    for i, _ in pairs(ItemLibrary.Classes) do
        local v19 = i == p18._weapon_class_selected;
        local v20 = p18._weapon_tab_buttons[i];
        v20.Title.TextColor3 = v19 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        v20.Title.Icon.ImageColor3 = v19 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        v20.Background.ImageColor3 = v19 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        v20.Background.ImageTransparency = v19 and 0 or 0.25;
        v20.Background.UIGradient.Enabled = not v19;
    end;

    for i, v in pairs(p18._weapon_slots) do
        v.Frame.Visible = ItemLibrary.Items[i].Class == p18._weapon_class_selected;
    end;
end;

function u1._GenerateRemainingBans(u21) -- Line: 239
    -- upvalues: Players (copy), DuelLibrary (copy), BanIcon (copy), Utility (copy), TweenService (copy), ItemLibrary (copy)
    for _, v in pairs(u21._weapon_ban_icons) do
        v:Destroy();
    end;

    u21._weapon_ban_icons = {};
    local v22 = u21.DuelInterface.ClientDuel:Get("VoteOptions");
    local v23 = u21.DuelInterface.ClientDuel:Get("VoteOptionsType");
    local v24;

    if v23 == "Weapons" then
        v24 = u21.DuelInterface.ClientDuel:Get("MaxWeaponBansPerTeam");
    else
        v24 = u21.DuelInterface.ClientDuel:Get("MaxMapBansPerTeam");
    end;

    local v25 = v24 or 0;
    local v26 = u21.DuelInterface.ClientDuel:Get("VoteBansRemaining") or {};
    local v27 = false;

    if not u21._remaining_ban_icons_generated then
        for _, v in pairs(u21._remaining_ban_icons) do
            for _, v2 in pairs(v) do
                v2:Destroy();
            end;
        end;

        u21._remaining_ban_icons = {};
        u21._remaining_ban_icons_generated = true;
        u21._remaining_ban_icons_generate_hash = u21._remaining_ban_icons_generate_hash + 1;
        local _remaining_ban_icons_generate_hash = u21._remaining_ban_icons_generate_hash;
        local v28 = {};

        for _, v in pairs(u21.DuelInterface.ClientDuel.Duelers) do
            local v29 = v:Get("TeamID");

            if v29 then
                v28[v29] = true;
            end;
        end;

        local Dueler = u21.DuelInterface.ClientDuel:GetDueler(Players.LocalPlayer);
        local u30 = 1;

        for i in pairs(v28) do
            if Dueler then
                local _ = i == Dueler:Get("TeamID");
            end;

            local TeamColor = DuelLibrary:GetTeamColor(i);
            local v31 = i;

            for i2 = 1, v25 - (v26[i] or 0) do
                local v32 = 1 - (u30 - 1) * 0.1;
                local u33 = BanIcon:Clone();
                u33.ImageColor3 = Utility:DarkenColor(TeamColor, v32 * 0.5);
                u33.Icon.ImageColor3 = Utility:DarkenColor(TeamColor, v32);
                u33.LayoutOrder = u30;
                u33.ZIndex = -u30;
                u21._remaining_ban_icons[v31] = u21._remaining_ban_icons[v31] or {};
                table.insert(u21._remaining_ban_icons[v31], u33);
                task.delay((u30 - 1) * 0.25 + 0.125, function() -- Line: 295
                    -- upvalues: _remaining_ban_icons_generate_hash (copy), u21 (copy), u33 (copy), TweenService (ref), u30 (ref)
                    if _remaining_ban_icons_generate_hash ~= u21._remaining_ban_icons_generate_hash then
                        return;
                    end;

                    u33.UIScale.Scale = 0.25;
                    u33.Parent = u21.RemainingBansContainer;
                    TweenService:Create(u33.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                    u21.DuelInterface:CreateSound("rbxassetid://92837039207579", 1.25, u30 * 0.075 + 0.75, script, true, 5);
                end);
                u30 = u30 + 1;
                local _ = i2;
                v27 = true;
            end;
        end;

        u21.RemainingBansContainer.Position = u21.RemainingBansStart.Position;
        u21.RemainingBansContainer:TweenPosition(u21.RemainingBansContainer.Position, "Out", "Linear", 0, true);
        u21.RemainingBansContainer.Size = u21.RemainingBansStart.Size;
        u21.RemainingBansContainer:TweenSize(u21.RemainingBansContainer.Size, "Out", "Linear", 0, true);
        task.spawn(function() -- Line: 317
            -- upvalues: u21 (copy), Players (ref)
            local _remaining_ban_icons_generate_hash2 = u21._remaining_ban_icons_generate_hash;
            wait(1);

            if u21._remaining_ban_icons_generate_hash ~= _remaining_ban_icons_generate_hash2 then
                return;
            end;

            if u21.RemainingBansContainer:IsDescendantOf(Players) then
                u21.RemainingBansContainer:TweenPosition(u21.RemainingBansFinish.Position, "InOut", "Quint", 0.5, true);
                u21.RemainingBansContainer:TweenSize(u21.RemainingBansFinish.Size, "InOut", "Quint", 0.5, true);

                return;
            end;

            u21.RemainingBansContainer.Position = u21.RemainingBansFinish.Position;
            u21.RemainingBansContainer.Size = u21.RemainingBansFinish.Size;
        end);
        u21:_SetWeaponClassSelected("Primary");
    end;

    for i, v in pairs(u21._remaining_ban_icons) do
        local v34 = v25 - (v26[i] or 0);

        for i2, v2 in pairs(v) do
            v2.Visible = i2 <= v34;
        end;
    end;

    if v23 == "Weapons" then
        local v35 = {};

        for _, v in pairs(v22) do
            local IsBanned = v.IsBanned;

            if IsBanned then
                local TeamColor = DuelLibrary:GetTeamColor(IsBanned);
                local v36 = ItemLibrary.Items[v.Name];
                v35[v36.Class] = (v35[v36.Class] or 0) + 1;
                local v37 = v35[v36.Class];
                local v38 = BanIcon:Clone();
                v38.ImageColor3 = Utility:DarkenColor(TeamColor, 0.5);
                v38.Icon.ImageColor3 = Utility:DarkenColor(TeamColor, 1);
                v38.LayoutOrder = v37;
                v38.ZIndex = -v37;
                v38.Parent = u21._weapon_tab_buttons[v36.Class].Bans;
                table.insert(u21._weapon_ban_icons, v38);
                v38.Weapon.Icon.Image = ItemLibrary.ViewModels[v.Name].ImageCentered or v36.Image;
                v38.Weapon.ZIndex = 10;
                v38.Weapon.Visible = true;
            end;
        end;
    end;

    if v27 then
        wait(1.25);
    end;
end;

function u1._ClearWeapons(p39) -- Line: 384
    for _, v in pairs(p39._weapon_slots) do
        v:Destroy();
    end;

    p39._weapon_slots = {};
    p39._weapon_slots_banned = {};
    p39.WeaponsFrame.Visible = false;
end;

function u1._GenerateWeapons(u40) -- Line: 395
    -- upvalues: Players (copy), WeaponSlot (copy), ReplicatedStorage (copy), TweenService (copy)
    u40.WeaponsFrame.Visible = true;
    local _generate_hash = u40._generate_hash;
    u40:_GenerateRemainingBans();

    if _generate_hash ~= u40._generate_hash then
        return;
    end;

    local v41 = u40.DuelInterface.ClientDuel:Get("VoteOptions");
    local Dueler = u40.DuelInterface.ClientDuel:GetDueler(Players.LocalPlayer);

    for i, v in pairs(v41) do
        local Name = v.Name;

        if not u40._weapon_slots[Name] then
            local v42 = WeaponSlot.new(Name);
            v42.Frame.LayoutOrder = i;
            v42.Frame.Parent = u40.WeaponsListContainer;

            if Dueler then
                v42.Frame.Button.MouseButton1Click:Connect(function() -- Line: 424
                    -- upvalues: ReplicatedStorage (ref), Name (copy)
                    ReplicatedStorage.Remotes.Duels.Vote:FireServer(Name);
                end);
            else
                v42:DisableButton();
            end;

            v42.PlayBanFrameSound:Connect(function(...) -- Line: 431
                -- upvalues: u40 (copy)
                u40:_PlayBanSound(...);
            end);
            u40._weapon_slots[Name] = v42;
            local UIScale = Instance.new("UIScale");
            UIScale.Scale = 0.25;
            UIScale.Parent = v42.Frame;
            TweenService:Create(UIScale, TweenInfo.new(math.sqrt(i) * 0.1 + 0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;
    end;

    for _, v in pairs(v41) do
        local Name = v.Name;
        local v43 = u40._weapon_slots[Name];

        if v43 and (v.IsBanned and not u40._weapon_slots_banned[Name]) then
            u40._weapon_slots_banned[Name] = true;
            v43:ToggleBanned(0, v.IsBanned);
        end;
    end;

    u40:_UpdateWeapons();
end;

function u1._ClearMaps(p44) -- Line: 461
    for _, v in pairs(p44._map_slots) do
        v:Destroy();
    end;

    p44._map_slots = {};
    p44.MapsCenter.Visible = false;
    p44.MapsList.Visible = false;
end;

function u1._GenerateMaps(u45) -- Line: 472
    -- upvalues: Players (copy), MapSlot (copy), ReplicatedStorage (copy), TweenService (copy)
    if u45._map_chosen_slot then
        return;
    end;

    local v46 = u45.DuelInterface.ClientDuel:Get("VoteSelectionMode");
    local v47 = u45.DuelInterface.ClientDuel:Get("VoteOptions");
    local v48 = #v47 <= 6;
    u45.MapsList.Visible = not v48;
    u45.MapsCenter.Visible = v48;
    u45.MapsCenterLayout.FillDirectionMaxCells = #v47 == 4 and 2 or 0;
    local _generate_hash = u45._generate_hash;
    u45:_GenerateRemainingBans();

    if _generate_hash ~= u45._generate_hash then
        return;
    end;

    local v49 = {};

    if not v48 and #v47 > 3 then
        local Random_new_ret = Random.new(u45.DuelInterface.ClientDuel:Get("DuelSeed"));
        local v50 = {};

        for _, v in pairs(v47) do
            if v.Name ~= "Random" then
                table.insert(v50, v);
            end;
        end;

        for i = 1, 3 do
            v49[table.remove(v50, Random_new_ret:NextInteger(1, #v50))] = true;
            local _ = i;
        end;
    end;

    local Dueler = u45.DuelInterface.ClientDuel:GetDueler(Players.LocalPlayer);
    local v51 = 0;

    for i, v in pairs(v47) do
        v51 = v51 + v.Votes;

        if not u45._map_slots[v.Name] then
            local v52;

            if v48 then
                v52 = u45.MapsCenter;
            elseif v49[v] then
                v52 = u45.MapsListMaximizedFrame;
            else
                v52 = u45.MapsListMinimizedFrame;
            end;

            local v53 = MapSlot.new(v.Name, not Dueler);
            v53.Frame.LayoutOrder = i;
            v53:SetParent(v52);
            u45._map_slots[v.Name] = v53;
            v53.CreateSound:Connect(function(...) -- Line: 530
                -- upvalues: u45 (copy)
                u45:_PlayBanSound(...);
            end);

            if Dueler then
                v53.Frame.Button.MouseButton1Click:Connect(function() -- Line: 535
                    -- upvalues: ReplicatedStorage (ref), v (copy)
                    ReplicatedStorage.Remotes.Duels.Vote:FireServer(v.Name);
                end);
            end;

            if v52 ~= u45.MapsListMaximizedFrame then
                local UIScale = Instance.new("UIScale");
                UIScale.Scale = 0.25;
                UIScale.Parent = v53.Frame;
                TweenService:Create(UIScale, TweenInfo.new(math.sqrt(i) * 0.1 + 0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
            end;
        end;
    end;

    local v54 = {};
    local v55 = {};
    local v56 = nil;

    for _, v in pairs(u45.DuelInterface.ClientDuel.Duelers) do
        local v57 = v:Get("LastVote");

        if v57 then
            v54[v57] = v54[v57] or {};
            table.insert(v54[v57], v.Player.UserId);
        end;

        if v.Player ~= Players.LocalPlayer then
            v57 = v56;
        end;

        v55[tostring(v.Player.UserId)] = v:Get("TeamID");
        v56 = v57;
    end;

    for _, v in pairs(v47) do
        local v58 = u45._map_slots[v.Name];

        if v58 then
            if v.IsBanned then
                v58.VoteBanFrame:Play(v.IsBanned, true);
            else
                v58:UpdateVotes(v.Votes, v51, v54[v.Name], v55, v.Name == v56, v46);
            end;
        end;
    end;
end;

function u1._UpdateLists(p59) -- Line: 583
    p59.MapsList.CanvasSize = UDim2.new(0, 0, 0, p59.MapsListMinimizedFrame.AbsolutePosition.Y + p59.MapsListMinimizedLayout.AbsoluteContentSize.Y - p59.MapsListContainer.AbsolutePosition.Y + 10);
    p59.MapsList.ClipsDescendants = p59.MapsList.CanvasPosition.Y > 5;
    p59.WeaponsList.CanvasSize = UDim2.new(0, 0, 0, p59.WeaponsListLayout.AbsoluteContentSize.Y);
    p59.WeaponsList.ClipsDescendants = p59.WeaponsList.CanvasPosition.Y > 5;
    p59.WeaponsTabsFrame.Visible = p59.WeaponsListLayout.AbsoluteContentSize.Y > 0;
    p59.WeaponsMapFrame.Visible = p59._last_map_chosen_result and p59.WeaponsTabsFrame.Visible;
    p59.MapsListMaximizedFrame.Visible = p59.MapsListMaximizedLayout.AbsoluteContentSize.Y > 0;
    p59.MapsListMinimizedFrame.Visible = p59.MapsListMinimizedLayout.AbsoluteContentSize.Y > 0;
    p59.MapsListCentererFrame.Size = UDim2.new(0, 0, 0, math.max(0, p59.MapsList.AbsoluteWindowSize.Y - p59.MapsList.CanvasSize.Y.Offset) / 2);
end;

function u1._Setup(u60) -- Line: 595
    -- upvalues: ItemLibrary (copy), VoteWeaponTabButton (copy), ButtonEffect (copy), DuelLibrary (copy)
    for i, v in pairs(ItemLibrary.Classes) do
        local v61 = VoteWeaponTabButton:Clone();
        v61.Title.Text = i;
        v61.Title.Icon.Image = v.ImageDiagonalLeft;
        v61.LayoutOrder = v.Slot;
        v61.Parent = u60.WeaponsTabsFrame;
        u60._weapon_tab_buttons[i] = v61;
        v61.MouseButton1Click:Connect(function() -- Line: 604
            -- upvalues: u60 (copy), i (copy)
            u60:_SetWeaponClassSelected(i);
        end);
        ButtonEffect:Add(v61);
        local Title = v61.Title;
        local Icon = Title.Icon;
        Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 613, Name: update
            -- upvalues: Icon (copy), Title (copy)
            Icon.Position = UDim2.new(0.5, -Title.TextBounds.X / 2, 0.5, 0);
        end);
        Icon.Position = UDim2.new(0.5, -Title.TextBounds.X / 2, 0.5, 0);
    end;

    local v62 = u60.DuelInterface.ClientDuel:Get("ArcadeMode");
    u60.MapsArcadeModeTitle.Text = v62 and ("Gamemode: " .. DuelLibrary.ArcadeModes[v62].DisplayName or "") or "";
    u60.MapsArcadeModeFrame.Visible = v62;
end;

function u1._Init(u63) -- Line: 627
    u63.MapsList:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 628
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsList:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 632
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsList:GetPropertyChangedSignal("CanvasSize"):Connect(function() -- Line: 636
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.WeaponsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 640
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.WeaponsList:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 644
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsListMaximizedLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 648
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsListMinimizedLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 652
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsListContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 656
        -- upvalues: u63 (copy)
        u63:_UpdateLists();
    end);
    u63.MapsListMinimizedFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 660
        -- upvalues: u63 (copy)
        task.defer(u63._UpdateLists, u63);
    end);
    u63:_Setup();
    u63:_UpdateLists();
end;

return u1;