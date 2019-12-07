/**  
 * @Title:  MinaCastTest.java   
 * @Package com.niocast.cast   
 * @Description:    TODO(用一句话描述该文件做什么)   
 * @author: Shuofang     
 * @date:   2019年1月10日 上午10:15:20   
 * @version V1.0 
 * @Copyright: 2019 
 */
package com.niocast.minatcpservice;

import java.net.InetSocketAddress;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

import com.audioweb.service.LogManager;
import com.audioweb.service.impl.LogService;
import com.audioweb.util.Const;
import com.audioweb.util.SpringContextUtils;
import com.niocast.entity.QtClientInfo;
import com.niocast.minatcpservice.handle.DefaultCommand;
import com.niocast.minatcpservice.handle.SimpleCommandFactory;
import com.niocast.util.GlobalInfoController;
import com.sun.javafx.css.CssError;
import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.future.WriteFuture;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @author Shuofang
 *	TODO
 */
public class TCPMinaCastHandler extends IoHandlerAdapter
{
    private static Logger logger = LoggerFactory.getLogger(TCPMinaCastHandler.class);  
    public static final CharsetDecoder decoder = (Charset.forName("ISO-8859-1")).newDecoder();
	private static final SimpleCommandFactory commandFactory = new SimpleCommandFactory();
    /**
     * MINA的异常回调方法。
     * <p>
     * 本类中将在异常发生时，立即close当前会话。
     * 
     * @param session 发生异常的会话
     * @param cause 异常内容
     * @see IoSession#close(boolean)
     */
    @Override
    public void exceptionCaught(IoSession session, Throwable cause) throws Exception 
    {
        //logger.error("[IMCORE]exceptionCaught捕获到错了，原因是："+cause.getMessage(), cause);
        session.closeNow();
    }

    /**
     * MINA框架中收到客户端消息的回调方法。
     * <p>
     * 本类将在此方法中实现完整的即时通讯数据交互和处理策略。
     * <p>
     * 为了提升并发性能，本方法将运行在独立于MINA的IoProcessor之外的线程池中，
     * 详见MINA设置代码 。
     *
     * @param session 收到消息对应的会话引用
     * @param message 收到的MINA的原始消息封装对象，本类中是 {@link IoBuffer}对象
     * @throws Exception 当有错误发生时将抛出异常
     */
    @Override
    public void messageReceived(IoSession session, Object message)throws Exception 
    {
		IoBuffer buffer = (IoBuffer) message;
		byte[] content = new byte[buffer.limit()];
		buffer.get(content);
		byte[] returndata = null;
        DefaultCommand command = null;
        command = commandFactory.createCommand(session, content);
		if(command != null) {
			returndata = command.execute();
		}
		if(returndata != null) {
			IoBuffer buf = IoBuffer.wrap(returndata);
			WriteFuture future = session.write(buf);
			// 在100毫秒超时间内等待写完成
			future.awaitUninterruptibly(100);
			// The message has been written successfully
			if( future.isWritten())
			{
				// send sucess!
			}
			// The messsage couldn't be written out completely for some reason.
			// (e.g. Connection is closed)
			else
			{
				logger.warn("[IMCORE]回复给客户端的数据发送失败！");
			}
		}

    }
    @Override
	 public void messageSent(IoSession session, Object message) throws Exception {
    	//logger.info("------------服务端发消息到客户端---");
	 }
	 @Override
	 public void sessionClosed(IoSession session) throws Exception {
	  // TODO Auto-generated method stub
		 logger.info("远程session关闭了一个...");
		 if(session.getAttribute(DefaultCommand.USERID) != null){
			 //做些事情
			GlobalInfoController.deleteClientInfo(session.getAttribute(DefaultCommand.USERID).toString());
		 }
	 }
	 @Override
	 public void sessionCreated(IoSession session) throws Exception {
	     //String clientIP = ((InetSocketAddress)session.getRemoteAddress()).getAddress().getHostAddress();
	     //session.setAttribute("KEY_SESSION_CLIENT_IP", clientIP);
	     //logger.info("sessionCreated, client IP: " + clientIP);
	 }

	 //心跳检测触发接口，设置好心跳值后，如果规定时间内未有心跳，则调用此方法，常用于检测终端状态，断开连接等
	 @Override
	 public void sessionIdle(IoSession session, IdleStatus status)
	   throws Exception {
		 logger.info("连接空闲,断开连接："+session.getLocalAddress());
		 session.closeNow();
	 }
	 @Override
	 public void sessionOpened(IoSession session) throws Exception {
		 logger.info("连接打开："+session.getLocalAddress());
	 }
}
