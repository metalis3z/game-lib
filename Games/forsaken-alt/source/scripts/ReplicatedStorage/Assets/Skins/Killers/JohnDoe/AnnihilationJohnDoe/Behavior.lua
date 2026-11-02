-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	OnIntroduction = function(_, _, _, v3) --[[ Line: 4 ]] --[[ Name: OnIntroduction ]]
		local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.5, "AnnihilationIntroScene");
		game.Debris:AddItem(l_FOVMultiplier_0, v3);
	end, 
	GetRig = function(_, v6) --[[ Line: 10 ]] --[[ Name: GetRig ]]
		local v7 = v6.Rig:Clone();
		for _, v9 in pairs(v7:GetDescendants()) do
			if v9.Name == "ScriptedHighlight" then
				local l_Highlight_0 = Instance.new("Highlight");
				l_Highlight_0.FillColor = v9:GetAttribute("FillColor");
				l_Highlight_0.FillTransparency = v9:GetAttribute("FillTransparency");
				l_Highlight_0.OutlineColor = v9:GetAttribute("OutlineColor");
				l_Highlight_0.OutlineTransparency = v9:GetAttribute("OutlineTransparency");
				l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
				l_Highlight_0.Parent = v9.Parent;
			end;
		end;
		return v7;
	end
};