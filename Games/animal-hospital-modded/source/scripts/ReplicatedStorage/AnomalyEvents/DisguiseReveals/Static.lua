local t = {}
local v1 = require(game.ReplicatedStorage:WaitForChild("Lib")).UI.Get("PhotoUI")

function t.Apply(p1) --[[ Apply | Line: 5 | Upvalues: v1 (copy) ]]
	v1:WaitForChild("static").Visible = true
end
function t.UnDo(p1) --[[ UnDo | Line: 9 | Upvalues: v1 (copy) ]]
	v1:WaitForChild("static").Visible = false
end

return t