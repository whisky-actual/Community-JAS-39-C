dofile(LockOn_Options.common_script_path.."tools.lua")
localize_table = {}
 
dofile(LockOn_Options.script_path.."l10n/ru.lua")
dofile(LockOn_Options.script_path.."l10n/en.lua")

aircraft_type = get_aircraft_type()

function getLocale(str)
	language = "EN"

	if	localize_table[language] == nil then
		return str
	else
		if localize_table[language][str] == nil then
			return str
		end
		return localize_table[language][str]
	end
	return '/'
end

 
