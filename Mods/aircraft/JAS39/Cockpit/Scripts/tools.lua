dofile(LockOn_Options.script_path.."locale.lua")

function debug(x)
   if debug_mode then
        print_message_to_user(x)
        log.alert(x)
   end
end

function run_action(val,command,value)
	-- if not  track_is_reading() then
	   dispatch_action(nil, command,value)
	-- end
end

-- calculates the haversine formula distance (m) between latitude,longitude pairs x1,y1 and x2,y2
local function haversine(x1, y1, x2, y2)
    local r=0.017453292519943295769236907684886127;
    local x1= x1*r; local x2= x2*r; local y1= y1*r; local y2= y2*r; local dy = y2-y1; local dx = x2-x1;
    local a = math.pow(math.sin(dx/2),2) + math.cos(x1) * math.cos(x2) * math.pow(math.sin(dy/2),2);
    local c = 2 * math.asin(math.sqrt(a));
    local d = 6372800 * c;
    return d;
end

-- calculates the "forward azimuth" bearing of a great circle route from x1,y1 to x2,y2 in true heading degrees
local function forward_azimuth_bearing(x1,y1,x2,y2)
    local lat1r = math.rad(x1)
    local lon1r = math.rad(y1)
    local lat2r = math.rad(x2)
    local lon2r = math.rad(y2)

    local y = math.sin(lon2r-lon1r) * math.cos(lat2r)
    local x = math.cos(lat1r)*math.sin(lat2r) - math.sin(lat1r)*math.cos(lat2r)*math.cos(lon2r-lon1r)
    local brng = math.deg(math.atan2(y, x))

    return brng
end

function geo2str(lx, lz)
				local geopos = lo_to_geo_coords(lx, lz)
				
				local lat     = math.floor(geopos.lat)
				local lat_min = math.floor((geopos.lat - lat) * 60)
				local lat_sec = math.floor((((geopos.lat - lat)* 60) - lat_min  ) * 60)
				
				local lon     = math.floor(geopos.lon)
				local lon_min = math.floor((geopos.lon - lon) * 60)
				local lon_sec = math.floor((((geopos.lon - lon)* 60) - lon_min  ) * 60)
				return lat.." "..lat_min.." "..lat_sec.." N / "..lon.." "..lon_min.." "..lon_sec..' E'
end

function get_dest_data(x1, y1, x2, y2)
	local point1 = lo_to_geo_coords(x1, y1)
	local point2 = lo_to_geo_coords(x2, y2)
	local abstime = get_absolute_model_time()
	local hours12 = abstime / 3600.0
	if hours12>12.0 then
		hours12 = hours12 - 12.0
	end
	local int,frac = math.modf(hours12)
	return { 
		hdg 	 = true_bearing_deg_from_xz(x1, y1, x2, y2),
		distance = haversine(point1.lat, point1.lon, point2.lat, point2.lon) / 1000,
		eta      = string.format("%0d  %02d  %02d",  hours12, frac * 60, frac)
	}
end

function true_bearing_deg_from_xz(x1,z1,x2,z2)
    return ( math.deg(math.atan2(z2-z1,x2-x1)) %360 )  -- true bearing in degrees
end

ptimer = get_model_time()
cycle_timeer = ptimer

function blink_arg(value, freq)
	ptimer = get_model_time()
	if ptimer - cycle_timeer >= freq then
	  if value:get() == 0 then 
		value:set(1)
  	  else
		value:set(0)
	  end
	  cycle_timeer = ptimer
	end
end

function sequencer(freq)
	ptimer = get_model_time()
	if ptimer - cycle_timeer >= freq then
		cycle_timeer = ptimer
		return 1
	end
	return 0
end

function true_bearing_deg_from_xz(x1,z1,x2,z2)
    return ( math.deg(math.atan2(z2-z1,x2-x1)) % 360 )  -- true bearing in degrees
end

function geotoxy_lola(lat, lon)
	w = 1024 
	h = 1024
	x =  ((w/360) * (180 + lon)) 
	y =  ((h/180) * (90 - lat)) * -1
	return {x = x, y = y}
