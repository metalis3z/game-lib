local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Component = require(Packages.Component);
local Trove = require(Packages.Trove);
local Controllers = ReplicatedStorage:WaitForChild("Controllers");
local DialogController = require(Controllers.DialogController);
local Utils = ReplicatedStorage:WaitForChild("Utils");
local StringUtils = require(Utils.StringUtils);
local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Linear);
local LocalPlayer = Players.LocalPlayer;
local Npc = Component.new({
    Tag = "Npc"
});
Npc.Construct = function(v13)
	v13.Collector = Trove.new();
    v13.Hightlight = Instance.new("Highlight");
    v13.Hightlight.FillTransparency = 1;
    v13.Hightlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    v13.Hightlight.OutlineTransparency = 1;
    v13.Hightlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    v13.Hightlight.Parent = v13.Instance;
    v13.ProximityPrompt = Instance.new("ProximityPrompt", v13.Instance);
    v13.ProximityPrompt.ActionText = "Talk";
    v13.ProximityPrompt.ObjectText = v13.Instance:GetAttribute("PromptObjectText") or "";
	v13.ShownTween = TweenService:Create(v13.Hightlight, v10, {
        OutlineTransparency = 0
    });
	v13.HiddenTween = TweenService:Create(v13.Hightlight, v10, {
        OutlineTransparency = 1
    });
	v13.DialogText = DialogController:GetDialogText();
    v13.DialogText.Parent = v13.Instance.PrimaryPart;
    if v13.Instance:GetAttribute("IdlePath") then
		local v14 = StringUtils:ReadPath(ReplicatedStorage, v13.Instance:GetAttribute("IdlePath"));
        local v15 = v13.Instance:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v14);
        v15.Looped = true;
        v15:Play();
    end;
end;
Npc.Start = function(v16)
    v16.Collector:Add(v16.ProximityPrompt.Triggered:Connect(function()
		DialogController:StartDialog(v16.Instance:GetAttribute("Dialog"), v16.Instance:GetAttribute("Index"), v16.DialogText);
    end));
    v16.Collector:Add(v16.ProximityPrompt.PromptShown:Connect(function()
        v16.ShownTween:Play();
    end));
    v16.Collector:Add(v16.ProximityPrompt.PromptHidden:Connect(function()
        v16.HiddenTween:Play();
    end));
end;
Npc.Stop = function(v17)
    v17.Collector:Destroy();
end
return Npc