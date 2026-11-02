-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = script.Surface:Clone();
v0.Parent = script.Parent.Parent.Parent;
v0.Adornee = game.Workspace:WaitForChild("Lobby"):WaitForChild("EliteBoard"):WaitForChild("Screen");
v0.Frame.Frame.Buy.MouseButton1Click:connect(function()
    game.ReplicatedStorage.Remotes.Shop.GetElite:FireServer();
end);