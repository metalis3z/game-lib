local l_Parent_0 = script.Parent
local v2 = os.clock();

local OldGrip;

script.Parent.Activated:Connect(function()
	if os.clock() - v2 >= 2 then
		v2 = os.clock();
		OldGrip = l_Parent_0.Grip;
		l_Parent_0.Grip = script.Parent.AnimationGrip.Value;
		task.wait(2);
		l_Parent_0.Grip = OldGrip;
		OldGrip = nil;
	end;
end);