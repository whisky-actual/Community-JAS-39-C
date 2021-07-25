local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = true,
}

local openFormation = true

function specialEvent(params) 
	return staticParamsEvent(Message.wMsgLeaderSpecialCommand, params)
end

local menus = data.menus

data.rootItem = {
	name = _('Main'),
	getSubmenu = function(self)	
		local tbl = {
			name = _('Main'),
			items = {}
		}
		
		if data.pUnit == nil or data.pUnit:isExist() == false then
			return tbl
		end
		
		if self.builders ~= nil then
			for index, builder in pairs(self.builders) do
				builder(self, tbl)
			end
		end
		
		if #data.menuOther.submenu.items > 0 then
			tbl.items[10] = {
				name = _('Other'),
				submenu = data.menuOther.submenu
			}
		end
		
		return tbl
	end,
	builders = {}
}

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)

-- Wheel Chocks and ladder
menus['Wheel chocks and ladder'] = {
	name = _('Wheel chocks and ladder'),
	items = {
		[1] = {
			name = _('Place wheel chocks and ladder'), 		
			command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, true)
		},
		[2] = {
			name = _('Remove wheel chocks and ladder'),
			command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, false)
		}
	}
}
menus['Ground Crew'].items[4] = { name = _('Wheel chocks and ladder'), submenu = menus['Wheel chocks and ladder']}