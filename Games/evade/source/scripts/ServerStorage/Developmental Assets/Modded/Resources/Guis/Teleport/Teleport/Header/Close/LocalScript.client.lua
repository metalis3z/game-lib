-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait(3);
local _ = game:GetService("TextChatService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v3 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local l_Teleport_0 = script.Teleport;
local v5 = v3:Register("Teleport", script.Parent.Parent.Parent, "TopQuint");
v5:AttachCloseButton(script.Parent);
v5:Close();
l_Teleport_0.Parent = script.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons;
local v6 = require(script.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll);
v6(script.Parent.Parent.Main.UIGradient, 3);
v6(l_Teleport_0.UIGradient, 3);
local v7 = v2.new(l_Teleport_0);
v7:Animate();
v7.OnActivated:Connect(function() --[[ Line: 24 ]]
    -- upvalues: v3 (copy)
    v3:Toggle("Teleport", true);
end);