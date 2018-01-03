--README:A simple lua script used2 signup momo account with qq account
--protosomatic Lib supported by TS
require("TSLib")
local ts = require("ts")
local sz = require("sz")
--======================================    general module    ===================================
--crucial index of loop
--I = 9
-- part of global phone info                //some code block was deprecated in momo module
screenWidth,screenHeight = getScreenSize()
DEVICEINFO = {
    deviceName = getDeviceName(),

    screen = {
        width = screenWidth,
        height =  screenHeight
    },

    iphone5s = {
        pixelLocate = {
            NZT = {
                lockBtn1 = {552,234},
                lockBtn2 = {230,550},
                refreshBtn = {500,820},
                phoneTypeField = {
                    {333,219},
                    {485,256},
                },
                osVersionField = {
                    {135,217},
                    {275,265},
                },
                historyBtn = {142,959},
                ipAddrField = {{440,301},{604,327}},
                noteBtn = {315,688},
                SIM = {{228,593},{382,650}},
            },
            momo = {
                loginBtn = {320,825},
                registerBtn = {314,962},
                loginWithQQBtn = {155, 1064},
                qqNumInput = {400,411},
                qqPwdInput = {80,519},
                signInBtn = {323,643},
                verifyCodeField = {},
                verifyCodeInput = {},
                verifyConfirmBtn = {},
                nickName = {388,549},
                birthday = {561,626},
                birthdayField = {
                    {167,1056},
                    {308,1076},
                    {454,1076},
                },
                gender = {
                    {557,717},
                    {320,970},
                    {321,973},
                    {313,630},
                },
                --genderField = {},                         -- deprecated
                confirmGenderBtn = {316,629},
                fillUpInfoBtn = {323,1011},
                createPwd = {91,340},
                registerDoneBtn = {325,522},

                --momo bottom btn
                home = {63, 1084},
                live = {189, 1085},
                news = {322, 1086},
                follow = {450, 1089},
                more = {577, 1081},

            },
        },
        colorInfo = {
            NZT = {
                lockBtn1 = {
                    lock = 0xcccccc,
                    unlock = 0x000000,
                },
                lockBtn2 = {
                    on = 0x000000,
                    off = 0xcccccc,
                },
                refreshBtn = {},
                phoneTypeField = {},
                osVersionField = {},
                historyBtn = {},
                ipAddrField = {},
                noteBtn = {},
            },
        },
    }
}
--click Modules  (NZT,MOMO,)
clickModules = {
    iphone5s = {
        NZT = {
            lockBtn1 = function() tap(iphone5sPx.NZT.lockBtn1[1],iphone5sPx.NZT.lockBtn1[2]) end,
            lockBtn2 = function() tap(iphone5sPx.NZT.lockBtn2[1],iphone5sPx.NZT.lockBtn2[2]) end,
            noteBtn = function() tap(iphone5sPx.NZT.noteBtn[1],iphone5sPx.NZT.noteBtn[2]) end,
            refreshBtn = function() tap(iphone5sPx.NZT.refreshBtn[1],iphone5sPx.NZT.refreshBtn[2]) end,
            historyBtn = function() tap(iphone5sPx.NZT.historyBtn[1],iphone5sPx.NZT.historyBtn[2]) end,
            SIM = function() tap(318,623) end,
        },
        momo = {
            Done = function() tap(581,663) end,
            loginWithQQBtn = function() tap(iphone5sPx.momo.loginWithQQBtn[1],iphone5sPx.momo.loginWithQQBtn[2]) end,
            qqNumInput = function() tap(iphone5sPx.momo.qqNumInput[1],iphone5sPx.momo.qqNumInput[2]) end,
            qqPwdInput = function() tap(iphone5sPx.momo.qqPwdInput[1],iphone5sPx.momo.qqPwdInput[2]) end,
            signInBtn = function() tap(iphone5sPx.momo.signInBtn[1],iphone5sPx.momo.signInBtn[2]) end,
            verifyCodeInput = function() tap(iphone5sPx.momo.verifyCodeInput[1],iphone5sPx.momo.verifyCodeInput[2]) end,
            verifyConfirmBtn = function() tap(iphone5sPx.momo.verifyConfirmBtn[1],iphone5sPx.momo.verifyConfirmBtn[2]) end,
            nickName = function() tap(iphone5sPx.momo.nickName[1],iphone5sPx.momo.nickName[2]) end,
            birthday = function() tap(iphone5sPx.momo.birthday[1],iphone5sPx.momo.birthday[2]) end,
            gender = function() tap(iphone5sPx.momo.gender[1][1],iphone5sPx.momo.gender[1][2]) mSleep(2000) tap(iphone5sPx.momo.gender[3][1],iphone5sPx.momo.gender[3][2]) mSleep(2000) tap(iphone5sPx.momo.gender[4][1],iphone5sPx.momo.gender[4][2]) mSleep(1000) end,
            fillUpInfoBtn = function() tap(iphone5sPx.momo.fillUpInfoBtn[1],iphone5sPx.momo.fillUpInfoBtn[2]) end,
            createPwd = function() tap(iphone5sPx.momo.createPwd[1],iphone5sPx.momo.createPwd[2]) end,
            registerDoneBtn = function() tap(iphone5sPx.momo.registerDoneBtn[1],iphone5sPx.momo.registerDoneBtn[2]) end,

            -- momo bottom menu
            home = function() tap (iphone5sPx.momo.home[1],iphone5sPx.momo.home[2]) mSleep(50) end,
            live = function() tap(iphone5sPx.momo.live[1],iphone5sPx.momo.live[2]) mSleep(50) end,
            news = function() tap(iphone5sPx.momo.news[1],iphone5sPx.momo.news[2]) mSleep(50) end,
            follow = function() tap(iphone5sPx.momo.follow[1],iphone5sPx.momo.follow[2]) mSleep(50) end,
            more = function() tap(iphone5sPx.momo.more[1],iphone5sPx.momo.more[2]) mSleep(50) end,

        },
    }
}
-- shotcut of data extration
iphone5sPx = DEVICEINFO.iphone5s.pixelLocate
iphone5sCol = DEVICEINFO.iphone5s.colorInfo
iphone5sRGB =  DEVICEINFO.iphone5s.RGBInfo                              --....................etc.
--shotcut of clickModules
CLICK = clickModules.iphone5s

--citys
CITY = {
    "杭州"
}

-- configInfo //global
configInfo = {}
--all registeredInfo carrier
registerLogTable = {}
function unLock()
    flag = deviceIsLock()
    if flag ~= 0 then
        unlockDevice()
    end
end
--switch airplaneMode
function airplaneModeSwitch()
    setAirplaneMode(true)
    mSleep(4000)
    setAirplaneMode(false)
    mSleep(3000)
end

function click(x,y)
    touchDown(x,y)
    mSleep(300)
    touchUp(x,y)
end

--open momo
function openMomo()
    local momo = "com.wemomo.momoappdemo1"
    runApp(momo)
    mSleep(2000)
end
--close momo
function closeMomo()
    local momo = "com.wemomo.momoappdemo1"
    closeApp(momo)
    mSleep(2000)
end
--open NZT
function openNZT()
    -- body
    local NZT = "NZT";
    runApp(NZT)
    mSleep(3000)
end
function closeNZT()
    -- body
    local NZT = "NZT"    -- unkonwn
    closeApp(NZT)
    mSleep(1000)
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

