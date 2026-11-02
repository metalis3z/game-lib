-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_TitlesFrame_0 = require(script.Parent.Parent.Handlers:WaitForChild("TitlesFrame"));
local v4 = l_Knit_0.CreateController({
    Name = "TitleFrameController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
v4.KnitInit = function(v6) --[[ Line: 13 ]] --[[ Name: KnitInit ]]
    v6.PlayerGui = nil;
    v6.ScreenFrames = nil;
    v6.TitlesFrameGui = nil;
    v6.UIManager = nil;
    v6.PlayerService = nil;
    v6.RankTitleService = nil;
    v6.TitlesFrame = nil;
    v6.ProfileLoadedConn = nil;
    v6.RankTitleDataConn = nil;
end;
v4.KnitStart = function(v7) --[[ Line: 27 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Knit_0 (copy), l_TitlesFrame_0 (copy)
    v7.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v7.ScreenFrames = v7.PlayerGui:WaitForChild("ScreenFrames");
    v7.TitlesFrameGui = v7.ScreenFrames:WaitForChild("TitlesFrame");
    v7.UIManager = l_Knit_0.GetController("UIManager");
    v7.PlayerService = l_Knit_0.GetService("PlayerService");
    v7.RankTitleService = l_Knit_0.GetService("RankTitleService");
    v7.TitlesFrame = l_TitlesFrame_0.new(v7.TitlesFrameGui);
    v7.TitlesFrame:Init();
    if v7.UIManager then
        v7.UIManager:WatchRoot(v7.TitlesFrameGui);
    end;
    if v7.PlayerService and v7.PlayerService.ProfileLoaded then
        v7.ProfileLoadedConn = v7.PlayerService.ProfileLoaded:Connect(function() --[[ Line: 44 ]]
            -- upvalues: v7 (copy)
            if v7.TitlesFrame then
                v7.TitlesFrame:_requestRankTitleDataRefresh();
            end;
        end);
    end;
    if v7.RankTitleService and v7.RankTitleService.RankTitleDataUpdated then
        v7.RankTitleDataConn = v7.RankTitleService.RankTitleDataUpdated:Connect(function() --[[ Line: 52 ]]
            -- upvalues: v7 (copy)
            if v7.TitlesFrame then
                v7.TitlesFrame:_requestRankTitleDataRefresh();
            end;
        end);
    end;
    task.defer(function() --[[ Line: 59 ]]
        -- upvalues: v7 (copy)
        if v7.TitlesFrame then
            v7.TitlesFrame:_requestRankTitleDataRefresh();
        end;
    end);
end;
return v4;