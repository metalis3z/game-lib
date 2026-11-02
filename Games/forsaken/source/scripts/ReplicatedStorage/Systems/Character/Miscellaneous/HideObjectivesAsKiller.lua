-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(v0) --[[ Line: 4 ]] --[[ Name: Start ]]
        local function v2(v1) --[[ Line: 7 ]] --[[ Name: hideObjectiveThing ]]
            if v1:GetAttribute("ObjectiveRelated") then
                v1:Destroy();
            end;
            v1:GetAttributeChangedSignal("ObjectiveRelated"):Connect(function() --[[ Line: 11 ]]
                -- upvalues: v1 (copy)
                v1:Destroy();
            end);
        end;
        require(game.ReplicatedStorage.Modules.Util).OnPlayingStateChanged(function(v3) --[[ Line: 18 ]]
            -- upvalues: v0 (copy), v2 (copy)
            if v0.Connection then
                v0.Connection:Disconnect();
            end;
            if v3 == "Killers" then
                v0.Connection = workspace.Map.Ingame.DescendantAdded:Connect(v2);
                for _, v5 in pairs(workspace.Map.Ingame:GetDescendants()) do
                    v2(v5);
                end;
            end;
        end);
    end
};