-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("MatchmakingCountdown"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Teleporting"));
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("PlayerList"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local PlayerInteractionGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PlayerInteractionGui");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 24
    -- upvalues: u1 (copy), PlayerInteractionGui (copy)
    local v2 = setmetatable({}, u1);
    v2.LocalFighter = nil;
    v2._connections = {};
    v2._changed_connections = {};
    v2._bbg = PlayerInteractionGui:Clone();
    v2._highlight = nil;
    v2._next_whitelist = 0;
    v2._whitelist = {};
    v2._disabled_until = 0;
    v2._hash = 0;
    v2:_Init();

    return v2;
end;

function u1._SetAdornee(p3, p4) -- Line: 53
    -- upvalues: Players (copy)
    p3._bbg.Adornee = p4 or nil;
    local v5;

    if p4 then
        v5 = Players.LocalPlayer.PlayerGui;
    else
        v5 = nil;
    end;

    p3._bbg.Parent = v5;
end;

function u1._GetWhitelist(p6) -- Line: 58
    -- upvalues: FighterController (copy)
    if tick() > p6._next_whitelist then
        p6._next_whitelist = tick() + 3;
        p6._whitelist = FighterController:GetFighterModels();
    end;

    return p6._whitelist;
end;

function u1._ClearChangedConnections(p7) -- Line: 67
    for _, v in pairs(p7._changed_connections) do
        v:Disconnect();
    end;

    p7._changed_connections = {};
end;

function u1._Verify(u8) -- Line: 75
    -- upvalues: Pages (copy), SpectateController (copy), MobileInputs (copy), Teleporting (copy), MatchmakingCountdown (copy), GuiService (copy), Players (copy), UILibrary (copy), Utility (copy), UserInputService (copy)
    for _, v in pairs(u8._connections) do
        v:Disconnect();
    end;

    u8._connections = {};

    if u8._highlight then
        u8._highlight:Destroy();
        u8._highlight = nil;
    end;

    u8:_SetAdornee(nil);
    u8:_ClearChangedConnections();
    u8._hash = u8._hash + 1;
    local _hash = u8._hash;

    if not u8.LocalFighter or (u8.LocalFighter:Get("IsInDuel") or (u8.LocalFighter:Get("IsInShootingRange") or u8.LocalFighter.Entity and u8.LocalFighter.Entity:Get("IsGrabbingSnowball"))) or tick() < u8._disabled_until then
        return;
    end;

    if Pages.PageSystem.CurrentPage or (SpectateController.CurrentDuelSubject or (MobileInputs.EditorEnabled or (Teleporting.Enabled or (MatchmakingCountdown:IsVisible() or GuiService.MenuIsOpen)))) then
        return;
    end;

    u8._highlight = Instance.new("Highlight");
    u8._highlight.Name = "PlayerInteraction";
    u8._highlight.FillColor = Color3.fromRGB(255, 255, 255);
    u8._highlight.Parent = Players.LocalPlayer.PlayerGui;

    local function get_hovered_player_object() -- Line: 106
        -- upvalues: UILibrary (ref), Utility (ref), u8 (copy), Players (ref)
        local MouseLocation = UILibrary:GetMouseLocation();
        local v9 = workspace.CurrentCamera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y, 0);
        local CharacterModel = Utility:GetCharacterModel(Utility:Raycast(v9.Origin, v9.Origin + v9.Direction * 100, 100, u8:_GetWhitelist(), Enum.RaycastFilterType.Include).Instance);
        local v10;

        if CharacterModel then
            v10 = Players:GetPlayerFromCharacter(CharacterModel);
        else
            v10 = CharacterModel;
        end;

        if not (CharacterModel and (CharacterModel:FindFirstChild("HumanoidRootPart") and (workspace.CurrentCamera.CFrame.Position - CharacterModel.HumanoidRootPart.Position).Magnitude < 5)) then
            return v10, CharacterModel;
        end;
    end;

    local u11 = nil;
    local u12 = 0;

    local function update_visuals() -- Line: 123
        -- upvalues: u8 (copy), _hash (copy), u12 (ref)
        if u8._hash ~= _hash then
            return;
        end;

        local v13 = tick() - u12 < 0.25;
        u8._highlight.FillTransparency = v13 and 0.5 or 0.75;
        u8._highlight.OutlineTransparency = v13 and 0 or 0.5;
        u8._bbg.Container.Title.Text = v13 and "Tap again to view profile" or "Double tap to view profile";
    end;

    if u8._hash == _hash then
        local v14 = tick() - u12 < 0.25;
        u8._highlight.FillTransparency = v14 and 0.5 or 0.75;
        u8._highlight.OutlineTransparency = v14 and 0 or 0.5;
        u8._bbg.Container.Title.Text = v14 and "Tap again to view profile" or "Double tap to view profile";
    end;

    local function set_start_click(p15) -- Line: 142
        -- upvalues: u12 (ref), u8 (copy), _hash (copy)
        u12 = p15;

        if u8._hash == _hash then
            local v16 = tick() - u12 < 0.25;
            u8._highlight.FillTransparency = v16 and 0.5 or 0.75;
            u8._highlight.OutlineTransparency = v16 and 0 or 0.5;
            u8._bbg.Container.Title.Text = v16 and "Tap again to view profile" or "Double tap to view profile";
        end;

        task.delay(0.25, function() -- Line: 146
            -- upvalues: u8 (ref), _hash (ref), u12 (ref)
            if u8._hash ~= _hash then
                return;
            end;

            local v17 = tick() - u12 < 0.25;
            u8._highlight.FillTransparency = v17 and 0.5 or 0.75;
            u8._highlight.OutlineTransparency = v17 and 0 or 0.5;
            u8._bbg.Container.Title.Text = v17 and "Tap again to view profile" or "Double tap to view profile";
        end);
    end;

    table.insert(u8._connections, UserInputService.InputBegan:Connect(function(u18) -- Line: 151
        -- upvalues: u12 (ref), u11 (ref), u8 (copy), _hash (copy), get_hovered_player_object (copy)
        if u18.UserInputType == Enum.UserInputType.MouseButton1 or (u18.UserInputType == Enum.UserInputType.Touch or u18.KeyCode == Enum.KeyCode.ButtonX) then
            if tick() - u12 > 0.25 then
                u11 = nil;
            end;

            u12 = tick();

            if u8._hash == _hash then
                local v19 = tick() - u12 < 0.25;
                u8._highlight.FillTransparency = v19 and 0.5 or 0.75;
                u8._highlight.OutlineTransparency = v19 and 0 or 0.5;
                u8._bbg.Container.Title.Text = v19 and "Tap again to view profile" or "Double tap to view profile";
            end;

            task.delay(0.25, function() -- Line: 146
                -- upvalues: u8 (ref), _hash (ref), u12 (ref)
                if u8._hash ~= _hash then
                    return;
                end;

                local v20 = tick() - u12 < 0.25;
                u8._highlight.FillTransparency = v20 and 0.5 or 0.75;
                u8._highlight.OutlineTransparency = v20 and 0 or 0.5;
                u8._bbg.Container.Title.Text = v20 and "Tap again to view profile" or "Double tap to view profile";
            end);

            if u18.UserInputType == Enum.UserInputType.Touch then
                u8:_ClearChangedConnections();
                local _changed_connections = u8._changed_connections;
                local PropertyChangedSignal = u18:GetPropertyChangedSignal("Position");
                table.insert(_changed_connections, PropertyChangedSignal:Connect(function() -- Line: 162
                    -- upvalues: get_hovered_player_object (ref), u8 (ref)
                    local _, v21 = get_hovered_player_object();
                    u8._highlight.Adornee = v21;

                    if v21 then
                        v21 = v21:FindFirstChild("HumanoidRootPart");
                    end;

                    u8:_SetAdornee(v21);
                end));
                local _changed_connections2 = u8._changed_connections;
                local PropertyChangedSignal2 = u18:GetPropertyChangedSignal("UserInputState");
                table.insert(_changed_connections2, PropertyChangedSignal2:Connect(function() -- Line: 169
                    -- upvalues: u18 (copy), u8 (ref)
                    if u18.UserInputState == Enum.UserInputState.End then
                        u8:_ClearChangedConnections();
                    end;
                end));
            end;
        end;
    end));
    table.insert(u8._connections, UserInputService.InputEnded:Connect(function(p22) -- Line: 178
        -- upvalues: u12 (ref), get_hovered_player_object (copy), u11 (ref), Pages (ref)
        if p22.UserInputType == Enum.UserInputType.MouseButton1 or (p22.UserInputType == Enum.UserInputType.Touch or p22.KeyCode == Enum.KeyCode.ButtonX) then
            if tick() - u12 > 0.25 then
                return;
            end;

            local v23 = get_hovered_player_object();

            if not v23 then
                return;
            end;

            if u11 == v23 then
                Pages.PageSystem:OpenPage("ViewProfile");
                Pages.PageSystem:WaitForPage("ViewProfile"):Fetch(v23);

                return;
            end;

            u11 = v23;
        end;
    end));
    local _connections = u8._connections;
    local PropertyChangedSignal = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame");
    table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 199, Name: mouse_moved
        -- upvalues: get_hovered_player_object (copy), u8 (copy)
        local _, v24 = get_hovered_player_object();
        u8._highlight.Adornee = v24;

        if v24 then
            v24 = v24:FindFirstChild("HumanoidRootPart");
        end;

        u8:_SetAdornee(v24);
    end));
    table.insert(u8._connections, UserInputService.InputChanged:Connect(function(p25) -- Line: 208
        -- upvalues: get_hovered_player_object (copy), u8 (copy)
        if p25.UserInputType == Enum.UserInputType.MouseMovement then
            local _, v26 = get_hovered_player_object();
            u8._highlight.Adornee = v26;

            if v26 then
                v26 = v26:FindFirstChild("HumanoidRootPart");
            end;

            u8:_SetAdornee(v26);
        end;
    end));
