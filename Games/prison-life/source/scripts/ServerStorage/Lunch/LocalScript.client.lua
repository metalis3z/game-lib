tool = script.Parent;
deb = false;
drink = 0;
tool.Equipped:connect(function(p1)
	p1.Button1Down:connect(function()
		if deb == false then
			drink = drink + 1;
			deb = true;
			tool.Handle.EatSound:Play();
			local l__Parent__1 = script.Parent.Parent;
			l__Parent__1.Humanoid:LoadAnimation(script.Parent.sss):Play();
			wait(3);
			l__Parent__1.Humanoid.Health = l__Parent__1.Humanoid.Health + 15;
			deb = false;
			if drink == 3 then
				script.Parent:Destroy();
			end;
		end;
	end);
end);