end	

function geotoxy(geopos)
	w = 1024 
	h = 1024
	x =  ((w/360) * (180 + geopos.lon)) 
	y =  ((h/180) * (90 - geopos.lat)) * -1
	return {x = x, y = y}
end	

function run_action(val,command,value)
	-- if not  track_is_reading() then
	   dispatch_action(nil, command,value)
	-- end
end

function dump(t,i)
    
    local s={}
    local n=0
    for k in pairs(t) do
        n=n+1 s[n]=k
    end
    table.sort(s)
    for k,v in ipairs(s) do
        log.alert(i..tostring(v).."["..type(t[v]).."="..tostring(t[v]).."]")
        v=t[v]
        
    end
end

function str2geo(line_input_txt)
	if line_input_txt ~= nil then
		local lonh = string.sub(line_input_txt,1,2)
		local lonm = string.sub(line_input_txt,3,4)
		local lons = string.sub(line_input_txt,5,6)
		return tonumber(lonh) + tonumber(lonm)/60 + tonumber(lons)/3600
	end
end

function geo2str(lx, lz)
	local geopos = lo_to_geo_coords(lx, lz)
	
	local lat     = math.floor(geopos.lat)
	local lat_min = math.floor((geopos.lat - lat) * 60)
	local lat_sec = math.floor((((geopos.lat - lat)* 60) - lat_min  ) * 60)
	
	local lon     = math.floor(geopos.lon)
	local lon_min = math.floor((geopos.lon - lon) * 60)
	local lon_sec = math.floor((((geopos.lon - lon)* 60) - lon_min  ) * 60)
	return lat.." "..lat_min.." "..lat_sec.." N / "..lon.." "..lon_min.." "..lon_sec..' E'
end

function geo2lonstr(lx, lz, outformat)
	local geopos = lo_to_geo_coords(lx, lz)
	local lon     = math.floor(geopos.lon)
	local lon_min = math.floor((geopos.lon - lon) * 60)
	local lon_sec = math.floor((((geopos.lon - lon)* 60) - lon_min  ) * 60)
	if outformat == 1 then
		return "E "..string.format("%0d°%02d.%02d",  lon, lon_min, lon_sec)
	end
	return getLocale("LON E ")..string.format("%0d %02d %02d",  lon, lon_min, lon_sec)
	-- return "LON E:"..tostring(lon).." "..tostring(lon_min).." "..tostring(lon_sec)
end

function geo2latstr(lx, lz, outformat)
	local geopos = lo_to_geo_coords(lx, lz)
	
	local lat     = math.floor(geopos.lat)
	local lat_min = math.floor((geopos.lat - lat) * 60)
	local lat_sec = math.floor((((geopos.lat - lat)* 60) - lat_min  ) * 60)

	if outformat == 1 then
		return "N "..string.format("%0d°%02d.%02d",  lat, lat_min, lat_sec)
	end
	return getLocale("LAT N ")..string.format("%0d %02d %02d",  lat, lat_min, lat_sec)
	-- return "LAT N:"..tostring(lat).." "..tostring(lat_min).." "..tostring(lat_sec)
end

function limit_xy(x, y, limit_x, limit_y, limit_x_down, limit_y_down) 
    limit_x_down = limit_x_down or -limit_x
    limit_y_down = limit_y_down or -limit_y

    local limited = false
    if x > limit_x then 
        y = y * limit_x / x
        x = limit_x
        limited = true
    end
    if x < limit_x_down then 
        y = y * limit_x_down / x
        x = limit_x_down 
        limited = true
    end
    if y > limit_y then 
        x = x * limit_y / y
        y = limit_y 
        limited = true
    end
    if y < limit_y_down then 
        x = x * limit_y_down / y
        y = limit_y_down 
        limited = true
    end
    return x, y, limited and 1 or 0, limited
end

function round_to(value, roundto)
    value = value + roundto/2
    return value - value % roundto
end
