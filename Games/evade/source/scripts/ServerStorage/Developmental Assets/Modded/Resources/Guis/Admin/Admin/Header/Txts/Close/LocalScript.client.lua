-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v2 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local l_Admin_0 = script.Admin;
local v4 = v2:Register("Admin", script.Parent.Parent.Parent.Parent, "TopQuint");
v4:AttachCloseButton(script.Parent);
v4:Close();
l_Admin_0.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons;
local v5 = require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll);
v5(script.Parent.Parent.Parent.Parent.Main.UIGradient, 3);
v5(l_Admin_0.UIGradient, 3);
local v6 = v1.new(l_Admin_0);
v6:Animate();
v6.OnActivated:Connect(function() --[[ Line: 21 ]]
    -- upvalues: v2 (copy)
    v2:Toggle("Admin", true);
end);