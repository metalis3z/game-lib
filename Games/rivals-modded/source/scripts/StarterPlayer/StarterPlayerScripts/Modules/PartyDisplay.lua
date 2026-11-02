-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"));
local Matchmaking = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Lobby"):WaitForChild("Matchmaking"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PartyMemberSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PartyMemberSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 15
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.Frame = p2;
    v4._connections = {};
    v4._slots = {};
    v4._inverted_order = p3;
    v4:_Init();

    return v4;
end;

function u1.Destroy(p5) -- Line: 33
    for _, v in pairs(p5._connections) do
        v:Disconnect();
    end;

    p5:_Clear();
end;

function u1._Clear(p6) -- Line: 45
    for _, v in pairs(p6._slots) do
        v:Destroy();
    end;

    p6._slots = {};
end;

function u1._Generate(u7) -- Line: 53
    -- upvalues: PartyController (copy), Players (copy), PartyMemberSlot (copy), CONSTANTS (copy), Matchmaking (copy), Pages (copy), ButtonEffect (copy)
    u7:_Clear();
    local v8 = PartyController.CurrentParty or { Players.LocalPlayer };

    local function generate_slot(p9, p10) -- Line: 58
        -- upvalues: PartyMemberSlot (ref), CONSTANTS (ref), PartyController (ref), u7 (copy), Matchmaking (ref), Pages (ref), ButtonEffect (ref)
        local v11 = PartyMemberSlot:Clone();
        v11.Button.Icon.Image = not p10 and "" or string.format(CONSTANTS.HEADSHOT_IMAGE, p10.UserId);
        v11.Button.Leader.Visible = PartyController.CurrentParty and p9 == 1;
        v11.Button.Invite.Visible = not p10;
        v11.Button.Inputs.Visible = not p10;
        v11.Button.Inputs.Gamepad.Keybind.Position = u7._inverted_order and UDim2.new(0.5, 0, -0.25, 0) or UDim2.new(1.25, 0, 0.5, 0);
        v11.Size = p9 == 1 and UDim2.new(1, 0, 1, 0) or UDim2.new(0.75, 0, 0.75, 0);
        v11.LayoutOrder = p9 * (u7._inverted_order and -1 or 1);
        v11.Button.MouseButton1Click:Connect(function() -- Line: 68
            -- upvalues: Matchmaking (ref), Pages (ref)
            if Matchmaking:IsVisible() then
                return;
            end;

            local v12 = Pages.PageSystem.CurrentPage and Pages.PageSystem.CurrentPage.Name;
            Pages.PageSystem:OpenPage("Party", true);
            Pages.PageSystem:WaitForPage("Party"):RedirectTo(v12);
        end);
        v11.Parent = u7.Frame;
        table.insert(u7._slots, v11);
        ButtonEffect:Add(v11.Button);
    end;

    for i, v in pairs(v8) do
        generate_slot(i, v);
    end;

    if #v8 < CONSTANTS.MAX_PARTY_SIZE and PartyController:IsPartyLeader() then
        generate_slot(#v8 + 1, nil);
    end;
end;

function u1._Init(u13) -- Line: 93
    -- upvalues: PartyController (copy)
    table.insert(u13._connections, PartyController.PartyChanged:Connect(function() -- Line: 94
        -- upvalues: u13 (copy)
        u13:_Generate();
    end));
    u13:_Generate();
end;

return u1;