--func: clear string..
function clearString()
    for var = 1,15 do
        inputText("\b")
    end
end

--check if str inside a table   // very important
function inside(table,str)
    -- body
    if (table == nil or table == false)
    then
        return false
    else
        local index = 0
        for key,value in pairs(table) do
            if value == str then
                index = index + 1
            end
        end

        if(index > 0)
        then
          return true
        else
          return false
        end
    end
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
--remove Element By Value
function removeElementByValue(tbl,str)
    for key,val in pairs(tbl) do
        if(val == str)
        then
            table.remove(tbl,key)
        end
    end
    return tbl
end

--function: tap one point in a rectangle field
function recRandomTap(x1,y1,x2,y2)
  tap(math.random(x1, x2),math.random(y1,y2))
end

-- function: get a string of required capacity   //very debased method .. to be optimized(string.format )
function randomString(pattern,len)
	local str = ''
	if(type(len) ~= "number")
	then
		toast("number expected,got " .. type(len) .. ",stupid!!!",3)
		return false
	else
    if(pattern == "mix")                              -- get mix strings
    then
      local var = {{97,122},{65,90},3}
      for i = 1,len,1 do
        local index = math.random(1,3)
        if(index == 3)
        then
          str = str .. math.random(0,9)
        else
          str = str .. string.char(math.random(var[index][1],var[index][2]))
        end
      end
      return str
    elseif(pattern == "number")
    then
      str = str .. math.random(1,9)
  		for i = 2,len,1 do
  			str = str .. math.random(0,9)
  		end
  		return str
    elseif(pattern == "letter")
    then
      for i = 1,len,1 do
        str = str .. string.char(math.random(97,122))
      end
      return str
    elseif(pattern == "capital")
    then
      for i = 1,len,1 do
        str = str .. string.char(math.random(65,90))
      end
      return str
    elseif(pattern == "strings")
    then
      for i = 1,len,1 do
        local index = math.random(0,1)
        str = str .. string.char(index*math.random(65,90) + (1-index)*math.random(97,122))
      end
      return str
    else
      toast("Invalid pattern,only number|letter|capital|strings|mix are activated!")
      return false
    end
	end
end
-- function : flip up continuously
function flipUpContinuously(num1,num2)
	for i = 1,math.random(num1,num2),1 do
		local x,y = getScreenSize()
		touchDown(x/2, y/2)
		for i = 0, 500,5 do
			touchMove(x/2 ,y/2 - i);
			mSleep(10)
		end
		mSleep(1000)
		touchUp(x/2, y/2 - 800)
		mSleep(1000)
	end
	mSleep(1000)
end


--=====================================    UI    =============================================
--iphone config
UINew(3,"环境设置,陌陌设置,检测设置","确认","取消","uiconfig.dat",0,360000,DEVICEINFO.screen.width,DEVICEINFO.screen.height)
--UIImage(2,"http://www.baidu.com/img/bdlogo.png";)
UILabel({num=1,text="手机: "})
UICheck(1,"p1,p2,p3,p4,p5,p6,p7,p8,p9","iPhone 6,iPhone 6P,iPhone 6s,iPhone 6SP,iPhone 7,iPhone 7P,iPhone 8,iPhone 8P,iPhone X","1@0")
UILabel({num=1,text="系统: "})
UICheck(1,"os1,os2,os3,os4,os5,os6,os7,os8,os9,os10,os11,os12,os13,os14,os15,os16,os17" ,"10.0.1,10.0.2,10.0.3,10.1,10.1.1,10.2,10.2.1,10.3,10.3.1,10.3.2,11.0,11.0.1,11.0.2,11.0.3,11.1,11.1.1,11.12","2@3@4")
UILabel({num=1,text="经纬度随机半径:",align="left",width="350",nowrap="1"})
UIEdit({num=1,id="radiusGPS",prompt="radius",text="0.8",size=15,align="left",color="50,50,50",width="200"})
UILabel({num=1,text="批次:",align="left",width="130",nowrap="1"})
UIEdit({num=1,id="batchId",prompt="batch ID",size=15,align="left",color="50,50,50",kbtype="number",width="420"})

UILabel({num=1,text="注册数量(每个环境):",align="left",width="300",nowrap="1"})
UIEdit({num=1,id="registerQuantity",prompt="? 个",size=15,align="left",color="50,50,50",kbtype="number",width="250"})

