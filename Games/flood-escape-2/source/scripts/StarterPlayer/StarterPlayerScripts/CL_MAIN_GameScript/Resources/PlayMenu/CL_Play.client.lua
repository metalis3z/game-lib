-- Decompiled using Krnl
local v6 = script:IsDescendantOf(game.Players.LocalPlayer.PlayerGui)
if not v6 then
    return 
end
v6 = game.Players.LocalPlayer.PlayerScripts
local v9 = v6:WaitForChild("CL_MAIN_GameScript")
script.Parent.Parent.MenuOpened.Event:connect(function(p1)
    local v11 = script
    if p1 == v11.Parent then
        v11 = v9
        v11.ViewMenu:Fire()
        v11 = v9
        v11.AddWaiting:Fire()
    end
end)
