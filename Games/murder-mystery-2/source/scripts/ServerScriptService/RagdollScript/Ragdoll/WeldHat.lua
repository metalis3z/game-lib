return function(Hat, Character)
	--[[local Weld = Instance.new("ManualWeld");
	Weld.Part0 = Character.notahead;
	Weld.Part1 = Hat:Clone();
	Weld.C0 = CFrame.new(0, 0.5, 0);
	Weld.C1 = Hat.AttachmentPoint;
	Weld.Parent = Weld.Part0;
	Weld.Part1.Parent = Character;
	--Hat:Destroy();]]
	local hat = Hat:Clone()
	hat.Parent = Character
end