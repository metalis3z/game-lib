-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Emotes_0 = l_Parent_0.Emotes;
_G.EmoteFrame = l_Emotes_0;
local v3 = require(game.ReplicatedStorage.Modules.EmoteModule);
v3.EmoteGUI = l_Emotes_0;
v3.GenerateEmotes(l_ProfileData_0.Emotes.Owned, l_Emotes_0);
v3.SetupPageButtons();
_G.UpdateEmotes();
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v5, v6, v7)
    l_ContextActionService_0:BindAction(v5, function(_, v9)
        if v9 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v7();
        end;
    end, false, v6);
end;
local _ = function(v11, _, _)
    l_ContextActionService_0:UnbindAction(v11);
end;
local v15 = {};
local function v19(v16)
    for _, v18 in pairs(v15) do
        game:GetService("GuiService"):RemoveSelectionGroup(v18);
    end;
    if v16 then
        game:GetService("GuiService"):AddSelectionParent(v16.Name, v16);
        table.insert(v15, v16.Name);
    end;
end;
local l_DPadRight_0 = Enum.KeyCode.DPadRight;
local function v25()
    for _, v22 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v22:IsA("Tool") and v22.Name == "Emotes" then
            _G.ResetDock();
            v22.Parent = game.Players.LocalPlayer.Character;
            v19(l_Emotes_0.EmotePages);
            game:GetService("GuiService").SelectedObject = l_Emotes_0.EmotePages[_G.CurrentPage or "RobloxEmotes"].Container:GetChildren()[1].Container.Button;
            return;
        end;
    end;
    for _, v24 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v24:IsA("Tool") and v24.Name == "Emotes" then
            v24.Parent = game.Players.LocalPlayer.Backpack;
            return;
        end;
    end;
end;
l_ContextActionService_0:BindAction("Emotes", function(_, v27)
    if v27 == Enum.UserInputState.Begin and not _G.PauseBinds then
        v25();
    end;
end, false, l_DPadRight_0);