end;

function u1._HookLocalFighter(u27) -- Line: 215
    -- upvalues: FighterController (copy)
    u27.LocalFighter = FighterController:WaitForLocalFighter();
    u27.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 218
        -- upvalues: u27 (copy)
        u27:_Verify();
    end);
    u27.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 222
        -- upvalues: u27 (copy)
        u27:_Verify();
    end);

    local function entity_added(p28) -- Line: 226
        -- upvalues: u27 (copy)
        p28:GetDataChangedSignal("IsGrabbingSnowball"):Connect(function() -- Line: 227
            -- upvalues: u27 (ref)
            u27._disabled_until = tick() + 2;
            task.delay(2, u27._Verify, u27);
            u27:_Verify();
        end);
        u27:_Verify();
    end;

    u27.LocalFighter.EntityAdded:Connect(entity_added);

    if u27.LocalFighter.Entity then
        task.defer(entity_added, u27.LocalFighter.Entity);
    end;

    u27:_Verify();
end;

function u1._Setup(p29) -- Line: 245
    -- upvalues: Players (copy)
    p29._bbg.Name = "PlayerInteraction";
    p29._bbg.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u30) -- Line: 250
    -- upvalues: Pages (copy), SpectateController (copy), Teleporting (copy), MobileInputs (copy), MatchmakingCountdown (copy), GuiService (copy)
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 251
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 255
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 259
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 263
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 267
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    MatchmakingCountdown.VisibilityChanged:Connect(function() -- Line: 271
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 275
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    u30:_Setup();
    task.defer(u30._Verify, u30);
    task.spawn(u30._HookLocalFighter, u30);
end;

return u1._new();