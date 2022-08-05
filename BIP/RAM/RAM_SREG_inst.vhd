RAM_SREG_inst : RAM_SREG PORT MAP (
		aclr	 => aclr_sig,
		address	 => address_sig,
		clken	 => clken_sig,
		clock	 => clock_sig,
		data	 => data_sig,
		wren	 => wren_sig,
		q	 => q_sig
	);
