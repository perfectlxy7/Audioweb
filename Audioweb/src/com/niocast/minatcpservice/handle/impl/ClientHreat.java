package com.niocast.minatcpservice.handle.impl;

import org.apache.mina.core.session.IoSession;

import com.niocast.minatcpservice.handle.DefaultCommand;

public class ClientHreat extends DefaultCommand{

	public ClientHreat(IoSession session, byte[] content) {
		super(session, content);
		// TODO Auto-generated constructor stub
	}

	@Override
	public byte[] execute() {
		// TODO 心跳,直接返回
		return content;
	}
	
}
