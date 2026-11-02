local t = {}
local Lib = require(game.ReplicatedStorage.Lib)
local MusicService = Lib.MusicService
local t2 = {}
local t3 = {}
local v1 = Random.new()
local v2 = true
local LocalPlayer = game.Players.LocalPlayer
local v3 = nil
local v4 = nil

function t.PlayDisk(p1) --[[ PlayDisk | Line: 17 | Upvalues: v4 (ref), v2 (ref), t2 (copy), v1 (copy), t3 (copy), v3 (ref), MusicService (copy) ]]
	if not v4 then
		print("play disk called!")
		v4 = true
		task.spawn(function() --[[ Line: 22 | Upvalues: v4 (ref), p1 (copy), v2 (ref), t2 (ref), v1 (ref), t3 (ref), v3 (ref), MusicService (ref) ]]
			task.wait(1)

			while v4 do
				local playing
				local v12 = p1

				if v2 then
					v2 = false
					playing = if v12 then v12 else t2[v1:NextInteger(1, #t2)]
				else
					playing = t3[v1:NextInteger(1, #t3)]
				end

				v3 = MusicService.Get(playing)
				print("Playing: ", playing, v4)
				v3:Broadcast()

				local v42 = math.ceil(v3.sound.TimeLength / 0.25)

				if v42 <= 0 then
					task.wait(1)
				end

				for i = 1, v42 do
					if not v4 then
						return
					end

					task.wait(0.25)
				end
			end
		end)
	end
end
Lib.Inject("PlayDisk", t.PlayDisk)
function t.SwitchTo(p1) --[[ SwitchTo | Line: 52 | Upvalues: v4 (ref), v3 (ref), MusicService (copy) ]]
	print("switching song to ", p1)
	v4 = false
	v3 = MusicService.Get(p1)
	v3:Broadcast()
end
Lib.Inject("SwitchDiskPlaying", t.SwitchTo)
Lib.Inject("StopDisk", function() --[[ Line: 62 | Upvalues: v4 (ref), MusicService (copy) ]]
	v4 = false

	local v1 = MusicService.GetCurrent()

	if not v1 then
		return
	end

	v1:Stop()
end)
function t.PlaySounAt(p1, p2, p3) --[[ PlaySounAt | Line: 68 | Upvalues: Lib (copy) ]]
	local v1 = Lib.MusicService.Get(p1, p3).sound:Clone()
	local Attachment = Instance.new("Attachment")

	Attachment.Parent = workspace.Terrain
	Attachment.WorldCFrame = CFrame.new(p2)
	v1.Parent = Attachment
	v1:Play()

	local count = 0

	while v1.TimeLength == 0 and count < 50 do
		task.wait()
		count = count + 1
	end

	task.wait(v1.TimeLength)
	Attachment:Destroy()
end
Lib.Inject("PlaySoundAt", t.PlaySounAt)
Lib.Network:BindEvents({
	SwitchMusicTo = t.SwitchTo,
	PlayDisk = t.PlayDisk,
	PlaySoundAt = t.PlaySounAt
})

return t