--momo config
--UILabel({num=2,text="MomoVersion:"})
--UICombo({num=2,id="configMomoVersion",list="8.0,8.1,8.2,8.3"})
UILabel({num=2,text="注册速度:",width="230",nowrap="1"})
UICombo({num=2,id="signUpRhythm",list="Normal,RandomDeceleration",width="300"})
UILabel({num=2,text="注册随机延时间隔:",width="270",nowrap="1"})
UIEdit({num=2,id="interval1",prompt="? s",text="5",size=15,align="left",color="255,0,0",kbtype="number",width="110",nowrap="1"})
UILabel({num=2,text="~",align="left",size="10",width="15",nowrap="1"})
UIEdit({num=2,id="interval2",prompt="? s",text="15",size=15,align="left",color="255,0,0",kbtype="number",width="110"})
UILabel({num=2,text="删除IP:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="deleteIP",list="yes,nope",sel=1,width="300"})
UILabel({num=2,text="删除QQ:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="deleteQQ",list="yes,nope",sel=1,width="300"})
UILabel({num=2,text="更换头像:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="changeHead",list="yes,nope",sel="0",width="300"})
UILabel({num=2,text="陌陌注册性别:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="momoGender",list="male,female",sel="1",width="300"})
UILabel({num=2,text="密码类型:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="momoPwd",list="arbitrary,constant",sel="1",width="300"})
UILabel({num=2,text="自定义密码:",align="left",width="230",nowrap="1"})
UIEdit({num=2,id="constantPwd",prompt="password",text="kd123456",size=15,align="left",color="50,50,50",width="350"})
UILabel({num=2,text="允许访问通讯录",align="left",width="230",nowrap="1"})
UICombo({num=2,id="access2Contacts",list="allow,reject",sel="1",width="300"})
UILabel({num=2,text="刷新附近人:",align="left",width="230",nowrap="1"})
UICombo({num=2,id="gotonearby",list="yes,nope",sel="1",width="300"})
UILabel({num=2,text="打码串:",align="left",width="230",nowrap="1"})
UIEdit({num=2,id="ocrDecodeString",text="打码串",prompt="haoai打码串",color="100,100,100",width="300"})

-- check part
UILabel({num=3,text="注册完成立即检测:",align="left",width="300",nowrap="1"})
UICombo({num=3,id="checkImmediately",list="yes,nope",sel="1",width="230"})
--check time
UILabel({num=3,text="检测时间:",align="left",width="300",nowrap="0"})
UIEdit({num=3,id="checkTimeY",prompt="Y",text="2017",size=15,align="left",color="50,50,50",kbtype="number",width="200",nowrap="1"})
UILabel({num=3,text="|",align="left",size=20,width="5",nowrap="1"})
UIEdit({num=3,id="checkTimeM",prompt="M",size=15,align="left",color="50,50,50",kbtype="number",width="150",nowrap="1"})
UILabel({num=3,text="|",align="left",size=20,width="5",nowrap="1"})
UIEdit({num=3,id="checkTimeD",prompt="D",size=15,align="left",color="50,50,50",kbtype="number",width="130",nowrap="1"})
UILabel({num=3,text="   ",align="left",size=20,width="10",nowrap="0"})
UIEdit({num=3,id="checkTimehh",prompt="hh",text="21",size=15,align="left",color="50,50,50",kbtype="number",width="200",nowrap="1"})
UILabel({num=3,text="|",align="left",size=20,width="5",nowrap="1"})
UIEdit({num=3,id="checkTimemm",prompt="mm",text="0",size=15,align="left",color="50,50,50",kbtype="number",width="150",nowrap="1"})
UILabel({num=3,text="|",align="left",size=20,width="5",nowrap="1"})
UIEdit({num=3,id="checkTimess",prompt="ss",text="0",size=15,align="left",color="50,50,50",kbtype="number",width="130",nowrap="1"})

UIShow()

--get config info
function getConfigInfo()
    -- body
    configInfo.requiredPhoneType = receivePhoneType()
    configInfo.requiredOsVersion = receiveOsVersion()
    configInfo.radiusGPS = receiveRadiusGps()
    configInfo.batchId = batchId
    configInfo.signUpRhythm = signUpRhythm
    configInfo.decelerationInterval = receiveDecelerationInterval()
    --    configInfo.deleteIP = {}
    --    configInfo.deleteQQ = {}
    configInfo.changeHead = receiveChangeHead()
    --    configInfo.momoGender = {}
    --    configInfo.momoPwd = momoPwd
    configInfo.constantPwd = constantPwd
    --    configInfo.access2Contacts = {}
    configInfo.goToNearby = gotonearby
    configInfo.checkImmediately = checkImmediately

    configInfo.checkTimeY = checkTimeY
    configInfo.checkTimeM = checkTimeM
    configInfo.checkTimeD = checkTimeD
    configInfo.checkTimehh = checkTimehh
    configInfo.checkTimemm = checkTimemm
    configInfo.checkTimess = checkTimess


    configInfo.registerQuantity = registerQuantity*1
    configInfo.ocrDecodeString = ocrDecodeString
    getPO()
end

--all ENV
envKit = {
  "iPhone 7-11.0.3",
  "iPhone 8-11.0",
  "iPhone 6-11.1",
  "iPhone X-11.12",
  "iPhone 6P-11.0.2",
  "iPhone 6-11.0",
  "iPhone 8-11.1",
  "iPhone 6-11.0.2",
  "iPhone 8-11.0.2",
  "iPhone 8P-11.1.1",
  "iPhone 8P-11.1",
  "iPhone 6-11.12",
  "iPhone 6SP-11.0.2",
  "iPhone 8P-11.0",
  "iPhone 6SP-11.0.1",
  "iPhone 8-11.0.3",
  "iPhone 8-11.1.1",
  "iPhone 6SP-11.12",
  "iPhone 7-11.0",
  "iPhone 8-11.0.1",
  "iPhone 6s-11.1.1",
  "iPhone 7-11.1",
  "iPhone 6SP-11.1",
  "iPhone 7P-11.12",
  "iPhone 7P-11.0.2",
  "iPhone 6s-11.0",
  "iPhone 8P-11.0.2",
  "iPhone 7-11.0.1",
  "iPhone X-11.1.1",
  "iPhone 7-11.0.2",
  "iPhone 7P-11.0.1",
  "iPhone 7P-11.0",
  "iPhone 7-11.1.1",
  "iPhone X-11.1",
  "iPhone 6s-11.0.3",
  "iPhone 6P-11.1.1",
  "iPhone 8-11.12",
  "iPhone 6s-11.0.1",
  "iPhone 8P-11.0.3",
  "iPhone 7P-11.0.3",
  "iPhone 6SP-11.1.1",
  "iPhone 6s-11.1",
  "iPhone 6SP-11.0.3",
  "iPhone 6-11.0.3",
  "iPhone 8P-11.12",
  "iPhone 7-11.12",
  "iPhone 7P-11.1",
  "iPhone 6-11.1.1",
  "iPhone 6s-11.0.2",
  "iPhone 6P-11.1",
  "iPhone 6SP-11.0",
  "iPhone 7P-11.1.1",
  "iPhone 6P-11.0.3",
  "iPhone 6P-11.0",
  "iPhone 8P-11.0.1",
  "iPhone 6P-11.0.1",
  "iPhone 6-11.0.1",
  "iPhone 6P-11.12",
  "iPhone 6s-11.12"

}
--Cartesian product table between PhoneType & Osversion  // very important
PO = {}
_PO = 0            -- index of check parts
--get a Cartesian product table between PhoneType & Osversion
function getPO()
    for i = 1,#configInfo.requiredPhoneType do
        for j = 1,#configInfo.requiredOsVersion do
            table.insert(PO,configInfo.requiredPhoneType[i] .. "-" .. configInfo.requiredOsVersion[j])
        end
    end
end


--get config info
function receivePhoneType()
    -- body
    local var = {}

    if(p1 == "iPhone 6")
    then
        table.insert(var,"iPhone 6")
    end

    if(p2 == "iPhone 6P")
    then
        table.insert(var,"iPhone 6P")
    end

    if(p3 == "iPhone 6s")
    then
        table.insert(var,"iPhone 6s")
    end

    if(p4 == "iPhone 6SP")
    then
        table.insert(var,"iPhone 6SP")
    end

    if(p5 == "iPhone 7")
    then
        table.insert(var,"iPhone 7")
    end

    if(p6 == "iPhone 7P")
    then
        table.insert(var,"iPhone 7P")
    end

    if(p7 == "iPhone 8")
    then
        table.insert(var,"iPhone 8")
    end

    if(p8 == "iPhone 8P")
    then
        table.insert(var,"iPhone 8P")
    end

    if(p9 == "iPhone X")
    then
        table.insert(var,"iPhone X")
    end

    return var
end

function receiveOsVersion()
    local var = {}

    if(os1 == "10.0.1")
    then
        table.insert(var,"10.0.1")
    end

    if(os2 == "10.0.2")
    then
        table.insert(var,"10.0.2")
    end

    if(os3 == "10.0.3")
    then
        table.insert(var,"10.0.3")
    end

    if(os4 == "10.1")
    then
        table.insert(var,"10.1")
    end

    if(os5 == "10.1.1")
    then
        table.insert(var,"10.1.1")
    end

    if(os6 == "10.2")
    then
        table.insert(var,"10.2")
    end

    if(os7 == "10.2.1")
    then
        table.insert(var,"10.2.1")
    end

    if(os8 == "10.3")
    then
        table.insert(var,"10.3")
    end

    if(os9 == "10.3.1")
    then
        table.insert(var,"10.3.1")
    end

    if(os10 == "10.3.2")
    then
        table.insert(var,"10.3.2")
    end

    if(os11 == "11.0")
    then
        table.insert(var,"11.0")
    end
    if(os12 == "11.0.1")
    then
        table.insert(var,"11.0.1")
    end
    if(os13 == "11.0.2")
    then
        table.insert(var,"11.0.2")
    end
    if(os14 == "11.0.3")
    then
        table.insert(var,"11.0.3")
    end
    if(os15 == "11.1")
    then
        table.insert(var,"11.1")
    end
    if(os16 == "11.1.1")
    then
        table.insert(var,"11.1.1")
    end
    if(os17 == "11.12")
    then
        table.insert(var,"11.12")
    end


    return var
end
function receiveRadiusGps()
    -- body
    local var = radiusGPS*1
    return var
end
--receive signUpRhythm
--receive decelerationInterval
function receiveDecelerationInterval()
    -- body
    local var = {}
    table.insert(var,interval1*1)
    table.insert(var,interval2*1)
    return var
end
--receive changeHead
function receiveChangeHead()
    -- body
    if(changeHead == "yes")
    then
        return true
    else
        return false
    end
end

--check if configed ENV are available
function unavailableEnv()
	local unavailableEnv = {}
	for k,v in pairs(PO) do
		if(not inside(envKit,v))
		then
			table.insert(unavailableEnv,v)
		end
	end
	return unavailableEnv
end



function checkUIConfig()
    -- body
    if(radiusGPS == "")
    then
        toast("radius of RandomGPS got nil!",1)
        lua_exit()
    elseif(batchId == "")
    then
        toast("batchId got nil!",1)
        lua_exit()
    elseif(ocrDecodeString == "") then
      toast("打码串为空")
      lua_exit()
    elseif(registerQuantity == "")
    then
        toast("registerQuantity got nil!",1)
        lua_exit()
    elseif(signUpRhythm == "RandomDeceleration" and (interval1 == "" or interval1 == ""))
    then
        toast("deceleration got nil!",1)
        lua_exit()
    elseif(changeHead == "nope")
    then
        toast("u'd better enable change head!",1)
        lua_exit()
        -- elseif(checkImmediately == "yes")
        -- then
        -- local choice = dialogRet("check part will start immediately","restart", "goon.",0,0)
        -- if (choice == 0)
        -- then
        -- toast("restarting ..",1)
        -- lua_restart()
        -- else
        -- toast("o.k... ",1)
        -- end
    elseif(checkImmediately == "nope" and (checkTimeY == "" or checkTimeM == "" or checkTimeD == "" or checkTimehh == "" or checkTimemm == "" or checkTimess == ""))
    then
        toast("error with check timer!",1)
        lua_exit()
	elseif(#unavailableEnv() > 0)
	then
		local var = unavailableEnv()
		local varstr = ""
		for i = 1,#var do
			varstr = varstr .. var[i] .. ","
		end
		dialog("Unavailable Env : " .. varstr .. "terminating ..")
		lua_exit()
    end





    local choice = dialogRet("start?","confirm", "cancel",0,0)
    if (choice == 0)
    then
        toast("initializing ..",1)
    else
        toast("terminating ..",1)
        lua_exit()
    end
    mSleep(1000)
end

--  settimer to check

function checkTimer()
    -- body
    if(configInfo.checkImmediately == "yes")
    then
        momoIdStatusCheck()
    elseif(configInfo.checkImmediately == "nope")
    then
        local triger = os.time({year = configInfo.checkTimeY*1, month = configInfo.checkTimeM*1, day = configInfo.checkTimeD*1, hour = configInfo.checkTimehh*1, min = configInfo.checkTimemm*1, sec = configInfo.checkTimess*1})
        local diff = triger - ts.ms()
        if(diff > 0)
        then
            mSleep(1000*diff)
            momoIdStatusCheck()
        else
            momoIdStatusCheck()
        end
    end
end





--=================================================    NZT module    ==================================
--init NZTBtns
function initNZTBtns()  --check if 2 btns is locked or not,if locked then unlock them
    local x1,y1,c1 = iphone5sPx.NZT.lockBtn1[1],iphone5sPx.NZT.lockBtn1[2],iphone5sCol.NZT.lockBtn1.lock
    local x2,y2,c2 = iphone5sPx.NZT.lockBtn2[1],iphone5sPx.NZT.lockBtn2[2],iphone5sCol.NZT.lockBtn2.on

    if isColor(x1,y1,c1,100)                     --the color c1 stands for locked suitation,the same as color c2
    then
        tap(x1,y1)
        mSleep(1000)
        CLICK.NZT.noteBtn()
        mSleep(1000)
    end

    if isColor(x2,y2,c2,100)
    then
        tap(x2,y2)
        mSleep(1000)
        CLICK.NZT.noteBtn()
        mSleep(1000)
    end
end
--get current phone_type
function getCurrentPhoneType()
    -- body
    currentPhoneType = ocrText(318,206,516,272,20)
    return currentPhoneType
end
--get current osVersion
function getCurrentOsVersion()
    -- body
    currentOsVersion = ocrText(136,216,276,266,20)
    return currentOsVersion
end
--get required iphone_type
function getRequiredPhoneType()
    -- to be confirmed!!!!!!!!!!!
    getCurrentPhoneType()
    getCurrentOsVersion()
    while(not(inside(PO,currentPhoneType .. currentOsVersion))) do
        newRecord()
        mSleep(1000)
        getCurrentPhoneType()
        getCurrentOsVersion()
    end
    mSleep(2000)
end

-- get a required ENV
function getRequiredEnv()
	chooseArecord(PO[1])
	mSleep(2000)
	tap(41,79)
	mSleep(2000)
end
-- lock phone type
function lockPhoneType()

    local i = 1
    --exception:stagnation of "clearing .."
    local clearingStagnation = {{175,500,0x333333},{452,502,0x333333},{171,645,0x333333},{450,644,0x333333}}
    -- lock phone type
    local x1,y1,c1 = iphone5sPx.NZT.lockBtn1[1],iphone5sPx.NZT.lockBtn1[2],iphone5sCol.NZT.lockBtn1.unlock
    local x2,y2,c2 = iphone5sPx.NZT.lockBtn2[1],iphone5sPx.NZT.lockBtn2[2],iphone5sCol.NZT.lockBtn2.off

    -- handle exception of clearing stagnation
    if(multiColor(clearingStagnation))
    then
        closeNZT()
        openNZT()
        return lockPhoneType()
    end

    -- lock phone type
    if isColor(x1,y1,c1,100)                     --the color c1 stands for unlocked suitation,the same as color c2
    then
        tap(x1,y1)
        mSleep(1000)
        if(isColor(337,676,0x007aff))
        then
            CLICK.NZT.noteBtn()
            mSleep(1000)
        end
    end

    if isColor(x2,y2,c2,100)
    then
        tap(x2,y2)
        mSleep(1000)
        if(isColor(337,660,0x007aff))
        then
            CLICK.NZT.noteBtn()
            mSleep(1000)
        end
    end

end

--init BTNs
function initBtns()
	-- lock phone type
	local x1,y1,c1 = iphone5sPx.NZT.lockBtn1[1],iphone5sPx.NZT.lockBtn1[2],iphone5sCol.NZT.lockBtn1.unlock
  local x2,y2,c2 = iphone5sPx.NZT.lockBtn2[1],iphone5sPx.NZT.lockBtn2[2],iphone5sCol.NZT.lockBtn2.off
	--exception:stagnation of "clearing .."
	local whiteSpace = {{204,508,0xffffff},{428,521,0xffffff},{314,601,0xffffff}}

	while(not(isColor(551,236,0xcccccc) and isColor(231,550,0x000000))) do
		if(not(multiColor(whiteSpace)))
		then
			mSleep(3000)
			if(not(multiColor(whiteSpace)))
			then
				closeNZT()
				openNZT()
				return initBtns()
			end
		else
			if isColor(x1,y1,c1,100)
			then
				tap(x1,y1)
				mSleep(1000)
				if(isColor(337,676,0x007aff))
				then
					CLICK.NZT.noteBtn()
					mSleep(1000)
				end
			end

			if isColor(x2,y2,c2,100)
			then
				tap(x2,y2)
				mSleep(1000)
				if(isColor(337,660,0x007aff))
				then
					CLICK.NZT.noteBtn()
					mSleep(1000)
				end
			end
		end
	end
end
--get required IP
function getRequiredIP()
    local ipLogs = readFile(userPath() .. "/res/ipLogs.txt")
    airplaneModeSwitch()
    while(inside(ipLogs,getNetIP())) do
        airplaneModeSwitch()
    end
    toast(string.format("Current IP : %s",getNetIP()),2)
    mSleep(1000)
end


-- attenion : inaccurate info!!!!!!! need to be optimized       ******************
function getCurrentDeviceInfo()
    -- local i = 1
    -- local deviceInfoPage = {{  310,  903, 0x007aff},{  337,  907, 0x007aff}}
    -- --get IP Addr
    -- while((not(multiColor(deviceInfoPage))) and (i <= 3)) do
    --     click(388,318)
    --     mSleep(1000)
    --     i = i + 1
    -- end
    --
    -- if(i >= 3)                                                --if anything wrong with getting device info,then return initialize step2 ...perfect!!
    -- then
    --     toast("Error with getting device info!!!",1)
    --     mSleep(1000)
    --     toast("initializing ..",2)
    --     closeNZT()
    --     openNZT()
    --     return getCurrentDeviceInfo()
    -- end
    -- init device info  // global
    Serial = "****"
    UDID = "****"
    IDFA = "****"
    IDFV = "****"
    MAC = "****"
    currentIP = getNetIP()
end
-- ******NZT RECORDS OPERATION FUNCTIONS ***********
--URI code func
function encodeURI(s)
    local s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end
--new record
function newRecord()
    -- body
    local url = "nzt://cmd/newrecord"
    openURL(url)
    mSleep(2000)
end
--active one required record
function chooseArecord(recordid)
    -- body
    local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/activerecord?%s",recordId)
    openURL(url)
end
--rename current record
function renameRecord(recordid)
    -- body
    local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/renamecurrentrecord?%s",recordId)
    openURL(url)
    mSleep(2000)
    tap(41,79)
    mSleep(2000)
end
--function set GPS of current record
function setCurrentRecordLocation(latitude,longitude,city)
    local var = latitude .. "_" .. longitude .. "_" .. city
    local location = encodeURI(var)
    local url = string.format("nzt://cmd/setcurrentrecordlocation?%s",location)
    openURL(url)
end
--func : get current record count
function getRecordCount()
    openURL("nzt://cmd/getrecordcount")
end
--func: get current record name
function getCurrentRecordName()
    openURL("nzt://cmd/getcurrentrecordname")
end
--func; get next record
function getNextRecord()
    openURL("nzt://cmd/nextrecord")
end
-- get required *random* GPS
function getCurrentRandomGPS()
    local randomNum1 = string.format("%0.5f",math.random()*configInfo.radiusGPS)
    local randomNum2 = string.format("%0.5f",math.random()*configInfo.radiusGPS)

    local city = CITY[math.random(1,#CITY)]
    local http = "http://restapi.amap.com/v3/geocode/geo?address=" .. encodeURI(city) .. "&output=XML&key=d28325246d18a73c4ff2441680f024cc"
    ts.setHttpsTimeOut(60)
    local status_resp,header_resp,body_resp = ts.httpGet(http)
    --get longitude & latitude
    if(body_resp)
    then
      if(strSplit(body_resp,"<location>")[2])
      then
          local gps = strSplit(strSplit(strSplit(body_resp,"<location>")[2],"</location>")[1],",")
          longitude = tostring(gps[1] + randomNum1)
          latitude = tostring(gps[2] + randomNum2)                        -- get nil sometimes!!!!!!
      else
          toast("trying to get GPS ...",2)
          mSleep(2000)
          return getCurrentRandomGPS()
      end
    else
      toast("手机已停机或网络异常,进程终止..",5)
      lua_exit()
    end

    setCurrentRecordLocation(latitude,longitude,city)

    mSleep(2000)
    tap(41,79)
    mSleep(2000)
end



--==================================================    momoModules    ============================================================
--init photos
function photoProcess()
	-- 相册处理
    writeFileString(userPath().."/res/headInfo.txt","","w")

    local allFileName = io.popen("ls "..userPath().."/res/photos/")
    local f = assert(io.open(userPath().."/res/headInfo.txt", "a"))
    for fileName in allFileName:lines() do
        f:write(fileName.."\r\n")
    end
    f:close()
    allFileName:close();
end

--function : handle exception // login with qq
function handleLoginWithqq()
    local i = 1
    local k = 1

    while ((not(multiColor({{203,833,0x3462ff},{334,292,0xffffff}}))) and (i <= 9)) do
        i = i + 1
        mSleep(1000)
    end
    -- if error happened to open momo,then reload loginWithqq
    if(i >= 9)
    then
        toast("error with open momo,initializing...",2)
        return loginWithqq()
    end

    recRandomTap(146,1052,272,1074)       -- tap loginWithqq
    -- if something wrong with loginwithqqBtn ,handle the exception dependly
    while ((not(multiColor({{90,186,0x000000},{568,671,0x12b7f5},{58,213,0xea1b27}}))) and (k <= 9)) do
        k = k + 1
        mSleep(1000)
    end

    if(k >= 9)
    then
        if(multiColor({{55,827,0x3462ff},{585,826,0x3462ff},{392,1073,0x77797a}}))
        then
            toast("error with QQBtn,initializing...",2)
            return loginWithqq()
        elseif(multiColor({{70,80,0x007aff},{58,211,0xffffff}}))
        then
            toast("trying to reconnect to the network...",1)
            while(not(multiColor({{90,186,0x000000},{568,671,0x12b7f5},{58,213,0xea1b27}}))) do
                tap(54,84)
                mSleep(1500)
                tap(220,1061)
                mSleep(3000)
            end
        end
    end
end



--func: input qqnum & qqpwd
function inputQQAccount()

    local qqInfo = readFile(userPath() .. "/res/qqInfo.txt")
    if(#qqInfo > 0)
    then
        local qqInfoFirst = qqInfo[1]
        qqNum = strSplit(qqInfoFirst,"----")[1]
        qqPwd = strSplit(qqInfoFirst,"----")[2]

        --  get cursor
        tap(490,401)
        mSleep(2000)
        --clear string if exists
        clearString()
        --input qqNUm
        inputStr(qqNum)
        mSleep(1000)
        --	get cursor
        tap(491,513)
        mSleep(2000)
        clearString()
        --input qqpwd
        inputStr(qqPwd)
        mSleep(500)
        CLICK.momo.Done()
        mSleep(1000)
        recRandomTap(59,599,579,673)
    else
        toast("QQ account has run out,initializing CHECK PART...",2)
        mSleep(2000)
        --ensure that check part executed only once
        CHECKED = true
        return checkTimer()
    end
end


-- func: exception handling
function handleException()
    local i = 0
    local j = 0
    local fillInfoPage = {{191,134,0x3c3c3c},{449,169,0x3c3c3c},{573,1022,0xc8c8c8}}
    local PwdError = {{88,653,0x12b7f5},{535,596,0x12b7f5},{340,770,0x000000}}
    local netError = {{58,212,0xffffff},{62,609,0xffffff},{94,691,0xffffff},{573,1022,0xffffff},{360,418,0xffffff}}
    local verifyPage = {{94,694,0x007aff},{191,694,0x007aff},{268,152,0x333333},{385,176,0x333333}}
    local signInException = {{111,143,0x404040},{564,143,0x404040},{602,196,0x404040},{569,173,0x404040} }
    local loginRejection = {{463,169,0xf15a22},{496,177,0xf15a22},{560,173,0xf15a22},{607,239,0x404040}}
    local reAuthorize = {
	{  242,  520, 0x000000},
	{  242,  535, 0x000000},
	{  263,  527, 0x000000},
	{  286,  524, 0x000000},
	{  309,  628, 0x007aff},
	{  337,  624, 0x007aff},
	{  337,  641, 0x007aff},
	{  354,  525, 0x000000}
}
	  local bindPhonePopup = {{82,231,0x3462ff},{309,424,0xb25c06},{421,514,0xffd3be},{95,872,0x2c53d9},{537,867,0x2c53d9}}
	  local levelPopup = {{198,434,0xffc74a},{278,434,0xeed7ca},{369,434,0xeed7ca},{439,448,0x4db5ff},{382,606,0x3c3c3c}}
    --if not fillInfo page then handle the exceptions dependly
    while(not(multiColor(fillInfoPage))) do
      -- signInException
      if(multiColor(signInException,100))
      then
        if(j < 3)
        then
          tap(322,635)                      --tap "login"
          mSleep(1000)
          j = j + 1
        else
				  keepDefectiveQQ()
          delFirstQQElement()
          inputQQAccount()
          return handleException()
        end
        --loginRejection
      elseif(multiColor(loginRejection))
      then
			  keepDefectiveQQ()
        delFirstQQElement()
        inputQQAccount()
      --reAuthorize
      elseif(multiColor(reAuthorize))
      then
        tap(310,621)                        -- tap "确定"
        mSleep(1000)
			  keepDefectiveQQ()
        delFirstQQElement()
        closeMomo()
        openNZT()
        renameRecord("ReAuthorized--" .. randomString("mix",4))
        newRecord()
        getRequiredIP()
        return registerHub()
      -- PwdError
      elseif(multiColor(PwdError))
      then
        if(i < 2)
        then
          tap(316,773)
          mSleep(1000)
          tap(322,635)
          mSleep(500)
          i = i + 1
        else
          tap(316,773)
          mSleep(500)
				  keepDefectiveQQ()
          delFirstQQElement()
          inputQQAccount()
          return handleException()
        end
      --verifyPage
      elseif(multiColor(verifyPage))
      then
        ocrDecode()
      --netError
      elseif(multiColor(netError))
      then
        local k = 0
        while(not(multiColor(fillInfoPage)) and (k <= 10)) do
          mSleep(1000)
          k = k + 1
        end
        if(multiColor(netError))
        then
          tap(50,82)
          mSleep(1000)
          handleLoginWithqq()
          inputQQAccount()
        end
      else
        -- if LOGGED
        if(multiColor(levelPopup))
        then
          tap(537,248)			-- tap X
          mSleep(2000)
          tap(572,91)				-- tap "skip"
          keepDefectiveQQ()
          delFirstQQElement()
          LOGGED = true
          break
        elseif(multiColor(bindPhonePopup))
        then
          tap(548,290)            -- tap X
          mSleep(2000)
          tap(581,96)              -- tap "skip"
          mSleep(1000)
          keepDefectiveQQ()
          delFirstQQElement()
          LOGGED = true
          break
        end
      end
    end
end



--ocr Decode
function ocrDecode()
    toast("decoding ..",2)
    ocrInfo("haoi23"," ",configInfo.ocrDecodeString)
    local text,tid = ocrScreen(30,315,609,646,8006,80,1)
    flip(137,695,strSplit(text,",")[1] + 30,695)
    mSleep(1000)
end
-- photo operation
function initPhotos()
    local headInfo = readFile(userPath() .. "/res/headInfo.txt")
    local path = headInfo[math.random(1,#headInfo)]:rtrim()
    clearAllPhotos()
    saveImageToAlbum(userPath().."/res/photos/"..path);
end

-- del first element of qqInfo.txt  &&  nickName.txt when completed register
function delFirstElement()
    local qqInfo = readFile(userPath() .. "/res/qqInfo.txt")
    local nickName = readFile(userPath() .. "/res/nickName.txt")
    local headInfo = readFile(userPath() .. "/res/headInfo.txt")

    table.remove(qqInfo,1)
    table.remove(nickName,1)
    table.remove(headInfo,1)

    writeContentTable(userPath() .. "/res/qqInfo.txt",qqInfo,"w")
    writeContentTable(userPath() .. "/res/nickName.txt",nickName,"w")
    writeContentTable(userPath() .. "/res/headInfo.txt",headInfo,"w")
    clearAllPhotos()
end

--func: delete first element of qqInfo.txt
function delFirstQQElement()
    local qqInfo = readFile(userPath() .. "/res/qqInfo.txt")
    table.remove(qqInfo,1)
    writeContentTable(userPath() .. "/res/qqInfo.txt",qqInfo,"w")
end
--func: delete first element of nickName.txt
function delFirstNickNameElement()
  local nickName = readFile(userPath() .. "/res/nickName.txt")
  table.remove(nickName,1)
  writeContentTable(userPath() .. "/res/nickName.txt",nickName,"w")
end
--func: write deprecated qq account
function keepDefectiveQQ()
	local qqInfo = readFile(userPath() .. "/res/qqInfo.txt")
	local allFileName = ts.hlfs.getFileList(userPath() .. "/res")
	if(inside(allFileName,"exception"))
	then
		writeContent(userPath() .. "/res/exception/deprecatedQQaccount.txt",qqInfo[1] .. "\n","a")
	else
		ts.hlfs.makeDir(userPath() .. "/res/exception")
		writeContent(userPath() .. "/res/exception/deprecatedQQaccount.txt",qqInfo[1] .. "\n","a")
	end
end


--check if is "查看我的陌陌等级"        // need a while & if clause !!!!!!!!!!
function dropLevelReminder()
    -- body
	local levelPopup = {{216,355,0x4db5ff},{275,397,0xeed7ca},{362,437,0xeed7ca},{405,483,0x4db5ff},{382,623,0x3c3c3c},{432,835,0x3462ff}}
    if(multiColor(levelPopup))
    then
        --tap X
        tap(548,  290)
        mSleep(2000)
        --tap "跳过"
        tap(581, 96)
        mSleep(2000)
    end
end
--check the bind phone  popup     // need a while & if clause !!!!!!!!!!
function dropBindPhonePopup()
    local bindPhonePopup = {{82,231,0x3462ff},{537,249,0xbfccf4},{309,424,0xb25c06},{421,514,0xffd3be},{95,872,0x2c53d9},{537,867,0x2c53d9}}
    if(multiColor(bindPhonePopup))
    then
        tap(538,250)
        mSleep(1000)

        tap(581, 96)
        mSleep(3000)
    end
end
--check if is "上划查看附近动态" // if true then drop it
function dropYellowHand()
    if(multiColor({{244,368,0xffcb3f},{290,544,0xfec93b},{354,502,0xffd451}}))
    then
        touchDown(317,711)
        mSleep(30)
        touchMove(322,383)
        mSleep(30)
        touchUp(322,383)
        mSleep(4000)
    end
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
--check if is rating||comment on momo ,if ture then drop it(***quite rare popup*****)   //  to be completed
function dropRatingPopup()
    -- body
    if(ocrText(x1, y1, x2, y2, language) == "rate U later")
    then
        tap(x,y)
    end
end



--check if caveat icon
function ifWarningIcon()
    local warningIcon = {
        {139,  227, 0xf65552},
        {139,  334, 0xf65552},
        {246,  334, 0xf65552},
        {246,  227, 0xf65552},
        {193,  268, 0xffffff},
        {193,  282, 0xffffff},
        {174,  297, 0xffffff},
        {196,  297, 0xffffff},
        {216,  288, 0xf65552},
        {217,  296, 0xffffff},
    }
    local warningIconX,warningIconY = findMultiColorInRegionFuzzyByTable(warningIcon,95,2,129,638,963)

    if(warningIconX == -1)
    then
        warning = "false"
    else
        warning = "true"
    end
end

-- function : go to nearby
function go2Nearby()
  if(configInfo.goToNearby == "yes")
  then
    recRandomTap(428,1075,462,1117)  	-- tap follow
		mSleep(2000)
		flipUpContinuously(3,5)
		recRandomTap(303,1074,336,1124)		-- tap news
		mSleep(1000)
    -- // to be confirmed
    recRandomTap(47,1073,77,1116)  		-- tap home
    dropHomePopup()
		flipUpContinuously(7,10)
		recRandomTap(303,1074,336,1124)		-- tap news
		mSleep(1000)
  end
end
-- check momoId status
function momoIdStatusCheck()
    local momoPage = {
  	{  293,  290, 0xffffff},
  	{  331,  289, 0xffffff},
  	{  231,  446, 0xffffff},
  	{  350,  445, 0xffffff},
  	{   58,  837, 0x3462ff},
  	{  575,  829, 0x3462ff}
  }
    toast("checking momoID status ..")
    openNZT()
    airplaneModeSwitch()
    airplaneModeSwitch()
    mSleep(1000)
    openMomo()
    mSleep(3000)
    if(multiColor(momoPage))
    then
      closeMomo()
      openNZT()
      getNextRecord()
      return momoIdStatusCheck()
    end
    CLICK.momo.news() 			--tap news
    mSleep(2000)
    dropYellowRings()

    flip(281,598,301,944)
    mSleep(1000)
    tap(331,172)
    mSleep(1000)
    local momoIds = readFile(userPath() .. "/res/registerInfoFiles.txt")

    for i = #momoIds - _PO + 1,#momoIds,1 do
        tap(453,84)
        mSleep(1000)
        clearString()
        inputText(strSplit(momoIds[i],"----")[15])
        mSleep(1000)
        tap(542,179)
        mSleep(4000)
        if(multiColor({{83,190,0xacacac},{54,242,0xa9a9a9},{88,242,0xaaaaaa},{141,258,0xe1e1e1}}))
        then
            momoIdStatus = "blocked"
        else
            momoIdStatus = "normal"
        end

        writeContent(userPath() .. "/res/momoIdStatus.txt",os.date("%Y/%m/%d  %H:%M:%S",ts.ms()) .. "----" .. strSplit(momoIds[i],"----")[15] .. "----" .. strSplit(momoIds[i],"----")[3] .. "----" .. strSplit(momoIds[i],"----")[4] .. "----" .. momoIdStatus .. "\n","a")
        tap(35,85)
        mSleep(2000)
    end
    dialog("The end!")
end



----------------------------------------------------    momoFlow    ------------------------------------------------------------------------------

--login with qq
function loginWithqq()
  closeMomo()
  openMomo()
  handleLoginWithqq()
end

--register
function register()
  inputQQAccount()
  handleException()
end

--full up person info  nickname,birthday,gender // next page : enter pwd etc.
function fillUpInfo()
    local personInfo = readFile(userPath() .. "/res/nickName.txt");
    local personInfoFirst = personInfo[1]
    momoNickName = personInfoFirst
	if(LOGGED)
	then
		toast("registered QQ,trying another account ..",3)
		closeMomo()
    openNZT()
    renameRecord("registered QQ--" .. randomString("mix",4))
		newRecord()
    getCurrentRandomGPS()
    getRequiredIP()
    LOGGED = false
		return registerHub()
	else
		--change head   //to be optimized
		if(configInfo.changeHead)
		then
      local photograph = {
  	{  308,  884, 0xf9f9fa},
  	{  308,  870, 0x007aff},
  	{  308,  875, 0xf9f9fa},
  	{  308,  879, 0x007aff},
  	{  308,  889, 0x007aff},
  	{  308,  894, 0xf8f9fa},
  	{  308,  899, 0x1483ff},
  	{  327,  876, 0x007aff},
  	{  331,  876, 0xf9f9fa}
  }


			initPhotos()				-- initPhotos
			mSleep(1000)

			recRandomTap(234,259,406,432)                -- tap "head"
			mSleep(1000)

      local X,Y = findMultiColorInRegionFuzzyByTable(photograph,90,174,741,421,984)
      if(X == -1)
      then
        tap(329,812)                                -- tap "相册"           // attention: y axis
  			mSleep(1000)
      else
        tap(X,Y)
        mSleep(1000)
      end

			recRandomTap(82,679,577,976)                -- tap the margin
			mSleep(2000)

			recRandomTap(21,324,605,450)                -- tap "相机胶卷"
			mSleep(1000)

			recRandomTap(6,156,149,297)                -- the first photo
			mSleep(1000)

			recRandomTap(546,1047,610,1075)                -- tap "Done"
			mSleep(2000)
		end
		-- clearString ....
		CLICK.momo.nickName()
		mSleep(2000)
		clearString()
		--input nickName
		inputText(momoNickName)
		mSleep(1000)
		-- get random birthday
		recRandomTap(60,605,543,610)              ---tap birthday field
		mSleep(1000)
		--get random birthday // execute only once
		for i = 1,math.random(1,5),1 do
			tap(162,math.random(713,1130))
			mSleep(500)
		end

		for i = 1,math.random(1,5),1 do
			tap(303,math.random(713,1130))
			mSleep(500)
		end

		for i = 1,math.random(1,5),1 do
			tap(469,math.random(713,1130))
			mSleep(500)
		end

    recRandomTap(443,258,605,428)                   -- tap margin
    mSleep(1000)
		--choose gender           // female only
		recRandomTap(65,701,544,727)                    -- tap gender field
    mSleep(1000)
    recRandomTap(65,940,544,945)                   -- tap female
    mSleep(1000)
    recRandomTap(289,616,347,642)                    -- tap confirm
    mSleep(1000)
		--next step  i.e. preCreatePwd
		recRandomTap(53,977,584,1048)                   -- tap next step
		mSleep(1000)
    setMomoPwd()
	end
end
--set momo pwd page
function setMomoPwd()
  local setMomoPwdPage = {{47,523,0xc8c8c8},{498,525,0xc8c8c8},{593,526,0xc8c8c8}}
  local dirtyWord = {{309,628,0x007aff},{337,632,0x007aff},{183,519,0x000000},{217,513,0x000000},{261,512,0x000000},{464,525,0xd5e4fa}}
  local i = 0
  while(not(multiColor(setMomoPwdPage))) do
    mSleep(1000)
    i = i + 1
    if(i > 12)
    then
      tap(37,84)                                      -- tap back
      mSleep(1000)
      return fillUpInfo()
    end
  end
  -- create password                                // need a while & if clause !!!!!!!
  CLICK.momo.createPwd()
  mSleep(1000)
  inputStr(configInfo.constantPwd)
  mSleep(1000)
  CLICK.momo.Done()
  mSleep(1000)
  --register Done
  recRandomTap(43,491,595,556)
  mSleep(2000)
  if(multiColor(dirtyWord))
  then
    tap(311,633)                                  -- tap ok
    mSleep(1000)
    tap(37,84)                                    -- tap back
    mSleep(1000)
    delFirstNickNameElement()
    return fillUpInfo()
  end
  delFirstElement()                                -- del first element of qqInfo.txt  &&  nickName.txt when completed register
end

--check if logged in
function dropHomePopup()
  local i = 1
	local bindPhonePopup = {{82,231,0x3462ff},{537,249,0xbfccf4},{309,424,0xb25c06},{421,514,0xffd3be},{95,872,0x2c53d9},{537,867,0x2c53d9}}
	local levelPopup = {{216,355,0x4db5ff},{275,397,0xeed7ca},{362,437,0xeed7ca},{405,483,0x4db5ff},{382,623,0x3c3c3c},{432,835,0x3462ff}}
  while(not(multiColor(bindPhonePopup) or multiColor(levelPopup)) and (i <= 10)) do
    i = i + 1
    mSleep(1000)
  end

    if(multiColor(levelPopup))
    then
        --tap X
        tap(548,  290)
        mSleep(2000)
        --tap "跳过"
        tap(581, 96)
        mSleep(2000)
    end

    if(multiColor(bindPhonePopup))
    then
        recRandomTap(525,235,551,262)       -- tap X
        mSleep(1000)
        recRandomTap(553,83,607,106)        -- tap "skip"
        mSleep(3000)
    end
end

--get momo id                         // attention : init page --HomePage
function getMomoId()
    local momoDataPath = appDataPath("com.wemomo.momoappdemo1") .. "/Documents/db"
    local var = ts.hlfs.getFileList(momoDataPath)
    if(var)
    then
        for key,val in pairs(var) do
            local para = string.len(val)
            if(para == 18)
            then
                momoId = strSplit(val,".")[2]
            end
        end
    end

    if(not momoId)
    then
        recRandomTap(563,1067,589,1095)             -- tap more
        mSleep(1000)
        flip(screenWidth/2,screenHeight - 900,screenWidth/2,screenHeight - 100)
        mSleep(1000)
        recRandomTap(475,97,576,199)                -- tap head
        mSleep(1000)
        --flip up
        flip(screenWidth/2,screenHeight - 100,screenWidth/2,screenHeight - 900)
        mSleep(2000)
        --ocrText momo id
        momoId = ocrText(140,261,330,300,20)
        mSleep(1000)
        recRandomTap(34,66,51,101)        -- tap back
        mSleep(1000)
    end
    toast(string.format("momoID = %s ",momoId),1)
end


-- read message
function readMessage()
    --momo icon
    recRandomTap(302,1071,333,1123)                     -- tap news
    dropYellowRings()
    mSleep(1000)
    local momoIcon = {
	{   41,  428, 0x4984ff},
	{   61,  425, 0x4635f6},
	{   70,  425, 0xfffffd},
	{   79,  425, 0x4634f4},
	{   93,  457, 0x2948f6},
	{  103,  448, 0xff9e2d},
	{   71,  396, 0xd847f7}
}
    local momoIconX,momoIconY = findMultiColorInRegionFuzzyByTable(momoIcon,90,15,135,633,1046)
    --tap momo icon
    tap(momoIconX + math.random(150,400),momoIconY)
    mSleep(5000)
    ifWarningIcon()
    recRandomTap(34,66,51,101)        -- tap back
    mSleep(1000)
end

--write register info into table:registerInfoFiles
function writeRegisterInfoTable()
    -- body
    registerLogTable.date = os.date("%Y/%m/%d  %H:%M:%S",ts.ms())
    registerLogTable.batch = configInfo.batchId
    registerLogTable.iphoneType = currentPhoneType
    registerLogTable.osVersion = currentOsVersion
    registerLogTable.momoVersion = "8.3"
    registerLogTable.serial = Serial
    registerLogTable.UDID = UDID
    registerLogTable.IDFA = IDFA
    registerLogTable.IDFV = IDFV
    registerLogTable.MAC = MAC
    registerLogTable.screenWidth,registerLogTable.screenHeight = getScreenSize()
    registerLogTable.IP = currentIP
    registerLogTable.latitude = latitude
    registerLogTable.longitude = longitude
    registerLogTable.qqNum = qqNum
    registerLogTable.qqPwd = qqPwd
    registerLogTable.momoNickName = momoNickName
    registerLogTable.momoId = momoId
    registerLogTable.momoPwd = configInfo.constantPwd
    registerLogTable.time = ts.ms()
    registerLogTable.warning = warning

    --etc.

end
--write register info  into file: registerInfoFiles.txt
function writeRegisterInfoFiles()
    writeContent(userPath() .. "/res/registerInfoFiles.txt",os.date("%Y/%m/%d  %H:%M:%S",ts.ms()) .. "----" .. batchId .. "----" .. strSplit(PO[1],"-")[1] .. "----" .. strSplit(PO[1],"-")[2] .. "----" .. "8.3" .. "----" .. Serial .. "----" .. IDFA .. "----" .. IDFV .. "----" .. MAC .. "----" .. getNetIP() .. "----" .. latitude .. "----" .. longitude .. "----" .. qqNum .. "----" .. qqPwd .. "----" .. momoId .. "----" .. constantPwd .. "----" .. warning .. "\n","a")
    writeContent(userPath() .. "/res/ipLogs.txt",currentIP .. "\n","a")
    _PO = _PO + 1
end
--random deceleration
function deceleration()
    -- body
    if(configInfo.signUpRhythm == "RandomDeceleration")
    then
        mSleep(math.random(configInfo.decelerationInterval[1],configInfo.decelerationInterval[2])*1000)
    end
end





--==============================================    scripts module    =================================================
function registerHub()
  loginWithqq()
  register()
  fillUpInfo()
end
function registerPart()
  getConfigInfo()
  checkUIConfig()
  pressHomeKey(0)
  pressHomeKey(1)
  toast("there r " .. #PO .. " types to test",1)
  -- NZT
  closeNZT()
  openNZT()
  setRotationLockEnable(true)
  setAssistiveTouchEnable(false)
  photoProcess()
    -- register loop
    while(#PO > 0) do
      initBtns()
      getRequiredEnv()
      for i = 1,configInfo.registerQuantity do
        newRecord()
			  getCurrentRandomGPS()
        getRequiredIP()
        getCurrentDeviceInfo()
        --momo
        registerHub()
        dropHomePopup()
        getMomoId()
        readMessage()
        writeRegisterInfoTable()
        writeRegisterInfoFiles()
        go2Nearby()
        deceleration()
        openNZT()
        renameRecord(momoId)
      end
        table.remove(PO,1)
    end
end

function checkPart()
    if(CHECKED)
    then
        toast("THE END!!!")
    else
        checkTimer()
    end
end



 registerPart()
 checkPart()
