-- -- coroutine expample
--
-- local produceFunc = function()
--   while true do
--     local value = io.read()
--     coroutine.yield(value)                 -- return the vale
--   end
-- end
--
-- local filteFunc = function(p)
--   while true do
--     local status, value = coroutine.resume(p)
--     value = value*100
--     coroutine.yield(value)
--   end
-- end
--
-- local consumer = function(f,p)
--   while true do
--     local status, value = coroutine.resume(f,p)
--   end
-- end
--
-- -- relation
-- producer = coroutine.create(produceFunc)
-- filter = coroutine.create(filteFunc)
-- consumer(filter,producer)





--[[ initialize script ]]
local init = {}

--[[ scrpit info || routine status ]]
local script = {}

--[[ scanning config files ]]
local configFile = {}

--[[ registering || fedding  ]]
local flows = {}

---------------------------------------------------------------------------------------------

-- mark script status
function script.markStatus(foo)
  local foo = foo or "running"
  local path = '/sdcard/com.zhiye.cellphoneinformation/script'
  if not isFileExist(path) then
    ts.hlfs.makeDir(path)
  end
  writeFileString(string.format("%s/status.txt",path),foo,'w')
end

-- scanning config files
function configFile:get()
  --pass
end

-- flows get ragister && browse flow
function flow:get()
  local foo = class('foo',Register)
  local bar = class('bar',Browse)
  return foo:getFlow(), bar:getFlow()
end

-- switch flow
function flow:switch(type)
  local register, browse = self:get()
  if type == 'register' then
    register()
  elseif type == 'browse' then
    browse()
  else
    return false
  end
end
