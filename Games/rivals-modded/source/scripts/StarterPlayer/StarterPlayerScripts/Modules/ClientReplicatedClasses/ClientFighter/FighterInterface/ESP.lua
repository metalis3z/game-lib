-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local ESPGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ESPGui");
local ESPSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ESPSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3._esp_connections = {};
    v3._esp_slots = {};
    v3._esp_gui = nil;
    v3._esp_gui_frame = nil;
    v3._esp_gui_fov_frame = nil;
    v3:_Init();

    return v3;
end;

function u1.Refresh(u4) -- Line: 33
    -- upvalues: Players (copy), ESPSlot (copy), UILibrary (copy), CONSTANTS (copy)
    u4:Clear();

    if not u4.FighterInterface.ClientFighter:Get("CheaterMode") then
        return;
    end;

    u4._esp_gui = u4:_CreateGui();
    u4._esp_gui_frame = u4._esp_gui:WaitForChild("Frame");
    u4._esp_gui_fov_frame = u4._esp_gui_frame:WaitForChild("FOV");
    table.insert(u4._esp_connections, Players.PlayerRemoving:Connect(function(p5) -- Line: 44, Name: clear_player
        -- upvalues: u4 (copy)
        if u4._esp_slots[p5] then
            u4._esp_slots[p5].Slot:Destroy();
            u4._esp_slots[p5] = nil;
        end;
    end));

    local function check_player(p6) -- Line: 53
        -- upvalues: u4 (copy), Players (ref), ESPSlot (ref), UILibrary (ref), CONSTANTS (ref)
        if u4._esp_slots[p6] then
            u4._esp_slots[p6].Slot:Destroy();
            u4._esp_slots[p6] = nil;
        end;

        if p6 == Players.LocalPlayer or Players.LocalPlayer:GetAttribute("TeamID") and Players.LocalPlayer:GetAttribute("TeamID") == p6:GetAttribute("TeamID") then
            return;
        end;

        local Character = p6.Character;
        local u7;

        if Character then
            u7 = Character:FindFirstChild("HumanoidRootPart");
        else
            u7 = Character;
        end;

        if Character then
            Character = Character:FindFirstChild("Humanoid");
        end;

        if not (u7 and (Character and Character.Health > 0)) then
            return;
        end;

        local u8 = ESPSlot:Clone();
        u8.Parent = u4._esp_gui_frame;
        local Line = u8.Line;
        u4._esp_slots[p6] = {
            Slot = u8,

            Update = function(p9) -- Line: 73, Name: update
                -- upvalues: u7 (copy), UILibrary (ref), u4 (ref), u8 (copy), CONSTANTS (ref), Character (copy), Line (copy)
                local v10, _ = workspace.CurrentCamera:WorldToScreenPoint(u7.Position);
                local v11 = UILibrary:ScreenPointToPosition(Vector2.new(v10.X, v10.Y), u4._esp_gui_frame.AbsolutePosition);
                local v12;

                if v10.Z >= 0 and v10.Z < CONSTANTS.RENDER_DISTANCE then
                    v12 = Character.Health > 0;
                else
                    v12 = false;
                end;

                u8.Visible = v12;

                if not u8.Visible then
                    return;
                end;

                local v13 = u4._esp_gui_fov_frame.AbsolutePosition + u4._esp_gui_fov_frame.AbsoluteSize / 2;
                local math_sqrt_ret = math.sqrt((v13.X - v10.X) ^ 2 + (v13.Y - v10.Y) ^ 2);
                local v14 = 4.71238898038469 - math.atan2(v10.X - v13.X, v10.Y - v13.Y);
                u8.Position = UDim2.new(0, v11.X, 0, v11.Y);
                Line.Size = UDim2.new(0, math_sqrt_ret, 0, 0);
                Line.Position = UDim2.new(0.5, math.cos(v14) * math_sqrt_ret / 2, 0.5, math.sin(v14) * math_sqrt_ret / 2);
                Line.Rotation = math.deg(v14);
                local v15 = workspace.CurrentCamera:WorldToScreenPoint(u7.Position + Vector3.new(0, 2, 0));
                local v16 = workspace.CurrentCamera:WorldToScreenPoint(u7.Position - Vector3.new(0, 3, 0));
                local math_abs_ret = math.abs(v15.Y - v16.Y);
                u8.Size = UDim2.new(0, math_abs_ret * 0.8, 0, math_abs_ret);
            end
        };
    end;

    local function player_added(u17) -- Line: 105
        -- upvalues: check_player (copy), u4 (copy)
        local function check() -- Line: 106
            -- upvalues: u17 (copy), check_player (ref)
            u17:WaitForChild("HumanoidRootPart", 3);
            check_player(u17);
        end;

        local _esp_connections = u4._esp_connections;
        local AttributeChangedSignal = u17:GetAttributeChangedSignal("TeamID");
        table.insert(_esp_connections, AttributeChangedSignal:Connect(check));
        table.insert(u4._esp_connections, u17.CharacterAdded:Connect(check));
        task.defer(check);
    end;

    table.insert(u4._esp_connections, Players.PlayerAdded:Connect(player_added));

    for _, v in pairs(Players:GetPlayers()) do
        task.defer(player_added, v);
    end;

    local function check_all_players() -- Line: 122
        -- upvalues: Players (ref), check_player (copy)
        for _, v in pairs(Players:GetPlayers()) do
            check_player(v);
        end;
    end;

    local _esp_connections = u4._esp_connections;
    local AttributeChangedSignal = Players.LocalPlayer:GetAttributeChangedSignal("TeamID");
    table.insert(_esp_connections, AttributeChangedSignal:Connect(check_all_players));
    u4._esp_gui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1.Update(p18, p19, p20) -- Line: 133
    -- upvalues: UILibrary (copy), CONSTANTS (copy)
    if not p18._esp_gui then
        return;
    end;

    local v21 = UILibrary:ScreenPointToPosition(p18.FighterInterface.ClientFighter:GetMouseLocation(), p18._esp_gui_frame.AbsolutePosition);
    p18._esp_gui_fov_frame.Position = UDim2.new(0, v21.X, 0, v21.Y);

    for _, v in pairs(p18._esp_slots) do
        if CONSTANTS.IS_STUDIO then
            v.Update(p19);
        else
            pcall(v.Update, p19);
        end;
    end;
