-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Header");
    v3.SeasonFrame = v3.Frame:WaitForChild("Season");
    v3.SeasonText = v3.SeasonFrame:WaitForChild("Title");
    v3.DescriptionFrame = v3.Frame:WaitForChild("Description");
    v3.DescriptionButton = v3.DescriptionFrame:WaitForChild("Info");
    v3.DescriptionTitle = v3.DescriptionFrame:WaitForChild("Title");
    v3.GloryFrame = v3.Frame:WaitForChild("Glory");
    v3.GloryButton = v3.GloryFrame:WaitForChild("Button");
    v3.GloryIcon = v3.GloryButton:WaitForChild("Icon");
    v3.GloryTitle = v3.GloryButton:WaitForChild("Title");
    v3._update_description_thread = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 45
    p4:_UpdateGlory();
    p4:_UpdateDescription();
end;

function u1.Close(p5) -- Line: 50
    p5:_CancelDescriptionThread();
end;

function u1._CancelDescriptionThread(p6) -- Line: 58
    if p6._update_description_thread then
        task.cancel(p6._update_description_thread);
        p6._update_description_thread = nil;
    end;
end;

function u1._UpdateDescription(u7) -- Line: 65
    -- upvalues: SeasonLibrary (copy), PlayerDataController (copy), Utility (copy)
    local Name = SeasonLibrary.CurrentSeason.Name;
    local u8 = SeasonLibrary.Seasons[Name];
    local UNIVERSAL_ELO_NAME = SeasonLibrary.UNIVERSAL_ELO_NAME;
    local u9 = PlayerDataController:Get("Seasons")[Name];

    if u9 then
        u9 = u9.RankedPerformances[UNIVERSAL_ELO_NAME];
    end;

    if not u9.LastDuelPlayedTime or (not u9.CurrentELO or u9.CurrentELO <= u8.ELODecayThreshold) then
        u7.DescriptionTitle.Text = "Standard duel gameplay  •  Restricted handicaps  •  Ban maps & weapons";

        return;
    end;

    u7:_CancelDescriptionThread();
    u7._update_description_thread = task.spawn(function() -- Line: 81
        -- upvalues: u9 (copy), u8 (copy), u7 (copy), Utility (ref)
        while true do
            local v10 = (math.ceil(u9.LastDuelPlayedTime / 60 / 60 / 24) + u8.ELODecayInactivePeriodDays) * 24 * 60 * 60 - os.time();

            if v10 <= 0 then
                u7.DescriptionTitle.Text = "Your ELO has begun decaying, play Ranked now to stop it";
            else
                u7.DescriptionTitle.Text = string.format("Your ELO will start decaying in %s if you don\'t play Ranked", Utility:TimeFormat2(v10));
            end;

            wait(1);
        end;
    end);
end;

function u1._UpdateGlory(p11) -- Line: 97
    -- upvalues: Utility (copy), PlayerDataController (copy)
    p11.GloryTitle.Text = string.format("%s <font transparency=\"0.25\" weight=\"500\" size=\"8\">Glory</font>", Utility:PrettyNumber(PlayerDataController:Get("Glory")));
end;

function u1._Setup(p12) -- Line: 101
    -- upvalues: SeasonLibrary (copy), CurrencyLibrary (copy)
    p12.SeasonText.Text = "Season " .. SeasonLibrary.CurrentSeason.Version;
    p12.GloryIcon.Image = CurrencyLibrary.Info.Glory.Image;
end;

function u1._Init(u13) -- Line: 106
    -- upvalues: Pages (copy), ButtonEffect (copy)
    u13.DescriptionButton.MouseButton1Click:Connect(function() -- Line: 107
        -- upvalues: u13 (copy)
        u13.Page.PromptSystem:Open("ViewRankedDetails");
    end);
    u13.GloryButton.MouseButton1Click:Connect(function() -- Line: 111
        -- upvalues: u13 (copy), Pages (ref)
        u13.Page.OpenPage:Fire("Shop");
        Pages.PageSystem:WaitForPage("Shop"):SetPage("Ranked");
        Pages.PageSystem:WaitForPage("Shop"):RedirectTo("Ranked");
    end);
    u13:_Setup();
    ButtonEffect:Add(u13.DescriptionButton);
    ButtonEffect:Add(u13.GloryButton, nil, {
        ReleaseRatio = 1.05,
        HoverRatio = 1.05
    });
end;

return u1;