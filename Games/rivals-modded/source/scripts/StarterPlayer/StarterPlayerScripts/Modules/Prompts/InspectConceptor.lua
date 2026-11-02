-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ConceptsLibrary = require(ReplicatedStorage.Modules.ConceptsLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 14
    -- upvalues: Prompt (copy), u1 (copy), ConceptsLibrary (copy)
    local v4 = Prompt.new(script.Name);
    local v5 = setmetatable(v4, u1);
    v5.CloseButton = v5.PromptFrame:WaitForChild("Close");
    v5.Headshot = v5.PromptFrame:WaitForChild("Headshot");
    v5.Title = v5.PromptFrame:WaitForChild("Title");
    v5.Points = v5.PromptFrame:WaitForChild("Points");
    v5.List = v5.PromptFrame:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.Layout = v5.Container:WaitForChild("Layout");
    v5._user_id = p2;
    v5._username = p3;
    v5._conceptor_info = ConceptsLibrary.Conceptors[tostring(v5._user_id)];
    v5._reward_slots = {};
    v5:_Init();

    return v5;
end;

function u1.Destroy(p6) -- Line: 39
    -- upvalues: Prompt (copy)
    for _, v in pairs(p6._reward_slots) do
        v:Destroy();
    end;

    Prompt.Destroy(p6);
end;

function u1._Update(p7) -- Line: 51
    p7.List.CanvasSize = UDim2.new(0, 0, 0, p7.Layout.AbsoluteContentSize.Y);
    p7.List.ClipsDescendants = p7.List.AbsoluteCanvasSize.Y > p7.List.AbsoluteWindowSize.Y;
end;

function u1._Setup(p8) -- Line: 56
    -- upvalues: ConceptsLibrary (copy), CONSTANTS (copy), CosmeticLibrary (copy), RewardSlot (copy)
    p8.Title.Text = p8._username;
    p8.Points.Text = string.format("%.1f", ConceptsLibrary:GetConceptScore(p8._user_id)) .. " points";
    p8.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p8._user_id);

    for _, v in pairs(p8._conceptor_info.CosmeticConcepts) do
        local v9 = RewardSlot.new({
            Name = v,
            Weapon = CosmeticLibrary.Cosmetics[v].ItemName
        });
        v9:SetParent(p8.Container);
        table.insert(p8._reward_slots, v9);
    end;
end;

function u1._Init(u10) -- Line: 69
    -- upvalues: ButtonEffect (copy)
    u10.CloseButton.MouseButton1Click:Connect(function() -- Line: 70
        -- upvalues: u10 (copy)
        u10:CloseRequest();
    end);
    u10.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 74
        -- upvalues: u10 (copy)
        u10:_Update();
    end);
    u10.List:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() -- Line: 78
        -- upvalues: u10 (copy)
        u10:_Update();
    end);
    u10.List:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 82
        -- upvalues: u10 (copy)
        u10:_Update();
    end);
    u10:_Setup();
    u10:_Update();
    ButtonEffect:Add(u10.CloseButton);
end;

return u1;