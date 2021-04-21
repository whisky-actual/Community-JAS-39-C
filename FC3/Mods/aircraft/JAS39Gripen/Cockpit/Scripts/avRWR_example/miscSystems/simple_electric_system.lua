local electric_system = GetSelf()

function SetCommand(command,value)

  if command == 3006 then   
   electric_system:AC_Generator_1_on(value > 0)
  elseif command == 3005 then
   electric_system:AC_Generator_2_on(value > 0)
  elseif command == 3004 then
   electric_system:DC_Battery_on(value > 0)
  end
end



function update()
	--print_message_to_user("Update Electric System")

	
end