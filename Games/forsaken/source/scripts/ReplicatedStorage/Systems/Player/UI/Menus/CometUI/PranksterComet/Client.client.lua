-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait();
local v0 = {
	game.CreatorType == Enum.CreatorType.User and game.CreatorId
};
local _ = game:GetService("ReplicatedStorage");
local l_Main_0 = script.Parent.Main;
local l_Segments_0 = l_Main_0.Segments;
local l_Frames_0 = l_Main_0.Frames;
local l_Tabs_0 = l_Main_0.Tabs;
local l_Assets_0 = script.Parent.Assets;
local v7 = require(l_Assets_0.Utility);
if not table.find(v0, game.Players.LocalPlayer.UserId) then
    script.Parent:Destroy();
end;
for _, v9 in ipairs(l_Tabs_0:GetChildren()) do
    if v9:IsA("Frame") and l_Assets_0.Tabs:FindFirstChild(v9.Name) then
        local l_TextButton_0 = v9:FindFirstChildOfClass("TextButton");
        local _ = v9.Name;
        local v12 = require(l_Assets_0.Tabs[v9.Name]);
        l_Frames_0[v9.Name].Visible = false;
        l_TextButton_0.MouseButton1Down:Connect(function() --[[ Line: 40 ]]
            -- upvalues: l_Frames_0 (copy), v9 (copy), l_Segments_0 (copy), v12 (copy), l_Main_0 (copy), l_TextButton_0 (copy), v7 (copy)
            for _, v14 in ipairs(l_Frames_0:GetChildren()) do
                if v14:IsA("Frame") then
                    v14.Visible = v14.Name == v9.Name;
                end;
            end;
            for _, v16 in ipairs(l_Segments_0:GetChildren()) do
                v16.Visible = table.find(v12.Data.Segments, v16.Name) and true or false;
            end;
            l_Main_0.Innings.Title.Text = v12.Data.Name or l_TextButton_0.Text;
            l_Main_0.Innings.Description.Text = v12.Data.Description or "";
            v7.SelectedModule = v9.Name;
        end);
    end;
end;
for _, v18 in ipairs(l_Segments_0:GetChildren()) do
    if l_Assets_0.Segments:FindFirstChild(v18.Name) then
        local _ = v18.Name;
        local _ = require(l_Assets_0.Segments[v18.Name]);
    end;
end;