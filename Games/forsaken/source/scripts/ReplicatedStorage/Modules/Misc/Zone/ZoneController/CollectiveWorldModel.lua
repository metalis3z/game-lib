-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVCElzQ2xpZW50EVJlcGxpY2F0ZWRTdG9yYWdlDVNlcnZlclN0b3JhZ2UISW5zdGFuY2UDbmV3CldvcmxkTW9kZWwSWm9uZVBsdXNXb3JsZE1vZGVsBE5hbWUEZ2FtZQpHZXRTZXJ2aWNlBlBhcmVudA9zZXR1cFdvcmxkTW9kZWwJd29ya3NwYWNlBXBhaXJzBXRhYmxlBmluc2VydBNfZ2V0Q29tYmluZWRSZXN1bHRzEkdldFBhcnRCb3VuZHNJbkJveBVHZXRQYXJ0Qm91bmRzSW5SYWRpdXMOR2V0UGFydHNJblBhcnQKUnVuU2VydmljZQAGBgECAAAAIPsBAAAOAQIA+wEAAIIBAgD7AgEAvAICBAAAAACfAgICDgICAG8BAQBlAAEAbwECAKQCBQAAEDCAbwMGAJ8CAgLeAgAA+wIAAG8DBwAwAwK6CAAAAPsCAACkAwoAAACQQFIFAQC8AwMWCwAAAJ8DAwIwAwIkDAAAAPsCAACCAgIADQMBAwIDAwMEAwUEABAwgAMGAwcDCAMJBAAAkEADCgMLAAgMARgAAAEAAgAAAAAAAAABAAAAAAEAAAABAAAAAAAAAAABAAkAAAAADAIBAQAAHqMCAACkAwEAAAAAQIcCAwGkAwEAAAAAQN0EAACfAgAC+wMAAA4DEwD7BAAAhwMEAfsEAADdBQAAnwMAAqQEAwAAACBAUgUDAJ8EAgQXBAcAnjQCBQgAAABSCgIAUgsIAKQJBgAAFECAnwkDAW4E+P8CAAAAggICAAcDDQQAAABAAw4EAAAgQAMPAxAEABRAgAAWEQEYAAEAAAAAAAABAAEAAAAAAQAAAAABAAAAAAAA/wAEFgAAAAAKBAAAAAAIbwYAAFIHAQBSCAIAUgkDALwEAKoBAAAAnwQGAIIEAAACAxIDEQAhEgEYAAAAAAAAAAAiAAAAAAoEAAAAAAhvBgAAUgcBAFIIAgBSCQMAvAQAqgEAAACfBAYAggQAAAIDEwMRACUTARgAAAAAAAAAACYAAAAACAMAAAAAB28FAABSBgEAUgcCALwDAKoBAAAAnwMFAIIDAAACAxQDEQApFAEYAAAAAAAAACoAAAAABQAAAQIAHqMAAAD/AAQAAAAAAMYBAACkAgEAAAAAQG8EAgC8AgIWAwAAAJ8CAwLZAwAAEgEB/xIAAgAwAwDxBAAAANkDAQASAQH/MAMAqgUAAADAAwYAMAMALwcAAADAAwgAMAMATAkAAADAAwoAMAMAtQsAAADBAQAAggACAAwDCQQAAABAAxUDCgMMAxEGAgMSBgMDEwYEAxQFAAECAwQBAAEYAAAAAQEAAAAAAAUAAAAADgAAAAsAAAQAAAQAAAYAAQAAAAAFV5Q2gP1VvlplUFwUwr2OQqf3au0h5XnK9ejnK77njdvLn91dWG5mgQ==

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = nil
local v_u_3 = game:GetService("RunService")
function v1.setupWorldModel(_)
	-- upvalues: (ref) v_u_2, (copy) v_u_3
	if v_u_2 then
		return v_u_2
	end
	local v4 = v_u_3:IsClient() and "ReplicatedStorage" or "ServerStorage"
	v_u_2 = Instance.new("WorldModel")
	v_u_2.Name = "ZonePlusWorldModel"
	v_u_2.Parent = game:GetService(v4)
	return v_u_2
end
function v1._getCombinedResults(_, p5, ...)
	-- upvalues: (ref) v_u_2
	local v6 = workspace[p5](workspace, ...)
	if v_u_2 then
		local v7 = v_u_2[p5](v_u_2, ...)
		for _, v8 in pairs(v7) do
			table.insert(v6, v8)
		end
	end
	return v6
end
function v1.GetPartBoundsInBox(p9, p10, p11, p12)
	return p9:_getCombinedResults("GetPartBoundsInBox", p10, p11, p12)
end
function v1.GetPartBoundsInRadius(p13, p14, p15, p16)
	return p13:_getCombinedResults("GetPartBoundsInRadius", p14, p15, p16)
end
function v1.GetPartsInPart(p17, p18, p19)
	return p17:_getCombinedResults("GetPartsInPart", p18, p19)
end
return v1
