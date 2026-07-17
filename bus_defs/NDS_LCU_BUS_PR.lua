---------------------------------------------------------------------------------
--   File             :  NDS_LCU_BUS_PR.lua                                      
--   Project          :  BLOC_LF5                                                
--   Project Date     :  29/12/2025 11:29:27                                     
--   System           :  LCU                                                     
--   Description      :  Wireshark Protocol related to Bus                       
--   Software Version :  Files Generation version 2.0.40.0                       
--   Generation Type  :  Wireshark Protocol                                      
--   Generation Name  :  LUA                                                     
--   Created          :  05/01/2026 18:36:13 (Automatic from ICD File Generation)
---------------------------------------------------------------------------------


require "AWF"

if (NDS_LCU_BUS_PR == nil) then

-- bus

NDS_LCU_BUS_PR = AWF.Protocol.new("NDS_LCU_BUS_PR", "NDS_LCU_BUS_PR", 0);

-- groups

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR = AWF.Namespace.new("IOSAMPLE_GROUP_PR", NDS_LCU_BUS_PR);

-- enumerations

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE =
{
	[0] = "FALSE",
	[1] = "TRUE",
};

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_DEGRADED_INVALID =
{
	[0] = "VALID_DATA",
	[1] = "DEGRADED_DATA",
	[2] = "INVALID_DATA",
};

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID =
{
	[0] = "VALID_DATA",
	[1] = "INVALID_DATA",
};

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_INS_IDENTIFICATION =
{
	[0] = "LAST_DIGIT_IP_ADDR_EVEN",
	[1] = "LAST_DIGIT_IP_ADDR_ODD",
};

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_STATUS_1_EQUIP_STATUS =
{
	[0] = "NO_FAILURE",
	[1] = "ANOMALY",
	[2] = "WARNING",
	[3] = "DATA_FAILURE",
	[4] = "GENERAL_FAILURE",
};

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_STATUS_1_MODE =
{
	[0] = "NAV_SEA",
	[1] = "NAV_QUAY",
	[2] = "ALIGNMENT",
	[3] = "MAINTENANCE",
};


