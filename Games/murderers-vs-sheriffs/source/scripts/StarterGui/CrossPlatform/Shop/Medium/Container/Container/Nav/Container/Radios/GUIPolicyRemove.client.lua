-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GUIPolicyRemove, time of decompilation: Fri Feb 13 19:20:45 2026 ]]
if require(game.ReplicatedFirst:WaitForChild("ChinaPolicyService")):IsActive() then
    script.Parent.Changed:Connect(function() --[[ Line: 5 ]]
        script.Parent.Visible = false;
    end);
end;