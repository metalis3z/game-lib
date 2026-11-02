-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ConceptsLibrary = require(ReplicatedStorage.Modules.ConceptsLibrary);
require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local CreditsPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CreditsPlayerSlot");
local u1 = {
    { "Tester", Color3.fromRGB(255, 215, 0) },
    { "Moderator", Color3.fromRGB(255, 127, 0) },
    { "Community Staff", Color3.fromRGB(127, 110, 255) }
};
local Color3_fromRGB_ret = Color3.fromRGB(159, 25, 255);
Color3.fromRGB(46, 204, 113);
local u2 = {
    {
        20349956,
        "Nosniy",
        "Owner, 3D Artist",
        Color3_fromRGB_ret
    },
    {
        15941965,
        "SenseiWarrior",
        "Owner, Programmer, UI/UX, SFX",
        Color3_fromRGB_ret
    },
    { 780350915, "nekoanims", "Animation" },
    { 8034104, "GreatGuyBoom", "3D Artist, 2D Artist" },
    { 1730213868, "Brian1KB", "Matchmaking, Technical Advisor" },
    { 13108868, "ShadowTrojan", "3D Artist, 2D Artist, Wraps Artist" },
    { 25056711, "PrimeVoxel", "Particles" },
    { 42477697, "D_reamz", "Renders" },
    { 945382833, "himochu", "2D Artist" },
    { 113947873, "LiamGame09", "Wraps Artist" },
    { 182316511, "BSlickMusic", "Music, SFX" },
    { 1080973296, "xlISinner", "Anticheat" },
    { 424377859, "Kurookku", "Technical Advisor" },
    { 4444072910, "FluxxyBoiOfficial", "Bot Developer" },
    { 274029164, "StaredSystemized", "Graphics" },
    { 167445091, "SoftGB", "Graphics" }
};
local u3 = setmetatable({}, Page);
u3.__index = u3;

function u3._new() -- Line: 45
    -- upvalues: Page (copy), u3 (copy), PromptSystem (copy)
    local v4 = Page.new(script.Name);
    local v5 = setmetatable(v4, u3);
    v5.PromptsFrame = v5.PageFrame:WaitForChild("Prompts");
    v5.PageContainer = v5.PageFrame:WaitForChild("Container");
    v5.CloseButton = v5.PageContainer:WaitForChild("Close");
    v5.List = v5.PageContainer:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.Layout = v5.Container:WaitForChild("Layout");
    v5.ConceptorsFrame = v5.Container:WaitForChild("Conceptors");
    v5.ConceptorsContainer = v5.ConceptorsFrame:WaitForChild("Container");
    v5.ConceptorsPlayersFrame = v5.ConceptorsContainer:WaitForChild("Players");
    v5.ConceptorsPlayersLayout = v5.ConceptorsPlayersFrame:WaitForChild("Layout");
    v5.ConceptorsRewardFrame = v5.ConceptorsContainer:WaitForChild("Reward");
    v5.TeamFrame = v5.Container:WaitForChild("Team");
    v5.TeamEmptyFrame = v5.TeamFrame:WaitForChild("Empty");
    v5.TeamContainer = v5.TeamFrame:WaitForChild("Container");
    v5.TeamPlayersFrame = v5.TeamContainer:WaitForChild("Players");
    v5.TeamPlayersLayout = v5.TeamPlayersFrame:WaitForChild("Layout");
    v5.ContributorsFrame = v5.Container:WaitForChild("Contributors");
    v5.ContributorsEmptyFrame = v5.ContributorsFrame:WaitForChild("Empty");
    v5.ContributorsContainer = v5.ContributorsFrame:WaitForChild("Container");
    v5.ContributorsPlayersFrame = v5.ContributorsContainer:WaitForChild("Players");
    v5.ContributorsPlayersLayout = v5.ContributorsPlayersFrame:WaitForChild("Layout");
    v5.PromptSystem = PromptSystem.new(v5.PromptsFrame);
    v5:_Init();

    return v5;
end;

