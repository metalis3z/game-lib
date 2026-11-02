local v1 = {};
local l__TweenService__5 = game.TweenService;
local l__Debris__6 = game.Debris;
function v1.RunFx(p1, p2)
	
	local v7 = script.Sound:Clone();
	v7.Parent = p2.UpperTorso;
	v7:Play();
	game.Debris:AddItem(v7, 4);
	
	local v8 = script.Effect:Clone();
	v8.Parent = p2.UpperTorso;
	v8.Enabled = true;
	game.Debris:AddItem(v7, 4);
	task.spawn(function()
		wait(4)
		v8.Enabled = false
	end)
	return nil;
end;
return v1;
