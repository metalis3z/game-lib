-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local GamepadService = game:GetService("GamepadService");
local Events = script.Parent.Parent.Events;
local u1 = {
    CurrentlyOpenInterfaces = {},
    OpenStack = {},
    Changed = Instance.new("BindableEvent")
};
local u2 = {
    CatalogController = true,
    CommunityOutfitsController = true,
    SavedOutfitsController = true,
    ExclusiveShopController = true,
    ModeratorPanelController = true,
    PublishOutfitController = true,
    SaveOutfitController = true,
    CreateAvatarController = true
};
local u3 = 0;

local function getTouchGui() -- Line: 27
    -- upvalues: Players (copy)
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

    if PlayerGui then
        return PlayerGui:FindFirstChild("TouchGui");
    end;

    return nil;
end;

local function updateTouchGuiVisibility() -- Line: 33
    -- upvalues: UserInputService (copy), Players (copy), u3 (ref)
    if not UserInputService.TouchEnabled then
        return;
    end;

    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
    local v4;

    if PlayerGui then
        v4 = PlayerGui:FindFirstChild("TouchGui");
    else
        v4 = nil;
    end;

    if not v4 then
        return;
    end;

    v4.Enabled = u3 <= 0;
end;

local u5 = false;

local function updateGamepadCursor() -- Line: 44
    -- upvalues: GuiService (copy), u3 (ref), u5 (ref), GamepadService (copy)
    if not GuiService:IsTenFootInterface() then
        return;
    end;

    local u6 = u3 > 0;

    if u6 == u5 then
        return;
    end;

    u5 = u6;
    pcall(function() -- Line: 49
        -- upvalues: u6 (copy), GamepadService (ref)
        if u6 then
            GamepadService:EnableGamepadCursor(nil);

            return;
        end;

        GamepadService:DisableGamepadCursor();
    end);
end;

function u1.Add(p7, p8, p9) -- Line: 58
    -- upvalues: u1 (copy), u2 (copy), u3 (ref), UserInputService (copy), Players (copy), GuiService (copy), u5 (ref), GamepadService (copy)
    if not p9 then
        u1.CloseOthers(p7);
    end;

    if u1.CurrentlyOpenInterfaces[p7] then
        u1.Remove(p7);
    end;

    u1.CurrentlyOpenInterfaces[p7] = p8;
    table.insert(u1.OpenStack, p7);

    if u2[p7] then
        u3 = u3 + 1;

        if UserInputService.TouchEnabled then
            local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
            local v10;

            if PlayerGui then
                v10 = PlayerGui:FindFirstChild("TouchGui");
            else
                v10 = nil;
            end;

            if v10 then
                v10.Enabled = u3 <= 0;
            end;
        end;

        if GuiService:IsTenFootInterface() then
            local u11 = u3 > 0;

            if u11 ~= u5 then
                u5 = u11;
                pcall(function() -- Line: 49
                    -- upvalues: u11 (copy), GamepadService (ref)
                    if u11 then
                        GamepadService:EnableGamepadCursor(nil);

                        return;
                    end;

                    GamepadService:DisableGamepadCursor();
                end);
            end;
        end;
    end;

    u1.Changed:Fire();
end;

function u1.Remove(p12) -- Line: 78
    -- upvalues: u1 (copy), u2 (copy), u3 (ref), UserInputService (copy), Players (copy), GuiService (copy), u5 (ref), GamepadService (copy)
    if u1.CurrentlyOpenInterfaces[p12] then
        u1.CurrentlyOpenInterfaces[p12] = nil;

        for i = #u1.OpenStack, 1, -1 do
            if u1.OpenStack[i] == p12 then
                table.remove(u1.OpenStack, i);
                break;
            end;
        end;

        if u2[p12] then
            u3 = u3 - 1;

            if UserInputService.TouchEnabled then
                local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
                local v13;

                if PlayerGui then
                    v13 = PlayerGui:FindFirstChild("TouchGui");
                else
                    v13 = nil;
                end;

                if v13 then
                    v13.Enabled = u3 <= 0;
                end;
            end;

            if GuiService:IsTenFootInterface() then
                local u14 = u3 > 0;

                if u14 ~= u5 then
                    u5 = u14;
                    pcall(function() -- Line: 49
                        -- upvalues: u14 (copy), GamepadService (ref)
                        if u14 then
                            GamepadService:EnableGamepadCursor(nil);

                            return;
                        end;

                        GamepadService:DisableGamepadCursor();
                    end);
                end;
            end;
        end;

        u1.Changed:Fire();
    end;
end;

function u1.CloseOthers(p15) -- Line: 96
    -- upvalues: u1 (copy)
    for i, v in u1.CurrentlyOpenInterfaces do
        if i ~= p15 then
            u1.Remove(i);
            v(true);
        end;
    end;
end;

function u1.Action(p16, ...) -- Line: 106
    -- upvalues: u1 (copy)
    local v17 = u1[p16];

    if v17 then
        v17(...);
    end;
end;

function u1.ForceCloseBackpack() -- Line: 113
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Purse.SetEnabled:Fire(false);
end;

Events.InterfaceAction.Event:Connect(u1.Action);
Events.ForceCloseBackpack.Event:Connect(u1.ForceCloseBackpack);

return u1;