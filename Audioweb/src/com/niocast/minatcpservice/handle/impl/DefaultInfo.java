package com.niocast.minatcpservice.handle.impl;

import org.apache.mina.core.session.IoSession;

import com.niocast.minatcpservice.handle.DefaultCommand;

public class DefaultInfo extends DefaultCommand{

	public DefaultInfo(IoSession session, byte[] content) {
		super(session, content);
		// TODO Auto-generated constructor stub
	}

	@Override
	public byte[] execute() {
		// TODO Auto-generated method stub
		return StrToByte(CommError);
	}

}
