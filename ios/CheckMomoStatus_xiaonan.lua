--README:forked form momoRegister.lua check part
require("TSLib")
local ts = require("ts")
local sz = require("sz")
-- ==================== general lib =================
--func; get next record
function getNextRecord()
    openURL("nzt://cmd/nextrecord")
end
--write content to file
function writeContent(fileName,content,pattern)
    local file = io.open(fileName,pattern)
    file:write(content)
    file:close()
end
function writeContentTable(fileName,tbl,pattern)
    local file = io.open(fileName,pattern)
	if(#tbl > 0)
	then
		for i = 1,#tbl do
			file:write(tbl[i],"\n")
		end
	end
    file:close()
end
--func: clear string..
function clearString()
    for var = 1,15 do
        inputText("\b")
    end
end
-- flip
function flip(x1,y1,x2,y2)
    -- body
    touchDown(x1,y1)
    mSleep(30)
    touchMove(x2,y2)
    mSleep(30)
    touchUp(x2,y2)
end
--open momo
function openMomo()
    local momo = "com.wemomo.momoappdemo1"
    runApp(momo)
    mSleep(2000)
end
--close Momo
function closeMomo()
    local momo = "com.wemomo.momoappdemo1"
    closeApp(momo)
    mSleep(2000)
end

--open NZT
function openNZT()
    local NZT = "NZT";
    runApp(NZT)
    mSleep(3000)
end
--close NZT
function closeNZT()
    local NZT = "NZT";
    closeApp(NZT)
    mSleep(3000)
end


--switch airplaneMode
function airplaneModeSwitch()
    -- body
    setAirplaneMode(true)
    mSleep(4000)
    setAirplaneMode(false)
    mSleep(3000)
end
--check if is "你关闭了系统通知"
function dropYellowRings()
  local i = 0
	local yellowRings = {{459,640,0x000000},{200,361,0xffcb24},{220,475,0xffcb24},{336,403,0xf38126},{433,541,0xf38126}}
  while (not(multiColor(yellowRings)) and i <= 4) do
    mSleep(1000)
    i = i + 1
  end
    if(multiColor(yellowRings))
    then
        tap(169,871)
        mSleep(2000)
    end
end


-- UI
UINew(1,"检测陌陌号状态","确认","取消","uiconfig_check.dat",0,360000,getScreenSize())
UILabel({num=1,text="检测MOMO数:",align="left",size=30,width="200",nowrap="0"})
UIEdit({num=1,id="checkQuantity",prompt="? 个",text="50",size=25,align="left",color="50,50,50",kbtype="number",width="200"})
UIShow()
configInfo = {}
--func: get configInfo
function getConfigInfo()
  configInfo.checkQuantity = checkQuantity*1
end
--func: check UI config
function checkConfig()
  local momoIds = readFile(userPath() .. "/lua/注册成功陌陌账号.txt")
  if(configInfo.checkQuantity == 0 or checkQuantity == "")
  then
    toast("Check Quantity got null! reset plz,terminating ..",3)
    lua_restart()
  elseif(configInfo.checkQuantity > #momoIds)
  then
    toast("There r only " .. #momoIds .. " records,reset plz ..",3)
    lua_restart()
  end
end


-- check part
-- check momoId status
function momoIdStatusCheck()
    openNZT()
    airplaneModeSwitch()
    airplaneModeSwitch()
    openMomo()
    mSleep(4000)
    if(multiColor({{293,292,0xffffff},{333,290,0xffffff},{48,829,0x3462ff},{569,831,0x3462ff}}) or multiColor({{59,681, 0x3462ff},{591,683,0x3462ff},{183,1062,0xfc7c3f},{318,1058,0x0ec600},{460,1062,0x36b6ff}}))
    then
      closeMomo()
      getNextRecord()
      mSleep(2000)
      return momoIdStatusCheck()
    end

    tap(319,1082) 			--tap news
    mSleep(2000)
    dropYellowRings()
    flip(281,598,301,944)     -- "drag down"
    mSleep(1000)
    tap(331,172)              -- tap "search"
    mSleep(1000)
    local momoIds = readFile(userPath() .. "/lua/注册成功陌陌账号.txt")

    for i = #momoIds - configInfo.checkQuantity + 1,#momoIds,1 do
        tap(453,84)
        mSleep(1000)
        clearString()
        inputText(strSplit(momoIds[i],"----")[4])
        mSleep(1000)
        tap(542,179)
        mSleep(3000)
        if(multiColor({{83,190,0xacacac},{54,242,0xa9a9a9},{88,242,0xaaaaaa},{141,258,0xe1e1e1}}))
        then
            momoIdStatus = "blocked"
        else
            momoIdStatus = "normal"
        end

        writeContent(userPath() .. "/lua/momoIdStatus_xiaonan.txt",os.date("%Y/%m/%d  %H:%M:%S",ts.ms()) .. "----" .. strSplit(momoIds[i],"----")[4] .. "----" .. momoIdStatus .. "\n","a")
        tap(35,85)
        mSleep(2000)
    end
    dialog("The end!")
end




getConfigInfo()
checkConfig()
momoIdStatusCheck()
