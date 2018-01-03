
--A simple lua script to build all required NZT environment that used to register momo account with qq account
require("TSLib")
local ts = require("ts")


--=============== general lib =====================

--URI code func
function encodeURI(s)
    local s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

--new record
function newRecord()
    local url = "nzt://cmd/newrecord"
    openURL(url)
end

--active one required record
function chooseArecord(recordid)
    local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/activerecord?%s",recordId)
    openURL(url)
end

--rename current record
function renameCurrentRecord(recordid)
    local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/renamecurrentrecord?%s",recordId)
    openURL(url)
end

--func: get current record name
function getCurrentRecordName()
    -- body
    openURL("nzt://cmd/getcurrentrecordname")
end

--func; get next record
function getNextRecord()
    -- body
    openURL("nzt://cmd/nextrecord")
end

--open NZT
function openNZT()
    local NZT = "NZT"
    runApp(NZT)
    mSleep(3000)
end
--close NZT
function closeNZT()
    local NZT = "NZT"
    closeApp(NZT)
    mSleep(1000)
end

--check if a str inside a table
function inside(table,str)
    if (table == nil)
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

--init Btns
function initNZTBtns() --check if 2 btns is locked or not,if locked then unlock them
    local x1,y1,c1 = 549,233,0x000000
    local x2,y2,c2 = 230,551,0xcccccc
	local whiteSpace = {{204,508,0xffffff},{428,521,0xffffff},{314,601,0xffffff}}
	while(not(isColor(552,235,0x000000) and isColor(229,550,0xcccccc))) do
		if(not(multiColor(whiteSpace)))
		then
			mSleep(3000)
			if(not(multiColor(whiteSpace)))
			then
				closeNZT()
				openNZT()
				return keepRecord()
			end
		else
			if (not(isColor(x1,y1,c1)))
			then
				tap(x1,y1)
				mSleep(1000)
				tap(310,663) --tap noteBtn
				mSleep(1000)
			end

			if (not(isColor(x2,y2,c2)))
			then
				tap(x2,y2)
				mSleep(1000)
				tap(310,663) --tap noteBtn
				mSleep(1000)
			end
		end
	end
end

-- keepRecord
function keepRecord() --lock phone type && keep record
    local x1,y1,c1 = 549,233,0x000000
    local x2,y2,c2 = 230,551,0xcccccc
	local whiteSpace = {{204,508,0xffffff},{428,521,0xffffff},{314,601,0xffffff}}
	while(not(isColor(551,236,0xcccccc) and isColor(231,550,0x000000))) do
		if(not(multiColor(whiteSpace)))
		then
			mSleep(3000)
			if(not(multiColor(whiteSpace)))
			then
				closeNZT()
				openNZT()
				return keepRecord()
			end
		else
			if (isColor(x1,y1,c1))
			then
				tap(x1,y1)
				mSleep(1000)
				tap(310,663) --tap noteBtn
				mSleep(1000)
			end

			if (isColor(x2,y2,c2))
			then
				tap(x2,y2)
				mSleep(1000)
				tap(310,663) --tap noteBtn
				mSleep(1000)
			end
		end
	end
end

-- UI
UINew(1,"BUILDENV","确认","取消","uiconfig_buildenv.dat",0,360000,getScreenSize())
UILabel({num=1,text="系统版本:",align="left",width="220",nowrap="1"})
UICombo({num=1,id="OsVersion",list="iOS8,iOS9,iOS10,iOS11",sel="3",width=300})

--init configInfo
configInfo = {}

--get config info
function getConfigInfo()
  if(OsVersion == "iOS8")
  then
    configInfo.OSVersion = "iOS8"
    configInfo.amount = nil
    toast("invalid version,chose another plz ..",3)
    mSleep(2000)
    lua_restart()
  elseif(OsVersion == "iOS9")
  then
    configInfo.OSVersion = "iOS9"
    configInfo.amount = nil
    toast("invalid version,chose another plz ..",3)
    mSleep(2000)
    lua_restart()
  elseif(OsVersion == "iOS10")
  then
    configInfo.OSVersion = "iOS10"
    configInfo.amount = 56
  elseif(OsVersion == "iOS11")
  then
    configInfo.OSVersion =  "iOS11"
    configInfo.amount = 59
  end
end

--check configInfo
-- function checkConfigInfo()
--
-- end
--check current NZT os version
function checkCurrentNZTOSVersion()
  local NZTHome = {
	{   68,  419, 0xcccccc},
	{  552,  427, 0xcccccc},
	{   57,  824, 0xcccccc},
	{  578,  822, 0xcccccc},
	{  417,  958, 0xcccccc},
}
  closeNZT()
  openNZT()
  if(multiColor(NZTHome))
  then
    local currentNZTOSVersion = ocrText(314,40,430,97,20)
    if(configInfo.OSVersion ~= currentNZTOSVersion)
    then
      dialog(string.format("%s is required,now is %s ,reset plz.",configInfo.OSVersion,currentNZTOSVersion),0)
      lua_exit()
    end
  else
    return checkCurrentNZTOSVersion()
  end
end

--buildEnv
function buildEnv()
    local i = 0
    local repo = {}

    --clearAllRecords() --clear all records
	initNZTBtns()
    newRecord()
    mSleep(1000)
    while (#repo < configInfo.amount) do
        if(inside(repo,getCurrentPhoneType() .. getCurrentOsVersion())) then
          newRecord()
          mSleep(1000)
        else
            if(string.find(currentPhoneType,"iPhone 5") or string.find(currentPhoneType,"iPhone SE") or string.find(currentPhoneType,"iPhone 4"))
			      then
              newRecord()
              mSleep(1000)
            else
              keepRecord()
              newRecord()
              mSleep(1000)
              renameCurrentRecord(currentPhoneType .. "-" .. currentOsVersion)
              mSleep(2000)
              table.insert(repo,currentPhoneType .. currentOsVersion)
              tap(41,79)
              mSleep(2000)
              initNZTBtns()
              newRecord()
              mSleep(1000)
            end
        end
    end
    dialog("THE END")
end


--============= script part =========================
UIShow()
getConfigInfo()
checkCurrentNZTOSVersion()
buildEnv()
