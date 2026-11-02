-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if require(game.ReplicatedFirst:WaitForChild("ChinaPolicyService")):IsActive() then
    script.Parent.Changed:Connect(function()
        script.Parent.Visible = false
    end)
end