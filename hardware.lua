mywibox4 = awful.wibox({ position = "bottom", screen = s, layout = awful.widget.layout.vertical.flex })

cpuTempIcn       = widget({ type = "imagebox", align = "left" })
cpuTempIcn.image = image("/home/lepagee/Icon/temp.png")

cpuTempLbl = widget({
    type = 'textbox',
    name = 'cpuTempLbl',
    align='left'
})
cpuTempLbl.text =" <b>Processor: </b>"

cpuTempBar = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.leftright })

cpuTempBar.vertical = true
cpuTempBar.width = 6
cpuTempBar.height = 0.75

-- cpuTempBar:bar_properties_set('cpu', {
-- --  fg = '#00FF00',
-- --  fg_center = '#FFFF00',
-- --  fg_end = '#FF0000',
--  reverse = false,
--  min_value = 0,
--  max_value = 100,
--  width = 7
-- })



cpuTempVal = widget({
    type = 'textbox',
    name = 'cpuTempLbl',
    align='left'
})

cpuTempVal.text ="50C | "

gpuTempIcn       = widget({ type = "imagebox", align = "left" })
gpuTempIcn.image = image("/home/lepagee/Icon/temp.png")

gpuTempLbl = widget({
    type = 'textbox',
    name = 'gpuTempLbl',
    align='left'
})
gpuTempLbl.text =" <b>Graphic Card: </b>"

gpuTempBar = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.leftright })

gpuTempBar.vertical = true
gpuTempBar.width = 6
gpuTempBar.height = 0.75

-- gpuTempBar:bar_properties_set('gpu', {
-- --  fg = '#00FF00',
-- --  fg_center = '#FFFF00',
-- --  fg_end = '#FF0000',
--  reverse = false,
--  min_value = 0,
--  max_value = 100,
--  width = 7
-- })


gpuTempVal = widget({
    type = 'textbox',
    name = 'gpuTempLbl',
    align='left'
})
gpuTempVal.text ="50C | "

hddTempIcn       = widget({ type = "imagebox", align = "left" })
hddTempIcn.image = image("/home/lepagee/Icon/temp.png")

hddTempLbl = widget({
    type = 'textbox',
    name = 'hddTempLbl',
    align='left'
})
hddTempLbl.text =" <b>Hard Drive: </b>"

hddTempBar = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.leftright })

hddTempBar.vertical = true
hddTempBar.width = 6
hddTempBar.height = 0.75

-- hddTempBar:bar_properties_set('hdd', {
-- --  fg = '#00FF00',
-- --  fg_center = '#FFFF00',
-- --  fg_end = '#FF0000',
--  reverse = false,
--  min_value = 0,
--  max_value = 100,
--  width = 7
-- })


hddTempVal = widget({
    type = 'textbox',
    name = 'hddTempLbl',
    align='left'
})
hddTempVal.text ="50C | "

vicious.register(hddTempVal, vicious.widgets.hddtemp, '${/dev/sda}°C | ', 20)

ambTempIcn       = widget({ type = "imagebox", align = "left" })
ambTempIcn.image = image("/home/lepagee/Icon/temp.png")

ambTempLbl = widget({
    type = 'textbox',
    name = 'ambTempLbl',
    align='left'
})
ambTempLbl.text =" <b>Ambiant: </b>"

ambTempBar = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.leftright })

ambTempBar.vertical = true
ambTempBar.width = 6
ambTempBar.height = 0.75

-- ambTempBar:bar_properties_set('amb', {
-- --  fg = '#00FF00',
-- --  fg_center = '#FFFF00',
-- --  fg_end = '#FF0000',
--  reverse = false,
--  min_value = 0,
--  max_value = 100,
--  width = 7
-- })


ambTempVal = widget({
    type = 'textbox',
    name = 'ambTempLbl',
    align='left'
})
ambTempVal.text ="50C | "

vicious.register(ambTempVal, getTemp1, "$1°C | ", 10)

cpuFanIcn       = widget({ type = "imagebox", align = "left" })
cpuFanIcn.image = image("/home/lepagee/Icon/fan.png")

cpuFanLbl = widget({
    type = 'textbox',
    name = 'cpuFanLbl',
    align='left'
})
cpuFanLbl.text ="<b>CPU Fan: </b>"

cpuFanVal = widget({
    type = 'textbox',
    name = 'cpuFanLbl',
    align='left'
})
cpuFanVal.text ="4232rpm | "

vicious.register(cpuFanVal, getFan1, "$1rpm | ", 10)

gpuFanIcn       = widget({ type = "imagebox", align = "left" })
gpuFanIcn.image = image("/home/lepagee/Icon/fan.png")

gpuFanLbl = widget({
    type = 'textbox',
    name = 'gpuFanLbl',
    align='left'
})
gpuFanLbl.text ="<b>GPU Fan: </b>"



gpuFanVal = widget({
    type = 'textbox',
    name = 'gpuFanLbl',
    align='left'
})
gpuFanVal.text ="3242rpm | "