function u3._Update(p6) -- Line: 87
    p6.List.Size = UDim2.new(0.85, 0, 0, p6.PageFrame.AbsoluteSize.Y * 0.75);
    p6.List.CanvasSize = UDim2.new(0, 0, 0, p6.Layout.AbsoluteContentSize.Y);
    p6.ConceptorsFrame.Size = UDim2.new(1, 0, 0.1325, p6.ConceptorsPlayersLayout.AbsoluteContentSize.Y);
end;

function u3._Generate(u7) -- Line: 98
    -- upvalues: ReplicatedStorage (copy), u2 (copy), u1 (copy), ConceptsLibrary (copy), ComplianceController (copy), CreditsPlayerSlot (copy), CONSTANTS (copy), ButtonEffect (copy)
    local v8 = ReplicatedStorage.Remotes.Misc.RequestGroupMembers:InvokeServer();
    local v9 = {};

    for _, v in pairs(u2) do
        table.insert(v9, v[1]);
    end;

    for _, v in pairs(u1) do
        for _, v2 in pairs(v8[v[1]] or {}) do
            table.insert(v9, v2);
        end;
    end;

    for _, v in pairs(ConceptsLibrary.Leaderboard) do
        local v10 = tonumber(v.key);
        table.insert(v9, v10);
    end;

    local UserInfos = ComplianceController:GetUserInfos(v9);
    local u11 = 0;

    local function create_slot(p12, p13, p14, p15, p16, p17) -- Line: 119
        -- upvalues: u11 (ref), CreditsPlayerSlot (ref), CONSTANTS (ref)
        u11 = u11 + 1;
        local v18 = CreditsPlayerSlot:Clone();
        v18.LayoutOrder = u11;
        v18.Description.Text = p14;
        v18.Username.Text = p13;
        v18.Headshot.Image = p17 or string.format(CONSTANTS.HEADSHOT_IMAGE, p12);
        v18.Background.ImageColor3 = p15;
        v18.Parent = p16;

        return v18;
    end;

    for i, v in pairs(ConceptsLibrary.Leaderboard) do
        local v19 = UserInfos[v.key];
        local u20 = v19 and (v19.Username and "@" .. v19.Username) or "• • •";
        local v21 = string.format("%.1f", v.value) .. " points";
        local key = v.key;
        local Color3_fromRGB_ret2 = Color3.fromRGB(0, 0, 0);
        local ConceptorsPlayersFrame = u7.ConceptorsPlayersFrame;
        u11 = u11 + 1;
        local v22 = CreditsPlayerSlot:Clone();
        v22.LayoutOrder = u11;
        v22.Description.Text = v21;
        v22.Username.Text = u20;
        v22.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, key);
        v22.Background.ImageColor3 = Color3_fromRGB_ret2;
        v22.Parent = ConceptorsPlayersFrame;
        v22.LayoutOrder = i;
        v22.Button.Visible = true;
        v22.Button.MouseButton1Click:Connect(function() -- Line: 167
            -- upvalues: u7 (copy), v (copy), u20 (copy)
            u7.PromptSystem:Open("InspectConceptor", tonumber(v.key), u20);
        end);
        ButtonEffect:Add(v22.Button);
    end;
end;

function u3._Setup(p23) -- Line: 175
    -- upvalues: RewardSlot (copy), ConceptsLibrary (copy)
    p23.TeamEmptyFrame.Visible = true;
    p23.TeamPlayersFrame.Visible = false;
    p23.ContributorsEmptyFrame.Visible = true;
    p23.ContributorsPlayersFrame.Visible = false;
    RewardSlot.new({
        Weapon = "IsRandom",
        Name = ConceptsLibrary.CONCEPT_REWARD_NAME
    }):SetParent(p23.ConceptorsRewardFrame);
end;

function u3._Init(u24) -- Line: 185
    -- upvalues: ButtonEffect (copy)
    u24.CloseButton.MouseButton1Click:Connect(function() -- Line: 186
        -- upvalues: u24 (copy)
        u24:CloseRequest();
    end);
    u24.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 190
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 194
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.ContributorsPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 198
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.ConceptorsPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 202
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24:_Setup();
    u24:_Update();
    task.defer(u24._Generate, u24);
    ButtonEffect:Add(u24.CloseButton);
end;

return u3._new();