-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LoadingGui_0 = script:WaitForChild("LoadingGui");
local l_Main_0 = l_LoadingGui_0:WaitForChild("LoadingScreen"):WaitForChild("Main");
local l_Percent_0 = l_Main_0:WaitForChild("Percent");
local l_Skip_0 = l_Main_0:WaitForChild("Skip");
l_LoadingGui_0.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
repeat
    task.wait();
until game:IsLoaded();
repeat
    task.wait();
until workspace:GetAttribute("ServerLoaded");
local v4 = tick();
local l_PlayerData_0 = game.Players.LocalPlayer:WaitForChild("PlayerData");
repeat
    task.wait();
until tick() >= v4 + 5 or l_PlayerData_0:GetAttribute("Instances") and #l_PlayerData_0:GetDescendants() + 2 >= l_PlayerData_0:GetAttribute("Instances");
task.wait(1);
local v6 = {};
local v7 = {};
local _ = function(v8) --[[ Line: 22 ]] --[[ Name: addAssetsToLoad ]]
    -- upvalues: v6 (copy)
    for _, v10 in pairs(v8) do
        table.insert(v6, v10);
    end;
end;
local l_workspace_Descendants_0 = workspace:GetDescendants();
for _, v14 in pairs(l_workspace_Descendants_0) do
    table.insert(v6, v14);
end;
l_workspace_Descendants_0 = game.ReplicatedStorage:GetDescendants();
for _, v16 in pairs(l_workspace_Descendants_0) do
    table.insert(v6, v16);
end;
l_workspace_Descendants_0 = game.StarterPlayer:GetDescendants();
for _, v18 in pairs(l_workspace_Descendants_0) do
    table.insert(v6, v18);
end;
l_workspace_Descendants_0 = game.StarterGui:GetDescendants();
for _, v20 in pairs(l_workspace_Descendants_0) do
    table.insert(v6, v20);
end;
function l_workspace_Descendants_0() --[[ Line: 33 ]] --[[ Name: updateProgress ]]
    -- upvalues: v7 (copy), v6 (copy), l_Percent_0 (copy)
    if not shared.Loaded then
        l_Percent_0.Text = ("%*%%"):format((math.floor(#v7 / #v6 * 100)));
    end;
end;
local v21 = #v6;
for v22, v23 in pairs(v6) do
    task.delay(v22 / (v21 / 0.75), function() --[[ Line: 43 ]]
        -- upvalues: v23 (copy), v7 (copy), v6 (copy), l_Percent_0 (copy)
        game.ContentProvider:PreloadAsync({
            v23
        });
        table.insert(v7, v23);
        if not shared.Loaded then
            l_Percent_0.Text = ("%*%%"):format((math.floor(#v7 / #v6 * 100)));
        end;
    end);
end;
task.delay(10, function() --[[ Line: 50 ]]
    -- upvalues: l_Skip_0 (copy)
    repeat
        task.wait();
    until game.Players.LocalPlayer:FindFirstChild("PlayerData");
    if not shared.Loaded then
        l_Skip_0.Visible = true;
        game.TweenService:Create(l_Skip_0, TweenInfo.new(1), {
            TextTransparency = 0
        }):Play();
        l_Skip_0.MouseButton1Click:Once(function() --[[ Line: 55 ]]
            shared.Loaded = true;
        end);
    end;
end);
repeat
    task.wait();
until #v7 >= #v6 - 100 or shared.Loaded;
shared.Loaded = true;
local v24 = require(game.ReplicatedStorage.Initializer);
repeat
    task.wait();
until v24.Loaded;
l_Percent_0.Text = "100%";
game.TweenService:Create(l_Percent_0.UIStroke, TweenInfo.new(0.666), {
    Transparency = 1
}):Play();
game.TweenService:Create(l_Percent_0.UIStroke, TweenInfo.new(2), {
    Thickness = 20
}):Play();
game.TweenService:Create(l_Skip_0, TweenInfo.new(0.666), {
    TextTransparency = 1
}):Play();
task.wait(1);
game.TweenService:Create(l_Percent_0, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    TextTransparency = 1
}):Play();
task.wait(0.5);
game.TweenService:Create(l_Main_0, TweenInfo.new(0.75), {
    BackgroundTransparency = 1
}):Play();
game.Debris:AddItem(l_LoadingGui_0, 0.75);