-- megafunction wizard: %LPM_CONSTANT%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_CONSTANT 

-- ============================================================
-- File Name: tempBaixa.vhd
-- Megafunction Name(s):
-- 			LPM_CONSTANT
--
-- Simulation Library Files(s):
-- 			
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 13.0.0 Build 156 04/24/2013 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2013 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


--lpm_constant CBX_AUTO_BLACKBOX="ALL" ENABLE_RUNTIME_MOD="YES" INSTANCE_NAME="NONE" LPM_CVALUE=00000064 LPM_WIDTH=32 result
--VERSION_BEGIN 13.0 cbx_lpm_constant 2013:04:24:18:08:47:SJ cbx_mgl 2013:04:24:18:11:10:SJ  VERSION_END

--synthesis_resources = sld_mod_ram_rom 1 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  tempBaixa_lpm_constant_v1b IS 
	 PORT 
	 ( 
		 result	:	OUT  STD_LOGIC_VECTOR (31 DOWNTO 0)
	 ); 
 END tempBaixa_lpm_constant_v1b;

 ARCHITECTURE RTL OF tempBaixa_lpm_constant_v1b IS

	 SIGNAL  wire_mgl_prim1_data_write	:	STD_LOGIC_VECTOR (31 DOWNTO 0);
	 COMPONENT  sld_mod_ram_rom
	 GENERIC 
	 (
		CVALUE	:	STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
		IS_DATA_IN_RAM	:	NATURAL;
		IS_READABLE	:	NATURAL;
		NODE_NAME	:	NATURAL;
		NUMWORDS	:	NATURAL;
		SHIFT_COUNT_BITS	:	NATURAL;
		WIDTH_WORD	:	NATURAL;
		WIDTHAD	:	NATURAL
	 );
	 PORT
	 ( 
		data_write	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	 ); 
	 END COMPONENT;
 BEGIN

	result <= wire_mgl_prim1_data_write;
	mgl_prim1 :  sld_mod_ram_rom
	  GENERIC MAP (
		CVALUE => "00000000000000000000000001100100",
		IS_DATA_IN_RAM => 0,
		IS_READABLE => 0,
		NODE_NAME => 0,
		NUMWORDS => 1,
		SHIFT_COUNT_BITS => 6,
		WIDTH_WORD => 32,
		WIDTHAD => 1
	  )
	  PORT MAP ( 
		data_write => wire_mgl_prim1_data_write
	  );

 END RTL; --tempBaixa_lpm_constant_v1b
--VALID FILE


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tempBaixa IS
	PORT
	(
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END tempBaixa;


ARCHITECTURE RTL OF tempbaixa IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);



	COMPONENT tempBaixa_lpm_constant_v1b
	PORT (
			result	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	result    <= sub_wire0(31 DOWNTO 0);

	tempBaixa_lpm_constant_v1b_component : tempBaixa_lpm_constant_v1b
	PORT MAP (
		result => sub_wire0
	);



END RTL;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "1"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: Radix NUMERIC "10"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: Value NUMERIC "100"
-- Retrieval info: PRIVATE: nBit NUMERIC "32"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_CVALUE NUMERIC "100"
-- Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=YES, INSTANCE_NAME=NONE"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_CONSTANT"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "32"
-- Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
-- Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL tempBaixa.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL tempBaixa.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL tempBaixa.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL tempBaixa.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL tempBaixa_inst.vhd FALSE