-- structures

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_10HZ_STRUCT = AWF.Struct.new("ATTITUDE_10HZ_STRUCT", "ATTITUDE_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 6;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 6, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_10HZ:read(buf, pkt, structTree, offset + 0, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_10HZ:read(buf, pkt, structTree, offset + 2, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_10HZ:read(buf, pkt, structTree, offset + 4, 2, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_RATE_10HZ_STRUCT = AWF.Struct.new("ATTITUDE_RATE_10HZ_STRUCT", "ATTITUDE_RATE_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_RATE_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 6;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 6, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_RATE_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_RATE_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_RATE_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_RATE_10HZ:read(buf, pkt, structTree, offset + 0, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_RATE_10HZ:read(buf, pkt, structTree, offset + 2, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_RATE_10HZ:read(buf, pkt, structTree, offset + 4, 2, byteOrder, dynamic);

	end
	return length;
end

-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.BITE_STATUS_10HZ_STRUCT = AWF.Struct.new("BITE_STATUS_10HZ_STRUCT", "BITE_STATUS_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
-- function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.BITE_STATUS_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	-- length = 1;
	-- local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	-- local value;
	-- if (dynamic) then
		-- local localOffset = offset;
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.altitudeSaturation:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.speedSaturation:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.dynamicExceeded:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.cpuOverload:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.temperatureErr:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.accAnomaly:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.fogAnomaly:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		-- length = localOffset - offset;
		-- structTree.len =  length;
	-- else
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ALTITUDE_SATURATION:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_SATURATION:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DYNAMIC_EXCEEDED:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CPU_OVERLOAD:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TEMPERATURE_ERR:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ACC_ANOMALY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.FOG_ANOMALY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	-- end
	-- return length;
-- end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ_STRUCT = AWF.Struct.new("CHECKSUM_10HZ_STRUCT", "CHECKSUM_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.checksum:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.checksum:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DATA_BYTES_COUNTER_10HZ_STRUCT = AWF.Struct.new("DATA_BYTES_COUNTER_10HZ_STRUCT", "DATA_BYTES_COUNTER_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DATA_BYTES_COUNTER_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NUMDATA_10HZ:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NUMDATA_10HZ:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_10HZ_STRUCT = AWF.Struct.new("GNSS_POSITION_10HZ_STRUCT", "GNSS_POSITION_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 8;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 8, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LATITUDE_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LONGITUDE_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LATITUDE_10HZ:read(buf, pkt, structTree, offset + 0, 4, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LONGITUDE_10HZ:read(buf, pkt, structTree, offset + 4, 4, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_10HZ_STRUCT = AWF.Struct.new("HEADER_10HZ_STRUCT", "HEADER_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 2;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 2, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_1_10HZ:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_2_10HZ:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_1_10HZ:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_2_10HZ:read(buf, pkt, structTree, offset + 1, 1, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ID_10HZ_STRUCT = AWF.Struct.new("ID_10HZ_STRUCT", "ID_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ID_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.IDENT_10HZ:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.IDENT_10HZ:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_10HZ_STRUCT = AWF.Struct.new("NAV_DATA_10HZ_STRUCT", "NAV_DATA_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 8;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 8, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.COURSE_MADE_GOOD_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_OVER_GROUND_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_DIRECTION_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_SPEED_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.COURSE_MADE_GOOD_10HZ:read(buf, pkt, structTree, offset + 0, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_OVER_GROUND_10HZ:read(buf, pkt, structTree, offset + 2, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_DIRECTION_10HZ:read(buf, pkt, structTree, offset + 4, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_SPEED_10HZ:read(buf, pkt, structTree, offset + 6, 2, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_10HZ_STRUCT = AWF.Struct.new("POSITION_10HZ_STRUCT", "POSITION_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 10;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 10, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_10HZ:read(buf, pkt, structTree, offset + 0, 4, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_10HZ:read(buf, pkt, structTree, offset + 4, 4, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_10HZ:read(buf, pkt, structTree, offset + 8, 2, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_ACC_10HZ_STRUCT = AWF.Struct.new("POSITION_ACC_10HZ_STRUCT", "POSITION_ACC_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_ACC_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 10;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 10, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_ACC_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_ACC_10HZ:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_CORR_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_ACC_10HZ:read(buf, pkt, structTree, offset + 0, 4, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_ACC_10HZ:read(buf, pkt, structTree, offset + 4, 4, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_CORR_10HZ:read(buf, pkt, structTree, offset + 8, 2, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPARE_BYTE_STRUCT = AWF.Struct.new("SPARE_BYTE_STRUCT", "SPARE_BYTE_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPARE_BYTE_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.spare:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.spare:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end

-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_1_10HZ_STRUCT = AWF.Struct.new("STATUS_1_10HZ_STRUCT", "STATUS_1_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
-- function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_1_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	-- length = 1;
	-- local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	-- local value;
	-- if (dynamic) then
		-- local localOffset = offset;
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EQUIP_STATUS:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_MODE:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_HEADING_VALIDITY:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		-- localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_DOWNSPEED_VALIDITY:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		-- length = localOffset - offset;
		-- structTree.len =  length;
	-- else
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EQUIP_STATUS:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_MODE:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_HEADING_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_DOWNSPEED_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	-- end
	-- return length;
-- end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT = AWF.Struct.new("STATUS_2_10HZ_STRUCT", "STATUS_2_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_TIME_VALIDITY:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_VALIDITY:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.logSpeedValidity:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.navDataValidity:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.isSimulation:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.insID:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_TIME_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_1:read(buf, pkt, structTree, offset, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_VALIDITY:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_2:read(buf, pkt, structTree, offset, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIMULATION_MODE:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_IDENTIFICATION_10HZ:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end





NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TERMINATOR_10HZ_STRUCT = AWF.Struct.new("TERMINATOR_10HZ_STRUCT", "TERMINATOR_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TERMINATOR_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.terminator:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.terminator:read(buf, pkt, structTree, offset + 0, 1, byteOrder, dynamic);

	end
	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.VELOCITIES_10HZ_STRUCT = AWF.Struct.new("VELOCITIES_10HZ_STRUCT", "VELOCITIES_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.VELOCITIES_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	length = 8;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 8, byteOrder, dynamic, instance);
	local value;
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NORTH_VELOCITY_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EAST_VELOCITY_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DOWN_VELOCITY_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_10HZ:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NORTH_VELOCITY_10HZ:read(buf, pkt, structTree, offset + 0, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EAST_VELOCITY_10HZ:read(buf, pkt, structTree, offset + 2, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DOWN_VELOCITY_10HZ:read(buf, pkt, structTree, offset + 4, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_10HZ:read(buf, pkt, structTree, offset + 6, 2, byteOrder, dynamic);

	end
	return length;
end


-- bits structures

-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ_STRUCT = AWF.Struct.new("TIME_REF_GNSS_10HZ_STRUCT", "TIME_REF_GNSS_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
-- function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	-- local length = 3;
	-- local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 3, byteOrder);
	-- local value = AWF.readValue(ftypes.UINT32, buf, offset, 3, byteOrder, dynamic, instance);
	-- NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ:readBits(buf, pkt, structTree, offset, 3, byteOrder, dynamic, nil, value, 0);

	-- return length;
-- end


NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ_STRUCT = AWF.Struct.new("TIME_REF_GNSS_10HZ_STRUCT", "TIME_REF_GNSS_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 3;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 4, byteOrder,dynamic, instance);
	local value = AWF.readValue(ftypes.UINT32, buf, offset, 3, byteOrder);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ:readBits(buf, pkt, structTree, offset, 3, byteOrder, dynamic, nil, value, 0);
	--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPARE_8BITS:readBits(buf, pkt, structTree, offset, 4, byteOrder, dynamic, nil, value, 24);

	return length;
end

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_1_10HZ_STRUCT = AWF.Struct.new("STATUS_1_10HZ_STRUCT", "STATUS_1_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_1_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value = AWF.readValue(ftypes.UINT8, buf, offset, 1, byteOrder);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EQUIP_STATUS:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 0);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_MODE:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 3);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_HEADING_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 5);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_DOWNSPEED_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 7);


	return length;
end



NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT = AWF.Struct.new("STATUS_2_10HZ_STRUCT", "STATUS_2_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value = AWF.readValue(ftypes.UINT8, buf, offset, 1, byteOrder);
	
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_TIME_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 0);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 1);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_1:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 2);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 3);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 4);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_2:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 5);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIMULATION_MODE:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 6);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_IDENTIFICATION_10HZ:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 7);

	return length;
end


NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT = AWF.Struct.new("STATUS_2_10HZ_STRUCT", "STATUS_2_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value = AWF.readValue(ftypes.UINT8, buf, offset, 1, byteOrder);
	
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_TIME_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 0);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 1);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_1:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 2);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 3);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_VALIDITY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 4);
	    NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_2:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 5);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIMULATION_MODE:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 6);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_IDENTIFICATION_10HZ:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 7);

	return length;
end



NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.BITE_STATUS_10HZ_STRUCT = AWF.Struct.new("BITE_STATUS_10HZ_STRUCT", "BITE_STATUS_10HZ_STRUCT", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.BITE_STATUS_10HZ_STRUCT:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 1;
	local actualLength, structTree = AWF.Struct.read(self, buf, pkt, tree, offset, 1, byteOrder, dynamic, instance);
	local value = AWF.readValue(ftypes.UINT8, buf, offset, 1, byteOrder);

	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ALTITUDE_SATURATION:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 0);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_SATURATION:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 1);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DYNAMIC_EXCEEDED:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 2);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CPU_OVERLOAD:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 3);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TEMPERATURE_ERR:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 4);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ACC_ANOMALY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 5);
	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.FOG_ANOMALY:readBits(buf, pkt, structTree, offset, 1, byteOrder, dynamic, nil, value, 6);

    return length;
end



-- arrays

--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIX_SPARE_BYTES = AWF.Array.new("SIX_SPARE_BYTES", "SIX_SPARE_BYTES", IOSAMPLE_GROUP_PR.SPARE_BYTE_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR)
--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TWO_SPARE_BYTES = AWF.Array.new("TWO_SPARE_BYTES", "TWO_SPARE_BYTES", IOSAMPLE_GROUP_PR.SPARE_BYTE_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR)

-- elements


NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPARE_8BITS = AWF.NumericElement.new("SPARE_8BITS","SPARE_8BITS",ftypes.UINT8, 0, 255, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 255, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ACC_ANOMALY = AWF.EnumElement.new("ACC_ANOMALY", "ACC_ANOMALY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ALTITUDE_SATURATION = AWF.EnumElement.new("ALTITUDE_SATURATION", "ALTITUDE_SATURATION", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_HEADING_VALIDITY = AWF.EnumElement.new("ATTITUDE_HEADING_VALIDITY", "ATTITUDE_HEADING_VALIDITY", ftypes.UINT8, 0, 3, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_DEGRADED_INVALID, AWF.CastConverter.new(ftypes.UINT8, 0, 3, 2), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ = AWF.NumericElement.new("CHECKSUM_10HZ","CHECKSUM_10HZ",ftypes.UINT8, 0, 255, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 255, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.COURSE_MADE_GOOD_10HZ = AWF.NumericElement.new("COURSE_MADE_GOOD_10HZ","COURSE_MADE_GOOD_10HZ",ftypes.FLOAT, 0.0, 359.994506835938, 0.0, AWF.LinearConverter.new(ftypes.UINT16, 0, 65535, 0.0054931640625, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CPU_OVERLOAD = AWF.EnumElement.new("CPU_OVERLOAD", "CPU_OVERLOAD", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_DIRECTION_10HZ = AWF.NumericElement.new("CURRENT_DIRECTION_10HZ","CURRENT_DIRECTION_10HZ",ftypes.FLOAT, 0.0, 359.994506835938, 0.0, AWF.LinearConverter.new(ftypes.UINT16, 0, 65535, 0.0054931640625, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CURRENT_SPEED_10HZ = AWF.NumericElement.new("CURRENT_SPEED_10HZ","CURRENT_SPEED_10HZ",ftypes.FLOAT, 0.0, 131.07, 0.0, AWF.LinearConverter.new(ftypes.UINT16, 0, 65535, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_10HZ = AWF.NumericElement.new("DEPTH_10HZ","DEPTH_10HZ",ftypes.FLOAT, -655.36, 655.34, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.02, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DEPTH_DOWNSPEED_VALIDITY = AWF.EnumElement.new("DEPTH_DOWNSPEED_VALIDITY", "DEPTH_DOWNSPEED_VALIDITY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DOWN_VELOCITY_10HZ = AWF.NumericElement.new("DOWN_VELOCITY_10HZ","DOWN_VELOCITY_10HZ",ftypes.FLOAT, -65.536, 65.534, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DYNAMIC_EXCEEDED = AWF.EnumElement.new("DYNAMIC_EXCEEDED", "DYNAMIC_EXCEEDED", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EAST_VELOCITY_10HZ = AWF.NumericElement.new("EAST_VELOCITY_10HZ","EAST_VELOCITY_10HZ",ftypes.FLOAT, -65.536, 65.534, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.END_MESSAGE = AWF.NumericElement.new("END_MESSAGE","END_MESSAGE",ftypes.UINT8, 170, 170, 170, AWF.CastConverter.new(ftypes.UINT8, 170, 170, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.EQUIP_STATUS = AWF.EnumElement.new("EQUIP_STATUS", "EQUIP_STATUS", ftypes.INT32, 0, 4, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_STATUS_1_EQUIP_STATUS, AWF.CastConverter.new(ftypes.UINT8, 0, 4, 3), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.FOG_ANOMALY = AWF.EnumElement.new("FOG_ANOMALY", "FOG_ANOMALY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSSPosition_10hz = AWF.ComplexElement.new("GNSSPosition_10hz", "GNSSPosition_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LATITUDE_10HZ = AWF.NumericElement.new("GNSS_LATITUDE_10HZ","GNSS_LATITUDE_10HZ",ftypes.DOUBLE, -90.0, 89.9999999580905, 0.0, AWF.LinearConverter.new(ftypes.INT32, -2147483648, 2147483647, 4.19095158576965E-8, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_LONGITUDE_10HZ = AWF.NumericElement.new("GNSS_LONGITUDE_10HZ","GNSS_LONGITUDE_10HZ",ftypes.DOUBLE, -180.0, 179.999999916181, 0.0, AWF.LinearConverter.new(ftypes.INT32, -2147483648, 2147483647, 8.38190317153931E-8, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_POSITION_VALIDITY = AWF.EnumElement.new("GNSS_POSITION_VALIDITY", "GNSS_POSITION_VALIDITY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSS_TIME_VALIDITY = AWF.EnumElement.new("GNSS_TIME_VALIDITY", "GNSS_TIME_VALIDITY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_1_10HZ = AWF.NumericElement.new("HEADER_1_10HZ","HEADER_1_10HZ",ftypes.UINT8, 90, 90, 90, AWF.CastConverter.new(ftypes.UINT8, 90, 90, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_2_10HZ = AWF.NumericElement.new("HEADER_2_10HZ","HEADER_2_10HZ",ftypes.UINT8, 165, 165, 165, AWF.CastConverter.new(ftypes.UINT8, 165, 165, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_10HZ = AWF.NumericElement.new("HEADING_10HZ","HEADING_10HZ",ftypes.FLOAT, 0.0, 359.994506835938, 0.0, AWF.LinearConverter.new(ftypes.UINT16, 0, 65535, 0.0054931640625, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADING_RATE_10HZ = AWF.NumericElement.new("HEADING_RATE_10HZ","HEADING_RATE_10HZ",ftypes.FLOAT, -57.295779513, 57.2940309845725, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.00174852842752075, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.IDENT_10HZ = AWF.NumericElement.new("IDENT_10HZ","IDENT_10HZ",ftypes.UINT8, 2, 2, 2, AWF.CastConverter.new(ftypes.UINT8, 2, 2, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_IDENTIFICATION_10HZ = AWF.EnumElement.new("INS_IDENTIFICATION_10HZ", "INS_IDENTIFICATION_10HZ", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_INS_IDENTIFICATION, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.INS_MODE = AWF.EnumElement.new("INS_MODE", "INS_MODE", ftypes.UINT8, 0, 3, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_STATUS_1_MODE, AWF.CastConverter.new(ftypes.UINT8, 0, 3, 2), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_10HZ = AWF.NumericElement.new("LATITUDE_10HZ","LATITUDE_10HZ",ftypes.DOUBLE, -90.0, 89.9999999580905, 0.0, AWF.LinearConverter.new(ftypes.INT32, -2147483648, 2147483647, 4.19095158576965E-8, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LATITUDE_ACC_10HZ = AWF.NumericElement.new("LATITUDE_ACC_10HZ","LATITUDE_ACC_10HZ",ftypes.DOUBLE, 0.0, 21599.9999949709, 0.0, AWF.LinearConverter.new(ftypes.UINT32, 0, 4294967295, 5.02914190292358E-6, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_10HZ = AWF.NumericElement.new("LOG_SPEED_10HZ","LOG_SPEED_10HZ",ftypes.FLOAT, -65.536, 65.534, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LOG_SPEED_VALIDITY = AWF.EnumElement.new("LOG_SPEED_VALIDITY", "LOG_SPEED_VALIDITY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_10HZ = AWF.NumericElement.new("LONGITUDE_10HZ","LONGITUDE_10HZ",ftypes.DOUBLE, -180.0, 179.999999916181, 0.0, AWF.LinearConverter.new(ftypes.INT32, -2147483648, 2147483647, 8.38190317153931E-8, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.LONGITUDE_ACC_10HZ = AWF.NumericElement.new("LONGITUDE_ACC_10HZ","LONGITUDE_ACC_10HZ",ftypes.DOUBLE, 0.0, 21599.9999949709, 0.0, AWF.LinearConverter.new(ftypes.UINT32, 0, 4294967295, 5.02914190292358E-6, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_VALIDITY = AWF.EnumElement.new("NAV_DATA_VALIDITY", "NAV_DATA_VALIDITY", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_DATA_VALID_INVALID,AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NORTH_VELOCITY_10HZ = AWF.NumericElement.new("NORTH_VELOCITY_10HZ","NORTH_VELOCITY_10HZ",ftypes.FLOAT, -65.536, 65.534, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NUMDATA_10HZ = AWF.NumericElement.new("NUMDATA_10HZ","NUMDATA_10HZ",ftypes.UINT8, 72, 72, 72, AWF.CastConverter.new(ftypes.UINT8, 72, 72, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_10HZ = AWF.NumericElement.new("PITCH_10HZ","PITCH_10HZ",ftypes.FLOAT, -90.0, 89.9972534179688, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.00274658203125, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.PITCH_RATE_10HZ = AWF.NumericElement.new("PITCH_RATE_10HZ","PITCH_RATE_10HZ",ftypes.FLOAT, -57.295779513, 57.2940309845725, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.00174852842752075, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_CORR_10HZ = AWF.NumericElement.new("POSITION_CORR_10HZ","POSITION_CORR_10HZ",ftypes.FLOAT, -1.0, 0.999969482421875, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 3.0517578125E-5, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_1 = AWF.NumericElement.new("RESERVED_BIT_1","RESERVED_BIT_1",ftypes.UINT8, 0, 1, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.RESERVED_BIT_2 = AWF.NumericElement.new("RESERVED_BIT_2","RESERVED_BIT_2",ftypes.UINT8, 0, 1, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_10HZ = AWF.NumericElement.new("ROLL_10HZ","ROLL_10HZ",ftypes.FLOAT, -90.0, 89.9972534179688, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.00274658203125, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ROLL_RATE_10HZ = AWF.NumericElement.new("ROLL_RATE_10HZ","ROLL_RATE_10HZ",ftypes.FLOAT, -57.295779513, 57.2940309845725, 0.0, AWF.LinearConverter.new(ftypes.INT16, -32768, 32767, 0.00174852842752075, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIMULATION_MODE = AWF.EnumElement.new("SIMULATION_MODE", "SIMULATION_MODE", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPARE_BYTE = AWF.NumericElement.new("SPARE_BYTE","SPARE_BYTE",ftypes.INT16, 0, 255, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 255, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_OVER_GROUND_10HZ = AWF.NumericElement.new("SPEED_OVER_GROUND_10HZ","SPEED_OVER_GROUND_10HZ",ftypes.FLOAT, 0.0, 131.07, 0.0, AWF.LinearConverter.new(ftypes.UINT16, 0, 65535, 0.002, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SPEED_SATURATION = AWF.EnumElement.new("SPEED_SATURATION", "SPEED_SATURATION", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TEMPERATURE_ERR = AWF.EnumElement.new("TEMPERATURE_ERR", "TEMPERATURE_ERR", ftypes.UINT8, 0, 1, 0, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.E_BOOLEAN_VALUE, AWF.CastConverter.new(ftypes.UINT8, 0, 1, 1), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ = AWF.NumericElement.new("TIME_REF_GNSS_10HZ","TIME_REF_GNSS_10HZ",ftypes.FLOAT, 0.0, 167772.15, 0.0, AWF.LinearConverter.new(ftypes.UINT24, 0, 16777215, 0.01, 0, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitudeRate_10hz = AWF.ComplexElement.new("attitudeRate_10hz", "attitudeRate_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_RATE_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitude_10hz = AWF.ComplexElement.new("attitude_10hz", "attitude_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ATTITUDE_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.biteStatus_10hz = AWF.ComplexElement.new("biteStatus_10hz", "biteStatus_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.BITE_STATUS_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.checksum_10hz = AWF.ComplexElement.new("checksum_10hz", "checksum_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.dataBytesCounter_10hz = AWF.ComplexElement.new("dataBytesCounter_10hz", "dataBytesCounter_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.DATA_BYTES_COUNTER_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.date_10hz = AWF.NumericElement.new("date_10hz","date_10hz",ftypes.UINT16, 0, 366, 0, AWF.CastConverter.new(ftypes.UINT16, 0, 366, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.header_10hz = AWF.ComplexElement.new("header_10hz", "header_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.HEADER_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.id_10hz = AWF.ComplexElement.new("id_10hz", "id_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.ID_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.navData_10hz = AWF.ComplexElement.new("navData_10hz", "navData_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_DATA_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.positionAcc_10hz = AWF.ComplexElement.new("positionAcc_10hz", "positionAcc_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_ACC_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.position_10hz = AWF.ComplexElement.new("position_10hz", "position_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.POSITION_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.sixBytesSpare = AWF.ArrayElement.new("sixBytesSpare", "sixBytesSpare", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.SIX_SPARE_BYTES, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state1_10hz = AWF.ComplexElement.new("state1_10hz", "state1_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_1_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state2_10hz = AWF.ComplexElement.new("state2_10hz", "state2_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.STATUS_2_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.terminator_10hz = AWF.ComplexElement.new("terminator_10hz", "terminator_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TERMINATOR_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.twoBytesSpare = AWF.ArrayElement.new("twoBytesSpare", "twoBytesSpare", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TWO_SPARE_BYTES, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.twoBytesSpare =  AWF.NumericElement.new("twoBytesSpare","twoBytesSpare",ftypes.UINT16, 0, 65535, 0, AWF.CastConverter.new(ftypes.UINT16, 0, 65535, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.velocities_10hz = AWF.ComplexElement.new("velocities_10hz", "velocities_10hz", NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.VELOCITIES_10HZ_STRUCT, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);

NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.spare_byte = AWF.NumericElement.new("spare_byte","spare_byte",ftypes.UINT8, 0, 255, 0, AWF.CastConverter.new(ftypes.UINT8, 0, 255, nil), NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);


-- messages

--NAV_10HZ_MESSAGE
NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_10HZ_MESSAGE = AWF.Message.new("NAV_10HZ_MESSAGE", "NAV_10HZ_MESSAGE", 90, ENC_LITTLE_ENDIAN, false, NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR);
function NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.NAV_10HZ_MESSAGE:read(buf, pkt, tree, offset, maxLength, byteOrder, dynamic, instance)
	local length = 78;
	local actualLength, structTree = AWF.Message.read(self, buf, pkt, tree, offset, 78, byteOrder, dynamic, instance); 
	if (dynamic) then
		local localOffset = offset;
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.header_10hz:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.dataBytesCounter_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.id_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state1_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state2_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.biteStatus_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.date_10hz:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ_STRUCT:read(buf, pkt, structTree, localOffset, 4, byteOrder, dynamic);
	--	NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.timeRefGNSS_10hz:readBits(buf, pkt, structTree, offset, , byteOrder, dynamic, nil, value, );
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.twoBytesSpare:read(buf, pkt, structTree, localOffset, 2, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitude_10hz:read(buf, pkt, structTree, localOffset, 6, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitudeRate_10hz:read(buf, pkt, structTree, localOffset, 6, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.position_10hz:read(buf, pkt, structTree, localOffset, 10, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.positionAcc_10hz:read(buf, pkt, structTree, localOffset, 10, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSSPosition_10hz:read(buf, pkt, structTree, localOffset, 8, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.velocities_10hz:read(buf, pkt, structTree, localOffset, 8, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.navData_10hz:read(buf, pkt, structTree, localOffset, 8, byteOrder, dynamic);
		--localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.sixBytesSpare:read(buf, pkt, structTree, localOffset, 6, 6, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);
		localOffset = localOffset + NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.terminator_10hz:read(buf, pkt, structTree, localOffset, 1, byteOrder, dynamic);

		length = localOffset - offset;
		structTree.len =  length;
	else
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.header_10hz:read(buf, pkt, structTree, offset + 0, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.dataBytesCounter_10hz:read(buf, pkt, structTree, offset + 2, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.id_10hz:read(buf, pkt, structTree, offset + 3, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state1_10hz:read(buf, pkt, structTree, offset + 4, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.state2_10hz:read(buf, pkt, structTree, offset + 5, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.biteStatus_10hz:read(buf, pkt, structTree, offset + 6, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.date_10hz:read(buf, pkt, structTree, offset + 7, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.TIME_REF_GNSS_10HZ:read(buf, pkt, structTree, offset + 9, 3, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.spare_byte:read(buf, pkt, structTree, offset + 12, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.spare_byte:read(buf, pkt, structTree, offset + 13, 1, byteOrder, dynamic);
		--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.twoBytesSpare:read(buf, pkt, structTree, offset + 12, 2, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitude_10hz:read(buf, pkt, structTree, offset + 14, 6, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.attitudeRate_10hz:read(buf, pkt, structTree, offset + 20, 6, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.position_10hz:read(buf, pkt, structTree, offset + 26, 10, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.positionAcc_10hz:read(buf, pkt, structTree, offset + 36, 10, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.GNSSPosition_10hz:read(buf, pkt, structTree, offset + 46, 8, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.velocities_10hz:read(buf, pkt, structTree, offset + 54, 8, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.navData_10hz:read(buf, pkt, structTree, offset + 62, 8, byteOrder, dynamic);
		--NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.sixBytesSpare:read(buf, pkt, structTree, offset + 70, 6, 6, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.CHECKSUM_10HZ:read(buf, pkt, structTree, offset + 76, 1, byteOrder, dynamic);
		NDS_LCU_BUS_PR.IOSAMPLE_GROUP_PR.END_MESSAGE:read(buf, pkt, structTree, offset + 77, 1, byteOrder, dynamic);

	end
	return length;
end


-- compound messages


end


