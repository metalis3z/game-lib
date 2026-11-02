-- Reference copy for study. Game: natural-disaster
-- Original: ServerStorage/LightningScript.server.lua  (Script, 23 lines)
-- What it does: Fades every Part of a lightning model out over 10 frames, then destroys it.

--Made by Stickmasterluke



sp=script.Parent
frames=10

wait()
for frame=1,frames do
	wait()
	for i,v in ipairs(sp:GetChildren()) do
		if v then
			if v.className=="Part" then
				v.Transparency=frame/frames
			end
		end
	end
end
sp:destroy()