function check_hardware(format)
  local f = io.popen('/home/lepagee/Scripts/hardwareWatch.sh')
  local cpuTemp = tonumber(f:read()) or 0
  local gpuTemp = tonumber(f:read()) or 0
  local hddTemp = tonumber(f:read()) or 0
  local auxTemp = tonumber(f:read()) or 0
  --local cpuFan = tonumber(f:read()) or 0
  local gpuFan = tonumber(f:read()) or 0
  f:close()
  
  if gpuTemp >= 70 then
    gpuTempLbl.text =' <span color="#FF0000"><b>Graphic Card: </b></span>'
    gpuTempVal.text = '<span color="#FF0000"> '..gpuTemp.."C</span> | "
    mywibox4.visible = true
  elseif gpuTemp >= 60 then
    gpuTempLbl.text =' <span color="#FFDD00"><b>Graphic Card: </b></span>'
    gpuTempVal.text = '<span color="#FFDD00"> '..gpuTemp.."C</span> | "
  else
    gpuTempLbl.text =' <span color="'..beautiful.fg_normal..'"><b>Graphic Card: </b></span>'
    gpuTempVal.text = '<span color="'..beautiful.fg_normal..'"> '..gpuTemp.."C</span> | "
  end
  
  
  if mywibox4.visible == true then
    --hddTempVal.text = hddTemp .."C | "
    if (not auxTemp == nil) then
       ambTempVal.text = auxTemp .."C | "
    else
       ambTempVal.text = "? C | "
    end
    if (not cpuFanVal == nil) then
       cpuFanVal.text = cpuFan .."rpm | "
    else
       cpuFanVal.text = "?rpm | "       
    end
    --gpuFanVal.text = gpuFan .."rpm | "
  end
  
  local toReturn
  if cpuTemp >= 80 then
    cpuTempLbl.text =' <span color="#FF0000"><b>Processor: </b></span>'
    mywibox4.visible = true
    toReturn = '<span color="#FF0000"> '..cpuTemp.."C</span> | "
  elseif cpuTemp >= 70 then
    cpuTempLbl.text =' <span color="#FFDD00"><b>Processor: </b></span>'
    toReturn = '<span color="#FFDD00"> '..cpuTemp.."C</span> | "
  else
    cpuTempLbl.text =' <b>Processor: </b>'
    toReturn = ' '..cpuTemp.."C | "
  end
  return toReturn
  
end
--vicious.register(cpuTempVal, check_hardware, '$1',10)
vicious.register(cpuTempVal, vicious.widgets.thermal, "$1°C", 10, {"coretemp.0", "core"})

voltage = widget({
    type = 'textbox',
    name = 'volt5Lbl',
    align='right'
})
voltage.text ="| <b>Voltage: </b>"

volt12Icn       = widget({ type = "imagebox", align = "right" })
volt12Icn.image = image(awful.util.getdir("config") .. "/Icon/volt.png")

volt12Lbl = widget({
    type = 'textbox',
    name = 'volt12Lbl',
    align='right'
})
volt12Lbl.text ="<small><b>12v: </b></small>"

volt12Val = widget({
    type = 'textbox',
    name = 'volt12Lbl',
    align='right'
})
volt12Val.text ="<small><i>11.2v</i></small> "

volt5Icn       = widget({ type = "imagebox", align = "right" })
volt5Icn.image = image(awful.util.getdir("config") .. "/Icon/volt.png")

volt5Lbl = widget({
    type = 'textbox',
    name = 'volt5Lbl',
    align='right'
})
volt5Lbl.text ="<small><b>5v: </b></small>"

volt5Val = widget({
    type = 'textbox',
    name = 'volt5Lbl',
    align='right'
})
volt5Val.text ="<small><i>5.3v</i></small> "

volt33Icn       = widget({ type = "imagebox", align = "right" })
volt33Icn.image = image(awful.util.getdir("config") .. "/Icon/volt.png")

volt33Lbl = widget({
    type = 'textbox',
    name = 'volt33Lbl',
    align='right'
})
volt33Lbl.text ="<small><b>3.3v: </b></small>"

volt33Val = widget({
    type = 'textbox',
    name = 'volt33Lbl',
    align='right'
})
volt33Val.text ="<small><i>3.2v</i></small> "


mywibox4.widgets = {  cpuTempIcn,
		      cpuTempBar,
		      cpuTempLbl, 
		      cpuTempVal, 
		      gpuTempIcn,
		      gpuTempBar,
		      gpuTempLbl, 
		      gpuTempVal, 
		      hddTempIcn,
		      hddTempBar,
		      hddTempLbl, 
		      hddTempVal, 
		      ambTempIcn,
		      ambTempBar,
		      ambTempLbl, 
		      ambTempVal, 
		      cpuFanIcn,
		      cpuFanLbl, 
		      cpuFanVal, 
		      gpuFanIcn,
		      gpuFanLbl, 
		      gpuFanVal,
		      {
			volt33Val,
			volt33Lbl,
			volt33Icn,
			volt5Val, 
			volt5Lbl, 
			volt5Icn,
			volt12Val, 
			volt12Lbl, 
			volt12Icn,
			voltage,
			layout = awful.widget.layout.horizontal.rightleft
		      },
		      layout = awful.widget.layout.horizontal.leftright
		      }
mywibox4.screen = 1
mywibox4.visible = false