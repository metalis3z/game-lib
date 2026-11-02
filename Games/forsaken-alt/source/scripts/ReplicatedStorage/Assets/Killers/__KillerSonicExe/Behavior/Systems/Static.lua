-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Type = "Client", 
    Start = function(_, _) --[[ Line: 5 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local _ = l_LocalPlayer_0.Character;
        local v4 = script.static:Clone();
        v4.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
        task.spawn(function() --[[ Line: 15 ]]
            -- upvalues: v4 (copy)
            while v4.Parent do
                for v5 = 0, 2 do
                    for v6 = 0, 2 do
                        if v6 ~= 2 or v5 ~= 2 then
                            v4.ImageRectOffset = Vector2.new(333 * v6, 250 * v5);
                            task.wait();
                        end;
                    end;
                end;
            end;
        end);
    end, 
    Destroy = function(_) --[[ Line: 29 ]] --[[ Name: Destroy ]]

    end
};