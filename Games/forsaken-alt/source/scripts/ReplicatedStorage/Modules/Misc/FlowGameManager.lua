-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.FlowGame);
local v1 = {};
v1.__index = v1;
v1.new = function() --[[ Line: 6 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy)
    local v2 = setmetatable({}, v1);
    v2.activeGame = nil;
    v2.Completed = nil;
    return v2;
end;
v1.startGame = function(v3, v4) --[[ Line: 13 ]] --[[ Name: startGame ]]
    -- upvalues: v0 (copy)
    if v3.activeGame then
        v3.activeGame:EndGame();
    end;
    local v5 = script.PuzzleUI:Clone();
    v5.Parent = game.Players.LocalPlayer.PlayerGui;
    v3.puzzleUI = v5;
    if not game.Players.LocalPlayer:GetAttribute("CompletedGenPuzzle") then
        v5.Container.Tutorial.Visible = true;
        v5.Container.Position = UDim2.fromScale(0.5, 0.55);
    end;
    v3.activeGame = v0.new(v5, v4);
    v3.activeGame.completedEvent = Instance.new("BindableEvent");
    v3.Completed = v3.activeGame.completedEvent.Event;
end;
v1.endGame = function(v6, v7) --[[ Line: 31 ]] --[[ Name: endGame ]]
    if not v6.activeGame then
        return;
    elseif v7 and v6.activeGame.id ~= v7 then
        return;
    else
        v6.activeGame:EndGame();
        v6.activeGame = nil;
        return;
    end;
end;
return v1.new();