end;

function u1.Clear(p22) -- Line: 151
    for _, v in pairs(p22._esp_connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p22._esp_slots) do
        v.Slot:Destroy();
    end;

    p22._esp_connections = {};
    p22._esp_slots = {};

    if p22._esp_gui then
        p22._esp_gui:Destroy();
        p22._esp_gui = nil;
    end;
end;

function u1.Destroy(p23) -- Line: 169
    p23:Clear();
end;

function u1._CreateGui(u24) -- Line: 177
    -- upvalues: ESPGui (copy)
    local u25 = ESPGui:Clone();

    local function update_visible() -- Line: 180
        -- upvalues: u25 (copy), u24 (copy)
        u25.Enabled = u24.FighterInterface.Frame.Visible and u24.FighterInterface.Frame.Parent;
    end;

    local _esp_connections = u24._esp_connections;
    local PropertyChangedSignal = u24.FighterInterface.Frame:GetPropertyChangedSignal("Visible");
    table.insert(_esp_connections, PropertyChangedSignal:Connect(update_visible));
    u25.Enabled = u24.FighterInterface.Frame.Visible and u24.FighterInterface.Frame.Parent;
    table.insert(u24._esp_connections, u24.FighterInterface.Frame.AncestryChanged:Connect(function() -- Line: 187, Name: ancestry_changed
        -- upvalues: u24 (copy), update_visible (copy), u25 (copy)
        if not u24.FighterInterface.Frame.Parent then
            return;
        end;

        local _esp_connections2 = u24._esp_connections;
        local PropertyChangedSignal2 = u24.FighterInterface.Frame.Parent:GetPropertyChangedSignal("Visible");
        table.insert(_esp_connections2, PropertyChangedSignal2:Connect(update_visible));
        u25.Enabled = u24.FighterInterface.Frame.Visible and u24.FighterInterface.Frame.Parent;
    end));

    if not u24.FighterInterface.Frame.Parent then
        return u25;
    end;

    local _esp_connections2 = u24._esp_connections;
    local PropertyChangedSignal2 = u24.FighterInterface.Frame.Parent:GetPropertyChangedSignal("Visible");
    table.insert(_esp_connections2, PropertyChangedSignal2:Connect(update_visible));
    u25.Enabled = u24.FighterInterface.Frame.Visible and u24.FighterInterface.Frame.Parent;

    return u25;
end;

function u1._Init(p26) -- Line: 202
end;

return u1;