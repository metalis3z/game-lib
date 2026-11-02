--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMJBlJhZGl1cw1HZXRDb2xsaXNpb25zCUdldE9iamVjdAV0YWJsZQZpbnNlcnQMQ2xvc2VzdFBvaW50Bk5vcm1hbA5Db2xsaXNpb25zRGF0YQ1Db2xsaXNpb25IaXRzAAITAwAAAAA8/wMAAAAAAAD/BAAAAAAAAFIFAgDGBgAAxgcAAGQFHwBSDAEATQ0AcQAAAAC8CglEAQAAAJ8KBAIcCwoAjAwAAGAMCQALAAAAUgwEALwNCfkCAAAAnw0CAEw0AAKkCwUAABAwgJ8LAAFSCwoAxgwAAMYNAABkCwcAnjQDBQ8AAABSEQMAUhIPAKQQBQAAEDCAnxADAW4L+P8CAAAAbgXg/wIAAABSBQMAxgYAAMYHAABkBQgATQoJYQYAAABNDAkQBwAAAE0NAHEAAAAACQsMDUMBCgtuBff/AgAAADADAKcIAAAAMAQAiQkAAACCAQIACgMBAwIDAwMEAwUEABAwgAMGAwcDCAMJAAEAARgAAAEAAgAAAAEAAAAAAAIAAAABAAAAAAAAAAMAAAABAAAAAAAA/wD5AAwAAAABAAAAAAAAAP8ABQABAAMDAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgABAAEAARgAAAABAAAAAAFLK2gMT8XtW4YbXW03MbLQOzN/eHnvAg0=

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	local t = {}
	local t2 = {}

	for v1, v2 in p3 do
		local v3 = v2:GetCollisions(p2, p1.Radius)

		if #v3 > 0 then
			table.insert(t, v2:GetObject())
		end

		for v4, v5 in v3 do
			table.insert(t2, v5)
		end
	end

	for v6, v7 in t2 do
		p2 = v7.ClosestPoint + v7.Normal * p1.Radius
	end

	p1.CollisionsData = t2
	p1.CollisionHits = t

	return p2
end